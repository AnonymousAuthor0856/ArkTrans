/* ============================================================
 *  025Whiteboarden — Retro Whiteboard
 *  UI type: Productivity | Style: Retro Flat | Lang: en
 *  Baseline: 720 x 1280
 *  File: entry/src/main/ets/pages/Index.ets
 * ============================================================ */

/* ---------------- Design tokens (mirrors AppTokens) ---------------- */
const COLOR_PRIMARY: string = '#EF476F';
const COLOR_SECONDARY: string = '#FFD166';
const COLOR_TERTIARY: string = '#06D6A0';
const COLOR_BACKGROUND: string = '#FFFCF2';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#F7EDE2';
const COLOR_OUTLINE: string = '#E5D4B1';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_ON_SECONDARY: string = '#1E1E1E';
const COLOR_ON_TERTIARY: string = '#1E1E1E';
const COLOR_ON_SURFACE: string = '#1E1E1E';

const FONT_DISPLAY: number = 26;
const FONT_TITLE: number = 18;
const FONT_BODY: number = 14;
const FONT_LABEL: number = 12;

const RADIUS_SMALL: number = 6;
const RADIUS_MEDIUM: number = 10;
const RADIUS_LARGE: number = 16;

const SPACE_XS: number = 4;
const SPACE_SM: number = 8;
const SPACE_MD: number = 12;
const SPACE_LG: number = 16;
const SPACE_XL: number = 24;

/* ElevationMapping.level1 -> ShadowSpec(elevation 2, radius 4, dy 2, opacity .12) */
const ELEVATION_L1_RADIUS: number = 4;
const ELEVATION_L1_DY: number = 2;
const ELEVATION_L1_COLOR: string = 'rgba(0, 0, 0, 0.12)';

/* Whiteboard specifics */
const BRUSH_RADIUS: number = 5; // Compose used radius 10f (px) -> 5vp
const FAB_SIZE: number = 56;
const APP_BAR_HEIGHT: number = 64;

/* ---------------- Data model ---------------- */
class DrawPoint {
  x: number;
  y: number;
  color: string;

  constructor(x: number, y: number, color: string) {
    this.x = x;
    this.y = y;
    this.color = color;
  }
}

/* ---------------- Screen ---------------- */
@Entry
@Component
struct WhiteboardPage {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private points: DrawPoint[] = [];
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;

  @State currentColor: string = COLOR_PRIMARY;

  private stampDot(x: number, y: number, color: string): void {
    this.ctx.beginPath();
    this.ctx.arc(x, y, BRUSH_RADIUS, 0, Math.PI * 2);
    this.ctx.fillStyle = color;
    this.ctx.fill();
    this.ctx.closePath();
  }

  private repaint(): void {
    this.ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);
    for (let i = 0; i < this.points.length; i++) {
      const p: DrawPoint = this.points[i];
      this.stampDot(p.x, p.y, p.color);
    }
  }

  private handleStroke(event: TouchEvent): void {
    if (event.type !== TouchType.Down && event.type !== TouchType.Move) {
      return;
    }
    const touches: TouchObject[] = event.touches;
    if (touches.length === 0) {
      return;
    }
    const t: TouchObject = touches[0];
    this.points.push(new DrawPoint(t.x, t.y, this.currentColor));
    this.stampDot(t.x, t.y, this.currentColor);
  }

  private clearBoard(): void {
    this.points = [];
    this.ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);
  }

  @Builder
  PaletteButton(label: string, bgColor: string, fgColor: string) {
    Button(label)
      .type(ButtonType.Normal)
      .height(44)
      .padding({ left: SPACE_XL + SPACE_XS, right: SPACE_XL + SPACE_XS })
      .fontSize(FONT_BODY)
      .fontWeight(FontWeight.Medium)
      .fontColor(fgColor)
      .backgroundColor(bgColor)
      .borderRadius(RADIUS_SMALL)
      .onClick(() => {
        this.currentColor = bgColor;
      })
  }

  build() {
    Column() {
      /* ---------- topBar : CenterAlignedTopAppBar ---------- */
      Row() {
        Text('Retro Whiteboard')
          .fontSize(FONT_DISPLAY)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .height(APP_BAR_HEIGHT)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_BACKGROUND)

      /* ---------- content : Canvas + Clear FAB ---------- */
      Stack({ alignContent: Alignment.BottomEnd }) {
        Canvas(this.ctx)
          .width('100%')
          .height('100%')
          .backgroundColor(COLOR_BACKGROUND)
          .onReady(() => {
            this.canvasWidth = this.ctx.width;
            this.canvasHeight = this.ctx.height;
            this.repaint();
          })
          .onTouch((event: TouchEvent) => {
            this.handleStroke(event);
          })

        Button('Clear')
          .type(ButtonType.Circle)
          .width(FAB_SIZE)
          .height(FAB_SIZE)
          .fontSize(FONT_LABEL)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SECONDARY)
          .backgroundColor(COLOR_SECONDARY)
          .margin({ right: SPACE_LG, bottom: SPACE_LG })
          .shadow({
            radius: ELEVATION_L1_RADIUS,
            color: ELEVATION_L1_COLOR,
            offsetX: 0,
            offsetY: ELEVATION_L1_DY
          })
          .onClick(() => {
            this.clearBoard();
          })
      }
      .width('100%')
      .layoutWeight(1)

      /* ---------- bottomBar : palette ---------- */
      Row() {
        this.PaletteButton('Red', COLOR_PRIMARY, COLOR_ON_PRIMARY)
        this.PaletteButton('Yellow', COLOR_SECONDARY, COLOR_ON_SECONDARY)
        this.PaletteButton('Green', COLOR_TERTIARY, COLOR_ON_TERTIARY)
      }
      .width('100%')
      .padding(SPACE_MD)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_SURFACE_VARIANT)
      .border({ width: { top: 1 }, color: { top: COLOR_OUTLINE } })
      .shadow({
        radius: ELEVATION_L1_RADIUS,
        color: ELEVATION_L1_COLOR,
        offsetX: 0,
        offsetY: -ELEVATION_L1_DY
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}