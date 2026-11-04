class MetricData {
  label: string
  value: string
  icon: string
  color: string

  constructor(label: string, value: string, icon: string, color: string) {
    this.label = label
    this.value = value
    this.icon = icon
    this.color = color
  }
}

@Entry
@Component
struct Index {
  private metrics: MetricData[] = [
    new MetricData('Temp', '23°C', 'i', '#1A1A1A'),
    new MetricData('Humidity', '45%', '✓', '#4CAF50'),
    new MetricData('PM 2.5', '12', '●', '#4CAF50'),
    new MetricData('CO2', '850', '!', '#FF9800')
  ]

  build() {
    Column() {
      this.TopHeader()
      Scroll() {
        Column() {
          this.AirQualityCircle(42)
          Grid() {
            ForEach(this.metrics, (metric: MetricData) => {
              GridItem() {
                this.MetricCard(metric)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(16)
          .columnsGap(16)
          .width('100%')
          .height(236)
          .margin({ top: 32 })
          this.StatusBanner()
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 32 })
      }
      .layoutWeight(1)
      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  TopHeader() {
    Row() {
      Column() {
        Text('Living Room')
          .fontSize(18)
          .fontColor('#757575')
        Text('AeroSense')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('⚙')
        .fontSize(24)
        .fontColor('#1A1A1A')
        .backgroundColor('#FAFAFA')
        .borderRadius(24)
        .width(48)
        .height(48)
        .padding(0)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  AirQualityCircle(aqi: number) {
    Stack() {
      Circle()
        .width(220)
        .height(220)
        .fill(Color.Transparent)
        .stroke('#FAFAFA')
        .strokeWidth(40)
      Circle()
        .width(172)
        .height(172)
        .fill(Color.Transparent)
        .stroke('#4CAF50')
        .strokeWidth(24)
      Column() {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
        Text(aqi.toString())
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1A1A1A')
        Text('Excellent')
          .fontSize(18)
          .fontColor('#4CAF50')
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .borderRadius(16)
          .backgroundColor('rgba(76,175,80,0.1)')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(316)
  }

  @Builder
  MetricCard(metric: MetricData) {
    Column() {
      Row() {
        Text(metric.icon)
          .fontSize(20)
          .fontColor(metric.color)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      Column() {
        Text(metric.value)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
        Text(metric.label)
          .fontSize(13)
          .fontColor('#757575')
          .margin({ top: 2 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .height(110)
    .width('100%')
    .padding(16)
    .borderRadius(24)
    .backgroundColor('#FAFAFA')
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  StatusBanner() {
    Column() {
      Row() {
        Text('⌂')
          .fontSize(24)
          .fontColor('#1A1A1A')
        Text('Room Analysis')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
          .margin({ left: 12 })
      }
      .alignItems(VerticalAlign.Center)
      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor('#757575')
        .lineHeight(22)
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(20)
    .border({ width: 1, color: '#EEEEEE', radius: 20 })
    .alignItems(HorizontalAlign.Start)
    .margin({ top: 32 })
  }

  @Builder
  BottomControlBar() {
    Column() {
      Divider().color('#EEEEEE')
      Row() {
        this.ControlIcon('☰')
        Button() {
          Row() {
            Text('↻')
              .fontSize(18)
              .fontColor(Color.White)
            Text('Refresh Data')
              .fontSize(14)
              .fontColor(Color.White)
              .margin({ left: 8 })
          }
          .alignItems(VerticalAlign.Center)
        }
        .borderRadius(16)
        .backgroundColor('#1A1A1A')
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        this.ControlIcon('+')
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  ControlIcon(icon: string) {
    Button(icon)
      .fontSize(22)
      .fontColor('#1A1A1A')
      .width(48)
      .height(48)
      .border({ width: 1, color: '#EEEEEE', radius: 24 })
      .backgroundColor(Color.Transparent)
      .padding(0)
  }
}
