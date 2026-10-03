// ─────────────────────────────────────────────────────────────
// entry/src/main/ets/pages/Index.ets
// ArkTS (HarmonyOS ArkUI) port of the Compose screen
// ─────────────────────────────────────────────────────────────
import { display } from '@kit.ArkUI';

/* ─────────────── Design tokens (mirrors AppTokens) ─────────────── */
class AppColors {
  static readonly primary: string = '#FF8C00';
  static readonly secondary: string = '#FFC107';
  static readonly tertiary: string = '#FFE082';
  static readonly background: string = '#FFF8E1';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFECB3';
  static readonly outline: string = '#D7CCC8';
  static readonly success: string = '#4CAF50';
  static readonly warning: string = '#FFB300';
  static readonly error: string = '#E53935';
  static readonly onPrimary: string = '#3E2723';
  static readonly onSecondary: string = '#3E2723';
  static readonly onBackground: string = '#3E2723';
  static readonly onSurface: string = '#3E2723';
}

class AppText {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppRadius {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

/* Mirrors AppTokens.ElevationMapping — ARGB alpha ≈ opacity */
interface ShadowSpec {
  radius: number;
  offsetY: number;
  color: string;
}

class AppElevation {
  static readonly level1: ShadowSpec = { radius: 4, offsetY: 2, color: '#1A000000' };
  static readonly level2: ShadowSpec = { radius: 8, offsetY: 4, color: '#26000000' };
  static readonly level3: ShadowSpec = { radius: 12, offsetY: 6, color: '#2E000000' };
}

/* ─────────────── Map model ─────────────── */
interface Pin {
  x: number;
  y: number;
  label: string;
}

/* Virtual coordinate space the pins live in (matches the reference render) */
const DESIGN_W: number = 620;
const DESIGN_H: number = 460;
const DOT_RADIUS: number = 13;

function randomBetween(min: number, max: number): number {
  return Math.floor(Math.random() * (max - min)) + min;
}

/* ─────────────── Screen ─────────────── */
@Entry
@Component
struct Index {
  @State @Watch('onPinsChanged') pins: Pin[] = [
    { x: 150, y: 250, label: 'Group A' },
    { x: 350, y: 420, label: 'Group B' },
    { x: 520, y: 310, label: 'Group C' }
  ];

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  onPinsChanged(_propName: string): void {
    this.drawMap();
  }

  private drawMap(): void {
    let w: number = this.ctx.width;
    let h: number = this.ctx.height;
    if (w <= 0) {
      w = px2vp(display.getDefaultDisplaySync().width) - 64;
    }
    if (h <= 0) {
      h = 204;
    }

    const kx: number = w / DESIGN_W;
    const ky: number = h / DESIGN_H;

    this.ctx.clearRect(0, 0, w, h);
    this.ctx.fillStyle = AppColors.surfaceVariant;
    this.ctx.fillRect(0, 0, w, h);

    this.pins.forEach((p: Pin) => {
      this.ctx.beginPath();
      this.ctx.arc(p.x * kx, p.y * ky, DOT_RADIUS * kx, 0, Math.PI * 2);
      this.ctx.closePath();
      this.ctx.fillStyle = AppColors.primary;
      this.ctx.fill();
    });
  }

  private addGroup(): void {
    const p: Pin = {
      x: randomBetween(100, 550),
      y: randomBetween(150, 450),
      label: 'New'
    };
    this.pins = this.pins.concat([p]);
    this.drawMap();
  }

  private clearGroups(): void {
    this.pins = [];
    this.drawMap();
  }

  build() {
    Column({ space: AppSpacing.lg }) {
      /* Title */
      Text('Retro Group Buy')
        .fontSize(AppText.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .width('100%')

      /* ── Live Deals Map card ── */
      Column({ space: AppSpacing.md }) {
        Text('Live Deals Map')
          .fontSize(AppText.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')

        Canvas(this.ctx)
          .width('100%')
          .height(220)
          .onReady(() => {
            this.drawMap();
          })
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppRadius.large)
      .shadow({
        radius: AppElevation.level2.radius,
        color: AppElevation.level2.color,
        offsetX: 0,
        offsetY: AppElevation.level2.offsetY
      })

      /* ── Action row ── */
      Row({ space: AppSpacing.md }) {
        Button() {
          Text('Add Group')
            .fontSize(AppText.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
        }
        .type(ButtonType.Normal)
        .borderRadius(AppRadius.medium)
        .backgroundColor(AppColors.secondary)
        .height(48)
        .layoutWeight(1)
        .onClick(() => {
          this.addGroup();
        })

        Button() {
          Text('Clear')
            .fontSize(AppText.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
        .type(ButtonType.Normal)
        .borderRadius(AppRadius.medium)
        .backgroundColor(AppColors.primary)
        .height(48)
        .layoutWeight(1)
        .onClick(() => {
          this.clearGroups();
        })
      }
      .width('100%')

      /* ── Active Groups card ── */
      Column({ space: AppSpacing.sm }) {
        Text('Active Groups')
          .fontSize(AppText.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .width('100%')

        ForEach(this.pins, (item: Pin, index: number) => {
          Row() {
            Text(item.label)
              .fontSize(AppText.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onSurface)

            Blank()

            Circle()
              .width(14)
              .height(14)
              .fill(AppColors.primary)
          }
          .width('100%')
        }, (item: Pin, index: number) => `${index}-${item.label}-${item.x}-${item.y}`)
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppRadius.large)
      .shadow({
        radius: AppElevation.level1.radius,
        color: AppElevation.level1.color,
        offsetX: 0,
        offsetY: AppElevation.level1.offsetY
      })
    }
    .width('100%')
    .height('100%')
    .padding({
      top: 32,
      bottom: AppSpacing.lg,
      left: AppSpacing.lg,
      right: AppSpacing.lg
    })
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}