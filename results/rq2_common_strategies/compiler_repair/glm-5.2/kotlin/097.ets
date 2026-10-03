// Index.ets
import curves from '@ohos.curves';

const PureWhite: string = '#FFFFFF';
const TextBlack: string = '#1C1C1E';
const TextGray: string = '#8E8E93';
const AccentBlue: string = '#007AFF';
const SoftGrayBg: string = '#F2F2F7';

interface QuickActionItem {
  icon: Resource;
  label: string;
  status: string;
  isActive: boolean;
}

@Entry
@Component
struct ClimateControllerApp {
  build() {
    Column() {
      HeaderSection()
      Blank().height(40)
      TemperatureDialSection()
      Blank().height(40)
      ControlGridSection()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .backgroundColor(PureWhite)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Image($r('sys.media.ohos_ic_public_drawer'))
        .width(24)
        .height(24)
        .fillColor(TextBlack)

      Column() {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontColor(TextGray)
          .letterSpacing(2)
          .fontWeight(FontWeight.Bold)
        Text('Connected')
          .fontSize(12)
          .fontColor(AccentBlue)
          .margin({ top: 2 })
      }

      Image($r('sys.media.ohos_ic_public_settings'))
        .width(24)
        .height(24)
        .fillColor(TextBlack)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ top: 16 })
  }
}

@Component
struct TemperatureDialSection {
  @State targetTemp: number = 21.5;
  @State isActive: boolean = true;
  private animatedProgress: number = 0.392;

  adjustTemp(delta: number): void {
    let newTemp = this.targetTemp + delta;
    if (newTemp < 16.0) {
      newTemp = 16.0;
    }
    if (newTemp > 30.0) {
      newTemp = 30.0;
    }
    this.targetTemp = Math.round(newTemp * 10) / 10.0;
    this.animateProgress();
  }

  animateProgress(): void {
    let progress = (this.targetTemp - 16.0) / (30.0 - 16.0);
    animateTo({ duration: 500, curve: curves.easeInOut }, () => {
      this.animatedProgress = progress;
    });
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        // Background Circle
        Circle({ width: 240, height: 240 })
          .fillColor(Color.Transparent)
          .stroke(SoftGrayBg)
          .strokeWidth(40)

        // Progress Arc
        Circle({ width: 240, height: 240 })
          .fillColor(Color.Transparent)
          .stroke(this.isActive ? AccentBlue : TextGray)
          .strokeWidth(40)
          .strokeLineCap(LineCapStyle.Round)
          .startAngle(135)
          .sweepAngle(270 * this.animatedProgress)

        // Knob Indicator
        Circle({ width: 32, height: 32 })
          .fillColor(PureWhite)
          .position({
            x: 120 + 120 * Math.cos((135 + 270 * this.animatedProgress) * Math.PI / 180) - 16,
            y: 120 + 120 * Math.sin((135 + 270 * this.animatedProgress) * Math.PI / 180) - 16
          })

        Circle({ width: 20, height: 20 })
          .fillColor(this.isActive ? AccentBlue : TextGray)
          .position({
            x: 120 + 120 * Math.cos((135 + 270 * this.animatedProgress) * Math.PI / 180) - 10,
            y: 120 + 120 * Math.sin((135 + 270 * this.animatedProgress) * Math.PI / 180) - 10
          })

        // Center Text
        Column() {
          Text(`${this.targetTemp.toFixed(1)}°`)
            .fontSize(56)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? TextBlack : TextGray)
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(14)
            .fontColor(TextGray)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 4 })
        }
      }
      .width(280)
      .height(280)

      Blank().height(32)

      Row() {
        RoundControlButton({
          iconRes: $r('sys.media.ohos_ic_public_arrow_down'),
          onClickAction: () => this.adjustTemp(-0.5),
          isEnabled: this.isActive
        })

        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor(TextBlack)
          .onChange((isOn: boolean) => {
            this.isActive = isOn;
          })

        RoundControlButton({
          iconRes: $r('sys.media.ohos_ic_public_arrow_up'),
          onClickAction: () => this.adjustTemp(0.5),
          isEnabled: this.isActive
        })
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .width('100%')
    }
  }
}

@Component
struct RoundControlButton {
  private iconRes: Resource = $r('sys.media.ohos_ic_public_arrow_up');
  private onClickAction: () => void = () => {};
  private isEnabled: boolean = true;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Image(this.iconRes)
        .width(28)
        .height(28)
        .fillColor(this.isEnabled ? TextBlack : '#D1D1D6')
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor(this.isEnabled ? SoftGrayBg : '#F9F9F9')
    .border({ width: 1, color: this.isEnabled ? Color.Transparent : '#EEEEEE' })
    .opacity(this.isEnabled ? 1.0 : 0.5)
    .onClick(() => {
      if (this.isEnabled) {
        this.onClickAction();
      }
    })
  }
}

@Component
struct ControlGridSection {
  private actions: QuickActionItem[] = [
    { icon: $r('sys.media.ohos_ic_public_refresh'), label: 'Fan Speed', status: 'Auto', isActive: false },
    { icon: $r('sys.media.ohos_ic_public_favor'), label: 'Eco Mode', status: 'On', isActive: true },
    { icon: $r('sys.media.ohos_ic_public_info'), label: 'Timer', status: 'Set 2h', isActive: false },
    { icon: $r('sys.media.ohos_ic_public_home'), label: 'Away', status: 'Off', isActive: false }
  ];

  build() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(TextGray)
        .margin({ bottom: 16 })
        .width('100%')

      Row() {
        QuickActionCard({ item: this.actions[0] })
        Blank().width(16)
        QuickActionCard({ item: this.actions[1] })
      }
      .width('100%')

      Blank().height(16)

      Row() {
        QuickActionCard({ item: this.actions[2] })
        Blank().width(16)
        QuickActionCard({ item: this.actions[3] })
      }
      .width('100%')
    }
    .width('100%')
  }
}

@Component
struct QuickActionCard {
  private item: QuickActionItem = {
    icon: $r('sys.media.ohos_ic_public_info'),
    label: 'Default',
    status: 'Default',
    isActive: false
  };

  build() {
    Column() {
      Image(this.item.icon)
        .width(24)
        .height(24)
        .fillColor(this.item.isActive ? PureWhite : TextBlack)

      Blank()

      Column() {
        Text(this.item.label)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.item.isActive ? PureWhite : TextBlack)
        Text(this.item.status)
          .fontSize(12)
          .fontColor(TextGray)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(100)
    .padding(16)
    .borderRadius(20)
    .backgroundColor(this.item.isActive ? TextBlack : SoftGrayBg)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}