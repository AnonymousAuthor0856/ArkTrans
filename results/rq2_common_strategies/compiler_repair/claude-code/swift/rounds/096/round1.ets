// Colors
const PureWhite: ResourceColor = '#FFFFFF';
const OffWhite: ResourceColor = '#FAFAFA';
const TextPrimary: ResourceColor = '#1A1A1A';
const TextSecondary: ResourceColor = '#757575';
const AccentGreen: ResourceColor = '#4CAF50';
const AccentWarning: ResourceColor = '#FF9800';
const DividerColor: ResourceColor = '#EEEEEE';
const AccentGreenBg: ResourceColor = 'rgba(76, 175, 80, 0.1)';

@Entry
@Component
struct AeroSenseApp {
  build() {
    Column() {
      AeroSenseContentView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PureWhite)
  }
}

@Component
struct AeroSenseContentView {
  build() {
    Stack() {
      Column() {
        TopHeader()
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        Scroll() {
          Column() {
            MainContent()
              .padding({ left: 24, right: 24, bottom: 16 })
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')

        BottomControlBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(PureWhite)
    }
    .width('100%')
    .height('100%')
  }
}

// Top Header
@Component
struct TopHeader {
  build() {
    Row() {
      Column() {
        Text('Living Room')
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(TextSecondary)
        Text('AeroSense')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextPrimary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(TextPrimary)
      }
      .width(48)
      .height(48)
      .backgroundColor(OffWhite)
      .borderRadius(24)
      .onClick(() => {})
    }
    .width('100%')
  }
}

// Main Content
@Component
struct MainContent {
  build() {
    Column() {
      AirQualityCircle({ aqi: 42 })

      Column() {
        Row() {
          MetricCard({
            label: 'Temp',
            value: '23°C',
            iconType: IconType.Info,
            statusColor: TextPrimary
          })
          .layoutWeight(1)
          MetricCard({
            label: 'Humidity',
            value: '45%',
            iconType: IconType.Check,
            statusColor: AccentGreen
          })
          .layoutWeight(1)
        }
        .width('100%')

        Row() {
          MetricCard({
            label: 'PM 2.5',
            value: '12',
            iconType: IconType.Check,
            statusColor: AccentGreen
          })
          .layoutWeight(1)
          MetricCard({
            label: 'CO2',
            value: '850',
            iconType: IconType.Warning,
            statusColor: AccentWarning
          })
          .layoutWeight(1)
        }
        .width('100%')
        .margin({ top: 16 })
      }
      .width('100%')
      .margin({ top: 32 })

      StatusBanner()
        .width('100%')
        .margin({ top: 32 })
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
  }
}

enum IconType {
  Info,
  Check,
  Warning,
  Menu,
  Add,
  Settings,
  Home,
  Refresh
}

// Air Quality Circle
@Component
struct AirQualityCircle {
  @State aqi: number = 42;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear(): void {
    this.drawAirQualityArc();
  }

  drawAirQualityArc(): void {
    const size: number = 220;
    const lineWidth: number = 40;
    const radius: number = (size - lineWidth) / 2;
    const cx: number = size / 2;
    const cy: number = size / 2;

    // SwiftUI: start at 135 degrees (ccw from right), sweep 270 degrees ccw
    // Canvas: 0 at right, positive = clockwise
    // SwiftUI 135 deg ccw = canvas 225 deg clockwise from right = 5*PI/4
    // SwiftUI 405 deg (135+270) ccw = 45 deg ccw from right = canvas 315 deg clockwise = 7*PI/4
    // counterclockwise=true in canvas means arc goes counter-clockwise (decreasing clockwise angle)
    const startAngle: number = (5 * Math.PI) / 4; // 225 deg clockwise
    const endAngle: number = (7 * Math.PI) / 4; // 315 deg clockwise
    const counterClockwise: boolean = true;

    // Background track
    this.ctx.lineWidth = lineWidth;
    this.ctx.lineCap = 'round';
    this.ctx.strokeStyle = '#FAFAFA';
    this.ctx.beginPath();
    this.ctx.arc(cx, cy, radius, startAngle, endAngle, counterClockwise);
    this.ctx.stroke();

    // Progress track: ~42% of 270 degrees = ~113.4 degrees
    const progressFraction: number = 42 / 100;
    const progressDeg: number = 270 * progressFraction;
    const progressRad: number = (progressDeg * Math.PI) / 180;
    // Progress end angle in canvas clockwise: start at 225, sweep progressDeg counter-clockwise
    const progressEnd: number = startAngle - progressRad;

    this.ctx.strokeStyle = '#4CAF50';
    this.ctx.beginPath();
    this.ctx.arc(cx, cy, radius, startAngle, progressEnd, counterClockwise);
    this.ctx.stroke();

    // Decorative dot at end of progress
    const dotRadius: number = 6;
    const dotX: number = cx + radius * Math.cos(progressEnd);
    const dotY: number = cy + radius * Math.sin(progressEnd);
    this.ctx.fillStyle = '#FFFFFF';
    this.ctx.beginPath();
    this.ctx.arc(dotX, dotY, dotRadius, 0, 2 * Math.PI);
    this.ctx.fill();
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.ctx)
        .width(220)
        .height(220)

      Column() {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextSecondary)
          .letterSpacing(2)
        Text(this.aqi.toString())
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(TextPrimary)
        Text('Excellent')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AccentGreen)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor(AccentGreenBg)
          .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .aspectRatio(1.2)
  }
}

// Metric Card
@Component
struct MetricCard {
  label: string = '';
  value: string = '';
  iconType: IconType = IconType.Info;
  statusColor: ResourceColor = Color.Black;

  build() {
    Column() {
      Row() {
        Image(this.getIconResource(this.iconType))
          .width(20)
          .height(20)
          .fillColor(this.statusColor)
        Blank()
      }
      .width('100%')

      Blank()

      Column() {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(TextPrimary)
        Text(this.label)
          .fontSize(12)
          .fontColor(TextSecondary)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 4 })
    }
    .width('100%')
    .height(110)
    .padding(16)
    .backgroundColor(OffWhite)
    .borderRadius(24)
  }

  getIconResource(type: IconType): Resource {
    switch (type) {
      case IconType.Info:
        return $r('sys.media.ohos_ic_public_info');
      case IconType.Check:
        return $r('sys.media.ohos_ic_public_selected');
      case IconType.Warning:
        return $r('sys.media.ohos_ic_public_alert');
      default:
        return $r('sys.media.ohos_ic_public_info');
    }
  }
}

// Status Banner
@Component
struct StatusBanner {
  build() {
    Column() {
      Row() {
        Image($r('sys.media.ohos_ic_public_home'))
          .width(24)
          .height(24)
          .fillColor(TextPrimary)
        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextPrimary)
          .margin({ left: 12 })
      }
      .width('100%')

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(TextSecondary)
        .lineHeight(22)
        .width('100%')
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(20)
    .border({ width: 1, color: DividerColor, radius: 20 })
  }
}

// Bottom Control Bar
@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider()
        .color(DividerColor)
        .strokeWidth(1)

      Row() {
        ControlIcon({ iconType: IconType.Menu })

        Blank()

        Button() {
          Row() {
            Image($r('sys.media.ohos_ic_public_refresh'))
              .width(18)
              .height(18)
              .fillColor(PureWhite)
            Text('Refresh Data')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(PureWhite)
              .margin({ left: 8 })
          }
        }
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .backgroundColor(TextPrimary)
        .borderRadius(16)
        .onClick(() => {})

        Blank()

        ControlIcon({ iconType: IconType.Add })
      }
      .width('100%')
      .padding(24)
      .backgroundColor(PureWhite)
    }
    .width('100%')
  }
}

// Control Icon
@Component
struct ControlIcon {
  iconType: IconType = IconType.Menu;

  build() {
    Button() {
      Image(this.getIconResource(this.iconType))
        .width(24)
        .height(24)
        .fillColor(TextPrimary)
    }
    .width(48)
    .height(48)
    .backgroundColor(Color.Transparent)
    .border({ width: 1, color: DividerColor, radius: 24 })
    .onClick(() => {})
  }

  getIconResource(type: IconType): Resource {
    switch (type) {
      case IconType.Menu:
        return $r('sys.media.ohos_ic_public_menu');
      case IconType.Add:
        return $r('sys.media.ohos_ic_public_add');
      default:
        return $r('sys.media.ohos_ic_public_menu');
    }
  }
}
