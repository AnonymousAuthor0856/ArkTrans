// AppTokens: Centralized design system tokens for unified modification and maintenance.
class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#FF111111',
    secondary: '#FF333333',
    tertiary: '#FF777777',
    background: '#FFFFFFFF',
    surface: '#FFF9F9F9',
    surfaceVariant: '#FFE5E5E5',
    outline: '#FFCCCCCC',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFDC2626',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF111111',
    onBackground: '#FF111111',
    onSurface: '#FF111111'
  };

  static readonly Typography: Record<string, TypographyStyle> = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static readonly Shapes: Record<string, number> = {
    small: 6,
    medium: 10,
    large: 14
  };

  static readonly Spacing: Record<string, number> = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static readonly Elevation: Record<string, ShadowSpec> = {
    level1: { radius: 4, dy: 2, opacity: 0.1 },
    level2: { radius: 8, dy: 4, opacity: 0.12 },
    level3: { radius: 12, dy: 6, opacity: 0.15 }
  };
}

interface TypographyStyle {
  size: number;
  weight: FontWeight;
}

interface ShadowSpec {
  radius: number;
  dy: number;
  opacity: number;
}

// Marker Data Model
class Marker {
  id: string = `${Date.now()}_${Math.random()}`; // Unique identifier
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

// RootScreen View
@Entry
@Component
struct RootScreen {
  // State management for markers list
  @State markers: Marker[] = [
    new Marker(120, 200, 'Store A'),
    new Marker(360, 400, 'Store B')
  ];

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private addToCart() {
    console.log("Add to Cart tapped!");
  }

  private addMarker() {
    const newX = Math.floor(Math.random() * 400) + 100;
    const newY = Math.floor(Math.random() * 300) + 150;
    this.markers.push(new Marker(newX, newY, 'New'));
  }

  private clearMarkers() {
    this.markers = [];
  }

  build() {
    Stack() {
      // Background color filling the entire screen
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background);

      // Main content area
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Product Detail')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .alignSelf(ItemAlign.Start);

        // Product information card
        Column({ space: AppTokens.Spacing.md }) {
          // Image placeholder
          Column()
            .width('100%')
            .height(160)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium);

          Text('Monochrome Bag')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .alignSelf(ItemAlign.Start);

          Text('A minimalist and timeless design piece.')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.tertiary)
            .alignSelf(ItemAlign.Start);

          Text('$79.00')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.primary)
            .alignSelf(ItemAlign.Start);

          // "Add to Cart" button
          Button('Add to Cart', { type: ButtonType.Normal })
            .onClick(() => {
              this.addToCart();
            })
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .width('100%')
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .borderRadius(AppTokens.Shapes.medium);
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`,
          offsetY: AppTokens.Elevation.level2.dy
        })
        .alignSelf(ItemAlign.Stretch);

        // Map area with Canvas
        Stack() {
          // Background container
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large);

          // Canvas for custom drawing
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.lg)
            .onReady(() => {
              const canvasWidth = this.context.width;
              const canvasHeight = this.context.height;

              // Draw background rect
              this.context.fillStyle = AppTokens.Colors.surfaceVariant;
              this.context.fillRect(0, 0, canvasWidth, canvasHeight);

              // Draw markers
              this.context.fillStyle = AppTokens.Colors.primary;
              for (const marker of this.markers) {
                this.context.beginPath();
                this.context.arc(marker.x, marker.y, 14, 0, Math.PI * 2);
                this.context.fill();
              }
            });
        }
        .width('100%')
        .height(240);

        // Bottom action buttons row
        Row({ space: AppTokens.Spacing.md }) {
          // "Add Marker" button
          Button('Add Marker', { type: ButtonType.Normal })
            .onClick(() => {
              this.addMarker();
            })
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .layoutWeight(1) // Equivalent to weight(1f)
            .height(44)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .borderRadius(AppTokens.Shapes.medium);

          // "Clear" button
          Button('Clear', { type: ButtonType.Normal })
            .onClick(() => {
              this.clearMarkers();
            })
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .layoutWeight(1) // Equivalent to weight(1f)
            .height(44)
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontColor(AppTokens.Colors.onTertiary)
            .borderRadius(AppTokens.Shapes.medium);
        }
        .width('100%');
      }
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]); // Equivalent to ignoresSafeArea
  }
}