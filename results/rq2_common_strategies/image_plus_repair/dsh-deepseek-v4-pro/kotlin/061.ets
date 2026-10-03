const NAME: string = "096_ParcelTracker_en";
const UI_TYPE: string = "Tools Dashboard";
const STYLE_THEME: string = "Monochrome";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

const COLOR_PRIMARY: string = '#111827';
const COLOR_SECONDARY: string = '#374151';
const COLOR_TERTIARY: string = '#6B7280';
const COLOR_BACKGROUND: string = '#F9FAFB';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#E5E7EB';
const COLOR_OUTLINE: string = '#D1D5DB';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_ON_SECONDARY: string = '#FFFFFF';
const COLOR_ON_BACKGROUND: string = '#111827';
const COLOR_ON_SURFACE: string = '#1F2937';

class Point {
  x: number = 0;
  y: number = 0;
  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct ParcelTracker {
  @State dragX: number = 0;
  @State dragY: number = 0;
  private gestureStartX: number = 0;
  private gestureStartY: number = 0;
  private parcelPoints: Point[] = [];
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear(): void {
    for (let i = 0; i < 25; i++) {
      this.parcelPoints.push(new Point(Math.random() * 400, Math.random() * 300));
    }
  }

  private drawParcels(): void {
    this.context.clearRect(0, 0, this.context.width, this.context.height);
    for (let i = 0; i < this.parcelPoints.length; i++) {
      const p: Point = this.parcelPoints[i];
      this.context.beginPath();
      this.context.arc(p.x, p.y, 4, 0, Math.PI * 2);
      this.context.fillStyle = COLOR_SECONDARY;
      this.context.fill();
    }
    this.context.beginPath();
    this.context.arc(this.dragX, this.dragY, 20, 0, Math.PI * 2);
    this.context.strokeStyle = COLOR_PRIMARY;
    this.context.lineWidth = 3;
    this.context.stroke();
  }

  build() {
    Column({ space: 22 }) {
      Text('Parcel Tracker')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_BACKGROUND)

      Stack() {
        Canvas(this.context)
          .width('100%')
          .height('100%')
          .padding(10)
          .onReady(() => {
            this.drawParcels();
          })

        Text('Drag to locate parcel')
          .fontSize(12)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .height(300)
      .backgroundColor(COLOR_SURFACE)
      .borderRadius(16)
      .border({ width: 1, color: COLOR_OUTLINE })
      .gesture(
        PanGesture({ fingers: 1, distance: 5 })
          .onActionStart((event: GestureEvent) => {
            this.gestureStartX = this.dragX;
            this.gestureStartY = this.dragY;
          })
          .onActionUpdate((event: GestureEvent) => {
            this.dragX = Math.max(0, Math.min(400, this.gestureStartX + event.offsetX));
            this.dragY = Math.max(0, Math.min(300, this.gestureStartY + event.offsetY));
          })
      )

      Text('Visualize parcel movements and positions.')
        .fontSize(12)
        .fontColor(COLOR_ON_SURFACE)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [[0xE5E7EB, 0], [0xF9FAFB, 1]]
    })
    .padding(14)
    .alignItems(HorizontalAlign.Center)
  }
}
