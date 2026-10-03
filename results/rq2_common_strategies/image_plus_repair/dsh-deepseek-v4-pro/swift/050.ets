// import SwiftUI
// import UIKit

// MARK: - 1. AppTokens Definition

// SwiftUI `Color` extension (init(hex:alpha:)) translated to a helper that
// converts a 0xRRGGBB value into an ArkUI "#AARRGGBB" color string.
function toHexByte(v: number): string {
  const s: string = Math.round(v).toString(16).toUpperCase();
  return s.length < 2 ? '0' + s : s;
}

function colorFromHex(hex: number, alpha: number = 1.0): string {
  const r: number = (hex >> 16) & 0xff;
  const g: number = (hex >> 8) & 0xff;
  const b: number = hex & 0xff;
  const a: number = alpha * 255;
  return '#' + toHexByte(a) + toHexByte(r) + toHexByte(g) + toHexByte(b);
}

// Applies an opacity multiplier to an existing "#AARRGGBB" color string.
function withOpacity(color: string, opacity: number): string {
  const a: number = parseInt(color.substring(1, 3), 16) * opacity;
  return '#' + toHexByte(a) + color.substring(3, 9);
}

interface ColorPalette {
  readonly primary: string;
  readonly secondary: string;
  readonly tertiary: string;
  readonly background: string;
  readonly surface: string;
  readonly surfaceVariant: string;
  readonly outline: string;
  readonly success: string;
  readonly warning: string;
  readonly error: string;
  readonly onPrimary: string;
  readonly onSecondary: string;
  readonly onTertiary: string;
  readonly onBackground: string;
  readonly onSurface: string;
}

interface AppTextStyle {
  readonly size: number;
  readonly weight: number;
}

interface TypographyPalette {
  readonly display: AppTextStyle;
  readonly headline: AppTextStyle;
  readonly title: AppTextStyle;
  readonly body: AppTextStyle;
  readonly label: AppTextStyle;
}

interface ShapeTokens {
  readonly smallCornerRadius: number;
  readonly mediumCornerRadius: number;
  readonly largeCornerRadius: number;
}

interface SpacingTokens {
  readonly xs: number;
  readonly sm: number;
  readonly md: number;
  readonly lg: number;
  readonly xl: number;
  readonly xxl: number;
}

interface ShadowSpec {
  readonly elevation: number;
  readonly radius: number;
  readonly dy: number;
  readonly opacity: number;
}

interface ElevationTokens {
  readonly level1: ShadowSpec;
  readonly level2: ShadowSpec;
  readonly level3: ShadowSpec;
}

class AppTokens {
  static readonly Colors: ColorPalette = {
    primary: colorFromHex(0xFF1E3A8A),
    secondary: colorFromHex(0xFF2563EB),
    tertiary: colorFromHex(0xFF60A5FA),
    background: colorFromHex(0xFFF5F8FF),
    surface: colorFromHex(0xFFFFFFFF),
    surfaceVariant: colorFromHex(0xFFE8EEFA),
    outline: colorFromHex(0xFFCBD5E1),
    success: colorFromHex(0xFF16A34A),
    warning: colorFromHex(0xFFF59E0B),
    error: colorFromHex(0xFFEF4444),
    onPrimary: colorFromHex(0xFFFFFFFF),
    onSecondary: colorFromHex(0xFFFFFFFF),
    onTertiary: colorFromHex(0xFF0B1220),
    onBackground: colorFromHex(0xFF0B1220),
    onSurface: colorFromHex(0xFF0B1220)
  };

  static readonly TypographyTokens: TypographyPalette = {
    display: { size: 28, weight: 700 },
    headline: { size: 20, weight: 600 },
    title: { size: 16, weight: 500 },
    body: { size: 14, weight: 400 },
    label: { size: 12, weight: 500 }
  };

  static readonly Shapes: ShapeTokens = {
    smallCornerRadius: 8,
    mediumCornerRadius: 12,
    largeCornerRadius: 18
  };

  static readonly Spacing: SpacingTokens = {
    xs: 6,
    sm: 10,
    md: 14,
    lg: 18,
    xl: 26,
    xxl: 36
  };

  static readonly ElevationMapping: ElevationTokens = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.16 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
  };
}

// MARK: - 2. Status Bar Hiding Implementation

// In Swift, `HiddenStatusBarHostingController` (UIHostingController subclass) and
// `HiddenStatusBarView` (UIViewControllerRepresentable) hide the status bar via
// `prefersStatusBarHidden`. ArkUI has no UIViewController equivalent; the same
// result is achieved by expanding the root view into the system safe area.

@Component
struct HiddenStatusBarView {
  build() {
    RootScreen()
  }
}

// MARK: - 3. Custom Segmented Control with Checkmarks

@Component
struct SegmentedControl {
  @Link selectedIndex: number;
  labels: string[] = [];

  build() {
    Row() {
      ForEach(this.labels, (label: string, index: number) => {
        Button({ type: ButtonType.Normal }) {
          Row({ space: AppTokens.Spacing.xs }) {
            if (this.selectedIndex === index) {
              Text('✓')
                .fontSize(14)
                .fontWeight(600)
                .fontColor(AppTokens.Colors.onPrimary)
            }
            Text(label)
              .fontSize(AppTokens.TypographyTokens.label.size)
              .fontWeight(AppTokens.TypographyTokens.label.weight)
              .fontColor(this.selectedIndex === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          }
          .justifyContent(FlexAlign.Center)
        }
        .layoutWeight(1)
        .height(40)
        .backgroundColor(this.selectedIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
        .borderRadius(this.segmentRadius(index))
        .onClick(() => {
          this.selectedIndex = index;
        })
      }, (label: string, index: number) => label + '_' + index)
    }
    .width('100%')
    .borderRadius(AppTokens.Shapes.mediumCornerRadius)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.mediumCornerRadius })
  }

  segmentRadius(index: number): number {
    const radius: number = AppTokens.Shapes.mediumCornerRadius;
    if (this.labels.length === 1) {
      return radius;
    } else if (index === 0) {
      return radius;
    } else if (index === this.labels.length - 1) {
      return radius;
    } else {
      return 0;
    }
  }
}

// MARK: - 4. RootScreen with Adjusted Passenger Card Size

@Component
struct RootScreen {
  @State name: string = '';
  @State code: string = '';
  @State selectedSeat: number = 0;
  @State showDialog: boolean = false;

  seatTabs: string[] = ['Economy', 'Premium', 'Business'];

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            [withOpacity(AppTokens.Colors.tertiary, 0.25), 0.0],
            [AppTokens.Colors.background, 0.5],
            [withOpacity(AppTokens.Colors.secondary, 0.2), 1.0]
          ]
        })
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

      Column() {
        Row() {
          Circle()
            .width(22)
            .height(22)
            .fill(AppTokens.Colors.primary)
            .margin({ left: AppTokens.Spacing.lg })

          Blank()

          Text('Flight Check-in')
            .fontSize(AppTokens.TypographyTokens.display.size)
            .fontWeight(AppTokens.TypographyTokens.display.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Circle()
            .width(22)
            .height(22)
            .fill(AppTokens.Colors.secondary)
            .margin({ right: AppTokens.Spacing.lg })
        }
        .width('100%')
        .height(56)
        .margin({ bottom: AppTokens.Spacing.md })

        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Passenger & Booking Card - 增大这个卡片
            Column({ space: AppTokens.Spacing.lg }) { // 增加内部间距
              Text('Passenger')
                .fontSize(AppTokens.TypographyTokens.headline.size)
                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              TextInput({ placeholder: 'Full name', text: this.name })
                .width('100%')
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .fontColor(AppTokens.Colors.onSurface)
                .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.mediumCornerRadius })
                .onChange((value: string) => {
                  this.name = value;
                })

              Text('Booking Code')
                .fontSize(AppTokens.TypographyTokens.headline.size)
                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .width('100%')
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .fontColor(AppTokens.Colors.onSurface)
                .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.mediumCornerRadius })
                .onChange((value: string) => {
                  this.code = value;
                })

              Text('Seat Class')
                .fontSize(AppTokens.TypographyTokens.headline.size)
                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              SegmentedControl({ selectedIndex: $selectedSeat, labels: this.seatTabs })
            }
            .alignItems(HorizontalAlign.Start)
            .padding(AppTokens.Spacing.xl) // 增加内边距使卡片更大
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.largeCornerRadius)
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: withOpacity('#FF000000', AppTokens.ElevationMapping.level2.opacity),
              offsetX: 0,
              offsetY: AppTokens.ElevationMapping.level2.dy
            })

            // Flight Details Card
            Column({ space: AppTokens.Spacing.md }) {
              // Flight信息行 - 添加白色背景
              Row() {
                Column({ space: AppTokens.Spacing.xs }) {
                  Text('Flight')
                    .fontSize(AppTokens.TypographyTokens.title.size)
                    .fontWeight(AppTokens.TypographyTokens.title.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text('BL 213 • HND → CTS')
                    .fontSize(AppTokens.TypographyTokens.body.size)
                    .fontWeight(AppTokens.TypographyTokens.body.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Circle()
                  .width(36)
                  .height(36)
                  .fill(AppTokens.Colors.secondary)
              }
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.mediumCornerRadius)

              Row() {
                Column() {
                  Text('Boarding')
                    .fontSize(AppTokens.TypographyTokens.label.size)
                    .fontWeight(AppTokens.TypographyTokens.label.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text('12:35')
                    .fontSize(AppTokens.TypographyTokens.title.size)
                    .fontWeight(AppTokens.TypographyTokens.title.weight)
                    .fontColor(AppTokens.Colors.primary)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Column() {
                  Text('Gate')
                    .fontSize(AppTokens.TypographyTokens.label.size)
                    .fontWeight(AppTokens.TypographyTokens.label.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text('A12')
                    .fontSize(AppTokens.TypographyTokens.title.size)
                    .fontWeight(AppTokens.TypographyTokens.title.weight)
                    .fontColor(AppTokens.Colors.primary)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Column() {
                  Text('Seat')
                    .fontSize(AppTokens.TypographyTokens.label.size)
                    .fontWeight(AppTokens.TypographyTokens.label.weight)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text(this.seatNumber(this.selectedSeat))
                    .fontSize(AppTokens.TypographyTokens.title.size)
                    .fontWeight(AppTokens.TypographyTokens.title.weight)
                    .fontColor(AppTokens.Colors.primary)
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })

              Button('Confirm Check-in')
                .width('100%')
                .fontSize(AppTokens.TypographyTokens.title.size)
                .fontWeight(AppTokens.TypographyTokens.title.weight)
                .height(52)
                .backgroundColor(AppTokens.Colors.primary)
                .fontColor(AppTokens.Colors.onPrimary)
                .borderRadius(AppTokens.Shapes.largeCornerRadius)
                .onClick(() => {
                  this.showDialog = true;
                  AlertDialog.show({
                    title: 'Check-in Successful',
                    message: 'Boarding pass is ready. Have a nice flight.',
                    confirm: {
                      value: 'Done',
                      action: () => {
                        this.showDialog = false;
                      }
                    }
                  });
                })
            }
            .alignItems(HorizontalAlign.Start)
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.largeCornerRadius)
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: withOpacity('#FF000000', AppTokens.ElevationMapping.level2.opacity),
              offsetX: 0,
              offsetY: AppTokens.ElevationMapping.level2.dy
            })
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  seatNumber(index: number): string {
    if (index === 0) {
      return '23C';
    } else if (index === 1) {
      return '11A';
    } else {
      return '2F';
    }
  }
}

// MARK: - 5. App Entry Point

@Entry
@Component
struct FlightCheckinApp {
  build() {
    Stack() {
      HiddenStatusBarView()
    }
  }
}
