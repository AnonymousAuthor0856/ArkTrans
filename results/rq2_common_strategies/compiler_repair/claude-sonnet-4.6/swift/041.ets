import { router } from '@kit.ArkUI';

// AppTokens - Design System Tokens
class AppColors {
  static primary: string = '#FF111111';
  static secondary: string = '#FF333333';
  static tertiary: string = '#FF777777';
  static background: string = '#FFFFFFFF';
  static surface: string = '#FFF9F9F9';
  static surfaceVariant: string = '#FFE5E5E5';
  static outline: string = '#FFCCCCCC';
  static success: string = '#FF16A34A';
  static warning: string = '#FFF59E0B';
  static error: string = '#FFDC2626';
  static onPrimary: string = '#FFFFFFFF';
  static onSecondary: string = '#FFFFFFFF';
  static onTertiary: string = '#FF111111';
  static onBackground: string = '#FF111111';
  static onSurface: string = '#FF111111';
}

class AppSpacing {
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 32;
}

class AppShapes {
  static smallCornerRadius: number = 6;
  static mediumCornerRadius: number = 10;
  static largeCornerRadius: number = 14;
}

interface MarkerItem {
  id: string;
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State markers: MarkerItem[] = [
    { id: '1', x: 120, y: 200, label: 'Store A' },
    { id: '2', x: 360, y: 400, label: 'Store B' }
  ];

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawMarkers() {
    const ctx = this.canvasContext;
    const canvasWidth = ctx.width;
    const canvasHeight = ctx.height;

    // Draw background
    ctx.clearRect(0, 0, canvasWidth, canvasHeight);
    ctx.fillStyle = AppColors.surfaceVariant;
    ctx.fillRect(0, 0, canvasWidth, canvasHeight);

    // Draw markers
    for (const marker of this.markers) {
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 14, 0, Math.PI * 2);
      ctx.fillStyle = AppColors.primary;
      ctx.fill();
      ctx.closePath();
    }
  }

  build() {
    Stack() {
      // Background
      Column() {}
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      // Main content
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          // Title
          Text('Product Detail')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.primary)
            .alignSelf(ItemAlign.Start)

          // Product Info Card
          Column({ space: AppSpacing.md }) {
            // Image placeholder
            Row() {}
            .width('100%')
            .height(160)
            .backgroundColor(AppColors.surfaceVariant)

            // Product name
            Text('Monochrome Bag')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .alignSelf(ItemAlign.Start)

            // Description
            Text('A minimalist and timeless design piece.')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.tertiary)
              .alignSelf(ItemAlign.Start)

            // Price
            Text('$79.00')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.primary)
              .alignSelf(ItemAlign.Start)

            // Add to Cart Button
            Button('Add to Cart')
              .width('100%')
              .height(48)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.mediumCornerRadius)
              .onClick(() => {
                console.log('Add to Cart tapped!');
              })
          }
          .padding(AppSpacing.lg)
          .width('100%')
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.largeCornerRadius)
          .shadow({
            radius: 8,
            color: '#1F000000',
            offsetX: 0,
            offsetY: 4
          })

          // Map area with Canvas
          Stack() {
            // Background rounded rectangle
            Column() {}
            .width('100%')
            .height('100%')
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.largeCornerRadius)

            // Canvas for drawing markers
            Canvas(this.canvasContext)
              .width('100%')
              .height('100%')
              .borderRadius(AppShapes.largeCornerRadius)
              .onReady(() => {
                this.drawMarkers();
              })
          }
          .width('100%')
          .height(240)
          .borderRadius(AppShapes.largeCornerRadius)
          .clip(true)

          // Bottom action buttons row
          Row({ space: AppSpacing.md }) {
            // Add Marker Button
            Button('Add Marker')
              .layoutWeight(1)
              .height(44)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
              .backgroundColor(AppColors.secondary)
              .borderRadius(AppShapes.mediumCornerRadius)
              .onClick(() => {
                const newMarker: MarkerItem = {
                  id: Date.now().toString(),
                  x: Math.random() * 400 + 100,
                  y: Math.random() * 300 + 150,
                  label: 'New'
                };
                this.markers = [...this.markers, newMarker];
                this.drawMarkers();
              })

            // Clear Button
            Button('Clear')
              .layoutWeight(1)
              .height(44)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onTertiary)
              .backgroundColor(AppColors.tertiary)
              .borderRadius(AppShapes.mediumCornerRadius)
              .onClick(() => {
                this.markers = [];
                this.drawMarkers();
              })
          }
          .width('100%')
        }
        .padding(AppSpacing.lg)
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }
}