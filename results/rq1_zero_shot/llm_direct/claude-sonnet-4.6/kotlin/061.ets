import { drawing } from '@kit.ArkGraphics2D';

// Design tokens
const Colors = {
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
  onSurface: '#1F2937',
};

interface Point {
  x: number;
  y: number;
}

function generateParcelPoints(count: number): Point[] {
  const points: Point[] = [];
  for (let i = 0; i < count; i++) {
    points.push({
      x: Math.random() * 400,
      y: Math.random() * 300,
    });
  }
  return points;
}

@Component
struct ParcelCanvas {
  @State dragX: number = 0;
  @State dragY: number = 0;
  private parcelPoints: Point[] = generateParcelPoints(25);
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawScene() {
    const ctx = this.context;
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    // Draw parcel points
    this.parcelPoints.forEach((pt: Point) => {
      ctx.beginPath();
      ctx.arc(pt.x, pt.y, 4, 0, Math.PI * 2);
      ctx.fillStyle = Colors.secondary;
      ctx.fill();
    });

    // Draw drag indicator circle
    if (this.dragX !== 0 || this.dragY !== 0) {
      ctx.beginPath();
      ctx.arc(this.dragX, this.dragY, 20, 0, Math.PI * 2);
      ctx.strokeStyle = Colors.primary;
      ctx.lineWidth = 3;
      ctx.stroke();
    }
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width('100%')
        .height(300)
        .borderRadius(16)
        .onReady(() => {
          this.canvasWidth = this.context.width;
          this.canvasHeight = this.context.height;
          this.drawScene();
        })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              const newX = Math.max(0, Math.min(this.canvasWidth, this.dragX + event.offsetX));
              const newY = Math.max(0, Math.min(this.canvasHeight, this.dragY + event.offsetY));
              this.dragX = newX;
              this.dragY = newY;
              this.drawScene();
            })
        )

      Text('Drag to locate parcel')
        .fontSize(12)
        .fontColor(Colors.onSurface)
        .fontWeight(FontWeight.Normal)
    }
    .width('100%')
    .height(300)
    .backgroundColor(Colors.surface)
    .borderRadius(16)
    .border({ width: 1, color: Colors.outline, radius: 16 })
  }
}

@Component
struct RootScreen {
  build() {
    Column({ space: 22 }) {
      Text('Parcel Tracker')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onBackground)

      ParcelCanvas()

      Text('Visualize parcel movements and positions.')
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(Colors.onSurface)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[0xFFE5E7EB, 0.0], [0xFFF9FAFB, 1.0]]
    })
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}