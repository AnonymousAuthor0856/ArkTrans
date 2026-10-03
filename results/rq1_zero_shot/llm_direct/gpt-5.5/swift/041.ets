import window from '@ohos.window';

class AppColors {
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

class TypographyToken {
  size: number;
  weight: FontWeight;

  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

class AppTypographyTokens {
  static readonly display: TypographyToken = new TypographyToken(28, FontWeight.Bold);
  static readonly title: TypographyToken = new TypographyToken(18, FontWeight.Medium);
  static readonly body: TypographyToken = new TypographyToken(14, FontWeight.Regular);
  static readonly label: TypographyToken = new TypographyToken(12, FontWeight.Medium);
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
  color: string;

  constructor(elevation: number, radius: number, dy: number, opacity: number, color: string) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
    this.color = color;
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1, '#1A000000');
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.12, '#1F000000');
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.15, '#26000000');
}

class AppTokens {
  static readonly Colors = AppColors;
  static readonly TypographyTokens = AppTypographyTokens;
  static readonly Shapes = AppShapes;
  static readonly Spacing = AppSpacing;
  static readonly ElevationMapping = AppElevationMapping;
}

class Marker {
  id: string;
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.id = `${Date.now()}-${Math.random()}`;
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    new Marker(120, 200, 'Store A'),
    new Marker(360, 400, 'Store B')
  ];

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    });
  }

  private randomInRange(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  private drawMap(): void {
    const width: number = this.canvasContext.width;
    const height: number = this.canvasContext.height;

    this.canvasContext.clearRect(0, 0, width, height);
    this.canvasContext.fillStyle = AppTokens.Colors.surfaceVariant;
    this.canvasContext.fillRect(0, 0, width, height);

    this.canvasContext.fillStyle = AppTokens.Colors.primary;
    this.markers.forEach((marker: Marker) => {
      this.canvasContext.beginPath();
      this.canvasContext.arc(marker.x, marker.y, 14, 0, Math.PI * 2);
      this.canvasContext.closePath();
      this.canvasContext.fill();
    });
  }

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Product Detail')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)

        Column({ space: AppTokens.Spacing.md }) {
          Blank()
            .width('100%')
            .height(160)
            .backgroundColor(AppTokens.Colors.surfaceVariant)

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

          Button('Add to Cart', { type: ButtonType.Normal })
            .width('100%')
            .height(48)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
            .onClick(() => {
              console.info('Add to Cart tapped!');
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.largeCornerRadius)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: AppTokens.ElevationMapping.level2.color,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        Stack() {
          Stack() {
            Canvas(this.canvasContext)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawMap();
              })
              .onAreaChange(() => {
                this.drawMap();
              })
          }
          .width('100%')
          .height('100%')
          .padding(AppTokens.Spacing.lg)
        }
        .width('100%')
        .height(240)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.largeCornerRadius)
        .clip(true)

        Row({ space: AppTokens.Spacing.md }) {
          Button('Add Marker', { type: ButtonType.Normal })
            .layoutWeight(1)
            .height(44)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
            .onClick(() => {
              this.markers = [
                ...this.markers,
                new Marker(
                  this.randomInRange(100, 500),
                  this.randomInRange(150, 450),
                  'New'
                )
              ];
              this.drawMap();
            })

          Button('Clear', { type: ButtonType.Normal })
            .layoutWeight(1)
            .height(44)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onTertiary)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
            .onClick(() => {
              this.markers = [];
              this.drawMap();
            })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}