/**
 * 020RemoteControlen | UI_TYPE: Media | STYLE_THEME: Retro Flat | LANG: en
 * Baseline: 720x1280 (360x640 vp)
 * ArkTS port of the Compose "Retro Remote Control" screen.
 */
import { window } from '@kit.ArkUI';

const NAME: string = '020RemoteControlen';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Retro Flat';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

/* ------------------------------- tokens -------------------------------- */

class AppColors {
  static readonly primary: string = '#FF7A00';
  static readonly secondary: string = '#FFC300';
  static readonly tertiary: string = '#FFF3C0';
  static readonly background: string = '#FFF8E7';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFEBC8';
  static readonly outline: string = '#BCA789';
  static readonly success: string = '#28A745';
  static readonly warning: string = '#FFC107';
  static readonly error: string = '#DC3545';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class FontToken {
  readonly size: number;
  readonly weight: FontWeight;

  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

class AppTypography {
  static readonly display: FontToken = new FontToken(28, FontWeight.Bold);
  static readonly title: FontToken = new FontToken(18, FontWeight.Medium);
  static readonly body: FontToken = new FontToken(14, FontWeight.Normal);
  static readonly label: FontToken = new FontToken(12, FontWeight.Medium);
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 14;
  static readonly large: number = 24;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class ShadowSpec {
  readonly elevation: number;
  readonly radius: number;
  readonly dy: number;
  readonly opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }

  /** ARGB string for `.shadow({ color })`, alpha derived from the spec opacity. */
  color(): string {
    const alpha: number = Math.round(this.opacity * 255);
    const hex: string = ('0' + alpha.toString(16)).slice(-2).toUpperCase();
    return '#' + hex + '000000';
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16);
}

/* ------------------------------- screen -------------------------------- */

@Entry
@Component
struct Index {
  @State knobX: number = 0;
  @State knobY: number = 0;
  @State powerOn: boolean = false;

  /** Card is 280vp with lg (16vp) inner padding -> 248vp drawable area. */
  private readonly cardSize: number = 280;
  private readonly canvasSize: number = 280 - AppSpacing.lg * 2;
  private readonly knobRadius: number = 12;

  aboutToAppear(): void {
    // Kotlin: WindowCompat.setDecorFitsSystemWindows(false) + hide(systemBars)
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch(() => {
      });
  }

  private applyKnob(localX: number, localY: number): void {
    this.knobX = Math.max(0, Math.min(this.canvasSize, localX));
    this.knobY = Math.max(0, Math.min(this.canvasSize, localY));
  }

  private resetKnob(): void {
    this.knobX = 0;
    this.knobY = 0;
  }

  /** (x + y) % 400, clamped to the Progress [0, total] range. */
  private progressValue(): number {
    const raw: number = (this.knobX + this.knobY) % 400;
    return Math.max(0, Math.min(400, raw));
  }

  build() {
    Column({ space: AppSpacing.xl }) {
      // ---- CenterAlignedTopAppBar ----
      Row() {
        Text('Retro Remote Control')
          .fontSize(AppTypography.display.size)
          .fontWeight(AppTypography.display.weight)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // ---- Remote surface + knob canvas ----
      Box() {
        Stack() {
          // pale halo: drawCircle(secondary @ 20%, r = 100vp)
          Circle({ width: 200, height: 200 })
            .fill(AppColors.secondary)
            .opacity(0.2)

          // knob: drawCircle(primary, r = 12vp) at knobPosition
          Circle({ width: this.knobRadius * 2, height: this.knobRadius * 2 })
            .fill(AppColors.primary)
            .position({
              x: this.knobX - this.knobRadius,
              y: this.knobY - this.knobRadius
            })
        }
        .width(this.canvasSize)
        .height(this.canvasSize)
        .gesture(
          PanGesture({ fingers: 1, distance: 0 })
            .onActionStart((event: GestureEvent) => {
              if (event.fingerList.length > 0) {
                this.applyKnob(event.fingerList[0].localX, event.fingerList[0].localY);
              }
            })
            .onActionUpdate((event: GestureEvent) => {
              if (event.fingerList.length > 0) {
                this.applyKnob(event.fingerList[0].localX, event.fingerList[0].localY);
              }
            })
        )
      }
      .width(this.cardSize)
      .height(this.cardSize)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.large)
      .shadow({
        radius: ElevationMapping.level1.radius,
        color: ElevationMapping.level1.color(),
        offsetX: 0,
        offsetY: ElevationMapping.level1.dy
      })

      // ---- power state ----
      Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
        .fontSize(AppTypography.title.size)
        .fontWeight(AppTypography.title.weight)
        .fontColor(this.powerOn ? AppColors.success : AppColors.error)

      // ---- actions ----
      Row() {
        Button() {
          Text(this.powerOn ? 'Off' : 'On')
            .fontSize(AppTypography.title.size)
            .fontWeight(AppTypography.title.weight)
            .fontColor(AppColors.onPrimary)
        }
        .type(ButtonType.Circle)
        .width(80)
        .height(80)
        .backgroundColor(AppColors.primary)
        .onClick(() => {
          this.powerOn = !this.powerOn;
        })

        Button() {
          Text('Reset')
            .fontSize(AppTypography.title.size)
            .fontWeight(AppTypography.title.weight)
            .fontColor(AppColors.onSecondary)
        }
        .type(ButtonType.Circle)
        .width(80)
        .height(80)
        .backgroundColor(AppColors.secondary)
        .onClick(() => {
          this.resetKnob();
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)

      // ---- progress ----
      Progress({ value: this.progressValue(), total: 400, type: ProgressType.Linear })
        .width('100%')
        .height(6)
        .color(AppColors.primary)
        .backgroundColor(AppColors.surfaceVariant)
        .style({ strokeWidth: 6, strokeRadius: 3, enableSmoothEffect: true })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}