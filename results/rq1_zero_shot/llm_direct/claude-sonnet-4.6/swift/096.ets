import { display } from '@kit.ArkUI';

// MARK: - 1. Colors
const pureWhite: string = '#FFFFFFFF';
const offWhite: string = '#FFFAFAFA';
const textPrimary: string = '#FF1A1A1A';
const textSecondary: string = '#FF757575';
const accentGreen: string = '#FF4CAF50';
const accentWarning: string = '#FFFF9800';
const dividerColor: string = '#FFEEEEEE';

// MARK: - 2. Main Entry
@Entry
@Component
struct AeroSenseContentView {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        TopHeader()
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })
        MainContent()
          .padding({ left: 24, right: 24, bottom: 16 })
          .layoutWeight(1)
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

// MARK: - 3. Top Header
@Component
struct TopHeader {
  build() {
    Row() {
      Column() {
        Text('Living Room')
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor(textSecondary)
        Text('AeroSense')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(textPrimary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button({ type: ButtonType.Normal }) {
        Image($r('sys.symbol.gearshape_fill'))
          .width(24)
          .height(24)
          .fillColor(textPrimary)
      }
      .width(48)
      .height(48)
      .backgroundColor(offWhite)
      .borderRadius(24)
      .padding(0)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - 4. Main Content
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
    .height('100%')
  }
}

// MARK: - 5. Air Quality Circle
@Component
struct AirQualityCircle {
  aqi: number = 42;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Canvas for drawing arcs
      Canvas(new CanvasRenderingContext2D(new RenderingContextSettings(true)))
        .width(220)
        .height(220)
        .onReady((context: CanvasRenderingContext2D) => {
          this.drawCircle(context);
        })

      Column() {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(textSecondary)
          .letterSpacing(2)
        Text(`${this.aqi}`)
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(textPrimary)
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
    .aspectRatio(1.2)
  }

  drawCircle(context: CanvasRenderingContext2D): void {
    const lineWidth = 40;
    const size = 220;
    const radius = (size - lineWidth) / 2;
    const centerX = size / 2;
    const centerY = size / 2;

    const toRad = (deg: number): number => (deg * Math.PI) / 180;

    // Background track
    context.beginPath();
    context.arc(centerX, centerY, radius, toRad(135), toRad(135 + 270), false);
    context.strokeStyle = offWhite;
    context.lineWidth = lineWidth;
    context.lineCap = 'round';
    context.stroke();

    // Progress track
    context.beginPath();
    context.arc(centerX, centerY, radius, toRad(135), toRad(135 + 110), false);
    context.strokeStyle = accentGreen;
    context.lineWidth = lineWidth;
    context.lineCap = 'round';
    context.stroke();

    // Decorative dot at end of progress
    const dotRadius = 12;
    const angleRad = toRad(135 + 110);
    const dotX = centerX + radius * Math.cos(angleRad);
    const dotY = centerY + radius * Math.sin(angleRad);
    context.beginPath();
    context.arc(dotX, dotY, dotRadius / 2, 0, Math.PI * 2, false);
    context.fillStyle = pureWhite;
    context.fill();
  }
}

// MARK: - 6. Metric Card
@Component
struct MetricCard {
  label: string = '';
  value: string = '';
  iconName: Resource = $r('sys.symbol.info_circle_fill');
  statusColor: string = textPrimary;

  build() {
    Column() {
      Row() {
        Image(this.iconName)
          .width(20)
          .height(20)
          .fillColor(this.statusColor)
        Blank()
      }
      .width('100%')

      Blank()

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

// MARK: - 7. Status Banner
@Component
struct StatusBanner {
  build() {
    Column() {
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

      Blank()
        .height(12)

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
  }
}

// MARK: - 8. Bottom Control Bar
@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider()
        .color(dividerColor)
        .strokeWidth(1)

      Row() {
        ControlIcon({ iconName: $r('sys.symbol.line_3_horizontal'), description: 'Menu' })

        Blank()

        Button({ type: ButtonType.Normal }) {
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
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        }
        .backgroundColor(textPrimary)
        .borderRadius(16)
        .padding(0)

        Blank()

        ControlIcon({ iconName: $r('sys.symbol.plus'), description: 'Add Room' })
      }
      .padding(24)
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(pureWhite)
    }
    .width('100%')
    .backgroundColor(pureWhite)
  }
}

// MARK: - 9. Control Icon
@Component
struct ControlIcon {
  iconName: Resource = $r('sys.symbol.line_3_horizontal');
  description: string = '';

  build() {
    Button({ type: ButtonType.Normal }) {
      Image(this.iconName)
        .width(24)
        .height(24)
        .fillColor(textPrimary)
    }
    .width(48)
    .height(48)
    .backgroundColor(Color.Transparent)
    .border({ width: 1, color: dividerColor, radius: 24 })
    .padding(0)
  }
}