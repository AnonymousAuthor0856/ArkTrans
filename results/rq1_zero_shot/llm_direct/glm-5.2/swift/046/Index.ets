// AppTokens (Translated from Kotlin/SwiftUI)

class AppTokens {
  static readonly Colors = {
    primary: '#7B61FF',
    secondary: '#26C6DA',
    tertiary: '#FF8A80',
    background: '#F5F7FF',
    surface: '#FFFFFF',
    surfaceVariant: '#F0F2F8',
    outline: '#E0E3EB',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#0B1220',
    onTertiary: '#0B1220',
    onBackground: '#0B1220',
    onSurface: '#0B1220',
  }

  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }

  static readonly Shapes = {
    small: 8,
    medium: 14,
    large: 20,
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  }

  static readonly Elevation = {
    level1: { radius: 4, dy: 2, opacity: 0.12 },
    level2: { radius: 10, dy: 6, opacity: 0.16 },
    level3: { radius: 14, dy: 8, opacity: 0.18 },
  }
}

// Data Models
class Coupon {
  id: number;
  title: string;
  value: string;
  colorA: string;
  colorB: string;

  constructor(id: number, title: string, value: string, colorA: string, colorB: string) {
    this.id = id;
    this.title = title;
    this.value = value;
    this.colorA = colorA;
    this.colorB = colorB;
  }
}

class MapPin {
  x: number;
  y: number;
  label: string;
  tint: string;

  constructor(x: number, y: number, label: string, tint: string) {
    this.x = x;
    this.y = y;
    this.label = label;
    this.tint = tint;
  }
}

// Helper function to apply opacity to hex colors
function applyOpacity(hex: string, opacity: number): string {
  const alpha = Math.round(opacity * 255).toString(16).padStart(2, '0');
  return `#${alpha}${hex.substring(1)}`;
}

@Entry
@Component
struct RootScreen {
  private coupons: Coupon[] = [
    new Coupon(1, "Grocery Pack", "-$5", AppTokens.Colors.primary, AppTokens.Colors.secondary),
    new Coupon(2, "Cafe Bundle", "-15%", AppTokens.Colors.secondary, AppTokens.Colors.tertiary),
    new Coupon(3, "Electro Deal", "-$20", AppTokens.Colors.tertiary, AppTokens.Colors.primary),
    new Coupon(4, "Fashion Duo", "-10%", AppTokens.Colors.secondary, AppTokens.Colors.primary)
  ];

  @State private pins: MapPin[] = [
    new MapPin(140, 220, "A", AppTokens.Colors.primary),
    new MapPin(320, 400, "B", AppTokens.Colors.secondary),
    new MapPin(520, 300, "C", AppTokens.Colors.tertiary)
  ];

  build() {
    Stack() {
      // Background Gradient
      Column() {
        // Main Content VStack
        Column() {
          // Top Navigation Bar
          Row() {
            Button() {}
              .width(20)
              .height(20)
              .borderRadius(10)
              .backgroundColor(AppTokens.Colors.onSurface)
              .margin({ left: AppTokens.Spacing.lg })

            Blank() // Spacer

            Text("Coupon Pack")
              .fontSize(AppTokens.Typography.display.size)
              .fontWeight(AppTokens.Typography.display.weight)
              .fontColor(AppTokens.Colors.onSurface)

            Blank() // Spacer

            Button() {}
              .width(20)
              .height(20)
              .borderRadius(10)
              .backgroundColor(AppTokens.Colors.primary)
              .margin({ right: AppTokens.Spacing.lg })
          }
          .width('100%')
          .padding({ top: AppTokens.Spacing.lg })

          // Main Content Area
          Column() {
            Text("Nearby Packs")
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.lg })

            // Map Area Box
            Stack({ align: Alignment.TopEnd }) {
              // Map Canvas
              Column() {
                Canvas(this.pins)
                  .width('100%')
                  .aspectRatio(16 / 9)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .onReady((context: CanvasRenderingContext2D) => {
                    // Draw Pins
                    for (let pin of this.pins) {
                      context.fillStyle = pin.tint;
                      context.beginPath();
                      context.arc(pin.x, pin.y, 14, 0, Math.PI * 2);
                      context.fill();
                    }
                  })
                  .borderRadius(AppTokens.Shapes.large)
                  .shadow({
                    radius: AppTokens.Elevation.level2.radius,
                    color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`,
                    offsetY: AppTokens.Elevation.level2.dy
                  })
              }
              .padding(AppTokens.Spacing.md)

              // Floating A B C Labels Row
              Row({ space: AppTokens.Spacing.sm }) {
                Circle({ width: 10, height: 10 }).fill(AppTokens.Colors.primary);
                Text("A")
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(AppTokens.Colors.onSurface)

                Circle({ width: 10, height: 10 }).fill(AppTokens.Colors.secondary);
                Text("B")
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(AppTokens.Colors.onSurface)

                Circle({ width: 10, height: 10 }).fill(AppTokens.Colors.tertiary);
                Text("C")
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(AppTokens.Colors.onSurface)
              }
              .padding({
                horizontal: AppTokens.Spacing.md,
                vertical: AppTokens.Spacing.xs
              })
              .backgroundColor(applyOpacity(AppTokens.Colors.surface, 0.9))
              .borderRadius(AppTokens.Shapes.small)
              .margin(AppTokens.Spacing.md)
            }
            .width('100%')

            Text("Your Coupon Packs")
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

            // Coupons LazyRow
            Scroll() {
              Row({ space: AppTokens.Spacing.lg }) {
                ForEach(this.coupons, (coupon: Coupon) => {
                  // Card Structure
                  Stack() {
                    // Card Content VStack
                    Column() {
                      Row({ space: AppTokens.Spacing.sm }) {
                        Circle({ width: 14, height: 14 }).fill(AppTokens.Colors.primary);
                        Text(coupon.title)
                          .fontSize(AppTokens.Typography.title.size)
                          .fontWeight(AppTokens.Typography.title.weight)
                          .fontColor(AppTokens.Colors.onSurface)
                      }

                      Text(coupon.value)
                        .fontSize(AppTokens.Typography.display.size)
                        .fontWeight(AppTokens.Typography.display.weight)
                        .fontColor(AppTokens.Colors.onSurface)
                        .margin({ top: AppTokens.Spacing.sm })

                      // Redeem Button
                      Button("Redeem")
                        .fontSize(AppTokens.Typography.label.size)
                        .fontWeight(AppTokens.Typography.label.weight)
                        .fontColor(AppTokens.Colors.onPrimary)
                        .width('100%')
                        .height(40)
                        .backgroundColor(AppTokens.Colors.primary)
                        .borderRadius(AppTokens.Shapes.medium)
                        .margin({ top: AppTokens.Spacing.sm })
                    }
                    .alignItems(HorizontalAlign.Start)
                    .padding(AppTokens.Spacing.lg)
                    .linearGradient({
                      angle: 90,
                      colors: [
                        [applyOpacity(coupon.colorA, 0.18), 0.0],
                        [applyOpacity(coupon.colorB, 0.18), 1.0]
                      ]
                    })
                    .borderRadius(AppTokens.Shapes.large)
                  }
                  .width(200)
                  .height(140)
                  .backgroundColor(AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shapes.large)
                  .shadow({
                    radius: AppTokens.Elevation.level2.radius,
                    color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`,
                    offsetY: AppTokens.Elevation.level2.dy
                  })
                })
              }
              .padding({ horizontal: AppTokens.Spacing.xs })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            Blank().height(AppTokens.Spacing.sm)

            // Bottom Buttons Row
            Row({ space: AppTokens.Spacing.md }) {
              Button("My Coupons")
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.onSecondary)
                .layoutWeight(1)
                .height(52)
                .backgroundColor(AppTokens.Colors.secondary)
                .borderRadius(AppTokens.Shapes.large)

              Button("Explore More")
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.onPrimary)
                .layoutWeight(1)
                .height(52)
                .backgroundColor(AppTokens.Colors.primary)
                .borderRadius(AppTokens.Shapes.large)
            }
            .width('100%')
          }
          .padding({ horizontal: AppTokens.Spacing.lg })
          .alignItems(HorizontalAlign.Start)
        }
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [
          [applyOpacity(AppTokens.Colors.secondary, 0.25), 0.0],
          [AppTokens.Colors.background, 0.5],
          [applyOpacity(AppTokens.Colors.primary, 0.25), 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
  }
}