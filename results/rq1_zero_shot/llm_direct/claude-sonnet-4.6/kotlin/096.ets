import { LengthMetrics } from '@kit.ArkUI';

// --- Theme & Colors ---
const PureWhite = '#FFFFFFFF';
const OffWhite = '#FFFAFAFA';
const TextPrimary = '#FF1A1A1A';
const TextSecondary = '#FF757575';
const AccentGreen = '#FF4CAF50';
const AccentWarning = '#FFFF9800';
const DividerColor = '#FFEEEEEE';

@Entry
@Component
struct AeroSenseApp {
  build() {
    Column() {
      TopHeader()
      MainContent()
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
          .fontWeight(FontWeight.Normal)
        Text('AeroSense')
          .fontSize(28)
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.ic_settings'))
          .width(24)
          .height(24)
          .fillColor(TextPrimary)
      }
      .width(48)
      .height(48)
      .backgroundColor(OffWhite)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MainContent {
  build() {
    Scroll() {
      Column({ space: 32 }) {
        AirQualityCircle({ aqi: 42 })

        Column({ space: 16 }) {
          Row({ space: 16 }) {
            MetricCard({
              label: 'Temp',
              value: '23°C',
              iconResource: $r('app.media.ic_info'),
              statusColor: TextPrimary
            })
            MetricCard({
              label: 'Humidity',
              value: '45%',
              iconResource: $r('app.media.ic_check'),
              statusColor: AccentGreen
            })
          }
          .width('100%')

          Row({ space: 16 }) {
            MetricCard({
              label: 'PM 2.5',
              value: '12',
              iconResource: $r('app.media.ic_check_circle'),
              statusColor: AccentGreen
            })
            MetricCard({
              label: 'CO2',
              value: '850',
              iconResource: $r('app.media.ic_warning'),
              statusColor: AccentWarning
            })
          }
          .width('100%')
        }

        StatusBanner()
      }
      .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      .width('100%')
    }
    .layoutWeight(1)
    .scrollBar(BarState.Off)
  }
}

@Component
struct AirQualityCircle {
  aqi: number = 42;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Arc Ring drawn via Canvas
      Canvas(new RenderingContextSettings(true))
        .width(220)
        .height(220)
        .onReady((context: CanvasRenderingContext2D) => {
          const cx = 110;
          const cy = 110;
          const radius = 90;
          const strokeWidth = 20;

          // Background Track
          context.beginPath();
          context.arc(cx, cy, radius, (135 * Math.PI) / 180, (405 * Math.PI) / 180);
          context.strokeStyle = OffWhite;
          context.lineWidth = strokeWidth;
          context.lineCap = 'round';
          context.stroke();

          // Progress Track
          context.beginPath();
          context.arc(cx, cy, radius, (135 * Math.PI) / 180, (245 * Math.PI) / 180);
          context.strokeStyle = AccentGreen;
          context.lineWidth = strokeWidth;
          context.lineCap = 'round';
          context.stroke();

          // Decor dot
          context.beginPath();
          context.arc(cx + 60, cy + 60, 8, 0, 2 * Math.PI);
          context.fillStyle = PureWhite;
          context.fill();
        })

      Column() {
        Text('AQI')
          .fontSize(14)
          .fontColor(TextSecondary)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)

        Text(`${this.aqi}`)
          .fontSize(80)
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Medium)

        Text('Excellent')
          .fontSize(16)
          .fontColor(AccentGreen)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#1A4CAF50')
          .borderRadius(16)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(280)
  }
}

@Component
struct MetricCard {
  label: string = '';
  value: string = '';
  iconResource: Resource = $r('app.media.ic_info');
  statusColor: string = TextPrimary;

  build() {
    Column() {
      Row() {
        Image(this.iconResource)
          .width(20)
          .height(20)
          .fillColor(this.statusColor)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(TextPrimary)

        Text(this.label)
          .fontSize(12)
          .fontColor(TextSecondary)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .height(110)
    .backgroundColor(OffWhite)
    .borderRadius(24)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StatusBanner {
  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Image($r('app.media.ic_home'))
          .width(24)
          .height(24)
          .fillColor(TextPrimary)

        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextPrimary)
      }
      .alignItems(VerticalAlign.Center)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(TextSecondary)
        .lineHeight(22)
    }
    .width('100%')
    .border({ width: 1, color: DividerColor, radius: 20 })
    .padding(20)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider()
        .color(DividerColor)
        .strokeWidth(1)

      Row() {
        ControlIcon({ iconResource: $r('app.media.ic_menu'), desc: 'Menu' })

        Button() {
          Row({ space: 8 }) {
            Image($r('app.media.ic_refresh'))
              .width(18)
              .height(18)
              .fillColor(PureWhite)

            Text('Refresh Data')
              .fontSize(14)
              .fontColor(PureWhite)
          }
        }
        .backgroundColor(TextPrimary)
        .borderRadius(16)
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .type(ButtonType.Normal)

        ControlIcon({ iconResource: $r('app.media.ic_add'), desc: 'Add Room' })
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(PureWhite)
  }
}

@Component
struct ControlIcon {
  iconResource: Resource = $r('app.media.ic_menu');
  desc: string = '';

  build() {
    Button({ type: ButtonType.Circle }) {
      Image(this.iconResource)
        .width(24)
        .height(24)
        .fillColor(TextPrimary)
    }
    .width(48)
    .height(48)
    .backgroundColor(PureWhite)
    .border({ width: 1, color: DividerColor, radius: 24 })
  }
}