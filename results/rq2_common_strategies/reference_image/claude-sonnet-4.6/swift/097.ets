// ClimateControllerPage.ets
// ArkTS (HarmonyOS / ArkUI) translation of the SwiftUI climate controller screen.

import { window } from '@kit.ArkUI';

/** Temperature range limits, mirroring the SwiftUI clamping logic. */
const TEMP_MIN: number = 16;
const TEMP_MAX: number = 30;
const TEMP_STEP: number = 0.5;

/** Dimensions — 1:1 mapping of the SwiftUI `Dimensions` struct (vp). */
class Dim {
  static readonly screenPadding: number = 24;
  static readonly headerTopPadding: number = 16;
  static readonly headerSpacerHeight: number = 40;
  static readonly dialSectionSpacerHeight: number = 40;

  static readonly dialOuterBoxSize: number = 280;
  static readonly dialCanvasSize: number = 240;
  static readonly dialStrokeWidth: number = 40;
  static readonly knobRadiusOuter: number = 16;
  static readonly knobRadiusInner: number = 10;
  static readonly tempControlsSpacerHeight: number = 32;
  static readonly tempControlsHorizontalSpacing: number = 32;

  static readonly roundControlButtonSize: number = 56;
  static readonly roundControlButtonBorderWidth: number = 1;
  static readonly roundControlButtonIconSize: number = 28;

  static readonly quickActionsTitleBottomPadding: number = 16;
  static readonly quickActionsRowSpacing: number = 16;
  static readonly quickActionCardHeight: number = 100;
  static readonly quickActionCardCornerRadius: number = 20;
  static readonly quickActionCardPadding: number = 16;
  static readonly quickActionCardIconSize: number = 24;

  static readonly letterSpacingSmall: number = 2;
  static readonly fontSizeLabelMedium: number = 13;
  static readonly fontSizeBodySmall: number = 11;
  static readonly fontSizeDisplayMedium: number = 45;
  static readonly fontSizeLabelLarge: number = 15;
  static readonly fontSizeLabelSmall: number = 11;
}

/** Palette, converted from the 0xAARRGGBB hex values of the SwiftUI extension. */
class AppColor {
  static readonly pureWhite: string = '#FFFFFF';
  static readonly textBlack: string = '#1C1C1E';
  static readonly textGray: string = '#8E8E93';
  static readonly accentBlue: string = '#007AFF';
  static readonly softGrayBg: string = '#F2F2F7';
  static readonly lightGrayBg: string = '#F9F9F9';
  static readonly lightBorderGray: string = '#EEEEEE';
  static readonly disabledIconGray: string = '#D1D1D6';
  static readonly transparent: string = '#00000000';
}

/** Round control button (chevron down / chevron up). */
@Component
struct RoundControlButton {
  @Prop icon: string = '';
  @Prop enabled: boolean = true;
  onTap: () => void = () => {
  };

  build() {
    Text(this.icon)
      .fontSize(Dim.roundControlButtonIconSize)
      .fontColor(this.enabled ? AppColor.textBlack : AppColor.disabledIconGray)
      .textAlign(TextAlign.Center)
      .width(Dim.roundControlButtonSize)
      .height(Dim.roundControlButtonSize)
      .borderRadius(Dim.roundControlButtonSize / 2)
      .backgroundColor(this.enabled ? AppColor.softGrayBg : AppColor.lightGrayBg)
      .border({
        width: Dim.roundControlButtonBorderWidth,
        color: this.enabled ? AppColor.transparent : AppColor.lightBorderGray
      })
      .onClick(() => {
        if (this.enabled) {
          this.onTap();
        }
      })
  }
}

/** Quick action card (icon on top, label + status pinned to the bottom). */
@Component
struct QuickActionCard {
  @Prop icon: string = '';
  @Prop label: string = '';
  @Prop status: string = '';
  @Prop isActive: boolean = false;

  build() {
    Column() {
      Text(this.icon)
        .fontSize(Dim.quickActionCardIconSize)
        .fontColor(this.isActive ? AppColor.pureWhite : AppColor.textBlack)

      Blank()

      Column() {
        Text(this.label)
          .fontSize(Dim.fontSizeLabelMedium)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isActive ? AppColor.pureWhite : AppColor.textBlack)
        Text(this.status)
          .fontSize(Dim.fontSizeBodySmall)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColor.textGray)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(Dim.quickActionCardPadding)
    .height(Dim.quickActionCardHeight)
    .width('100%')
    .backgroundColor(this.isActive ? AppColor.textBlack : AppColor.softGrayBg)
    .borderRadius(Dim.quickActionCardCornerRadius)
  }
}

@Entry
@Component
struct ClimateControllerPage {
  @State targetTemp: number = 21.5;
  @State isActive: boolean = true;
  @State progress: number = (21.5 - TEMP_MIN) / (TEMP_MAX - TEMP_MIN);

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private canvasReady: boolean = false;
  private timerId: number = -1;

  aboutToAppear(): void {
    // Full screen, status bar hidden — the ArkUI counterpart of
    // .ignoresSafeArea() + .statusBarHidden(true).
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch((err: Error) => {
        console.error('Fullscreen setup failed: ' + err.message);
      });
  }

  aboutToDisappear(): void {
    this.stopTimer();
  }

  // ------------------------------------------------------------------
  // Temperature logic
  // ------------------------------------------------------------------

  private adjustTemp(delta: number): void {
    let next: number = this.targetTemp + delta;
    if (next < TEMP_MIN) {
      next = TEMP_MIN;
    }
    if (next > TEMP_MAX) {
      next = TEMP_MAX;
    }
    next = Math.round(next * 10) / 10;
    this.targetTemp = next;
    this.animateProgress((next - TEMP_MIN) / (TEMP_MAX - TEMP_MIN));
  }

  /** Ease-out animation of the arc sweep, equivalent to withAnimation(.easeOut). */
  private animateProgress(target: number): void {
    this.stopTimer();
    const start: number = this.progress;
    const startTime: number = Date.now();
    const duration: number = 400;

    this.timerId = setInterval(() => {
      const t: number = Math.min(1, (Date.now() - startTime) / duration);
      const eased: number = 1 - Math.pow(1 - t, 3);
      this.progress = start + (target - start) * eased;
      this.drawDial();
      if (t >= 1) {
        this.stopTimer();
      }
    }, 16);
  }

  private stopTimer(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  // ------------------------------------------------------------------
  // Canvas dial — replaces the SwiftUI Path/Stroke + knob overlay
  // ------------------------------------------------------------------

  private drawDial(): void {
    if (!this.canvasReady) {
      return;
    }

    const size: number = Dim.dialOuterBoxSize;
    const strokeWidth: number = Dim.dialStrokeWidth;
    const center: number = size / 2;
    const radius: number = (size - strokeWidth) / 2;
    const startDeg: number = 135;
    const endDeg: number = startDeg + 270 * this.progress;
    const toRad: number = Math.PI / 180;
    const arcColor: string = this.isActive ? AppColor.accentBlue : AppColor.textGray;

    this.ctx.clearRect(0, 0, size, size);

    // Background track
    this.ctx.beginPath();
    this.ctx.lineWidth = strokeWidth;
    this.ctx.lineCap = 'round';
    this.ctx.strokeStyle = AppColor.softGrayBg;
    this.ctx.arc(center, center, radius, 0, Math.PI * 2, false);
    this.ctx.stroke();

    // Animated progress arc
    if (270 * this.progress > 0.5) {
      this.ctx.beginPath();
      this.ctx.lineWidth = strokeWidth;
      this.ctx.lineCap = 'round';
      this.ctx.strokeStyle = arcColor;
      this.ctx.arc(center, center, radius, startDeg * toRad, endDeg * toRad, false);
      this.ctx.stroke();
    }

    // Knob indicator
    const rad: number = endDeg * toRad;
    const knobX: number = center + radius * Math.cos(rad);
    const knobY: number = center + radius * Math.sin(rad);

    this.ctx.beginPath();
    this.ctx.fillStyle = AppColor.pureWhite;
    this.ctx.arc(knobX, knobY, Dim.knobRadiusOuter, 0, Math.PI * 2, false);
    this.ctx.fill();

    this.ctx.beginPath();
    this.ctx.fillStyle = arcColor;
    this.ctx.arc(knobX, knobY, Dim.knobRadiusInner, 0, Math.PI * 2, false);
    this.ctx.fill();
  }

  // ------------------------------------------------------------------
  // Sections
  // ------------------------------------------------------------------

  @Builder
  headerSection() {
    Row() {
      Text('☰')
        .fontSize(Dim.roundControlButtonIconSize)
        .fontColor(AppColor.textBlack)
        .onClick(() => {
        })

      Blank()

      Column() {
        Text('LIVING ROOM')
          .fontSize(Dim.fontSizeLabelMedium)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColor.textGray)
          .letterSpacing(Dim.letterSpacingSmall)
        Text('Connected')
          .fontSize(Dim.fontSizeBodySmall)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColor.accentBlue)
          .margin({ top: 2 })
      }

      Blank()

      Text('⚙')
        .fontSize(Dim.roundControlButtonIconSize)
        .fontColor(AppColor.textBlack)
        .onClick(() => {
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  temperatureDialSection() {
    Column() {
      Stack() {
        Canvas(this.ctx)
          .width(Dim.dialOuterBoxSize)
          .height(Dim.dialOuterBoxSize)
          .onReady(() => {
            this.canvasReady = true;
            this.drawDial();
          })

        Column() {
          Text(this.targetTemp.toFixed(1) + '°')
            .fontSize(Dim.fontSizeDisplayMedium)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? AppColor.textBlack : AppColor.textGray)
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(Dim.fontSizeLabelLarge)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColor.textGray)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(Dim.dialOuterBoxSize)
      .height(Dim.dialOuterBoxSize)

      Row() {
      }
      .width('100%')
      .height(Dim.tempControlsSpacerHeight)

      Row() {
        RoundControlButton({
          icon: '∨',
          enabled: this.isActive,
          onTap: () => {
            this.adjustTemp(-TEMP_STEP);
          }
        })

        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor(AppColor.textBlack)
          .switchPointColor(AppColor.pureWhite)
          .onChange((isOn: boolean) => {
            this.isActive = isOn;
            this.drawDial();
          })

        RoundControlButton({
          icon: '∧',
          enabled: this.isActive,
          onTap: () => {
            this.adjustTemp(TEMP_STEP);
          }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  controlGridSection() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(Dim.fontSizeLabelSmall)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColor.textGray)
        .letterSpacing(Dim.letterSpacingSmall)
        .margin({ bottom: Dim.quickActionsTitleBottomPadding })

      Row({ space: Dim.quickActionsRowSpacing }) {
        Column() {
          QuickActionCard({ icon: '↻', label: 'Fan Speed', status: 'Auto' })
        }
        .layoutWeight(1)

        Column() {
          QuickActionCard({ icon: '♥', label: 'Eco Mode', status: 'On', isActive: true })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Row() {
      }
      .width('100%')
      .height(Dim.quickActionsRowSpacing)

      Row({ space: Dim.quickActionsRowSpacing }) {
        Column() {
          QuickActionCard({ icon: 'ⓘ', label: 'Timer', status: 'Set 2h' })
        }
        .layoutWeight(1)

        Column() {
          QuickActionCard({ icon: '⌂', label: 'Away', status: 'Off' })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      this.headerSection()

      Row() {
      }
      .width('100%')
      .height(Dim.headerSpacerHeight)

      this.temperatureDialSection()

      Row() {
      }
      .width('100%')
      .height(Dim.dialSectionSpacerHeight)

      this.controlGridSection()

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding({
      left: Dim.screenPadding,
      right: Dim.screenPadding,
      top: Dim.headerTopPadding
    })
    .backgroundColor(AppColor.pureWhite)
    .alignItems(HorizontalAlign.Start)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}