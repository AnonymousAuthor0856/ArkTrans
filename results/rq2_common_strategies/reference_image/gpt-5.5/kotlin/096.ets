const PureWhite: string = '#FFFFFFFF';
const OffWhite: string = '#FFFAFAFA';
const TextPrimary: string = '#FF1A1A1A';
const TextSecondary: string = '#FF757575';
const AccentGreen: string = '#FF4CAF50';
const AccentGreenSoft: string = '#1A4CAF50';
const AccentWarning: string = '#FFFF9800';
const DividerColor: string = '#FFEEEEEE';

@Entry
@Component
struct AeroSenseApp {
  build() {
    Column() {
      TopHeader()

      Scroll() {
        Column() {
          AirQualityCircle({ aqi: 42 })

          Blank().height(32)

          Column() {
            Row() {
              MetricCard({
                label: 'Temp',
                value: '23°C',
                icon: 'i',
                statusColor: TextPrimary
              })
                .layoutWeight(1)

              Blank().width(16)

              MetricCard({
                label: 'Humidity',
                value: '45%',
                icon: '✓',
                statusColor: AccentGreen
              })
                .layoutWeight(1)
            }
            .width('100%')

            Blank().height(16)

            Row() {
              MetricCard({
                label: 'PM 2.5',
                value: '12',
                icon: '✓',
                statusColor: AccentGreen
              })
                .layoutWeight(1)

              Blank().width(16)

              MetricCard({
                label: 'CO2',
                value: '850',
                icon: '⚠',
                statusColor: AccentWarning
              })
                .layoutWeight(1)
            }
            .width('100%')
          }
          .width('100%')

          Blank().height(32)

          StatusBanner()

          Blank().height(24)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 0, bottom: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PureWhite)
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      Column() {
        Text('Living Room')
          .fontSize(16)
          .fontColor(TextSecondary)
          .fontWeight(FontWeight.Regular)

        Text('AeroSense')
          .fontSize(32)
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Stack({ alignContent: Alignment.Center }) {
        Text('⚙')
          .fontSize(28)
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Bold)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(OffWhite)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 28, bottom: 42 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(PureWhite)
  }
}

@Component
struct AirQualityCircle {
  @Prop aqi: number = 42;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private radians(degrees: number): number {
    return degrees * Math.PI / 180;
  }

  private drawGauge(): void {
    const cx: number = 130;
    const cy: number = 130;
    const radius: number = 108;

    this.context.clearRect(0, 0, 260, 260);

    this.context.beginPath();
    this.context.lineWidth = 20;
    this.context.lineCap = 'round';
    this.context.strokeStyle = OffWhite;
    this.context.arc(cx, cy, radius, this.radians(135), this.radians(405), false);
    this.context.stroke();

    this.context.beginPath();
    this.context.lineWidth = 20;
    this.context.lineCap = 'round';
    this.context.strokeStyle = AccentGreen;
    this.context.arc(cx, cy, radius, this.radians(235), this.radians(135), true);
    this.context.stroke();

    this.context.beginPath();
    this.context.fillStyle = PureWhite;
    this.context.arc(205, 218, 10, 0, Math.PI * 2, false);
    this.context.fill();
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width(260)
        .height(260)
        .onReady(() => {
          this.drawGauge();
        })

      Column() {
        Text('A Q I')
          .fontSize(14)
          .fontColor(TextSecondary)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)

        Text(`${this.aqi}`)
          .fontSize(80)
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Medium)
          .lineHeight(92)
          .margin({ top: 18 })

        Text('Excellent')
          .fontSize(16)
          .fontColor(AccentGreen)
          .fontWeight(FontWeight.Bold)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor(AccentGreenSoft)
          .borderRadius(16)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(270)
  }
}

@Component
struct MetricCard {
  @Prop label: string = '';
  @Prop value: string = '';
  @Prop icon: string = '';
  @Prop statusColor: string = TextPrimary;

  @Builder
  IconView() {
    if (this.icon === 'i') {
      Stack({ alignContent: Alignment.Center }) {
        Text('i')
          .fontSize(14)
          .fontColor(PureWhite)
          .fontWeight(FontWeight.Bold)
      }
      .width(20)
      .height(20)
      .borderRadius(10)
      .backgroundColor(this.statusColor)
    } else {
      Text(this.icon)
        .fontSize(26)
        .fontColor(this.statusColor)
        .fontWeight(FontWeight.Bold)
        .height(28)
    }
  }

  build() {
    Column() {
      Row() {
        this.IconView()
        Blank()
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(this.value)
          .fontSize(24)
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Bold)

        Text(this.label)
          .fontSize(14)
          .fontColor(TextSecondary)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .height(110)
    .width('100%')
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(OffWhite)
    .borderRadius(24)
  }
}

@Component
struct StatusBanner {
  build() {
    Column() {
      Row() {
        Text('⌂')
          .fontSize(24)
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Bold)

        Text('Room Analysis')
          .fontSize(18)
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 12 })
      }
      .alignItems(VerticalAlign.Center)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(15)
        .fontColor(TextSecondary)
        .lineHeight(22)
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(20)
    .border({ width: 1, color: DividerColor, radius: 20 })
  }
}

@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider()
        .color(DividerColor)
        .strokeWidth(1)
        .width('100%')

      Row() {
        ControlIcon({ icon: '☰' })

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Row() {
            Text('⟳')
              .fontSize(22)
              .fontColor(PureWhite)
              .fontWeight(FontWeight.Bold)

            Text('Refresh Data')
              .fontSize(15)
              .fontColor(PureWhite)
              .fontWeight(FontWeight.Bold)
              .margin({ left: 10 })
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }
        .width(156)
        .height(52)
        .backgroundColor(TextPrimary)
        .borderRadius(16)

        ControlIcon({ icon: '+' })
      }
      .width('100%')
      .height(104)
      .padding({ left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(PureWhite)
    }
    .width('100%')
    .backgroundColor(PureWhite)
  }
}

@Component
struct ControlIcon {
  @Prop icon: string = '';

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text(this.icon)
        .fontSize(this.icon === '+' ? 32 : 28)
        .fontColor(TextPrimary)
        .fontWeight(FontWeight.Medium)
    }
    .width(48)
    .height(48)
    .borderRadius(24)
    .border({ width: 1, color: DividerColor })
    .backgroundColor(PureWhite)
  }
}