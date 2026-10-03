// Index.ets
import curves from '@ohos.curves';

// --- Colors ---
const PureWhite: string = '#FFFFFF';
const OffWhite: string = '#FAFAFA';
const TextPrimary: string = '#1A1A1A';
const TextSecondary: string = '#757575';
const AccentGreen: string = '#4CAF50';
const AccentWarning: string = '#FF9800';
const DividerColor: string = '#EEEEEE';

// --- Main Entry ---
@Entry
@Component
struct AeroSenseApp {
  build() {
    Column() {
      // Top Header
      TopHeader()

      // Main Content
      Scroll() {
        Column() {
          // 1. Main Air Quality Indicator
          AirQualityCircle({ aqi: 42 })

          // 2. Metrics Grid
          Row({ space: 16 }) {
            MetricCard({ label: "Temp", value: "23°C", icon: $r('sys.media.ohos_ic_public_info'), statusColor: TextPrimary })
            MetricCard({ label: "Humidity", value: "45%", icon: $r('sys.media.ohos_ic_public_ok'), statusColor: AccentGreen })
          }
          .width('100%')
          .margin({ top: 32 })

          Row({ space: 16 }) {
            MetricCard({ label: "PM 2.5", value: "12", icon: $r('sys.media.ohos_ic_public_ok'), statusColor: AccentGreen })
            MetricCard({ label: "CO2", value: "850", icon: $r('sys.media.ohos_ic_public_warn'), statusColor: AccentWarning })
          }
          .width('100%')
          .margin({ top: 16 })

          // 3. Status Message
          StatusBanner()
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 32 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Control Bar
      BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PureWhite)
  }
}

// --- Top Header ---
@Component
struct TopHeader {
  build() {
    Row() {
      Column() {
        Text("Living Room")
          .fontSize(14)
          .fontColor(TextSecondary)
          .margin({ bottom: 4 })
        Text("AeroSense")
          .fontSize(24)
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Circle }) {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(TextPrimary)
      }
      .width(48)
      .height(48)
      .backgroundColor(OffWhite)
      .onClick(() => {})
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// --- Air Quality Circle ---
@Component
struct AirQualityCircle {
  private aqi: number = 42;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Custom Drawing for the Indicator Ring
      AirQualityCanvas()

      Column() {
        Text("AQI")
          .fontSize(12)
          .fontColor(TextSecondary)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .margin({ bottom: 4 })
        
        Text(`${this.aqi}`)
          .fontSize(80)
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })

        Text("Excellent")
          .fontSize(14)
          .fontColor(AccentGreen)
          .backgroundColor('#E8F5E9') // AccentGreen with 0.1 alpha approximation
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .borderRadius(16)
      }
    }
    .width('100%')
    .aspectRatio(1.2)
  }
}

@Component
struct AirQualityCanvas {
  build() {
    // Using Stack of arcs to replicate Compose Canvas
    Stack() {
      // Background Track
      Arc()
        .width(220)
        .height(220)
        .startAngle(135)
        .totalAngle(270)
        .fillColor(Color.Transparent)
        .strokeWidth(40)
        .strokeColor(OffWhite)
        .strokeCap(LineCapStyle.Round)

      // Progress Track (110 degrees out of 270)
      Arc()
        .width(220)
        .height(220)
        .startAngle(135)
        .totalAngle(110)
        .fillColor(Color.Transparent)
        .strokeWidth(40)
        .strokeColor(AccentGreen)
        .strokeCap(LineCapStyle.Round)
    }
    .width(220)
    .height(220)
  }
}

// --- Metric Card ---
@Component
struct MetricCard {
  @Prop label: string;
  @Prop value: string;
  @Prop icon: Resource;
  @Prop statusColor: string;

  build() {
    Column() {
      Row() {
        Image(this.icon)
          .width(20)
          .height(20)
          .fillColor(this.statusColor)
      }
      .width('100%')
      .justifyContent(FlexAlign.End)

      Column() {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextPrimary)
          .margin({ bottom: 4 })
        Text(this.label)
          .fontSize(12)
          .fontColor(TextSecondary)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .height(110)
    .padding(16)
    .backgroundColor(OffWhite)
    .borderRadius(24)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// --- Status Banner ---
@Component
struct StatusBanner {
  build() {
    Column() {
      Row() {
        Image($r('sys.media.ohos_ic_public_home'))
          .width(24)
          .height(24)
          .fillColor(TextPrimary)
          .margin({ right: 12 })
        Text("Room Analysis")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextPrimary)
      }
      .alignItems(VerticalAlign.Center)

      Text("Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.")
        .fontSize(14)
        .fontColor(TextSecondary)
        .lineHeight(22)
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(20)
    .borderRadius(20)
    .border({ width: 1, color: DividerColor })
    .alignItems(HorizontalAlign.Start)
  }
}

// --- Bottom Control Bar ---
@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider()
        .color(DividerColor)
        .strokeWidth(1)

      Row() {
        ControlIcon({ icon: $r('sys.media.ohos_ic_public_menu'), desc: "Menu" })

        Button("Refresh Data") {
          Row() {
            Image($r('sys.media.ohos_ic_public_refresh'))
              .width(18)
              .height(18)
              .fillColor(PureWhite)
              .margin({ right: 8 })
            Text("Refresh Data")
              .fontColor(PureWhite)
              .fontSize(16)
          }
        }
        .type(ButtonType.Capsule)
        .backgroundColor(TextPrimary)
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })

        ControlIcon({ icon: $r('sys.media.ohos_ic_public_add'), desc: "Add Room" })
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

// --- Control Icon ---
@Component
struct ControlIcon {
  private icon: Resource;
  private desc: string;

  build() {
    Button({ type: ButtonType.Circle }) {
      Image(this.icon)
        .width(24)
        .height(24)
        .fillColor(TextPrimary)
    }
    .width(48)
    .height(48)
    .backgroundColor(Color.Transparent)
    .border({ width: 1, color: DividerColor })
    .onClick(() => {})
  }
}