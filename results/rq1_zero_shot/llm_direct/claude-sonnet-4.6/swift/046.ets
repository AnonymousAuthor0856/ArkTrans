import { LengthMetrics } from '@kit.ArkUI';

// MARK: - AppTokens

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF7B61FF';
    export const secondary: string = '#FF26C6DA';
    export const tertiary: string = '#FFFF8A80';
    export const background: string = '#FFF5F7FF';
    export const surface: string = '#FFFFFFFF';
    export const surfaceVariant: string = '#FFF0F2F8';
    export const outline: string = '#FFE0E3EB';
    export const success: string = '#FF22C55E';
    export const warning: string = '#FFF59E0B';
    export const error: string = '#FFEF4444';
    export const onPrimary: string = '#FFFFFFFF';
    export const onSecondary: string = '#FF0B1220';
    export const onTertiary: string = '#FF0B1220';
    export const onBackground: string = '#FF0B1220';
    export const onSurface: string = '#FF0B1220';
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28;
    export const headlineSize: number = 20;
    export const titleSize: number = 16;
    export const bodySize: number = 14;
    export const labelSize: number = 12;
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

  export namespace ElevationMapping {
    export const level1Radius: number = 4;
    export const level1Dy: number = 2;
    export const level1Opacity: number = 0.12;
    export const level2Radius: number = 10;
    export const level2Dy: number = 6;
    export const level2Opacity: number = 0.16;
    export const level3Radius: number = 14;
    export const level3Dy: number = 8;
    export const level3Opacity: number = 0.18;
  }
}

// MARK: - Data Models

interface Coupon {
  id: number;
  title: string;
  value: string;
  colorA: string;
  colorB: string;
}

interface MapPin {
  x: number;
  y: number;
  label: string;
  tint: string;
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  private coupons: Coupon[] = [
    {
      id: 1,
      title: 'Grocery Pack',
      value: '-$5',
      colorA: AppTokens.Colors.primary,
      colorB: AppTokens.Colors.secondary
    },
    {
      id: 2,
      title: 'Cafe Bundle',
      value: '-15%',
      colorA: AppTokens.Colors.secondary,
      colorB: AppTokens.Colors.tertiary
    },
    {
      id: 3,
      title: 'Electro Deal',
      value: '-$20',
      colorA: AppTokens.Colors.tertiary,
      colorB: AppTokens.Colors.primary
    },
    {
      id: 4,
      title: 'Fashion Duo',
      value: '-10%',
      colorA: AppTokens.Colors.secondary,
      colorB: AppTokens.Colors.primary
    }
  ];

  @State private pins: MapPin[] = [
    { x: 140, y: 220, label: 'A', tint: AppTokens.Colors.primary },
    { x: 320, y: 400, label: 'B', tint: AppTokens.Colors.secondary },
    { x: 520, y: 300, label: 'C', tint: AppTokens.Colors.tertiary }
  ];

  @Builder
  CouponCard(coupon: Coupon) {
    Stack() {
      RoundedRect()

      Column({ space: AppTokens.Spacing.sm }) {
        Row({ space: AppTokens.Spacing.sm }) {
          Circle()
            .fill(AppTokens.Colors.primary)
            .width(14)
            .height(14)
          Text(coupon.title)
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(VerticalAlign.Center)

        Text(coupon.value)
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)

        Button('Redeem')
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .height(40)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(AppTokens.Shapes.mediumCornerRadius)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 90,
        colors: [
          [coupon.colorA + '2E', 0.0],
          [coupon.colorB + '2E', 1.0]
        ]
      })
      .borderRadius(AppTokens.Shapes.largeCornerRadius)
    }
    .width(200)
    .height(140)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.largeCornerRadius)
    .shadow({
      radius: AppTokens.ElevationMapping.level2Radius,
      color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2Opacity})`,
      offsetY: AppTokens.ElevationMapping.level2Dy
    })
  }

  @Builder
  MapArea() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Stack() {
        Canvas(new CanvasRenderingContext2D(new RenderingContextSettings(true)))
          .width('100%')
          .height('100%')
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
          .onReady((event?: CanvasReadyEvent) => {
            if (event) {
              const ctx = event.context as CanvasRenderingContext2D;
              const w = ctx.width;
              const h = ctx.height;
              ctx.fillStyle = AppTokens.Colors.surfaceVariant;
              ctx.fillRect(0, 0, w, h);
              for (const pin of this.pins) {
                ctx.beginPath();
                ctx.arc(pin.x, pin.y, 14, 0, Math.PI * 2);
                ctx.fillStyle = pin.tint;
                ctx.fill();
              }
            }
          })
      }
      .width('100%')
      .aspectRatio(16 / 9)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.largeCornerRadius)
      .padding(AppTokens.Spacing.md)
      .shadow({
        radius: AppTokens.ElevationMapping.level2Radius,
        color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2Opacity})`,
        offsetY: AppTokens.ElevationMapping.level2Dy
      })

      Row({ space: AppTokens.Spacing.sm }) {
        Circle()
          .fill(AppTokens.Colors.primary)
          .width(10)
          .height(10)
        Text('A')
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Circle()
          .fill(AppTokens.Colors.secondary)
          .width(10)
          .height(10)
        Text('B')
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Circle()
          .fill(AppTokens.Colors.tertiary)
          .width(10)
          .height(10)
        Text('C')
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(VerticalAlign.Center)
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md,
        top: AppTokens.Spacing.xs,
        bottom: AppTokens.Spacing.xs
      })
      .backgroundColor('#E6FFFFFF')
      .borderRadius(AppTokens.Shapes.smallCornerRadius)
      .margin(AppTokens.Spacing.md)
    }
    .width('100%')
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            [AppTokens.Colors.secondary + '40', 0.0],
            [AppTokens.Colors.background, 0.5],
            [AppTokens.Colors.primary + '40', 1.0]
          ]
        })

      // Main content
      Column({ space: AppTokens.Spacing.lg }) {
        // Top navigation bar
        Row() {
          Button({ type: ButtonType.Circle }) {
            Circle()
              .fill(AppTokens.Colors.onSurface)
              .width(20)
              .height(20)
          }
          .width(40)
          .height(40)
          .backgroundColor(Color.Transparent)
          .margin({ left: AppTokens.Spacing.lg })

          Blank()

          Text('Coupon Pack')
            .fontSize(AppTokens.TypographyTokens.displaySize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Button({ type: ButtonType.Circle }) {
            Circle()
              .fill(AppTokens.Colors.primary)
              .width(20)
              .height(20)
          }
          .width(40)
          .height(40)
          .backgroundColor(Color.Transparent)
          .margin({ right: AppTokens.Spacing.lg })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding({ top: AppTokens.Spacing.lg })

        // Main content area
        Column({ space: AppTokens.Spacing.lg }) {
          Text('Nearby Packs')
            .fontSize(AppTokens.TypographyTokens.headlineSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')

          this.MapArea()

          Text('Your Coupon Packs')
            .fontSize(AppTokens.TypographyTokens.headlineSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')

          // Coupon horizontal scroll
          Scroll() {
            Row({ space: AppTokens.Spacing.lg }) {
              ForEach(this.coupons, (coupon: Coupon) => {
                this.CouponCard(coupon)
              }, (coupon: Coupon) => coupon.id.toString())
            }
            .padding({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.xs })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Blank()
            .height(AppTokens.Spacing.sm)

          // Bottom buttons row
          Row({ space: AppTokens.Spacing.md }) {
            Button('My Coupons')
              .fontSize(AppTokens.TypographyTokens.titleSize)
              .fontWeight(FontWeight.Medium)
              .layoutWeight(1)
              .height(52)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .borderRadius(AppTokens.Shapes.largeCornerRadius)

            Button('Explore More')
              .fontSize(AppTokens.TypographyTokens.titleSize)
              .fontWeight(FontWeight.Medium)
              .layoutWeight(1)
              .height(52)
              .backgroundColor(AppTokens.Colors.primary)
              .fontColor(AppTokens.Colors.onPrimary)
              .borderRadius(AppTokens.Shapes.largeCornerRadius)
          }
          .width('100%')
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}