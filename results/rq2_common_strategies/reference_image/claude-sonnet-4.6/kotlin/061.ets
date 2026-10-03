/**
 * 096_ParcelTracker_en
 * UI_TYPE     : Tools Dashboard
 * STYLE_THEME : Monochrome
 * LANG        : en
 * BASELINE    : 720x1280
 *
 * ArkTS port of the Compose screen: gradient page background, display title,
 * a 300vp bordered card holding a Canvas (25 scatter dots + a draggable
 * 20-radius ring) and a centered hint label, plus a body caption.
 */

const NAME: string = '096_ParcelTracker_en';
const UI_TYPE: string = 'Tools Dashboard';
const STYLE_THEME: string = 'Monochrome';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

interface Point {
  x: number;
  y: number;
}

class AppTokens {
  // Colors
  static readonly primary: string = '#111827';
  static readonly secondary: string = '#374151';
  static readonly tertiary: string = '#6B7280';
  static readonly background: string = '#F9FAFB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';

  // Typography (fp)
  static readonly displaySize: number = 26;
  static readonly headlineSize: number = 18;
  static readonly titleSize: number = 14;
  static readonly bodySize: number = 12;

  // Shapes (vp)
  static readonly radiusSmall: number = 6;
  static readonly radiusMedium: number = 10;
  static readonly radiusLarge: number = 16;

  // Spacing (vp)
  static readonly spacingSm: number = 6;
  static readonly spacingMd: number = 10;
  static readonly spacingLg: number = 14;
  static readonly spacingXl: number = 22;
}

const DOT_COUNT: number = 25;
const DOT_RADIUS: number = 4;
const MARKER_RADIUS: number = 20;
const MARKER_STROKE: number = 3;
const CARD_HEIGHT: number = 300;

@Entry
@Component
struct ParcelTrackerPage {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private dots: Point[] = [];
  private canvasW: number = 0;
  private canvasH: number = 0;

  private markerX: number = 0;
  private markerY: number = 0;
  private baseX: number = 0;
  private baseY: number = 0;

  aboutToAppear(): void {
    // Normalised 0..1 coordinates so the scatter survives any card size.
    for (let i = 0; i < DOT_COUNT; i++) {
      const p: Point = {
        x: 0.04 + Math.random() * 0.90,
        y: 0.04 + Math.random() * 0.90
      };
      this.dots.push(p);
    }
  }

  private clamp(value: number, low: number, high: number): number {
    return Math.max(low, Math.min(high, value));
  }

  private redraw(): void {
    const w: number = this.canvasW;
    const h: number = this.canvasH;
    if (w <= 0 || h <= 0) {
      return;
    }

    this.ctx.clearRect(0, 0, w, h);

    // Parcel scatter points
    this.ctx.fillStyle = AppTokens.secondary;
    for (let i = 0; i < this.dots.length; i++) {
      const p: Point = this.dots[i];
      this.ctx.beginPath();
      this.ctx.arc(p.x * w, p.y * h, DOT_RADIUS, 0, Math.PI * 2);
      this.ctx.fill();
    }

    // Draggable locator ring
    this.ctx.strokeStyle = AppTokens.primary;
    this.ctx.lineWidth = MARKER_STROKE;
    this.ctx.beginPath();
    this.ctx.arc(this.markerX, this.markerY, MARKER_RADIUS, 0, Math.PI * 2);
    this.ctx.stroke();
  }

  build() {
    Column({ space: AppTokens.spacingXl }) {
      Text('Parcel Tracker')
        .fontSize(AppTokens.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.onBackground)

      Stack() {
        Canvas(this.ctx)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.canvasW = this.ctx.width;
            this.canvasH = this.ctx.height;
            this.redraw();
          })

        Text('Drag to locate parcel')
          .fontSize(AppTokens.bodySize)
          .fontColor(AppTokens.onSurface)
      }
      .width('100%')
      .height(CARD_HEIGHT)
      .backgroundColor(AppTokens.surface)
      .borderRadius(AppTokens.radiusLarge)
      .border({ width: 1, color: AppTokens.outline })
      .gesture(
        PanGesture({ fingers: 1, distance: 0 })
          .onActionStart(() => {
            this.baseX = this.markerX;
            this.baseY = this.markerY;
          })
          .onActionUpdate((event: GestureEvent) => {
            // event.offsetX/Y is cumulative since gesture start, so add the
            // value captured on start (Compose used per-event drag deltas).
            this.markerX = this.clamp(this.baseX + event.offsetX, 0, this.canvasW);
            this.markerY = this.clamp(this.baseY + event.offsetY, 0, this.canvasH);
            this.redraw();
          })
      )

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTokens.bodySize)
        .fontColor(AppTokens.onSurface)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.spacingLg)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      angle: 180, // top -> bottom, matching Brush.verticalGradient
      colors: [
        [AppTokens.surfaceVariant, 0.0],
        [AppTokens.background, 1.0]
      ]
    })
  }
}