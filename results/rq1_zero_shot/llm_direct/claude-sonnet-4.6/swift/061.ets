import { curves } from '@kit.ArkUI';

// AppTokens
const AppTokens = {
  Colors: {
    primary: '#FF111827',
    secondary: '#FF374151',
    tertiary: '#FF6B7280',
    background: '#FFF9FAFB',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE5E7EB',
    outline: '#FFD1D5DB',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onBackground: '#FF111827',
    onSurface: '#FF1F2937',
  },
  Typography: {
    displaySize: 26,
    headlineSize: 18,
    titleSize: 14,
    bodySize: 12,
  },
  Shapes: {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 16,
  },
  Spacing: {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 22,
  },
};

interface PointData {
  x: number;
  y: number;
}

@Component
struct ParcelCanvas {
  @State dragOffset: PointData = { x: 0, y: 0 };
  @State parcelPoints: PointData[] = [];
  @State canvasWidth: number = 0;
  @State canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private generateRandomPoints(width: number, height: number): PointData[] {
    const points: PointData[] = [];
    for (let i = 0; i < 25; i++) {
      points.push({
        x: Math.random() * width,
        y: Math.random() * height,
      });
    }
    return points;
  }

  private drawCanvas() {
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

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.canvasWidth = this.context.width;
          this.canvasHeight = this.context.height;
          const effectiveWidth = this.canvasWidth - AppTokens.Spacing.md * 2;
          const effectiveHeight = this.canvasHeight - AppTokens.Spacing.md * 2;
          this.parcelPoints = this.generateRandomPoints(effectiveWidth, effectiveHeight);
          this.dragOffset = {
            x: Math.random() * (effectiveWidth - 40) + 20,
            y: Math.random() * (effectiveHeight - 40) + 20,
          };
          this.drawCanvas();
        })

      Text('Drag to locate parcel')
        .fontSize(AppTokens.Typography.bodySize)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(300)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.largeCornerRadius)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.largeCornerRadius,
    })
    .gesture(
      PanGesture()
        .onActionUpdate((event: GestureEvent) => {
          const effectiveWidth = this.canvasWidth - AppTokens.Spacing.md * 2;
          const effectiveHeight = this.canvasHeight - AppTokens.Spacing.md * 2;
          const newX = Math.max(20, Math.min(event.offsetX + this.canvasWidth / 2, effectiveWidth - 20));
          const newY = Math.max(20, Math.min(event.offsetY + this.canvasHeight / 2, effectiveHeight - 20));
          this.dragOffset = { x: newX, y: newY };
          this.drawCanvas();
        })
    )
  }
}

@Component
struct RootScreen {
  build() {
    Column({ space: AppTokens.Spacing.xl }) {
      Text('Parcel Tracker')
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)

      ParcelCanvas()

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTokens.Typography.bodySize)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppTokens.Colors.surfaceVariant, 0.0],
        [AppTokens.Colors.background, 1.0],
      ],
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Entry
@Component
struct ParcelTrackerApp {
  build() {
    RootScreen()
  }
}