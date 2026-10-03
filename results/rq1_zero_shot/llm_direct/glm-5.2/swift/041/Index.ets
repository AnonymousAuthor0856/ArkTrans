// AppTokens.ets
// 集中管理应用的设计系统代币，方便统一修改和维护。

export class AppColors {
  static readonly primary: string = '#111111';
  static readonly secondary: string = '#333333';
  static readonly tertiary: string = '#777777';
  static readonly background: string = '#FFFFFF';
  static readonly surface: string = '#F9F9F9';
  static readonly surfaceVariant: string = '#E5E5E5';
  static readonly outline: string = '#CCCCCC';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#DC2626';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#111111';
  static readonly onBackground: string = '#111111';
  static readonly onSurface: string = '#111111';
}

export class AppTypography {
  static readonly display: Font = { size: 28, weight: FontWeight.Bold };
  static readonly title: Font = { size: 18, weight: FontWeight.Medium };
  static readonly body: Font = { size: 14, weight: FontWeight.Normal };
  static readonly label: Font = { size: 12, weight: FontWeight.Medium };
}

export class AppShapes {
  static readonly smallCornerRadius: number = 6;
  static readonly mediumCornerRadius: number = 10;
  static readonly largeCornerRadius: number = 14;
}

export class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

export class ShadowSpec {
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

export class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.12);
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.15);
}

// Marker Data Model
export class Marker {
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

// RootScreen.ets
import { AppColors, AppTypography, AppShapes, AppSpacing, AppElevation, Marker } from './AppTokens';

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    new Marker(120, 200, 'Store A'),
    new Marker(360, 400, 'Store B')
  ];

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.background);

      // Main Content
      Column({ space: AppSpacing.lg }) {
        Text('Product Detail')
          .font(AppTypography.display)
          .fontColor(AppColors.primary)
          .width('100%');

        // Product Info Card
        Column({ space: AppSpacing.md }) {
          // Image Placeholder
          Column()
            .width('100%')
            .height(160)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.mediumCornerRadius);

          Text('Monochrome Bag')
            .font(AppTypography.title)
            .fontColor(AppColors.onSurface)
            .width('100%');

          Text('A minimalist and timeless design piece.')
            .font(AppTypography.body)
            .fontColor(AppColors.tertiary)
            .width('100%');

          Text('$79.00')
            .font(AppTypography.title)
            .fontColor(AppColors.primary)
            .width('100%');

          // Add to Cart Button
          Button('Add to Cart', { type: ButtonType.Normal })
            .font(AppTypography.title)
            .fontColor(AppColors.onPrimary)
            .width('100%')
            .height(48)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.mediumCornerRadius)
            .onClick(() => {
              console.log('Add to Cart tapped!');
            });
        }
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.largeCornerRadius)
        .shadow({
          radius: AppElevation.level2.radius,
          color: `rgba(0,0,0,${AppElevation.level2.opacity})`,
          offsetX: 0,
          offsetY: AppElevation.level2.dy
        });

        // Map Area
        Stack() {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.largeCornerRadius);

          // Canvas for drawing markers
          Column() {
            Canvas(this.markers)
              .width('100%')
              .height('100%')
              .onDraw((context: CanvasRenderingContext2D, markers: Marker[]) => {
                const canvasWidth = context.canvas.width;
                const canvasHeight = context.canvas.height;
                
                // Draw markers
                markers.forEach(marker => {
                  context.beginPath();
                  context.arc(marker.x, marker.y, 14, 0, Math.PI * 2);
                  context.fillStyle = AppColors.primary;
                  context.fill();
                });
              });
          }
          .padding(AppSpacing.lg);
        }
        .width('100%')
        .height(240);

        // Bottom Action Buttons Row
        Row({ space: AppSpacing.md }) {
          Button('Add Marker', { type: ButtonType.Normal })
            .font(AppTypography.label)
            .fontColor(AppColors.onSecondary)
            .layoutWeight(1)
            .height(44)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.mediumCornerRadius)
            .onClick(() => {
              const newX = Math.floor(Math.random() * (500 - 100 + 1)) + 100;
              const newY = Math.floor(Math.random() * (450 - 150 + 1)) + 150;
              this.markers.push(new Marker(newX, newY, 'New'));
            });

          Button('Clear', { type: ButtonType.Normal })
            .font(AppTypography.label)
            .fontColor(AppColors.onTertiary)
            .layoutWeight(1)
            .height(44)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(AppShapes.mediumCornerRadius)
            .onClick(() => {
              this.markers = [];
            });
        }
        .width('100%');
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL]);
  }
}