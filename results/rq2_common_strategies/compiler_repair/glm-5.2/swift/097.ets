// Dimensions.ets
export class Dimensions {
  static screenPadding: number = 24
  static headerTopPadding: number = 16
  static headerSpacerHeight: number = 40
  static dialSectionSpacerHeight: number = 40

  static dialOuterBoxSize: number = 280
  static dialCanvasSize: number = 240
  static dialStrokeWidth: number = 40
  static knobRadiusOuter: number = 16
  static knobRadiusInner: number = 10
  static tempControlsSpacerHeight: number = 32
  static tempControlsHorizontalSpacing: number = 32

  static roundControlButtonSize: number = 56
  static roundControlButtonBorderWidth: number = 1
  static roundControlButtonIconSize: number = 28

  static quickActionsTitleBottomPadding: number = 16
  static quickActionsRowSpacing: number = 16
  static quickActionCardHeight: number = 100
  static quickActionCardCornerRadius: number = 20
  static quickActionCardPadding: number = 16
  static quickActionCardIconSize: number = 24

  static letterSpacingSmall: number = 2
  static fontSizeLabelMedium: number = 13
  static fontSizeBodySmall: number = 11
  static fontSizeDisplayMedium: number = 45
  static fontSizeLabelLarge: number = 15
  static fontSizeLabelSmall: number = 11
}

// Colors.ets
export class AppColors {
  static pureWhite: string = '#FFFFFFFF'
  static textBlack: string = '#FF1C1C1E'
  static textGray: string = '#FF8E8E93'
  static accentBlue: string = '#FF007AFF'
  static softGrayBg: string = '#FFF2F2F7'
  static lightGrayBg: string = '#FFF9F9F9'
  static lightBorderGray: string = '#FFEEEEEE'
  static disabledIconGray: string = '#FFD1D1D6'
}

// Helper for clamping floats
function clamp(value: number, min: number, max: number): number {
  return Math.min(Math.max(value, min), max);
}

// Entry Point
@Entry
@Component
struct ClimateControllerApp {
  build() {
    Stack() {
      Column() {
        HeaderSection()
          .padding({ top: Dimensions.headerTopPadding })

        Blank()
          .height(Dimensions.headerSpacerHeight)

        TemperatureDialSection()

        Blank()
          .height(Dimensions.dialSectionSpacerHeight)

        ControlGridSection()

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: Dimensions.screenPadding, right: Dimensions.screenPadding })
    }
    .backgroundColor(AppColors.pureWhite)
  }
}

// Header Section
@Component
struct HeaderSection {
  build() {
    Row() {
      Button({ type: ButtonType.Normal }) {
        Image($r('sys.media.ohos_ic_public_more'))
          .width(Dimensions.roundControlButtonIconSize)
          .height(Dimensions.roundControlButtonIconSize)
          .fillColor(AppColors.textBlack)
      }
      .backgroundColor(Color.Transparent)

      Blank()

      Column() {
        Text('LIVING ROOM')
          .fontSize(Dimensions.fontSizeLabelMedium)
          .fontColor(AppColors.textGray)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(Dimensions.letterSpacingSmall)
        Text('Connected')
          .fontSize(Dimensions.fontSizeBodySmall)
          .fontColor(AppColors.accentBlue)
      }

      Blank()

      Button({ type: ButtonType.Normal }) {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(Dimensions.roundControlButtonIconSize)
          .height(Dimensions.roundControlButtonIconSize)
          .fillColor(AppColors.textBlack)
      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }
}

// Temperature Dial Section
@Component
struct TemperatureDialSection {
  @State targetTemp: number = 21.5;
  @State isActive: boolean = true;

  adjustTemp(delta: number): void {
    let newTemp = clamp(this.targetTemp + delta, 16.0, 30.0);
    this.targetTemp = Math.round(newTemp * 10) / 10.0;
  }

  build() {
    Column() {
      Stack() {
        // Background Circle
        Circle()
          .width(Dimensions.dialCanvasSize)
          .height(Dimensions.dialCanvasSize)
          .fill(AppColors.softGrayBg)

        // Animated Arc Indicator and Knob
        TemperatureDial({
          progress: (this.targetTemp - 16.0) / (30.0 - 16.0),
          isActive: this.isActive
        })
          .width(Dimensions.dialCanvasSize)
          .height(Dimensions.dialCanvasSize)

        // Center Text
        Column() {
          Text(`${this.targetTemp.toFixed(1)}°`)
            .fontSize(Dimensions.fontSizeDisplayMedium)
            .fontColor(this.isActive ? AppColors.textBlack : AppColors.textGray)
            .fontWeight(FontWeight.Bold)
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(Dimensions.fontSizeLabelLarge)
            .fontColor(AppColors.textGray)
            .fontWeight(FontWeight.Medium)
        }
      }
      .width(Dimensions.dialOuterBoxSize)
      .height(Dimensions.dialOuterBoxSize)

      Blank()
        .height(Dimensions.tempControlsSpacerHeight)

      // Temp Controls
      Row() {
        RoundControlButton({
          iconName: $r('sys.media.ohos_ic_public_arrow_down'),
          action: () => this.adjustTemp(-0.5),
          isEnabled: this.isActive
        })

        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor(AppColors.textBlack)
          .onChange((isOn: boolean) => this.isActive = isOn)

        RoundControlButton({
          iconName: $r('sys.media.ohos_ic_public_arrow_up'),
          action: () => this.adjustTemp(0.5),
          isEnabled: this.isActive
        })
      }
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}

// Custom Temperature Dial Drawing
@Component
struct TemperatureDial {
  @Prop progress: number;
  @Prop isActive: boolean;
  @State animatedProgress: number = 0.0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear(): void {
    animateTo({ duration: 500, curve: Curve.EaseOut }, () => {
      this.animatedProgress = this.progress;
    })
  }

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        const ctx = this.context;
        const size: SizeOptions = { width: Dimensions.dialCanvasSize, height: Dimensions.dialCanvasSize };
        const strokeWidth = Dimensions.dialStrokeWidth;
        const startAngleDeg = 135;
        const sweepAngleDeg = 270 * this.animatedProgress;
        const endAngleDeg = startAngleDeg + sweepAngleDeg;

        const radius = (Math.min(size.width as number, size.height as number) - strokeWidth) / 2;
        const centerX = (size.width as number) / 2;
        const centerY = (size.height as number) / 2;

        // Draw Arc
        ctx.beginPath();
        ctx.lineWidth = strokeWidth;
        ctx.lineCap = 'round';
        ctx.strokeStyle = this.isActive ? AppColors.accentBlue : AppColors.textGray;
        const startRad = (Math.PI / 180) * (startAngleDeg - 90);
        const endRad = (Math.PI / 180) * (endAngleDeg - 90);
        ctx.arc(centerX, centerY, radius, startRad, endRad, false);
        ctx.stroke();

        // Draw Knob
        const knobRad = (Math.PI / 180) * (endAngleDeg - 90);
        const knobX = centerX + radius * Math.cos(knobRad);
        const knobY = centerY + radius * Math.sin(knobRad);

        // Outer Knob
        ctx.beginPath();
        ctx.fillStyle = AppColors.pureWhite;
        ctx.arc(knobX, knobY, Dimensions.knobRadiusOuter, 0, 2 * Math.PI, false);
        ctx.fill();

        // Inner Knob
        ctx.beginPath();
        ctx.fillStyle = this.isActive ? AppColors.accentBlue : AppColors.textGray;
        ctx.arc(knobX, knobY, Dimensions.knobRadiusInner, 0, 2 * Math.PI, false);
        ctx.fill();
      })
      .onAreaChange(() => {
        animateTo({ duration: 500, curve: Curve.EaseOut }, () => {
          this.animatedProgress = this.progress;
        })
      })
  }
}

// Round Control Button
@Component
struct RoundControlButton {
  @Prop iconName: Resource;
  @Prop isEnabled: boolean;
  private action: () => void = () => {};

  build() {
    Button({ type: ButtonType.Normal }) {
      Image(this.iconName)
        .width(Dimensions.roundControlButtonIconSize)
        .height(Dimensions.roundControlButtonIconSize)
        .fillColor(this.isEnabled ? AppColors.textBlack : AppColors.disabledIconGray)
    }
    .onClick(this.action)
    .width(Dimensions.roundControlButtonSize)
    .height(Dimensions.roundControlButtonSize)
    .backgroundColor(this.isEnabled ? AppColors.softGrayBg : AppColors.lightGrayBg)
    .borderRadius(Dimensions.roundControlButtonSize / 2)
    .border({
      width: this.isEnabled ? 0 : Dimensions.roundControlButtonBorderWidth,
      color: this.isEnabled ? Color.Transparent : AppColors.lightBorderGray
    })
    .enabled(this.isEnabled)
  }
}

// Control Grid Section
@Component
struct ControlGridSection {
  build() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(Dimensions.fontSizeLabelSmall)
        .fontColor(AppColors.textGray)
        .fontWeight(FontWeight.Bold)
        .padding({ bottom: Dimensions.quickActionsTitleBottomPadding })

      Row() {
        QuickActionCard({
          iconName: $r('sys.media.ohos_ic_public_restore'),
          label: 'Fan Speed',
          status: 'Auto'
        })
        QuickActionCard({
          iconName: $r('sys.media.ohos_ic_public_heart'),
          label: 'Eco Mode',
          status: 'On',
          isActive: true
        })
      }
      .width('100%')

      Blank()
        .height(Dimensions.quickActionsRowSpacing)

      Row() {
        QuickActionCard({
          iconName: $r('sys.media.ohos_ic_public_clock'),
          label: 'Timer',
          status: 'Set 2h'
        })
        QuickActionCard({
          iconName: $r('sys.media.ohos_ic_public_home'),
          label: 'Away',
          status: 'Off'
        })
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// Quick Action Card
@Component
struct QuickActionCard {
  @Prop iconName: Resource;
  @Prop label: string;
  @Prop status: string;
  @Prop isActive: boolean = false;

  build() {
    Column() {
      Image(this.iconName)
        .width(Dimensions.quickActionCardIconSize)
        .height(Dimensions.quickActionCardIconSize)
        .fillColor(this.isActive ? AppColors.pureWhite : AppColors.textBlack)
        .margin({ bottom: 8 })

      Blank()

      Column() {
        Text(this.label)
          .fontSize(Dimensions.fontSizeLabelMedium)
          .fontColor(this.isActive ? AppColors.pureWhite : AppColors.textBlack)
          .fontWeight(FontWeight.Medium)
        Text(this.status)
          .fontSize(Dimensions.fontSizeBodySmall)
          .fontColor(AppColors.textGray)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(Dimensions.quickActionCardPadding)
    .height(Dimensions.quickActionCardHeight)
    .layoutWeight(1)
    .backgroundColor(this.isActive ? AppColors.textBlack : AppColors.softGrayBg)
    .borderRadius(Dimensions.quickActionCardCornerRadius)
    .alignItems(HorizontalAlign.Start)
  }
}