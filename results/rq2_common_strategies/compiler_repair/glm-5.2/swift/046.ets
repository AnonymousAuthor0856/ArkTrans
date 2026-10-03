// AppTokens (Translated from Kotlin/SwiftUI)

class AppColors {
  primary: ResourceColor = '#FF7B61FF';
  secondary: ResourceColor = '#FF26C6DA';
  tertiary: ResourceColor = '#FFFF8A80';
  background: ResourceColor = '#FFF5F7FF';
  surface: ResourceColor = '#FFFFFFFF';
  surfaceVariant: ResourceColor = '#FFF0F2F8';
  outline: ResourceColor = '#FFE0E3EB';
  success: ResourceColor = '#FF22C55E';
  warning: ResourceColor = '#FFF59E0B';
  error: ResourceColor = '#FFEF4444';
  onPrimary: ResourceColor = '#FFFFFFFF';
  onSecondary: ResourceColor = '#FF0B1220';
  onTertiary: ResourceColor = '#FF0B1220';
  onBackground: ResourceColor = '#FF0B1220';
  onSurface: ResourceColor = '#FF0B1220';
}

class AppTypographyTokens {
  display: AppFontStyle = { size: 28, weight: FontWeight.Bold };
  headline: AppFontStyle = { size: 20, weight: FontWeight.Medium };
  title: AppFontStyle = { size: 16, weight: FontWeight.Medium };
  body: AppFontStyle = { size: 14, weight: FontWeight.Normal };
  label: AppFontStyle = { size: 12, weight: FontWeight.Medium };
}

interface AppFontStyle {
  size: number | string | Resource;
  weight: FontWeight | number | string;
}

class AppShapes {
  smallCornerRadius: number = 8;
  mediumCornerRadius: number = 14;
  largeCornerRadius: number = 20;
}

class AppSpacing {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppElevationMapping {
  level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 };
  level2: ShadowSpec = { elevation: 6, radius: 10, dy: 6, opacity: 0.16 };
  level3: ShadowSpec = { elevation: 10, radius: 14, dy: 8, opacity: 0.18 };
}

class AppTokens {
  static readonly Colors: AppColors = new AppColors();
  static readonly TypographyTokens: AppTypographyTokens = new AppTypographyTokens();
  static readonly Shapes: AppShapes = new AppShapes();
  static readonly Spacing: AppSpacing = new AppSpacing();
  static readonly ElevationMapping: AppElevationMapping = new AppElevationMapping();
}

// Data Models
class Coupon {
  id: number;
  title: string;
  value: string;
  colorA: ResourceColor;
  colorB: ResourceColor;

  constructor(id: number, title: string, value: string, colorA: ResourceColor, colorB: ResourceColor) {
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
  tint: ResourceColor;

  constructor(x: number, y: number, label: string, tint: ResourceColor) {
    this.x = x;
    this.y = y;
    this.label = label;
    this.tint = tint;
  }
}

@Entry
@Component
struct RootScreen {
  private coupons: Array<Coupon> = [
    new Coupon(1, "Grocery Pack", "-$5", AppTokens.Colors.primary, AppTokens.Colors.secondary),
    new Coupon(2, "Cafe Bundle", "-15%", AppTokens.Colors.secondary, AppTokens.Colors.tertiary),
    new Coupon(3, "Electro Deal", "-$20", AppTokens.Colors.tertiary, AppTokens.Colors.primary),
    new Coupon(4, "Fashion Duo", "-10%", AppTokens.Colors.secondary, AppTokens.Colors.primary)
  ];

  private pins: Array<MapPin> = [
    new MapPin(140, 100, "A", AppTokens.Colors.primary),
    new MapPin(220, 160, "B", AppTokens.Colors.secondary),
    new MapPin(300, 80, "C", AppTokens.Colors.tertiary)
  ];

  build() {
    Stack() {
      // Background Gradient
      Column() {
        // Top App Bar
        Row() {
          Button() {
            Circle().width(20).height(20).fill(AppTokens.Colors.onSurface)
          }
          .backgroundColor(Color.Transparent)

          Blank()

          Text("Coupon Pack")
            .fontSize(AppTokens.TypographyTokens.display.size)
            .fontWeight(AppTokens.TypographyTokens.display.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Button() {
            Circle().width(20).height(20).fill(AppTokens.Colors.primary)
          }
          .backgroundColor(Color.Transparent)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        // Main Content
        Column() {
          Text("Nearby Packs")
            .fontSize(AppTokens.TypographyTokens.headline.size)
            .fontWeight(AppTokens.TypographyTokens.headline.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

          // Map Area
          Stack({ alignContent: Alignment.TopEnd }) {
            Column() {
              // Canvas for Map and Pins
              Column() {
                Stack() {
                  // Draw Surface Variant Background
                  Column()
                    .width('100%')
                    .height('100%')
                    .backgroundColor(AppTokens.Colors.surfaceVariant)
                  
                  // Draw Pins
                  ForEach(this.pins, (pin: MapPin) => {
                    Column()
                      .width(28)
                      .height(28)
                      .borderRadius(14)
                      .backgroundColor(pin.tint)
                      .position({ x: pin.x - 14, y: pin.y - 14 })
                  })
                }
                .width('100%')
                .height('100%')
              }
              .width('100%')
              .aspectRatio(1.7) // Approx 16:9
              .borderRadius(AppTokens.Shapes.largeCornerRadius)
              .backgroundColor(AppTokens.Colors.surface)
              .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })
            }
            .padding(AppTokens.Spacing.md)

            // Floating A B C Labels
            Row({ space: AppTokens.Spacing.sm }) {
              Circle().width(10).height(10).fill(AppTokens.Colors.primary)
              Text("A")
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.onSurface)
              
              Circle().width(10).height(10).fill(AppTokens.Colors.secondary)
              Text("B")
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.onSurface)
                
              Circle().width(10).height(10).fill(AppTokens.Colors.tertiary)
              Text("C")
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.onSurface)
            }
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .opacity(0.9)
            .margin({ top: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          }
          .width('100%')

          Text("Your Coupon Packs")
            .fontSize(AppTokens.TypographyTokens.headline.size)
            .fontWeight(AppTokens.TypographyTokens.headline.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

          // Coupons LazyRow
          Scroll() {
            Row({ space: AppTokens.Spacing.lg }) {
              ForEach(this.coupons, (coupon: Coupon) => {
                Stack() {
                  // Card Content
                  Column({ space: AppTokens.Spacing.sm }) {
                    Row({ space: AppTokens.Spacing.sm }) {
                      Circle().width(14).height(14).fill(AppTokens.Colors.primary)
                      Text(coupon.title)
                        .fontSize(AppTokens.TypographyTokens.title.size)
                        .fontWeight(AppTokens.TypographyTokens.title.weight)
                        .fontColor(AppTokens.Colors.onSurface)
                    }
                    
                    Text(coupon.value)
                      .fontSize(AppTokens.TypographyTokens.display.size)
                      .fontWeight(AppTokens.TypographyTokens.display.weight)
                      .fontColor(AppTokens.Colors.onSurface)

                    Button() {
                      Text("Redeem")
                        .fontSize(AppTokens.TypographyTokens.label.size)
                        .fontWeight(AppTokens.TypographyTokens.label.weight)
                        .fontColor(AppTokens.Colors.onPrimary)
                    }
                    .width('100%')
                    .height(40)
                    .backgroundColor(AppTokens.Colors.primary)
                    .borderRadius(AppTokens.Shapes.mediumCornerRadius)
                  }
                  .width('100%')
                  .height('100%')
                  .padding(AppTokens.Spacing.lg)
                  .alignItems(HorizontalAlign.Start)
                  .linearGradient({
                    direction: GradientDirection.Right,
                    colors: [[coupon.colorA, 0.18], [coupon.colorB, 0.18]]
                  })
                }
                .width(200)
                .height(140)
                .borderRadius(AppTokens.Shapes.largeCornerRadius)
                .backgroundColor(AppTokens.Colors.surface)
                .clip(true)
                .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })
              })
            }
            .padding({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.xs })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Blank().height(AppTokens.Spacing.sm)

          // Bottom Buttons
          Row({ space: AppTokens.Spacing.md }) {
            Button() {
              Text("My Coupons")
                .fontSize(AppTokens.TypographyTokens.title.size)
                .fontWeight(AppTokens.TypographyTokens.title.weight)
                .fontColor(AppTokens.Colors.onSecondary)
            }
            .layoutWeight(1)
            .height(52)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.largeCornerRadius)

            Button() {
              Text("Explore More")
                .fontSize(AppTokens.TypographyTokens.title.size)
                .fontWeight(AppTokens.TypographyTokens.title.weight)
                .fontColor(AppTokens.Colors.onPrimary)
            }
            .layoutWeight(1)
            .height(52)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.largeCornerRadius)
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary, 0.25],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary, 0.25]
        ]
      })
    }
    .width('100%')
    .height('100%')
  }
}