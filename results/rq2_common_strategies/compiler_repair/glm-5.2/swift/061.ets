// AppTokens.ets
// Centralized management of application colors, fonts, shapes, and spacing.

interface ColorsType {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onPrimary: string;
  onSecondary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyItemType {
  size: number;
  weight: FontWeight;
}

interface TypographyType {
  display: TypographyItemType;
  headline: TypographyItemType;
  title: TypographyItemType;
  body: TypographyItemType;
}

interface ShapesType {
  smallCornerRadius: number;
  mediumCornerRadius: number;
  largeCornerRadius: number;
}

interface SpacingType {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

export class AppTokens {
  static Colors: ColorsType = {
    primary: '#111827',
    secondary: '#374151',
    tertiary: '#6B7280',
    background: '#F9FAFB',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onBackground: '#111827',
    onSurface: '#1F2937'
  }

  static TypographyTokens: TypographyType = {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal }
  }

  static Shapes: ShapesType = {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 16
  }

  static Spacing: SpacingType = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 22
  }
}

// Helper to generate random points
function generateRandomPoints(width: number, height: number): Array<Point> {
  const points: Array<Point> = [];
  for (let i = 0; i < 25; i++) {
    const p: Point = {
      x: Math.random() * width,
      y: Math.random() * height
    };
    points.push(p);
  }
  return points;
}

interface Point {
  x: number;
  y: number;
}

// ParcelCanvas.ets
@Component
export struct ParcelCanvas {
  @State dragOffset: Point = { x: 0, y: 0 };
  @State parcelPoints: Array<Point> = [];
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .padding(AppTokens.Spacing.md)
        .onReady(() => {
          // Initial setup if needed
        })
        .onAreaChange((oldValue: Area, newValue: Area) => {
          const newWidth = newValue.width as number;
          const newHeight = newValue.height as number;
          this.canvasWidth = newWidth - (AppTokens.Spacing.md * 2);
          this.canvasHeight = newHeight - (AppTokens.Spacing.md * 2);
          this.parcelPoints = generateRandomPoints(this.canvasWidth, this.canvasHeight);
          this.dragOffset = {
            x: 20 + Math.random() * (this.canvasWidth - 40),
            y: 20 + Math.random() * (this.canvasHeight - 40)
          };
          this.drawCanvas();
        })

      Text('Drag to locate parcel')
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(300)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.largeCornerRadius)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.largeCornerRadius })
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Move || event.type === TouchType.Down) {
        const touchX = event.touches[0].x;
        const touchY = event.touches[0].y;

        const minX = 20;
        const maxX = this.canvasWidth - 20;
        const minY = 20;
        const maxY = this.canvasHeight - 20;

        this.dragOffset = {
          x: Math.max(minX, Math.min(touchX, maxX)),
          y: Math.max(minY, Math.min(touchY, maxY))
        };
        this.drawCanvas();
      }
    })
  }

  private drawCanvas() {
    // Clear canvas
    this.context.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    // Draw parcel points
    this.context.fillStyle = AppTokens.Colors.secondary;
    for (const point of this.parcelPoints) {
      this.context.beginPath();
      this.context.arc(point.x, point.y, 4, 0, Math.PI * 2);
      this.context.fill();
    }

    // Draw draggable circle
    this.context.strokeStyle = AppTokens.Colors.primary;
    this.context.lineWidth = 3;
    this.context.beginPath();
    this.context.arc(this.dragOffset.x, this.dragOffset.y, 20, 0, Math.PI * 2);
    this.context.stroke();
  }
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  build() {
    Column({ space: AppTokens.Spacing.xl }) {
      Text('Parcel Tracker')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onBackground)

      ParcelCanvas()

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.background, 1.0]]
    })
    .padding(AppTokens.Spacing.lg)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}