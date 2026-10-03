/**
 * 105_ChargingProgress_en — SmartHome Dashboard — Retro Flat
 * ArkTS / ArkUI (HarmonyOS) conversion of the Jetpack Compose sample.
 * Place as: entry/src/main/ets/pages/Index.ets
 *
 * Design tokens are mirrored from the Kotlin `AppTokens` object.
 */

class AppColors {
  readonly primary: string = '#3B82F6';
  readonly secondary: string = '#22C55E';
  readonly background: string = '#F5F5F4';
  readonly surface: string = '#FFFFFF';
  readonly outline: string = '#D4D4D8';
  readonly onPrimary: string = '#FFFFFF';
  readonly onBackground: string = '#111827';
  readonly onSurface: string = '#1F2937';
  readonly accent: string = '#F59E0B';
}

class AppSizes {
  // spacing
  readonly sm: number = 6;
  readonly md: number = 10;
  readonly lg: number = 14;
  readonly xl: number = 20;
  // typography
  readonly display: number = 24;
  readonly displayBig: number = 40;
  readonly headline: number = 18;
  readonly title: number = 14;
  readonly body: number = 12;
  // component metrics
  readonly appBarHeight: number = 56;
  readonly progressHeight: number = 14;
  readonly buttonHeight: number = 40;
  readonly buttonPadding: number = 24;
}

const COLORS: AppColors = new AppColors();
const SIZE: AppSizes = new AppSizes();

@Entry
@Component
struct ChargingProgressPage {
  /** mirrors `var progress by remember { mutableStateOf(0.45f) }` */
  @State progress: number = 0.45;

  /** mirrors the Button onClick: progress += 0.1f, wrap to 0 above 100 % */
  private simulateCharge(): void {
    const next: number = Math.round((this.progress + 0.1) * 10) / 10;
    this.progress = next > 1 ? 0 : next;
  }

  private percentLabel(): string {
    return `${Math.round(this.progress * 100)}%`;
  }

  private statusLabel(): string {
    return this.progress >= 1 ? 'Fully Charged!' : 'Charging...';
  }

  /* ---------------------------------------------------------------- *
   *  Icons (pure ArkUI shapes so the file compiles with no assets)
   * ---------------------------------------------------------------- */

  @Builder
  VehicleIcon() {
    Column() {
      // cabin
      Row()
        .width(16)
        .height(9)
        .borderRadius({ topLeft: 6, topRight: 6 })
        .backgroundColor(COLORS.primary)
      // body
      Row()
        .width(34)
        .height(12)
        .borderRadius(4)
        .backgroundColor(COLORS.primary)
        .margin({ top: 1 })
      // wheels
      Row({ space: 14 }) {
        Row().width(7).height(7).borderRadius(4).backgroundColor(COLORS.primary)
        Row().width(7).height(7).borderRadius(4).backgroundColor(COLORS.primary)
      }
      .margin({ top: -2 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  /** 72vp battery-charging icon: blue body + white bolt */
  @Builder
  BatteryChargingIcon() {
    Column() {
      Row()
        .width(14)
        .height(4)
        .borderRadius({ topLeft: 2, topRight: 2 })
        .backgroundColor(COLORS.primary)

      Stack() {
        Path({
          width: 16,
          height: 30,
          commands: 'M11 0 L1 17 L7 17 L4 30 L16 12 L10 12 Z'
        })
          .fill(COLORS.onPrimary)
      }
      .width(40)
      .height(64)
      .borderRadius(8)
      .backgroundColor(COLORS.primary)
      .alignContent(Alignment.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }

  /* ---------------------------------------------------------------- *
   *  Top app bar — CenterAlignedTopAppBar
   * ---------------------------------------------------------------- */

  @Builder
  AppBar() {
    Row() {
      Row() {
        this.VehicleIcon()
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)

      Text('Charging Progress')
        .fontSize(SIZE.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.onBackground)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Row() {
        // gear glyph — swap for $r('sys.symbol.gearshape_fill') or an app.media icon if preferred
        Text('⚙')
          .fontSize(22)
          .fontColor(COLORS.accent)
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(SIZE.appBarHeight)
    .backgroundColor(COLORS.surface)
    .border({ width: { bottom: 1 }, color: COLORS.outline })
    .alignItems(VerticalAlign.Center)
  }

  /* ---------------------------------------------------------------- *
   *  Body
   * ---------------------------------------------------------------- */

  @Builder
  Content() {
    Column({ space: SIZE.xl }) {
      this.BatteryChargingIcon()

      Text(this.percentLabel())
        .fontSize(SIZE.displayBig)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.onBackground)

      Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
        .width('80%')
        .height(SIZE.progressHeight)
        .color(COLORS.primary)
        .backgroundColor(COLORS.surface)
        .style({ strokeWidth: SIZE.progressHeight, enableSmoothEffect: true })
        .border({ width: 1, color: COLORS.outline, radius: SIZE.progressHeight / 2 })

      Button('Simulate Charge', { type: ButtonType.Capsule, stateEffect: true })
        .fontSize(SIZE.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.onPrimary)
        .backgroundColor(COLORS.secondary)
        .height(SIZE.buttonHeight)
        .padding({ left: SIZE.buttonPadding, right: SIZE.buttonPadding })
        .onClick(() => {
          this.simulateCharge();
        })

      Text(this.statusLabel())
        .fontSize(SIZE.headline)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(this.progress < 1 ? COLORS.primary : COLORS.secondary)
    }
    .width('100%')
    .layoutWeight(1)
    .padding(SIZE.lg)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }

  build() {
    Column() {
      this.AppBar()
      this.Content()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

/*
 * EntryAbility.ets — to reproduce the full-bleed, bar-less look of the reference frame
 * (the Kotlin side hides status + navigation bars):
 *
 *   import { window } from '@kit.ArkUI';
 *
 *   export default class EntryAbility extends UIAbility {
 *     onWindowStageCreate(windowStage: window.WindowStage): void {
 *       windowStage.loadContent('pages/Index', (err) => {});
 *       const win: window.Window = windowStage.getMainWindowSync();
 *       win.setWindowLayoutFullScreen(true);
 *       win.setWindowSystemBarEnable([]);            // hide status & navigation bars
 *     }
 *   }
 */