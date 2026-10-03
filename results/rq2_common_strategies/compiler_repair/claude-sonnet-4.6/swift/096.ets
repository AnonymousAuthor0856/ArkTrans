// Color constants
const pureWhite = '#FFFFFFFF';
const offWhite = '#FFFAFAFA';
const textPrimary = '#FF1A1A1A';
const textSecondary = '#FF757575';
const accentGreen = '#FF4CAF50';
const accentWarning = '#FFFF9800';
const dividerColor = '#FFEEEEEE';

// ControlIcon Component
@Component
struct ControlIcon {
  iconName: Resource = $r('sys.symbol.list_bullet');
  description: string = '';

  build() {
    Button() {
      Image(this.iconName)
        .width(24)
        .height(24)
        .fillColor(textPrimary)
    }
    .width(48)
    .height(48)
    .backgroundColor(Color.Transparent)
    .border({ width: 1, color: dividerColor, radius: 24 })
  }
}

// BottomControlBar Component
@Component
struct BottomControlBar {
  build() {
    Column({ space: 0 }) {
      Divider()
        .color(dividerColor)
        .strokeWidth(1)

      Row() {
        ControlIcon({
          iconName: $r('sys.symbol.list_bullet'),
          description: 'Menu'
        })

        Button() {
          Row({ space: 8 }) {
            Image($r('sys.symbol.arrow_clockwise'))
              .width(18)
              .height(18)
              .fillColor(pureWhite)
            Text('Refresh Data')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(pureWhite)
          }
          .alignItems(VerticalAlign.Center)
        }
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .backgroundColor(textPrimary)
        .borderRadius(16)
        .layoutWeight(1)
        .margin({ left: 16, right: 16 })

        ControlIcon({
          iconName: $r('sys.symbol.plus'),
          description: 'Add Room'
        })
      }
      .padding(24)
      .width('100%')
      .backgroundColor(pureWhite)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(pureWhite)
  }
}

// StatusBanner Component
@Component
struct StatusBanner {
  build() {
    Column({ space: 0 }) {
      Row() {
        Image($r('sys.symbol.house_fill'))
          .width(24)
          .height(24)
          .fillColor(textPrimary)
        Blank()
          .width(12)
        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(textPrimary)
        Blank()
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank().height(12)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(textSecondary)
        .lineHeight(22)
        .width('100%')
    }
    .padding(20)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .border({ width: 1, color: dividerColor, radius: 20 })
    .backgroundColor(pureWhite)
  }
}

// MetricCard Component
@Component
struct MetricCard {
  label: string = '';
  value: string = '';
  iconName: Resource = $r('sys.symbol.info_circle_fill');
  statusColor: string = textPrimary;

  build() {
    Column({ space: 0 }) {
      Row() {
        Image(this.iconName)
          .width(20)
          .height(20)
          .fillColor(this.statusColor)
        Blank()
      }
      .width('100%')

      Blank().layoutWeight(1)

      Column({ space: 4 }) {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(textPrimary)
        Text(this.label)
          .fontSize(12)
          .fontColor(textSecondary)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(16)
    .height(110)
    .layoutWeight(1)
    .backgroundColor(offWhite)
    .borderRadius(24)
    .alignItems(HorizontalAlign.Start)
  }
}

// AirQualityCircle Component
@Component
struct AirQualityCircle {
  aqi: number = 42;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width(220)
        .height(220)
        .onReady(() => {
          const lineWidth = 40;
          const size = 220;
          const radius = (size - lineWidth) / 2;
          const centerX = size / 2;
          const centerY = size / 2;

          // Background track
          this.context.beginPath();
          this.context.arc(centerX, centerY, radius, (135 * Math.PI) / 180, ((135 + 270) * Math.PI) / 180, false);
          this.context.strokeStyle = offWhite;
          this.context.lineWidth = lineWidth;
          this.context.lineCap = 'round';
          this.context.stroke();

          // Progress track
          this.context.beginPath();
          this.context.arc(centerX, centerY, radius, (135 * Math.PI) / 180, ((135 + 110) * Math.PI) / 180, false);
          this.context.strokeStyle = accentGreen;
          this.context.lineWidth = lineWidth;
          this.context.lineCap = 'round';
          this.context.stroke();

          // Decorative dot at end of progress
          const dotRadius = 12;
          const angleRad = ((135 + 110) * Math.PI) / 180;
          const dotX = centerX + radius * Math.cos(angleRad);
          const dotY = centerY + radius * Math.sin(angleRad);
          this.context.beginPath();
          this.context.arc(dotX, dotY, dotRadius / 2, 0, 2 * Math.PI, false);
          this.context.fillStyle = pureWhite;
          this.context.fill();
        })

      // Center text
      Column({ space: 0 }) {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(textSecondary)
          .letterSpacing(2)
        Text(`${this.aqi}`)
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(textPrimary)
          .lineHeight(88)
        Text('Excellent')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(accentGreen)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#1A4CAF50')
          .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(220)
  }
}

// TopHeader Component
@Component
struct TopHeader {
  build() {
    Row() {
      Column({ space: 0 }) {
        Text('Living Room')
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(textSecondary)
        Text('AeroSense')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(textPrimary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Image($r('sys.symbol.gearshape_fill'))
          .width(24)
          .height(24)
          .fillColor(textPrimary)
      }
      .width(48)
      .height(48)
      .backgroundColor(offWhite)
      .borderRadius(24)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

// MainContent Component
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
              iconName: $r('sys.symbol.info_circle_fill'),
              statusColor: textPrimary
            })
            MetricCard({
              label: 'Humidity',
              value: '45%',
              iconName: $r('sys.symbol.checkmark_circle_fill'),
              statusColor: accentGreen
            })
          }
          .width('100%')

          Row({ space: 16 }) {
            MetricCard({
              label: 'PM 2.5',
              value: '12',
              iconName: $r('sys.symbol.checkmark_circle_fill'),
              statusColor: accentGreen
            })
            MetricCard({
              label: 'CO2',
              value: '850',
              iconName: $r('sys.symbol.exclamationmark_triangle_fill'),
              statusColor: accentWarning
            })
          }
          .width('100%')
        }
        .width('100%')

        StatusBanner()
      }
      .padding({ top: 16, bottom: 16 })
      .width('100%')
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .layoutWeight(1)
  }
}

// Main Content View
@Component
struct AeroSenseContentView {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        TopHeader()
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        MainContent()
          .padding({ left: 24, right: 24, bottom: 16 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(pureWhite)

      BottomControlBar()
        .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(pureWhite)
  }
}

// Entry Point
@Entry
@Component
struct Index {
  build() {
    Column() {
      AeroSenseContentView()
        .width('100%')
        .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}