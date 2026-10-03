import { router } from '@kit.ArkUI';

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#111111';
    export const secondary: string = '#333333';
    export const tertiary: string = '#777777';
    export const background: string = '#FFFFFF';
    export const surface: string = '#F9F9F9';
    export const surfaceVariant: string = '#E5E5E5';
    export const outline: string = '#CCCCCC';
    export const success: string = '#16A34A';
    export const warning: string = '#F59E0B';
    export const error: string = '#DC2626';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#FFFFFF';
    export const onTertiary: string = '#111111';
    export const onBackground: string = '#111111';
    export const onSurface: string = '#111111';
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28;
    export const titleSize: number = 18;
    export const bodySize: number = 14;
    export const labelSize: number = 12;
  }

  export namespace Spacing {
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
    export const xxl: number = 32;
  }

  export namespace Radius {
    export const small: number = 6;
    export const medium: number = 10;
    export const large: number = 14;
  }
}

interface MarkerData {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State markers: MarkerData[] = [
    { x: 120, y: 200, label: 'Store A' },
    { x: 360, y: 400, label: 'Store B' }
  ];

  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawMap() {
    const ctx = this.canvasContext;
    const w = this.canvasWidth;
    const h = this.canvasHeight;

    ctx.clearRect(0, 0, w, h);

    // Background rect
    ctx.fillStyle = AppTokens.Colors.surfaceVariant;
    ctx.fillRect(0, 0, w, h);

    // Draw markers
    this.markers.forEach((marker: MarkerData) => {
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 14, 0, Math.PI * 2);
      ctx.fillStyle = AppTokens.Colors.primary;
      ctx.fill();
      ctx.closePath();
    });
  }

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.lg }) {

        // Title
        Text('Product Detail')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')

        // Product Card
        Column({ space: AppTokens.Spacing.md }) {
          // Product image placeholder
          Row()
            .width('100%')
            .height(160)
            .backgroundColor(AppTokens.Colors.surfaceVariant)

          // Product name
          Text('Monochrome Bag')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')

          // Product description
          Text('A minimalist and timeless design piece.')
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppTokens.Colors.tertiary)
            .width('100%')

          // Price
          Text('$79.00')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')

          // Add to Cart button
          Button('Add to Cart')
            .width('100%')
            .height(48)
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Radius.medium)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Radius.large)
        .shadow({
          radius: 8,
          color: '#1F000000',
          offsetX: 0,
          offsetY: 4
        })

        // Map / Canvas area
        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height(240)
            .borderRadius(AppTokens.Radius.large)
            .backgroundColor(AppTokens.Colors.surface)
            .onReady(() => {
              this.canvasWidth = this.canvasContext.width;
              this.canvasHeight = this.canvasContext.height;
              this.drawMap();
            })
        }
        .width('100%')
        .height(240)
        .borderRadius(AppTokens.Radius.large)
        .backgroundColor(AppTokens.Colors.surface)

        // Action buttons row
        Row({ space: AppTokens.Spacing.md }) {
          Button('Add Marker')
            .layoutWeight(1)
            .height(44)
            .fontSize(AppTokens.TypographyTokens.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Radius.medium)
            .onClick(() => {
              const newX = Math.floor(Math.random() * 400) + 100;
              const newY = Math.floor(Math.random() * 300) + 150;
              this.markers = [...this.markers, { x: newX, y: newY, label: 'New' }];
              this.drawMap();
            })

          Button('Clear')
            .layoutWeight(1)
            .height(44)
            .fontSize(AppTokens.TypographyTokens.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onTertiary)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Radius.medium)
            .onClick(() => {
              this.markers = [];
              this.drawMap();
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}