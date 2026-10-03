// FavoritesGridScreen.ets  —  ohabench: 009FavoritesGriden (Social / Glassmorphic / 720x1280)
// Path: entry/src/main/ets/pages/Index.ets

const COLOR_PRIMARY: string = '#60A5FA';
const COLOR_HALO_INNER: string = 'rgba(147, 197, 253, 0.30)';
const COLOR_HALO_OUTER: string = 'rgba(147, 197, 253, 0.20)';
const COLOR_MARKER_RING: string = 'rgba(96, 165, 250, 0.35)';
const COLOR_OUTLINE: string = '#D1D5DB';
const COLOR_BACKGROUND: string = '#F9FAFB';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_ON_SURFACE: string = '#111827';

const SPACING_MD: number = 12;
const SPACING_LG: number = 16;

const MAP_HEIGHT: number = 400;
const MARKER_X: number = 200;
const MARKER_Y: number = 400;

@Entry
@Component
struct FavoritesGridScreen {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  @State markerX: number = MARKER_X;
  @State markerY: number = MARKER_Y;

  private drawMap(): void {
    const w: number = this.ctx.width;
    const h: number = this.ctx.height;
    const cx: number = w / 2;
    const cy: number = h / 2;

    this.ctx.clearRect(0, 0, w, h);

    // glassmorphic radial backdrop
    const backdrop: CanvasGradient =
      this.ctx.createRadialGradient(cx, cy, 0, cx, cy, Math.max(w, h) * 0.75);
    backdrop.addColorStop(0, 'rgba(255, 255, 255, 0.95)');
    backdrop.addColorStop(0.55, 'rgba(239, 246, 255, 0.85)');
    backdrop.addColorStop(1, 'rgba(255, 255, 255, 0.75)');
    this.ctx.fillStyle = backdrop;
    this.ctx.fillRect(0, 0, w, h);

    // inner halo
    this.ctx.beginPath();
    this.ctx.fillStyle = COLOR_HALO_INNER;
    this.ctx.arc(cx, cy, 220, 0, Math.PI * 2);
    this.ctx.fill();

    // outer halo
    this.ctx.beginPath();
    this.ctx.fillStyle = COLOR_HALO_OUTER;
    this.ctx.arc(cx, cy, 340, 0, Math.PI * 2);
    this.ctx.fill();

    // marker pulse ring
    this.ctx.beginPath();
    this.ctx.strokeStyle = COLOR_MARKER_RING;
    this.ctx.lineWidth = 3;
    this.ctx.arc(this.markerX, this.markerY, 30, 0, Math.PI * 2);
    this.ctx.stroke();

    // marker dot
    this.ctx.beginPath();
    this.ctx.fillStyle = COLOR_PRIMARY;
    this.ctx.arc(this.markerX, this.markerY, 14, 0, Math.PI * 2);
    this.ctx.fill();
  }

  build() {
    Column() {
      // Top app bar title
      Text('Favorite Spots Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_SURFACE)
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .width('100%')
        .padding({ top: SPACING_MD, bottom: SPACING_LG })

      // Glass card with the canvas map
      Column() {
        Canvas(this.ctx)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawMap();
          })
      }
      .width('100%')
      .height(MAP_HEIGHT)
      .backgroundColor(COLOR_SURFACE)
      .borderRadius(24)
      .border({ width: 1, color: COLOR_OUTLINE })
      .clip(true)

      // Bottom info + action
      Column({ space: SPACING_MD }) {
        Text(`Spot Coordinates: (${this.markerX}, ${this.markerY})`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(COLOR_ON_SURFACE)

        Button('Save Marker', { type: ButtonType.Normal, stateEffect: true })
          .width('100%')
          .height(48)
          .borderRadius(16)
          .backgroundColor(COLOR_PRIMARY)
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
          })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(SPACING_LG)
    .backgroundColor(COLOR_BACKGROUND)
    .justifyContent(FlexAlign.SpaceBetween)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}