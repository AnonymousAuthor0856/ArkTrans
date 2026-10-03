// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
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
  }

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes = {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 14
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly ElevationMapping = {
    level2: { opacity: 0.12, radius: 8, dy: 4 }
  }
}

// Marker.ets
export interface Marker {
  id: number;
  x: number;
  y: number;
  label: string;
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { id: 1, x: 120, y: 200, label: 'Store A' },
    { id: 2, x: 360, y: 400, label: 'Store B' }
  ];

  build() {
    Column() {
      Text('Product Detail')
        .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
        .foregroundColor(AppTokens.Colors.primary)
        .alignSelf(ItemAlign.Start)

      // Product Card
      Column({ space: AppTokens.Spacing.md }) {
        // Image Placeholder
        Rectangle()
          .fill(Color(AppTokens.Colors.surfaceVariant))
          .height(160)
          .width('100%')

        Text('Monochrome Bag')
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
          .foregroundColor(AppTokens.Colors.onSurface)

        Text('A minimalist and timeless design piece.')
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
          .foregroundColor(AppTokens.Colors.tertiary)

        Text('$79.00')
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
          .foregroundColor(AppTokens.Colors.primary)

        Button('Add to Cart')
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
          .backgroundColor(AppTokens.Colors.primary)
          .foregroundColor(AppTokens.Colors.onPrimary)
          .borderRadius(AppTokens.Shapes.mediumCornerRadius)
          .height(48)
          .onClick(() => {
            console.info('Add to Cart tapped!');
          })
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
      .width('100%')

      // Map Area
      Stack() {
        // Background for map area
        Rect()
          .fill(Color(AppTokens.Colors.surfaceVariant))
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
          .width('100%')
          .height('100%')

        // Canvas for drawing markers
        CanvasRenderingContext2D()
          .draw((context: CanvasRenderingContext2D, rect: Rect) => {
            this.markers.forEach(marker => {
              context.beginPath();
              context.arc(marker.x, marker.y, 14, 0, Math.PI * 2);
              context.fillStyle = AppTokens.Colors.primary;
              context.fill();
            });
          })
          .width('100%')
          .height('100%')
      }
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.largeCornerRadius)
      .width('100%')
      .height(240)

      // Bottom Action Buttons
      Row({ space: AppTokens.Spacing.md }) {
        Button('Add Marker')
          .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
          .backgroundColor(AppTokens.Colors.secondary)
          .foregroundColor(AppTokens.Colors.onSecondary)
          .borderRadius(AppTokens.Shapes.mediumCornerRadius)
          .height(44)
          .layoutWeight(1)
          .onClick(() => {
            const newMarker: Marker = {
              id: Date.now(),
              x: Math.random() * 400 + 100,
              y: Math.random() * 300 + 150,
              label: 'New'
            };
            this.markers.push(newMarker);
          })

        Button('Clear')
          .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
          .backgroundColor(AppTokens.Colors.tertiary)
          .foregroundColor(AppTokens.Colors.onTertiary)
          .borderRadius(AppTokens.Shapes.mediumCornerRadius)
          .height(44)
          .layoutWeight(1)
          .onClick(() => {
            this.markers = [];
          })
      }
      .width('100%')
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
    .width('100%')
    .height('100%')
  }
}