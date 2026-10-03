import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens (Equivalent to Kotlin's AppTokens object)
// Centralized management of application design system tokens.

interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeTokens {
  smallCornerRadius: number;
  mediumCornerRadius: number;
  largeCornerRadius: number;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ElevationToken {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMapping {
  level1: ElevationToken;
  level2: ElevationToken;
  level3: ElevationToken;
}

export class AppTokens {
  static Colors: ColorTokens = {
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
  };

  static TypographyTokens: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes: ShapeTokens = {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 14
  };

  static Spacing: SpacingTokens = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static ElevationMapping: ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.12 },
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.15 }
  };
}

// MARK: - Marker Data Model
interface Marker {
  id: number; // Using number for unique ID in ArkTS context for simplicity with random generation
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { id: 1, x: 120, y: 200, label: 'Store A' },
    { id: 2, x: 360, y: 400, label: 'Store B' }
  ];

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Product Detail')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)

        // Product Info Card
        Column({ space: AppTokens.Spacing.md }) {
          // Image Placeholder
          Rect()
            .fill(AppTokens.Colors.surfaceVariant)
            .width('100%')
            .height(160)

          Text('Monochrome Bag')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Text('A minimalist and timeless design piece.')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.tertiary)

          Text('$79.00')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.primary)

          // Add to Cart Button
          Button('Add to Cart')
            .onClick(() => {
              console.info('Add to Cart tapped!');
            })
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .width('100%')
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.largeCornerRadius)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        // Map Area
        Stack() {
          // Background for map area
          Rect()
            .width('100%')
            .height('100%')
            .fill(AppTokens.Colors.surfaceVariant)

          // Canvas for drawing markers
          Canvas(this.drawCanvas)
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height(240)
        .borderRadius(AppTokens.Shapes.largeCornerRadius)
        .clip(true) // Ensure corners are clipped if content overflows

        // Bottom Action Buttons
        Row({ space: AppTokens.Spacing.md }) {
          // Add Marker Button
          Button('Add Marker')
            .onClick(() => {
              const newId = Date.now(); // Simple unique ID generation
              const newX = Math.random() * 400 + 100; // Random between 100 and 500
              const newY = Math.random() * 300 + 150; // Random between 150 and 450
              this.markers.push({ id: newId, x: newX, y: newY, label: 'New' });
            })
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .layoutWeight(1)
            .height(44)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)

          // Clear Button
          Button('Clear')
            .onClick(() => {
              this.markers = [];
            })
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .layoutWeight(1)
            .height(44)
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontColor(AppTokens.Colors.onTertiary)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
        }
      }
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
  }

  drawCanvas(context: CanvasRenderingContext2D, canvasWidth: number, canvasHeight: number) {
    this.markers.forEach(marker => {
      context.beginPath();
      context.arc(marker.x, marker.y, 14, 0, 2 * Math.PI);
      context.fillStyle = AppTokens.Colors.primary;
      context.fill();
    });
  }
}