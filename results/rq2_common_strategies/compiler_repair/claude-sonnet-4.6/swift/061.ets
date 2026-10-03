// AppTokens Colors
const primaryColor: string = '#111827';
const secondaryColor: string = '#374151';
const tertiaryColor: string = '#6B7280';
const backgroundColor: string = '#F9FAFB';
const surfaceColor: string = '#FFFFFF';
const surfaceVariantColor: string = '#E5E7EB';
const outlineColor: string = '#D1D5DB';
const onPrimaryColor: string = '#FFFFFF';
const onSecondaryColor: string = '#FFFFFF';
const onBackgroundColor: string = '#111827';
const onSurfaceColor: string = '#1F2937';

// AppTokens Typography
const displayFontSize: number = 26;
const headlineFontSize: number = 18;
const titleFontSize: number = 14;
const bodyFontSize: number = 12;

// AppTokens Shapes
const smallCornerRadius: number = 6;
const mediumCornerRadius: number = 10;
const largeCornerRadius: number = 16;

// AppTokens Spacing
const spacingSm: number = 6;
const spacingMd: number = 10;
const spacingLg: number = 14;
const spacingXl: number = 22;

class ParcelPoint {
  x: number = 0;
  y: number = 0;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

@Component
struct ParcelCanvas {
  @State dragX: number = 0;
  @State dragY: number = 0;
  @State parcelPoints: ParcelPoint[] = [];
  @State canvasWidth: number = 0;
  @State canvasHeight: number = 0;
  @State initialized: boolean = false;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private generateRandomPoints(width: number, height: number): ParcelPoint[] {
    const points: ParcelPoint[] = [];
    for (let i = 0; i < 25; i++) {
      points.push(new ParcelPoint(Math.random() * width, Math.random() * height));
    }
    return points;
  }

  private drawCanvas() {
    this.ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    // Draw parcel points
    this.ctx.fillStyle = secondaryColor;
    for (const point of this.parcelPoints) {
      this.ctx.beginPath();
      this.ctx.arc(point.x, point.y, 4, 0, Math.PI * 2);
      this.ctx.fill();
    }

    // Draw draggable circle
    this.ctx.strokeStyle = primaryColor;
    this.ctx.lineWidth = 3;
    this.ctx.beginPath();
    this.ctx.arc(this.dragX, this.dragY, 20, 0, Math.PI * 2);
    this.ctx.stroke();
  }

  build() {
    Stack() {
      Canvas(this.ctx)
        .width('100%')
        .height(300)
        .onReady(() => {
          const w = this.ctx.width;
          const h = this.ctx.height;
          this.canvasWidth = w;
          this.canvasHeight = h;
          if (!this.initialized) {
            this.initialized = true;
            const effectiveW = w - spacingMd * 2;
            const effectiveH = h - spacingMd * 2;
            this.parcelPoints = this.generateRandomPoints(effectiveW, effectiveH);
            this.dragX = spacingMd + Math.random() * (effectiveW - 40) + 20;
            this.dragY = spacingMd + Math.random() * (effectiveH - 40) + 20;
          }
          this.drawCanvas();
        })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              const effectiveW = this.canvasWidth - spacingMd * 2;
              const effectiveH = this.canvasHeight - spacingMd * 2;
              const newX = event.offsetX + this.dragX;
              const newY = event.offsetY + this.dragY;
              this.dragX = Math.max(spacingMd + 20, Math.min(newX, effectiveW + spacingMd - 20));
              this.dragY = Math.max(spacingMd + 20, Math.min(newY, effectiveH + spacingMd - 20));
              this.drawCanvas();
            })
        )

      Text('Drag to locate parcel')
        .fontSize(bodyFontSize)
        .fontColor(onSurfaceColor)
    }
    .width('100%')
    .height(300)
    .backgroundColor(surfaceColor)
    .borderRadius(largeCornerRadius)
    .border({
      width: 1,
      color: outlineColor,
      radius: largeCornerRadius,
    })
    .clip(true)
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Column({ space: spacingXl }) {
      Text('Parcel Tracker')
        .fontSize(displayFontSize)
        .fontWeight(FontWeight.Bold)
        .fontColor(onBackgroundColor)

      ParcelCanvas()
        .width('100%')

      Text('Visualize parcel movements and positions.')
        .fontSize(bodyFontSize)
        .fontWeight(FontWeight.Normal)
        .fontColor(onSurfaceColor)
    }
    .width('100%')
    .height('100%')
    .padding(spacingLg)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [surfaceVariantColor, 0.0],
        [backgroundColor, 1.0],
      ],
    })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}