@Entry
@Component
struct CouponPackPage {
  @State coupons: CouponInfo[] = [
    { id: 1, title: 'Grocery Pack', value: '-$5', colorA: AppTokens.Colors.primary, colorB: AppTokens.Colors.secondary },
    { id: 2, title: 'Cafe Bundle', value: '-15%', colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.tertiary },
    { id: 3, title: 'Electro Deal', value: '-$20', colorA: AppTokens.Colors.tertiary, colorB: AppTokens.Colors.primary },
    { id: 4, title: 'Fashion Duo', value: '-10%', colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.primary }
  ];

  @State pins: MapPinInfo[] = [
    { id: 'A', x: 140, y: 220, label: 'A', tint: AppTokens.Colors.primary },
    { id: 'B', x: 320, y: 400, label: 'B', tint: AppTokens.Colors.secondary },
    { id: 'C', x: 520, y: 300, label: 'C', tint: AppTokens.Colors.tertiary }
  ];

  private scroller: Scroller = new Scroller();
  private canvasSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings);

  aboutToAppear(): void {
    this.drawMap();
  }

  drawMap(): void {
    const w: number = 360;
    const h: number = 202.5;
    const ctx: CanvasRenderingContext2D = this.canvasContext;
    ctx.fillStyle = AppTokens.Colors.surfaceVariant;
    ctx.fillRect(0, 0, w, h);

    for (let i: number = 0; i < this.pins.length; i++) {
      const pin: MapPinInfo = this.pins[i];
      ctx.beginPath();
      ctx.arc(pin.x, pin.y, 14, 0, Math.PI * 2);
      ctx.fillStyle = pin.tint;
      ctx.fill();
    }
  }

  build() {
    Stack() {
      // Background gradient
      Stack()
        .width('100%')
        .height('100%')
        .linearGradient({
          colors: [
            [AppTokens.Colors.secondary + '40', 0.0],
            [AppTokens.Colors.background, 0.5],
            [AppTokens.Colors.primary + '40', 1.0]
          ],
          direction: GradientDirection.Bottom
        })

      Column({ space: AppTokens.Spacing.lg }) {
        // Top navigation bar
        Row() {
          Circle({ width: 20, height: 20 })
            .fill(AppTokens.Colors.onSurface)
            .margin({ left: AppTokens.Spacing.lg })

          Blank()

          Text('Coupon Pack')
            .font(AppTokens.TypographyTokens.display())
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Circle({ width: 20, height: 20 })
            .fill(AppTokens.Colors.primary)
            .margin({ right: AppTokens.Spacing.lg })
        }
        .margin({ top: AppTokens.Spacing.lg })

        // Main content
        Column({ space: AppTokens.Spacing.lg }) {
          Text('Nearby Packs')
            .font(AppTokens.TypographyTokens.headline())
            .fontColor(AppTokens.Colors.onSurface)

          // Map area
          Stack({ alignContent: Alignment.TopEnd }) {
            // Map card
            Stack() {
              Canvas(this.canvasContext)
                .onReady(() => {
                  this.drawMap();
                })
                .width('100%')
                .height('100%')
                .padding(AppTokens.Spacing.md)
            }
            .width('100%')
            .aspectRatio(16 / 9)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.largeCornerRadius)
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
              offsetY: AppTokens.ElevationMapping.level2.dy
            })

            // Legend row
            Row({ space: AppTokens.Spacing.sm }) {
              Circle({ width: 10, height: 10 }).fill(AppTokens.Colors.primary)
              Text('A')
                .font(AppTokens.TypographyTokens.label())
                .fontColor(AppTokens.Colors.onSurface)

              Circle({ width: 10, height: 10 }).fill(AppTokens.Colors.secondary)
              Text('B')
                .font(AppTokens.TypographyTokens.label())
                .fontColor(AppTokens.Colors.onSurface)

              Circle({ width: 10, height: 10 }).fill(AppTokens.Colors.tertiary)
              Text('C')
                .font(AppTokens.TypographyTokens.label())
                .fontColor(AppTokens.Colors.onSurface)
            }
            .padding({
              left: AppTokens.Spacing.md,
              right: AppTokens.Spacing.md,
              top: AppTokens.Spacing.xs,
              bottom: AppTokens.Spacing.xs
            })
            .backgroundColor(AppTokens.Colors.surface + 'E6')
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .margin(AppTokens.Spacing.md)
          }

          Text('Your Coupon Packs')
            .font(AppTokens.TypographyTokens.headline())
            .fontColor(AppTokens.Colors.onSurface)

          // Coupon horizontal scroll
          Scroll(this.scroller)
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
          {
            Row({ space: AppTokens.Spacing.lg }) {
              ForEach(this.coupons, (coupon: CouponInfo) => {
                // Coupon card
                Stack() {
                  Column({ space: AppTokens.Spacing.sm }) {
                    Row({ space: AppTokens.Spacing.sm }) {
                      Circle({ width: 14, height: 14 }).fill(AppTokens.Colors.primary)
                      Text(coupon.title)
                        .font(AppTokens.TypographyTokens.title())
                        .fontColor(AppTokens.Colors.onSurface)
                    }

                    Text(coupon.value)
                      .font(AppTokens.TypographyTokens.display())
                      .fontColor(AppTokens.Colors.onSurface)

                    Button('Redeem')
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .width('100%')
                      .height(40)
                      .backgroundColor(AppTokens.Colors.primary)
                      .fontColor(AppTokens.Colors.onPrimary)
                      .borderRadius(AppTokens.Shapes.mediumCornerRadius)
                  }
                  .padding(AppTokens.Spacing.lg)
                  .width('100%')
                  .height('100%')
                  .linearGradient({
                    colors: [
                      [coupon.colorA + '2E', 0.0],
                      [coupon.colorB + '2E', 1.0]
                    ],
                    direction: GradientDirection.Right
                  })
                  .borderRadius(AppTokens.Shapes.largeCornerRadius)
                }
                .width(200)
                .height(140)
                .backgroundColor(AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.largeCornerRadius)
                .shadow({
                  radius: AppTokens.ElevationMapping.level2.radius,
                  color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
                  offsetY: AppTokens.ElevationMapping.level2.dy
                })
              }, (coupon: CouponInfo) => coupon.id.toString())
            }
            .padding({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.xs })
          }

          Blank()

          // Bottom buttons
          Row({ space: AppTokens.Spacing.md }) {
            Button('My Coupons')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .layoutWeight(1)
              .height(52)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .borderRadius(AppTokens.Shapes.largeCornerRadius)

            Button('Explore More')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .layoutWeight(1)
              .height(52)
              .backgroundColor(AppTokens.Colors.primary)
              .fontColor(AppTokens.Colors.onPrimary)
              .borderRadius(AppTokens.Shapes.largeCornerRadius)
          }
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

interface CouponInfo {
  id: number;
  title: string;
  value: string;
  colorA: string;
  colorB: string;
}

interface MapPinInfo {
  id: string;
  x: number;
  y: number;
  label: string;
  tint: string;
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#7B61FF';
    export const secondary: string = '#26C6DA';
    export const tertiary: string = '#FF8A80';
    export const background: string = '#F5F7FF';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#F0F2F8';
    export const outline: string = '#E0E3EB';
    export const success: string = '#22C55E';
    export const warning: string = '#F59E0B';
    export const error: string = '#EF4444';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#0B1220';
    export const onTertiary: string = '#0B1220';
    export const onBackground: string = '#0B1220';
    export const onSurface: string = '#0B1220';
  }

  export namespace TypographyTokens {
    export function display(): Font {
      return { size: 28, weight: FontWeight.Bold };
    }
    export function headline(): Font {
      return { size: 20, weight: FontWeight.Medium };
    }
    export function title(): Font {
      return { size: 16, weight: FontWeight.Medium };
    }
    export function body(): Font {
      return { size: 14, weight: FontWeight.Regular };
    }
    export function label(): Font {
      return { size: 12, weight: FontWeight.Medium };
    }
  }

  export namespace Shapes {
    export const smallCornerRadius: number = 8;
    export const mediumCornerRadius: number = 14;
    export const largeCornerRadius: number = 20;
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
    export const xxl: number = 32;
  }

  export interface ShadowSpec {
    elevation: number;
    radius: number;
    dy: number;
    opacity: number;
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 };
    export const level2: ShadowSpec = { elevation: 6, radius: 10, dy: 6, opacity: 0.16 };
    export const level3: ShadowSpec = { elevation: 10, radius: 14, dy: 8, opacity: 0.18 };
  }
}
