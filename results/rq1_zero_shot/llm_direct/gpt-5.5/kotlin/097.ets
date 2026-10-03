import window from '@ohos.window';

const PureWhite: ResourceColor = '#FFFFFFFF';
const TextBlack: ResourceColor = '#FF1C1C1E';
const TextGray: ResourceColor = '#FF8E8E93';
const AccentBlue: ResourceColor = '#FF007AFF';
const SoftGrayBg: ResourceColor = '#FFF2F2F7';
const ActiveOrange: ResourceColor = '#FFFF9500';

@Entry
@Component
struct ClimateControllerApp {
  aboutToAppear(): void {
    window.getLastWindow(getContext(this), (err, win) => {
      if (err.code === 0) {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      }
    });
  }

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
    .padding(24)
    .backgroundColor(PureWhite)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Button({ type: ButtonType.Circle, stateEffect: false }) {
        Text('☰')
          .fontSize(26)
          .fontColor(TextBlack)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)

      Column() {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontColor(TextGray)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)

        Text('Connected')
          .fontSize(12)
          .fontColor(AccentBlue)
      }
      .alignItems(HorizontalAlign.Center)

      Button({ type: ButtonType.Circle, stateEffect: false }) {
        Text('⚙')
          .fontSize(24)
          .fontColor(TextBlack)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .padding({ top: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TemperatureDialSection {
  @State targetTemp: number = 21.5;
  @State isActive: boolean = true;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  adjustTemp(delta: number): void {
    if (!this.isActive) {
      return;
    }

    let newTemp = this.targetTemp + delta;
    newTemp = Math.max(16.0, Math.min(30.0, newTemp));
    this.targetTemp = Math.round(newTemp * 10) / 10;

    setTimeout(() => {
      this.drawDial();
    }, 0);
  }

  drawDial(): void {
    const width = 240;
    const height = 240;
    const strokeWidth = 40;
    const radius = (width - strokeWidth) / 2;
    const centerX = width / 2;
    const centerY = height / 2;

    this.context.clearRect(0, 0, width, height);

    this.context.beginPath();
    this.context.lineWidth = strokeWidth;
    this.context.strokeStyle = SoftGrayBg as string;
    this.context.arc(centerX, centerY, radius, 0, Math.PI * 2);
    this.context.stroke();

    const progress = (this.targetTemp - 16) / (30 - 16);
    const startAngle = 135 * Math.PI / 180;
    const sweepAngle = 270 * progress * Math.PI / 180;
    const endAngle = startAngle + sweepAngle;

    this.context.beginPath();
    this.context.lineWidth = strokeWidth;
    this.context.lineCap = 'round';
    this.context.strokeStyle = (this.isActive ? AccentBlue : TextGray) as string;
    this.context.arc(centerX, centerY, radius, startAngle, endAngle);
    this.context.stroke();

    const knobX = centerX + radius * Math.cos(endAngle);
    const knobY = centerY + radius * Math.sin(endAngle);

    this.context.beginPath();
    this.context.fillStyle = PureWhite as string;
    this.context.arc(knobX, knobY, 16, 0, Math.PI * 2);
    this.context.fill();

    this.context.beginPath();
    this.context.fillStyle = (this.isActive ? AccentBlue : TextGray) as string;
    this.context.arc(knobX, knobY, 10, 0, Math.PI * 2);
    this.context.fill();
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.context)
          .width(240)
          .height(240)
          .onReady(() => {
            this.drawDial();
          })

        Column() {
          Text(`${this.targetTemp.toFixed(1)}°`)
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? TextBlack : TextGray)

          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(TextGray)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)

      Blank().height(32)

      Row() {
        RoundControlButton({
          icon: '⌄',
          enabled: this.isActive,
          onClick: () => {
            this.adjustTemp(-0.5);
          }
        })

        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor(TextBlack)
          .switchPointColor(PureWhite)
          .onChange((isOn: boolean) => {
            this.isActive = isOn;
            setTimeout(() => {
              this.drawDial();
            }, 0);
          })

        RoundControlButton({
          icon: '⌃',
          enabled: this.isActive,
          onClick: () => {
            this.adjustTemp(0.5);
          }
        })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .gap(32)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct RoundControlButton {
  icon: string = '';
  enabled: boolean = true;
  onClick: () => void = () => {};

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text(this.icon)
        .fontSize(28)
        .fontColor(this.enabled ? TextBlack : '#FFD1D1D6')
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor(this.enabled ? SoftGrayBg : '#FFF9F9F9')
    .border({
      width: 1,
      color: this.enabled ? Color.Transparent : '#FFEEEEEE',
      radius: 28
    })
    .enabled(this.enabled)
    .onClick(() => {
      if (this.enabled) {
        this.onClick();
      }
    })
  }
}

@Component
struct ControlGridSection {
  build() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(TextGray)
        .width('100%')
        .padding({ bottom: 16 })

      Row() {
        QuickActionCard({
          icon: '↻',
          label: 'Fan Speed',
          status: 'Auto'
        })
          .layoutWeight(1)

        QuickActionCard({
          icon: '♥',
          label: 'Eco Mode',
          status: 'On',
          isActive: true
        })
          .layoutWeight(1)
      }
      .width('100%')
      .gap(16)

      Blank().height(16)

      Row() {
        QuickActionCard({
          icon: 'i',
          label: 'Timer',
          status: 'Set 2h'
        })
          .layoutWeight(1)

        QuickActionCard({
          icon: '⌂',
          label: 'Away',
          status: 'Off'
        })
          .layoutWeight(1)
      }
      .width('100%')
      .gap(16)
    }
    .width('100%')
  }
}

@Component
struct QuickActionCard {
  icon: string = '';
  label: string = '';
  status: string = '';
  isActive: boolean = false;

  build() {
    Column() {
      Text(this.icon)
        .fontSize(24)
        .fontColor(this.isActive ? PureWhite : TextBlack)

      Column() {
        Text(this.label)
          .fontSize(14)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.isActive ? PureWhite : TextBlack)

        Text(this.status)
          .fontSize(12)
          .fontColor(TextGray)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(100)
    .padding(16)
    .borderRadius(20)
    .backgroundColor(this.isActive ? TextBlack : SoftGrayBg)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}