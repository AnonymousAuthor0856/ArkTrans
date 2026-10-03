import { Window } from '@kit.ArkUI'

// Token Definitions
const AppTokens = {
  Colors: {
    primary: '#111111',
    secondary: '#333333',
    tertiary: '#777777',
    background: '#FFFFFF',
    surface: '#F9F9F9',
    surfaceVariant: '#E5E5E5',
    outline: '#CCCCCC',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#DC2626',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#111111',
    onBackground: '#111111',
    onSurface: '#111111'
  },
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }
}

interface Marker {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { x: 120, y: 200, label: "Store A" },
    { x: 360, y: 400, label: "Store B" }
  ];

  build() {
    Column() {
      Text("Product Detail")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.primary)

      // Product Card
      Column() {
        // Image Placeholder
        Row()
          .width('100%')
          .height(160)
          .backgroundColor(AppTokens.Colors.surfaceVariant)

        Text("Monochrome Bag")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.md })

        Text("A minimalist and timeless design piece.")
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.tertiary)
          .margin({ top: AppTokens.Spacing.sm })

        Text("$79.00")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.md })

        Button("Add to Cart")
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(10)
          .height(48)
          .width('100%')
          .margin({ top: AppTokens.Spacing.lg })
          .onClick(() => {
            // Add to cart logic
          })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(14)
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.12)', offsetY: 4 })
      .margin({ top: AppTokens.Spacing.lg })

      // Map Canvas Area
      Stack() {
        // Background for map area
        Row()
          .width('100%')
          .height(240)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(14)

        // Canvas for Markers
        CanvasRenderingContext2D()
          .width('100%')
          .height(240)
          .onReady((context: CanvasRenderingContext2D) => {
            context.fillStyle = AppTokens.Colors.surfaceVariant;
            context.fillRect(0, 0, context.canvas.width, context.canvas.height);

            this.markers.forEach(marker => {
              context.beginPath();
              context.arc(marker.x, marker.y, 14, 0, 2 * Math.PI);
              context.fillStyle = AppTokens.Colors.primary;
              context.fill();
            });
          })
      }
      .width('100%')
      .height(240)
      .borderRadius(14)
      .margin({ top: AppTokens.Spacing.lg })

      // Action Buttons
      Row() {
        Button("Add Marker")
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .borderRadius(10)
          .height(44)
          .layoutWeight(1)
          .onClick(() => {
            const newX = Math.floor(Math.random() * (500 - 100 + 1)) + 100;
            const newY = Math.floor(Math.random() * (450 - 150 + 1)) + 150;
            this.markers.push({ x: newX, y: newY, label: "New" });
          })

        Button("Clear")
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.tertiary)
          .fontColor(AppTokens.Colors.onTertiary)
          .borderRadius(10)
          .height(44)
          .layoutWeight(1)
          .margin({ left: AppTokens.Spacing.md })
          .onClick(() => {
            this.markers = [];
          })
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.lg })

    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
  }
}