import { display } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#FF111111';
  static readonly secondary: string = '#FF333333';
  static readonly tertiary: string = '#FF777777';
  static readonly background: string = '#FFFFFFFF';
  static readonly surface: string = '#FFF9F9F9';
  static readonly surfaceVariant: string = '#FFE5E5E5';
  static readonly outline: string = '#FFCCCCCC';
  static readonly success: string = '#FF16A34A';
  static readonly warning: string = '#FFF59E0B';
  static readonly error: string = '#FFDC2626';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FFFFFFFF';
  static readonly onTertiary: string = '#FF111111';
  static readonly onBackground: string = '#FF111111';
  static readonly onSurface: string = '#FF111111';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly smallCornerRadius: number = 6;
  static readonly mediumCornerRadius: number = 10;
  static readonly largeCornerRadius: number = 14;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.12);
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.15);
}

// MARK: - Marker Data Model
class Marker {
  id: string;
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.id = Math.random().toString(36).substring(2);
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State private markers: Marker[] = [
    new Marker(120, 200, 'Store A'),
    new Marker(360, 400, 'Store B')
  ];

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
            .fontSize(AppTypography.displaySize)
            .fontWeight(AppTypography.displayWeight)
            .fontColor(AppColors.primary)
            .alignSelf(ItemAlign.Start)

          // Product Info Card
          Column({ space: AppSpacing.md }) {
            // Image placeholder
            Row() {}
            .width('100%')
            .height(160)
            .backgroundColor(AppColors.surfaceVariant)

            Text('Monochrome Bag')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
              .fontColor(AppColors.onSurface)
              .alignSelf(ItemAlign.Start)

            Text('A minimalist and timeless design piece.')
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.tertiary)
              .alignSelf(ItemAlign.Start)

            Text('$79.00')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
              .fontColor(AppColors.primary)
              .alignSelf(ItemAlign.Start)

            // Add to Cart Button
            Button('Add to Cart')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
              .width('100%')
              .height(48)
              .backgroundColor(AppColors.primary)
              .fontColor(AppColors.onPrimary)
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
            radius: AppElevation.level2.radius,
            color: `rgba(0,0,0,${AppElevation.level2.opacity})`,
            offsetX: 0,
            offsetY: AppElevation.level2.dy
          })

          // Map Area with Canvas
          Stack() {
            // Background
            Column() {}
            .width('100%')
            .height('100%')
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.largeCornerRadius)

            // Canvas for drawing markers
            Canvas(this.canvasContext)
              .width('100%')
              .height('100%')
              .padding(AppSpacing.lg)
              .onReady(() => {
                this.drawCanvas();
              })
          }
          .width('100%')
          .height(240)
          .borderRadius(AppShapes.largeCornerRadius)
          .clip(true)

          // Bottom Action Buttons Row
          Row({ space: AppSpacing.md }) {
            // Add Marker Button
            Button('Add Marker')
              .fontSize(AppTypography.labelSize)
              .fontWeight(AppTypography.labelWeight)
              .layoutWeight(1)
              .height(44)
              .backgroundColor(AppColors.secondary)
              .fontColor(AppColors.onSecondary)
              .borderRadius(AppShapes.mediumCornerRadius)
              .onClick(() => {
                const newMarker = new Marker(
                  Math.random() * 400 + 100,
                  Math.random() * 300 + 150,
                  'New'
                );
                this.markers = [...this.markers, newMarker];
                this.drawCanvas();
              })

            // Clear Button
            Button('Clear')
              .fontSize(AppTypography.labelSize)
              .fontWeight(AppTypography.labelWeight)
              .layoutWeight(1)
              .height(44)
              .backgroundColor(AppColors.tertiary)
              .fontColor(AppColors.onTertiary)
              .borderRadius(AppShapes.mediumCornerRadius)
              .onClick(() => {
                this.markers = [];
                this.drawCanvas();
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
    }
    .width('100%')
    .height('100%')
  }

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  private drawCanvas(): void {
    const ctx = this.canvasContext;
    if (!ctx) return;

    const width = ctx.width;
    const height = ctx.height;

    // Clear canvas
    ctx.clearRect(0, 0, width, height);

    // Draw background
    ctx.fillStyle = AppColors.surfaceVariant;
    ctx.fillRect(0, 0, width, height);

    // Draw markers
    for (const marker of this.markers) {
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 14, 0, Math.PI * 2);
      ctx.fillStyle = AppColors.primary;
      ctx.fill();
    }
  }
}