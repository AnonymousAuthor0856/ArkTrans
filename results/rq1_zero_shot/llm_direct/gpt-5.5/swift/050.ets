import { window } from '@kit.ArkUI';

class AppColors {
  static readonly primary: ResourceColor = '#FF1E3A8A';
  static readonly secondary: ResourceColor = '#FF2563EB';
  static readonly tertiary: ResourceColor = '#FF60A5FA';
  static readonly background: ResourceColor = '#FFF5F8FF';
  static readonly surface: ResourceColor = '#FFFFFFFF';
  static readonly surfaceVariant: ResourceColor = '#FFE8EEFA';
  static readonly outline: ResourceColor = '#FFCBD5E1';
  static readonly success: ResourceColor = '#FF16A34A';
  static readonly warning: ResourceColor = '#FFF59E0B';
  static readonly error: ResourceColor = '#FFEF4444';
  static readonly onPrimary: ResourceColor = '#FFFFFFFF';
  static readonly onSecondary: ResourceColor = '#FFFFFFFF';
  static readonly onTertiary: ResourceColor = '#FF0B1220';
  static readonly onBackground: ResourceColor = '#FF0B1220';
  static readonly onSurface: ResourceColor = '#FF0B1220';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly headlineSize: number = 20;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly smallCornerRadius: number = 8;
  static readonly mediumCornerRadius: number = 12;
  static readonly largeCornerRadius: number = 18;
}

class AppSpacing {
  static readonly xs: number = 6;
  static readonly sm: number = 10;
  static readonly md: number = 14;
  static readonly lg: number = 18;
  static readonly xl: number = 26;
  static readonly xxl: number = 36;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
  color: ResourceColor;

  constructor(elevation: number, radius: number, dy: number, opacity: number, color: ResourceColor) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
    this.color = color;
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12, '#1F000000');
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.16, '#29000000');
  static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18, '#2E000000');
}

@Component
struct SegmentedControl {
  @Link selectedIndex: number;
  labels: string[] = [];

  private segmentRadius(index: number): BorderRadiuses {
    if (this.labels.length === 1) {
      return {
        topLeft: AppShapes.mediumCornerRadius,
        topRight: AppShapes.mediumCornerRadius,
        bottomLeft: AppShapes.mediumCornerRadius,
        bottomRight: AppShapes.mediumCornerRadius
      };
    }

    if (index === 0) {
      return {
        topLeft: AppShapes.mediumCornerRadius,
        bottomLeft: AppShapes.mediumCornerRadius,
        topRight: 0,
        bottomRight: 0
      };
    }

    if (index === this.labels.length - 1) {
      return {
        topLeft: 0,
        bottomLeft: 0,
        topRight: AppShapes.mediumCornerRadius,
        bottomRight: AppShapes.mediumCornerRadius
      };
    }

    return {
      topLeft: 0,
      topRight: 0,
      bottomLeft: 0,
      bottomRight: 0
    };
  }

  build() {
    Row() {
      ForEach(this.labels, (label: string, index: number) => {
        Row({ space: AppSpacing.xs }) {
          if (this.selectedIndex === index) {
            Text('✓')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
          }

          Text(label)
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedIndex === index ? AppColors.onPrimary : AppColors.onSurface)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .height(40)
        .layoutWeight(1)
        .backgroundColor(this.selectedIndex === index ? AppColors.primary : AppColors.surfaceVariant)
        .borderRadius(this.segmentRadius(index))
        .onClick(() => {
          this.selectedIndex = index;
        })
      }, (label: string, index: number) => `${index}-${label}`)
    }
    .width('100%')
    .height(40)
    .clip(true)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: AppShapes.mediumCornerRadius
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State private name: string = '';
  @State private code: string = '';
  @State private selectedSeat: number = 0;
  @State private showDialog: boolean = false;

  private readonly seatTabs: string[] = ['Economy', 'Premium', 'Business'];

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((mainWindow: window.Window) => {
      mainWindow.setWindowSystemBarEnable(['navigation']);
    });
  }

  private seatNumber(index: number): string {
    if (index === 0) {
      return '23C';
    } else if (index === 1) {
      return '11A';
    } else {
      return '2F';
    }
  }

  private showSuccessDialog(): void {
    this.showDialog = true;
    AlertDialog.show({
      title: 'Check-in Successful',
      message: 'Boarding pass is ready. Have a nice flight.',
      primaryButton: {
        value: 'Done',
        action: () => {
          this.showDialog = false;
        }
      }
    });
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Blank()
            .width(22)
            .height(22)
            .borderRadius(11)
            .backgroundColor(AppColors.primary)
            .margin({ left: AppSpacing.lg })

          Blank()
            .layoutWeight(1)

          Text('Flight Check-in')
            .fontSize(AppTypography.displaySize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)

          Blank()
            .layoutWeight(1)

          Blank()
            .width(22)
            .height(22)
            .borderRadius(11)
            .backgroundColor(AppColors.secondary)
            .margin({ right: AppSpacing.lg })
        }
        .width('100%')
        .height(56)
        .margin({ bottom: AppSpacing.md })

        Scroll() {
          Column({ space: AppSpacing.lg }) {
            Column({ space: AppSpacing.lg }) {
              Text('Passenger')
                .fontSize(AppTypography.headlineSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)

              TextInput({ placeholder: 'Full name', text: this.name })
                .fontSize(AppTypography.bodySize)
                .fontColor(AppColors.onSurface)
                .placeholderColor('#990B1220')
                .height(48)
                .padding({ left: AppSpacing.md, right: AppSpacing.md })
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.mediumCornerRadius)
                .border({
                  width: 1,
                  color: AppColors.outline,
                  radius: AppShapes.mediumCornerRadius
                })
                .onChange((value: string) => {
                  this.name = value;
                })

              Text('Booking Code')
                .fontSize(AppTypography.headlineSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)

              TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
                .fontSize(AppTypography.bodySize)
                .fontColor(AppColors.onSurface)
                .placeholderColor('#990B1220')
                .height(48)
                .padding({ left: AppSpacing.md, right: AppSpacing.md })
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(AppShapes.mediumCornerRadius)
                .border({
                  width: 1,
                  color: AppColors.outline,
                  radius: AppShapes.mediumCornerRadius
                })
                .onChange((value: string) => {
                  this.code = value;
                })

              Text('Seat Class')
                .fontSize(AppTypography.headlineSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)

              SegmentedControl({
                selectedIndex: $selectedSeat,
                labels: this.seatTabs
              })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding(AppSpacing.xl)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.largeCornerRadius)
            .shadow({
              radius: AppElevation.level2.radius,
              color: AppElevation.level2.color,
              offsetX: 0,
              offsetY: AppElevation.level2.dy
            })

            Column({ space: AppSpacing.md }) {
              Row() {
                Column({ space: AppSpacing.xs }) {
                  Text('Flight')
                    .fontSize(AppTypography.titleSize)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)

                  Text('BL 213 • HND → CTS')
                    .fontSize(AppTypography.bodySize)
                    .fontWeight(FontWeight.Regular)
                    .fontColor(AppColors.onSurface)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()
                  .layoutWeight(1)

                Blank()
                  .width(36)
                  .height(36)
                  .borderRadius(18)
                  .backgroundColor(AppColors.secondary)
              }
              .width('100%')
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShapes.mediumCornerRadius)

              Row() {
                Column() {
                  Text('Boarding')
                    .fontSize(AppTypography.labelSize)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)

                  Text('12:35')
                    .fontSize(AppTypography.titleSize)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.primary)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()
                  .layoutWeight(1)

                Column() {
                  Text('Gate')
                    .fontSize(AppTypography.labelSize)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)

                  Text('A12')
                    .fontSize(AppTypography.titleSize)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.primary)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()
                  .layoutWeight(1)

                Column() {
                  Text('Seat')
                    .fontSize(AppTypography.labelSize)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)

                  Text(this.seatNumber(this.selectedSeat))
                    .fontSize(AppTypography.titleSize)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.primary)
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .padding({ top: AppSpacing.md, bottom: AppSpacing.md })

              Button() {
                Text('Confirm Check-in')
                  .fontSize(AppTypography.titleSize)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onPrimary)
              }
              .type(ButtonType.Normal)
              .width('100%')
              .height(52)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.largeCornerRadius)
              .onClick(() => {
                this.showSuccessDialog();
              })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding(AppSpacing.lg)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.largeCornerRadius)
            .shadow({
              radius: AppElevation.level2.radius,
              color: AppElevation.level2.color,
              offsetX: 0,
              offsetY: AppElevation.level2.dy
            })
          }
          .width('100%')
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.md,
            bottom: AppSpacing.md
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        ['#4060A5FA', 0.0],
        [AppColors.background, 0.5],
        ['#332563EB', 1.0]
      ]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}