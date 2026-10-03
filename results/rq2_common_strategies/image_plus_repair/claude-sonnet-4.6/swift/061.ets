// AppTokens
const ColorPrimary: string = '#111827';
const ColorSecondary: string = '#374151';
const ColorTertiary: string = '#6B7280';
const ColorBackground: string = '#F9FAFB';
const ColorSurface: string = '#FFFFFF';
const ColorSurfaceVariant: string = '#E5E7EB';
const ColorOutline: string = '#D1D5DB';
const ColorOnPrimary: string = '#FFFFFF';
const ColorOnSecondary: string = '#FFFFFF';
const ColorOnBackground: string = '#111827';
const ColorOnSurface: string = '#1F2937';

const SpacingSm: number = 6;
const SpacingMd: number = 10;
const SpacingLg: number = 14;
const SpacingXl: number = 22;

const ShapeSmall: number = 6;
const ShapeMedium: number = 10;
const ShapeLarge: number = 16;

interface ParcelPoint {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  build() {
    Column({ space: SpacingXl }) {
      Text('Parcel Tracker')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(ColorOnBackground)

      ParcelCanvas()

      Text('Visualize parcel movements and positions.')
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(ColorOnSurface)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[0xE5E7EB, 0.0], [0xF9FAFB, 1.0]]
    })
    .padding(SpacingLg)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ParcelCanvas {
  @State dragX: number = 150;
  @State dragY: number = 150;
  @State parcelPoints: ParcelPoint[] = [];
  @State canvasWidth: number = 0;
  @State canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private initialized: boolean = false;

  private generateRandomPoints(width: number, height: number): ParcelPoint[] {
    const points: ParcelPoint[] = [];
    for (let i = 0; i < 25; i++) {
      const pt: ParcelPoint = {
        x: Math.random() * width,
        y: Math.random() * height
      };
      points.push(pt);
    }
    return points;
  }

  private drawCanvas() {
    const ctx = this.context;
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    // Draw parcel points
    ctx.fillStyle = ColorSecondary;
    for (const point of this.parcelPoints) {
      ctx.beginPath();
      ctx.arc(point.x, point.y, 4, 0, Math.PI * 2);
      ctx.fill();
    }

    // Draw draggable circle
    ctx.strokeStyle = ColorPrimary;
    ctx.lineWidth = 3;
    ctx.beginPath();
    ctx.arc(this.dragX, this.dragY, 20, 0, Math.PI * 2);
    ctx.stroke();
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.canvasWidth = this.context.width;
          this.canvasHeight = this.context.height;
          if (!this.initialized) {
            this.initialized = true;
            const effectiveWidth = this.canvasWidth - SpacingMd * 2;
            const effectiveHeight = this.canvasHeight - SpacingMd * 2;
            this.parcelPoints = this.generateRandomPoints(effectiveWidth, effectiveHeight);
            this.dragX = 20 + Math.random() * (effectiveWidth - 40);
            this.dragY = 20 + Math.random() * (effectiveHeight - 40);
          }
          this.drawCanvas();
        })

      Text('Drag to locate parcel')
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(ColorOnSurface)
    }
    .width('100%')
    .height(300)
    .backgroundColor(ColorSurface)
    .borderRadius(ShapeLarge)
    .border({ width: 1, color: ColorOutline, radius: ShapeLarge })
    .clip(true)
    .gesture(
      PanGesture()
        .onActionStart((event: GestureEvent) => {
          const effectiveWidth = this.canvasWidth - SpacingMd * 2;
          const effectiveHeight = this.canvasHeight - SpacingMd * 2;
          this.dragX = Math.max(20, Math.min(event.offsetX, effectiveWidth - 20));
          this.dragY = Math.max(20, Math.min(event.offsetY, effectiveHeight - 20));
          this.drawCanvas();
        })
        .onActionUpdate((event: GestureEvent) => {
          const effectiveWidth = this.canvasWidth - SpacingMd * 2;
          const effectiveHeight = this.canvasHeight - SpacingMd * 2;
          this.dragX = Math.max(20, Math.min(event.offsetX, effectiveWidth - 20));
          this.dragY = Math.max(20, Math.min(event.offsetY, effectiveHeight - 20));
          this.drawCanvas();
        })
    )
  }
}