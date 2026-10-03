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
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      Column() {
        Text('Living Room')
          .fontSize(14)
          .fontColor('#757575')
          .fontWeight(FontWeight.Normal)
        Text('AeroSense')
          .fontSize(28)
          .fontColor('#1A1A1A')
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor('#1A1A1A')
      }
      .width(48)
      .height(48)
      .backgroundColor('#FAFAFA')
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct AirQualityCircle {
  private aqi: number = 42

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Progress({ value: 42, total: 100, type: ProgressType.Ring })
        .width(220)
        .height(220)
        .style({ strokeWidth: 20, scaleCount: 100, scaleWidth: 5 })
        .color('#4CAF50')
        .backgroundColor('#FAFAFA')

      Column() {
        Text('AQI')
          .fontSize(14)
          .fontColor('#757575')
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
        Text(`${this.aqi}`)
          .fontSize(80)
          .fontColor('#1A1A1A')
          .fontWeight(FontWeight.Medium)
        Text('Excellent')
          .fontSize(16)
          .fontColor('#4CAF50')
          .backgroundColor('#4CAF501A')
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
  label: string = ''
  value: string = ''
  iconSymbol: string = '✓'
  statusColor: string = '#1A1A1A'

  build() {
    Column() {
      Row() {
        Text(this.iconSymbol)
          .fontSize(20)
          .fontColor(this.statusColor)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1A1A1A')
        Text(this.label)
          .fontSize(12)
          .fontColor('#757575')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(110)
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StatusBanner {
  build() {
    Column() {
      Row() {
        Text('🏠')
          .fontSize(24)
        Text('Room Analysis')
          .fontSize(16)
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
  }
}

@Component
struct MainContent {
  build() {
    Scroll() {
      Column({ space: 32 }) {
        AirQualityCircle()

        Column({ space: 16 }) {
          Row({ space: 16 }) {
            MetricCard({
              label: 'Temp',
              value: '23°C',
              iconSymbol: 'ℹ',
              statusColor: '#1A1A1A'
            })
              .layoutWeight(1)

            MetricCard({
              label: 'Humidity',
              value: '45%',
              iconSymbol: '✓',
              statusColor: '#4CAF50'
            })
              .layoutWeight(1)
          }
          .width('100%')

          Row({ space: 16 }) {
            MetricCard({
              label: 'PM 2.5',
              value: '12',
              iconSymbol: '✔',
              statusColor: '#4CAF50'
            })
              .layoutWeight(1)

            MetricCard({
              label: 'CO2',
              value: '850',
              iconSymbol: '⚠',
              statusColor: '#FF9800'
            })
              .layoutWeight(1)
          }
          .width('100%')
        }

        StatusBanner()
      }
      .padding({ left: 24, right: 24, top: 16, bottom: 16 })
    }
    .layoutWeight(1)
    .scrollBar(BarState.Off)
  }
}

@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider()
        .color('#EEEEEE')
        .strokeWidth(1)

      Row() {
        Button({ type: ButtonType.Circle }) {
          Text('☰')
            .fontSize(20)
            .fontColor('#1A1A1A')
        }
        .width(48)
        .height(48)
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#EEEEEE', radius: 24 })

        Button() {
          Row({ space: 8 }) {
            Text('↻')
              .fontSize(18)
              .fontColor('#FFFFFF')
            Text('Refresh Data')
              .fontSize(14)
              .fontColor('#FFFFFF')
          }
        }
        .backgroundColor('#1A1A1A')
        .borderRadius(16)
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })

        Button({ type: ButtonType.Circle }) {
          Text('+')
            .fontSize(20)
            .fontColor('#1A1A1A')
        }
        .width(48)
        .height(48)
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#EEEEEE', radius: 24 })
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
  }
}