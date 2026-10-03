// pages/Index.ets
const PureWhite: string = '#FFFFFF';
const TextBlack: string = '#1C1C1E';
const TextGray: string = '#8E8E93';
const AccentBlue: string = '#007AFF';
const SoftGrayBg: string = '#F2F2F7';
const DisabledBg: string = '#F9F9F9';
const DisabledIcon: string = '#D1D1D6';
const DisabledBorder: string = '#EEEEEE';
const Clear: string = '#00000000';

const DIAL_SIZE: number = 240;
const DIAL_STROKE: number = 20;
const DIAL_RADIUS: number = 110;
const MIN_TEMP: number = 16;
const MAX_TEMP: number = 30;

@Entry
@Component
struct ClimateController {
  @State targetTemp: number = 21.5;
  @State @Watch('onActiveChange') isActive: boolean = true;
  @State @Watch('onProgressChange') progress: number = (21.5 - MIN_TEMP) / (MAX_TEMP - MIN_TEMP);

  private isCanvasReady: boolean = false;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  onProgressChange(): void {
    this.drawDial();
  }

  onActiveChange(): void {
    this.drawDial();
  }

  adjustTemp(delta: number): void {
    const clamped: number = Math.min(MAX_TEMP, Math.max(MIN_TEMP, this.targetTemp + delta));
    const rounded: number = Math.round(clamped * 10) / 10;
    this.targetTemp = rounded;
    animateTo({ duration: 500, curve: Curve.EaseInOut }, () => {
      this.progress = (rounded - MIN_TEMP) / (MAX_TEMP - MIN_TEMP);
    });
  }

  drawDial(): void {
    if (!this.isCanvasReady) {
      return;
    }
    const ctx: CanvasRenderingContext2D = this.ctx;
    const cx: number = DIAL_SIZE / 2;
    const cy: number = DIAL_SIZE / 2;

    ctx.clearRect(0, 0, DIAL_SIZE, DIAL_SIZE);

    // Background track
    ctx.beginPath();
    ctx.lineWidth = DIAL_STROKE;
    ctx.lineCap = 'round';
    ctx.strokeStyle = SoftGrayBg;
    ctx.arc(cx, cy, DIAL_RADIUS, 0, Math.PI * 2);
    ctx.stroke();

    // Animated arc: 135° start, 270° sweep
    const startAngle: number = 135 * Math.PI / 180;
    const sweepAngle: number = 270 * Math.PI / 180 * this.progress;
    const endAngle: number = startAngle + sweepAngle;
    const activeColor: string = this.isActive ? AccentBlue : TextGray;

    ctx.beginPath();
    ctx.lineWidth = DIAL_STROKE;
    ctx.lineCap = 'round';
    ctx.strokeStyle = activeColor;
    ctx.arc(cx, cy, DIAL_RADIUS, startAngle, endAngle);
    ctx.stroke();

    // Knob at the arc tip
    const knobX: number = cx + DIAL_RADIUS * Math.cos(endAngle);
    const knobY: number = cy + DIAL_RADIUS * Math.sin(endAngle);

    ctx.beginPath();
    ctx.fillStyle = PureWhite;
    ctx.arc(knobX, knobY, 8, 0, Math.PI * 2);
    ctx.fill();

    ctx.beginPath();
    ctx.fillStyle = activeColor;
    ctx.arc(knobX, knobY, 5, 0, Math.PI * 2);
    ctx.fill();
  }

  @Builder
  SpacerV(height: number) {
    Row() {
    }
    .width('100%')
    .height(height)
  }

  @Builder
  HeaderSection() {
    Row() {
      Text('☰')
        .fontSize(26)
        .fontColor(TextBlack)
        .width(44)
        .height(44)
        .textAlign(TextAlign.Center)
        .onClick(() => {
        })

      Column() {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextGray)
          .letterSpacing(2)
        Text('Connected')
          .fontSize(13)
          .fontColor(AccentBlue)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Text('⚙')
        .fontSize(24)
        .fontColor(TextBlack)
        .width(44)
        .height(44)
        .textAlign(TextAlign.Center)
        .onClick(() => {
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  RoundControlButton(glyph: string, delta: number) {
    Stack() {
      Text(glyph)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isActive ? TextBlack : DisabledIcon)
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor(this.isActive ? SoftGrayBg : DisabledBg)
    .border({ width: 1, color: this.isActive ? Clear : DisabledBorder })
    .onClick(() => {
      if (this.isActive) {
        this.adjustTemp(delta);
      }
    })
  }

  @Builder
  DialSection() {
    Column() {
      Stack() {
        Canvas(this.ctx)
          .width(DIAL_SIZE)
          .height(DIAL_SIZE)
          .onReady(() => {
            this.isCanvasReady = true;
            this.drawDial();
          })

        Column() {
          Text(this.targetTemp.toFixed(1) + '°')
            .fontSize(56)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? TextBlack : TextGray)
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(TextGray)
            .letterSpacing(1)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)

      this.SpacerV(32)

      Row({ space: 32 }) {
        this.RoundControlButton('⌄', -0.5)

        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor(TextBlack)
          .switchPointColor(PureWhite)
          .width(52)
          .height(32)
          .onChange((isOn: boolean) => {
            this.isActive = isOn;
          })

        this.RoundControlButton('⌃', 0.5)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  QuickActionCard(glyph: string, label: string, status: string, active: boolean) {
    Column() {
      Text(glyph)
        .fontSize(22)
        .fontColor(active ? PureWhite : TextBlack)

      Column() {
        Text(label)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(active ? PureWhite : TextBlack)
        Text(status)
          .fontSize(12)
          .fontColor(TextGray)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .height(100)
    .padding(16)
    .borderRadius(20)
    .backgroundColor(active ? TextBlack : SoftGrayBg)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ControlGridSection() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(TextGray)
        .letterSpacing(1)
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 16 })

      Row({ space: 16 }) {
        this.QuickActionCard('↻', 'Fan Speed', 'Auto', false)
        this.QuickActionCard('♥', 'Eco Mode', 'On', true)
      }
      .width('100%')

      this.SpacerV(16)

      Row({ space: 16 }) {
        this.QuickActionCard('ⓘ', 'Timer', 'Set 2h', false)
        this.QuickActionCard('⌂', 'Away', 'Off', false)
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      this.HeaderSection()

      Scroll() {
        Column() {
          this.SpacerV(32)
          this.DialSection()
          this.SpacerV(40)
          this.ControlGridSection()
          this.SpacerV(8)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .align(Alignment.Top)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PureWhite)
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
  }
}