import { random } from '@kit.ArkTS'

// --- Design Tokens & Constants ---

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
    onSurface: '#111111',
  },
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  },
  Radius: {
    small: 6,
    medium: 10,
    large: 14,
  }
}

interface Marker {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct ProductDetailPage {
  @State markers: Marker[] = [
    { x: 120, y: 200, label: 'Store A' },
    { x: 360, y: 400, label: 'Store B' }
  ];

  build() {
    Column() {
      // Header
      Text('Product Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.lg })

      // Product Card
      Column() {
        // Placeholder Image
        Row()
          .width('100%')
          .height(160)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Radius.small)

        Text('Monochrome Bag')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.md })

        Text('A minimalist and timeless design piece.')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.tertiary)
          .margin({ top: AppTokens.Spacing.sm })

        Text('$79.00')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.md })

        Button('Add to Cart')
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(AppTokens.Radius.medium)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ top: AppTokens.Spacing.lg })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Radius.large)
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: 4 })

      // Map Section
      Column() {
        Canvas(this)
          .width('100%')
          .height(240)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Radius.large)
          .margin({ top: AppTokens.Spacing.lg })
      }
      .width('100%')

      // Action Buttons
      Row() {
        Button('Add Marker')
          .layoutWeight(1)
          .height(44)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .borderRadius(AppTokens.Radius.medium)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.markers.push({
              x: Math.floor(Math.random() * 400) + 100,
              y: Math.floor(Math.random() * 300) + 150,
              label: 'New'
            });
          })

        Button('Clear')
          .layoutWeight(1)
          .height(44)
          .backgroundColor(AppTokens.Colors.tertiary)
          .fontColor(AppTokens.Colors.onTertiary)
          .borderRadius(AppTokens.Radius.medium)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
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

  drawMap(ctx: CanvasRenderingContext2D, width: number, height: number) {
    // Draw Background Box
    ctx.fillStyle = AppTokens.Colors.surfaceVariant;
    const padding = AppTokens.Spacing.lg;
    ctx.fillRect(padding, padding, width - (padding * 2), height - (padding * 2));

    // Draw Markers
    ctx.fillStyle = AppTokens.Colors.primary;
    for (let i = 0; i < this.markers.length; i++) {
      const m = this.markers[i];
      ctx.beginPath();
      ctx.arc(m.x, m.y, 14, 0, 2 * Math.PI);
      ctx.fill();
    }
  }
}