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

// MainPage.ets
import { Dimensions, AppColors } from './PathToYourModules' // Adjust import path accordingly

@Component
export struct ClimateControllerView {
  build() {
    Column() {
      // Header Section
      HeaderSection()
        .padding({ top: Dimensions.headerTopPadding })

      // Spacer
      Blank()
        .height(Dimensions.headerSpacerHeight)

      // Temperature Dial Section
      TemperatureDialSection()

      // Spacer
      Blank()
        .height(Dimensions.dialSectionSpacerHeight)

      // Control Grid Section
      ControlGridSection()

      // Pushes content to top if there's extra space
      Blank()
    }
    .width('100%')
    .height('100%')
    .padding({ left: Dimensions.screenPadding, right: Dimensions.screenPadding })
    .backgroundColor(AppColors.pureWhite)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      // Menu Button
      Button() {
        Image($r('sys.media.ohos_ic_public_drawer'))
          .width(Dimensions.roundControlButtonIconSize)
          .height(Dimensions.roundControlButtonIconSize)
          .fillColor(AppColors.textBlack)
      }
      .backgroundColor(Color.Transparent)
      .type(ButtonType.Normal)

      Blank()

      // Center Text
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

      // Settings Button
      Button() {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(Dimensions.roundControlButtonIconSize)
          .height(Dimensions.roundControlButtonIconSize)
          .fillColor(AppColors.textBlack)
      }
      .backgroundColor(Color.Transparent)
      .type(ButtonType.Normal)
    }
    .width('100%')
  }
}

@Component
struct TemperatureDialSection {
  @State targetTemp: number = 21.5;
  @State isActive: boolean = true;

  adjustTemp(delta: number) {
    let newTemp = this.targetTemp + delta;
    if (newTemp < 16.0) newTemp = 16.0;
    if (newTemp > 30.0) newTemp = 30.0;
    this.targetTemp = Math.round(newTemp * 10) / 10.0;
  }

  build() {
    Column() {
      Stack() {
        // Background Circle
        Circle()
          .width(Dimensions.dialCanvasSize)
          .height(Dimensions.dialCanvasSize)
          .fillColor(Color.Transparent)
          .stroke(AppColors.softGrayBg)
          .strokeWidth(Dimensions.dialStrokeWidth)

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
          iconName: 'sys.media.ohos_ic_public_arrow_down',
          action: () => this.adjustTemp(-0.5),
          enabled: this.isActive
        })

        // Power Switch
        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor(AppColors.textBlack)
          .onChange((isOn: boolean) => this.isActive = isOn)

        RoundControlButton({
          iconName: 'sys.media.ohos_ic_public_arrow_up',
          action: () => this.adjustTemp(0.5),
          enabled: this.isActive
        })
      }
      .justifyContent(FlexAlign.SpaceEvenly)
    }
  }
}

@Component
struct TemperatureDial {
  progress: number = 0.0;
  isActive: boolean = false;
  @State animatedProgress: number = 0.0;

  aboutToAppear() {
    animateTo({ duration: 500, curve: Curve.EaseOut }, () => {
      this.animatedProgress = this.progress;
    });
  }

  build() {
    Canvas((context: CanvasRenderingContext2D) => {
      const ctx = context as CanvasRenderingContext2D;
      const size = { width: Dimensions.dialCanvasSize, height: Dimensions.dialCanvasSize };
      const strokeWidth = Dimensions.dialStrokeWidth;
      const startAngleDeg = 135;
      const sweepAngleDeg = 270 * this.animatedProgress;
      const endAngleDeg = startAngleDeg + sweepAngleDeg;

      const radius = (Math.min(size.width, size.height) - strokeWidth) / 2;
      const centerX = size.width / 2;
      const centerY = size.height / 2;

      // Draw Arc
      ctx.beginPath();
      ctx.lineWidth = strokeWidth;
      ctx.lineCap = 'round';
      ctx.strokeStyle = this.isActive ? AppColors.accentBlue : AppColors.textGray;
      ctx.arc(centerX, centerY, radius, (startAngleDeg * Math.PI) / 180, (endAngleDeg * Math.PI) / 180);
      ctx.stroke();

      // Draw Knob
      const knobAngleRad = (endAngleDeg * Math.PI) / 180;
      const knobX = centerX + radius * Math.cos(knobAngleRad);
      const knobY = centerY + radius * Math.sin(knobAngleRad);

      ctx.beginPath();
      ctx.fillStyle = AppColors.pureWhite;
      ctx.arc(knobX, knobY, Dimensions.knobRadiusOuter, 0, 2 * Math.PI);
      ctx.fill();

      ctx.beginPath();
      ctx.fillStyle = this.isActive ? AppColors.accentBlue : AppColors.textGray;
      ctx.arc(knobX, knobY, Dimensions.knobRadiusInner, 0, 2 * Math.PI);
      ctx.fill();
    })
    .width('100%')
    .height('100%')
    .onAreaChange(() => {
      animateTo({ duration: 500, curve: Curve.EaseOut }, () => {
        this.animatedProgress = this.progress;
      });
    })
  }
}

@Component
struct RoundControlButton {
  iconName: Resource = $r('sys.media.ohos_ic_public_arrow_down'); // Default fallback
  action: () => void = () => {};
  enabled: boolean = true;

  build() {
    Button(this.action) {
      Image(this.iconName)
        .width(Dimensions.roundControlButtonIconSize)
        .height(Dimensions.roundControlButtonIconSize)
        .fillColor(this.enabled ? AppColors.textBlack : AppColors.disabledIconGray)
    }
    .width(Dimensions.roundControlButtonSize)
    .height(Dimensions.roundControlButtonSize)
    .backgroundColor(this.enabled ? AppColors.softGrayBg : AppColors.lightGrayBg)
    .borderRadius(Dimensions.roundControlButtonSize / 2)
    .border({ width: Dimensions.roundControlButtonBorderWidth, color: this.enabled ? Color.Transparent : AppColors.lightBorderGray })
    .enabled(this.enabled)
    .type(ButtonType.Normal)
  }
}

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
          iconName: $r('sys.media.ohos_ic_public_rotate'),
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
          iconName: $r('sys.media.ohos_ic_public_info'),
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

@Component
struct QuickActionCard {
  iconName: Resource = $r('sys.media.ohos_ic_public_info');
  label: string = '';
  status: string = '';
  isActive: boolean = false;

  build() {
    Column() {
      Image(this.iconName)
        .width(Dimensions.quickActionCardIconSize)
        .height(Dimensions.quickActionCardIconSize)
        .fillColor(this.isActive ? AppColors.pureWhite : AppColors.textBlack)
        .padding({ bottom: 8 })

      Blank() // Pushes content apart

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
    .alignItems(HorizontalAlign.Start)
    .padding(Dimensions.quickActionCardPadding)
    .height(Dimensions.quickActionCardHeight)
    .layoutWeight(1) // Matches weight(1f) in Row
    .backgroundColor(this.isActive ? AppColors.textBlack : AppColors.softGrayBg)
    .borderRadius(Dimensions.quickActionCardCornerRadius)
  }
}