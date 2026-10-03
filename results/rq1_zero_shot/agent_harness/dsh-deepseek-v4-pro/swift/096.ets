// Translated from 096.swift (AeroSense App)

@Entry
@Component
struct Index {
  build() {
    AeroSenseContentView()
  }
}

@Component
struct AeroSenseContentView {
  build() {
    Stack() {
      Column() {
        TopHeader()
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        MainContent()
          .padding({ left: 24, right: 24, bottom: 16 })
          .layoutWeight(1)
      }
      .backgroundColor('#FFFFFF')

      Column() {
        Blank()
        BottomControlBar()
      }
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
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor('#757575')
        Text('AeroSense')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor('#1A1A1A')
          .width(48)
          .height(48)
          .textAlign(TextAlign.Center)
          .backgroundColor('#FAFAFA')
          .borderRadius(24)
      }
      .onClick(() => {})
    }
    .width('100%')
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
            MetricCard({ label: 'Temp', value: '23°C', iconName: 'ⓘ', statusColor: '#1A1A1A' })
              .layoutWeight(1)
            MetricCard({ label: 'Humidity', value: '45%', iconName: '✅', statusColor: '#4CAF50' })
              .layoutWeight(1)
          }
          Row({ space: 16 }) {
            MetricCard({ label: 'PM 2.5', value: '12', iconName: '✅', statusColor: '#4CAF50' })
              .layoutWeight(1)
            MetricCard({ label: 'CO2', value: '850', iconName: '⚠', statusColor: '#FF9800' })
              .layoutWeight(1)
          }
        }

        StatusBanner()
      }
      .padding({ top: 16, bottom: 16 })
    }
    .scrollBar(BarState.Off)
  }
}

@Component
struct AirQualityCircle {
  @Prop aqi: number = 0
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Stack() {
      Canvas(this.context)
        .width(220)
        .height(220)
        .onReady(() => {
          const lineWidth = 40
          const radius = (220 - lineWidth) / 2
          const center = 110

          this.context.strokeStyle = '#FAFAFA'
          this.context.lineWidth = lineWidth
          this.context.lineCap = 'round'
          this.context.beginPath()
          this.context.arc(center, center, radius, (135 * Math.PI) / 180, ((135 + 270) * Math.PI) / 180, false)
          this.context.stroke()

          this.context.strokeStyle = '#4CAF50'
          this.context.beginPath()
          this.context.arc(center, center, radius, (135 * Math.PI) / 180, ((135 + 110) * Math.PI) / 180, false)
          this.context.stroke()

          const dotRadius = 12
          const angleForDot = (135 + 110) * Math.PI / 180
          const xOffset = radius * Math.cos(angleForDot)
          const yOffset = radius * Math.sin(angleForDot)
          const dotX = center + xOffset
          const dotY = center + yOffset

          this.context.fillStyle = '#FFFFFF'
          this.context.beginPath()
          this.context.arc(dotX, dotY, dotRadius / 2, 0, Math.PI * 2)
          this.context.fill()
        })

      Column() {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
          .letterSpacing(2)
        Text(this.aqi.toString())
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1A1A1A')
        Text('Excellent')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#4CAF50')
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#1A4CAF50')
          .borderRadius(16)
      }
    }
    .width('100%')
    .aspectRatio(1.2)
  }
}

@Component
struct MetricCard {
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop iconName: string = ''
  @Prop statusColor: string = '#000000'

  build() {
    Column() {
      Row() {
        Text(this.iconName)
          .fontSize(20)
          .fontColor(this.statusColor)
        Blank()
      }
      Blank()
      Column({ space: 4 }) {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.Semibold)
          .fontColor('#1A1A1A')
        Text(this.label)
          .fontSize(12)
          .fontColor('#757575')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(110)
    .backgroundColor('#FAFAFA')
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
          .fontColor('#1A1A1A')
        Blank().width(12)
        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
      }
      Blank().height(12)
      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor('#757575')
        .lineHeight(22)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(20)
    .width('100%')
    .border({ width: 1, color: '#EEEEEE', radius: 20 })
  }
}

@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider().color('#EEEEEE')
      Row() {
        ControlIcon({ iconName: '☰', description: 'Menu' })

        Button() {
          Row({ space: 8 }) {
            Text('↻')
              .fontSize(18)
              .fontColor('#FFFFFF')
            Text('Refresh Data')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })
          .backgroundColor('#1A1A1A')
          .borderRadius(16)
        }
        .onClick(() => {})

        ControlIcon({ iconName: '+', description: 'Add Room' })
      }
      .padding(24)
      .width('100%')
      .backgroundColor('#FFFFFF')
    }
  }
}

@Component
struct ControlIcon {
  @Prop iconName: string = ''
  @Prop description: string = ''

  build() {
    Button() {
      Text(this.iconName)
        .fontSize(24)
        .fontColor('#1A1A1A')
        .width(48)
        .height(48)
        .textAlign(TextAlign.Center)
    }
    .backgroundColor('#00000000')
    .border({ width: 1, color: '#EEEEEE', radius: 24 })
    .onClick(() => {})
  }
}
