import { curves } from '@kit.ArkUI';

// --- Colors ---
const PureWhite = '#FFFFFFFF';
const TextBlack = '#FF1C1C1E';
const TextGray = '#FF8E8E93';
const AccentBlue = '#FF007AFF';
const SoftGrayBg = '#FFF2F2F7';

@Entry
@Component
struct ClimateControllerApp {
  build() {
    Surface() {
      Column({ space: 0 }) {
        HeaderSection()
        Blank().height(40)
        TemperatureDialSection()
        Blank().height(40)
        ControlGridSection()
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PureWhite)
  }
}

@Component
struct Surface {
  @BuilderParam content: () => void;

  build() {
    Stack() {
      this.content()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PureWhite)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_public_drawer_filled'))
          .width(24)
          .height(24)
          .fillColor(TextBlack)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)

      Column() {
        Text('LIVING ROOM')
          .fontSize(11)
          .fontColor(TextGray)
          .letterSpacing(2)
          .fontWeight(FontWeight.Bold)
        Text('Connected')
          .fontSize(12)
          .fontColor(AccentBlue)
      }
      .alignItems(HorizontalAlign.Center)

      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(TextBlack)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
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
  @State animatedProgress: number = (21.5 - 16) / (30 - 16);

  adjustTemp(delta: number) {
    let newTemp = this.targetTemp + delta;
    newTemp = Math.min(30, Math.max(16, newTemp));
    newTemp = Math.round(newTemp * 10) / 10;
    this.targetTemp = newTemp;
    this.animatedProgress = (newTemp - 16) / (30 - 16);
  }

  build() {
    Column({ space: 0 }) {
      Stack({ alignContent: Alignment.Center }) {
        // Background arc track
        Circle()
          .width(240)
          .height(240)
          .fill(Color.Transparent)
          .stroke(SoftGrayBg)
          .strokeWidth(20)

        // Animated Arc
        TemperatureArc({
          progress: this.animatedProgress,
          isActive: this.isActive
        })

        // Center Text
        Column() {
          Text(`${this.targetTemp}°`)
            .fontSize(45)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? TextBlack : TextGray)
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(14)
            .fontColor(TextGray)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)

      Blank().height(32)

      Row({ space: 32 }) {
        RoundControlButton({
          iconType: 'down',
          onClick: () => { this.adjustTemp(-0.5); },
          enabled: this.isActive
        })

        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor(TextBlack)
          .switchPointColor(PureWhite)
          .onChange((isOn: boolean) => {
            this.isActive = isOn;
          })
          .width(51)
          .height(31)

        RoundControlButton({
          iconType: 'up',
          onClick: () => { this.adjustTemp(0.5); },
          enabled: this.isActive
        })
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct TemperatureArc {
  @Prop progress: number = 0;
  @Prop isActive: boolean = true;

  build() {
    Canvas(new RenderingContextSettings(true))
      .width(240)
      .height(240)
      .onReady((context: CanvasRenderingContext2D) => {
        this.drawArc(context);
      })
      .onAreaChange(() => {})
  }

  drawArc(context: CanvasRenderingContext2D) {
    const width = 240;
    const height = 240;
    const cx = width / 2;
    const cy = height / 2;
    const radius = (width / 2) - 20;
    const strokeWidth = 20;

    const startAngleDeg = 135;
    const sweepAngleDeg = 270 * this.progress;

    const startAngleRad = (startAngleDeg * Math.PI) / 180;
    const endAngleRad = ((startAngleDeg + sweepAngleDeg) * Math.PI) / 180;

    context.clearRect(0, 0, width, height);

    if (sweepAngleDeg > 0) {
      context.beginPath();
      context.arc(cx, cy, radius, startAngleRad, endAngleRad, false);
      context.strokeStyle = this.isActive ? AccentBlue : TextGray;
      context.lineWidth = strokeWidth;
      context.lineCap = 'round';
      context.stroke();
    }

    // Draw knob
    const knobAngleRad = endAngleRad;
    const knobX = cx + radius * Math.cos(knobAngleRad);
    const knobY = cy + radius * Math.sin(knobAngleRad);

    context.beginPath();
    context.arc(knobX, knobY, 16, 0, 2 * Math.PI);
    context.fillStyle = PureWhite;
    context.fill();

    context.beginPath();
    context.arc(knobX, knobY, 10, 0, 2 * Math.PI);
    context.fillStyle = this.isActive ? AccentBlue : TextGray;
    context.fill();
  }
}

@Component
struct RoundControlButton {
  iconType: string = 'up';
  onClick: () => void = () => {};
  enabled: boolean = true;

  build() {
    Button({ type: ButtonType.Circle }) {
      Text(this.iconType === 'up' ? '＋' : '－')
        .fontSize(24)
        .fontColor(this.enabled ? TextBlack : '#FFD1D1D6')
        .fontWeight(FontWeight.Light)
    }
    .width(56)
    .height(56)
    .backgroundColor(this.enabled ? SoftGrayBg : '#FFF9F9F9')
    .border({
      width: 1,
      color: this.enabled ? Color.Transparent : '#FFEEEEEE',
      radius: 28
    })
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
    Column({ space: 0 }) {
      Text('QUICK ACTIONS')
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(TextGray)
        .width('100%')
        .margin({ bottom: 16 })

      Row({ space: 16 }) {
        QuickActionCard({
          iconSymbol: '↻',
          label: 'Fan Speed',
          status: 'Auto',
          isActive: false
        })
        QuickActionCard({
          iconSymbol: '♥',
          label: 'Eco Mode',
          status: 'On',
          isActive: true
        })
      }
      .width('100%')

      Blank().height(16)

      Row({ space: 16 }) {
        QuickActionCard({
          iconSymbol: '⏱',
          label: 'Timer',
          status: 'Set 2h',
          isActive: false
        })
        QuickActionCard({
          iconSymbol: '⌂',
          label: 'Away',
          status: 'Off',
          isActive: false
        })
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct QuickActionCard {
  iconSymbol: string = '';
  label: string = '';
  status: string = '';
  isActive: boolean = false;

  build() {
    Column() {
      Text(this.iconSymbol)
        .fontSize(22)
        .fontColor(this.isActive ? PureWhite : TextBlack)
        .width(24)
        .height(24)
        .textAlign(TextAlign.Center)

      Blank()

      Column({ space: 2 }) {
        Text(this.label)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isActive ? PureWhite : TextBlack)
        Text(this.status)
          .fontSize(11)
          .fontColor(TextGray)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .height(100)
    .padding(16)
    .backgroundColor(this.isActive ? TextBlack : SoftGrayBg)
    .borderRadius(20)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}