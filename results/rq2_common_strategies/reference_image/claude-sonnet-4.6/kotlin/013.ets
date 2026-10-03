/**
 * 011*MusicPlayer*en — "Retro Flat" media screen.
 * ArkTS / ArkUI port of the Kotlin + Jetpack Compose reference.
 * Target: HarmonyOS NEXT / API 11+  (file: pages/Index.ets)
 */

const NAME: string = '011*MusicPlayer*en';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Retro Flat';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

/* ------------------------------------------------------------------ */
/* Design tokens (mirrors the Compose AppTokens object)                */
/* ------------------------------------------------------------------ */

class AppColors {
  static readonly primary: string = '#EF476F';
  static readonly secondary: string = '#FFD166';
  static readonly tertiary: string = '#06D6A0';
  static readonly background: string = '#FFFCF2';
  static readonly surface: string = '#FFF8E1';
  static readonly surfaceVariant: string = '#FCE7E7';
  static readonly outline: string = '#BDBDBD';
  static readonly success: string = '#06D6A0';
  static readonly warning: string = '#FFA600';
  static readonly error: string = '#D62828';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1F1F1F';
  static readonly onTertiary: string = '#1F1F1F';
  static readonly onBackground: string = '#1F1F1F';
  static readonly onSurface: string = '#1F1F1F';
}

class AppTypography {
  static readonly display: number = 30;
  static readonly title: number = 18;
  static readonly body: number = 14;
  static readonly label: number = 12;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

/* ------------------------------------------------------------------ */
/* Screen                                                              */
/* ------------------------------------------------------------------ */

@Entry
@Component
struct Index {
  /** Knob centre, in vp, relative to the dial component. */
  @State knobX: number = 140;
  @State knobY: number = 140;

  private ctxSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.ctxSettings);

  private readonly dialSize: number = 280;      // Box .size(280.dp)
  private readonly ringInset: number = 20;      // radius = size/2 - 20f
  private readonly ringStroke: number = 12;     // Stroke(width = 12f)
  private readonly knobRadius: number = 20;     // drawCircle radius = 20f

  /* ---------------------------- drawing --------------------------- */

  private drawDial(): void {
    const w: number = this.ctx.width;
    const h: number = this.ctx.height;
    const cx: number = w / 2;
    const cy: number = h / 2;

    this.ctx.clearRect(0, 0, w, h);

    // Ring
    this.ctx.beginPath();
    this.ctx.arc(cx, cy, Math.min(w, h) / 2 - this.ringInset, 0, Math.PI * 2);
    this.ctx.lineWidth = this.ringStroke;
    this.ctx.strokeStyle = AppColors.secondary;
    this.ctx.stroke();

    // Draggable knob
    this.ctx.beginPath();
    this.ctx.arc(this.knobX, this.knobY, this.knobRadius, 0, Math.PI * 2);
    this.ctx.fillStyle = AppColors.primary;
    this.ctx.fill();
  }

  /* ---------------------------- input ----------------------------- */

  private onDrag(event: GestureEvent): void {
    const centre: number = this.dialSize / 2;
    const maxR: number = centre - this.ringInset - this.ringStroke / 2 - this.knobRadius;

    let dx: number = event.offsetX - centre;
    let dy: number = event.offsetY - centre;
    const dist: number = Math.sqrt(dx * dx + dy * dy);

    if (dist > maxR && dist > 0) {
      dx = dx / dist * maxR;
      dy = dy / dist * maxR;
    }

    this.knobX = centre + dx;
    this.knobY = centre + dy;
    this.drawDial();
  }

  private knobLabel(): string {
    return 'Knob X:' + Math.round(this.knobX).toString() +
      ' Y:' + Math.round(this.knobY).toString();
  }

  /* ---------------------------- build ----------------------------- */

  build() {
    Column() {
      // TopAppBar title
      Text('Retro Music Player')
        .fontSize(AppTypography.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppSpacing.md, bottom: AppSpacing.md })

      Column() {
        // Dial
        Canvas(this.ctx)
          .width(this.dialSize)
          .height(this.dialSize)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .border({ width: 3, color: AppColors.outline, radius: AppShapes.large })
          .onReady(() => {
            this.drawDial();
          })
          .gesture(
            PanGesture({ fingers: 1, distance: 1 })
              .onActionStart((event: GestureEvent) => {
                this.onDrag(event);
              })
              .onActionUpdate((event: GestureEvent) => {
                this.onDrag(event);
              })
          )

        // Track label
        Text('Track: Summer Nights')
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        // Transport controls
        Row() {
          Button('Play')
            .type(ButtonType.Normal)
            .width(120)
            .height(48)
            .borderRadius(AppShapes.medium)
            .backgroundColor(AppColors.primary)
            .fontColor(AppColors.onPrimary)
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
            })

          Button('Pause')
            .type(ButtonType.Normal)
            .width(120)
            .height(48)
            .borderRadius(AppShapes.medium)
            .backgroundColor(AppColors.secondary)
            .fontColor(AppColors.onSecondary)
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        // Live readout
        Text(this.knobLabel())
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.tertiary)

        // Bottom spacer (Spacer 32.dp)
        Row()
          .height(AppSpacing.xxl)
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .padding(AppSpacing.lg)
  }
}