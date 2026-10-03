@Entry
@Component
struct AeroSensePage {
  @State refreshed: boolean = false
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Column({ space: 0 }) {
            Text('Living Room')
              .fontSize(16)
              .fontColor('#757575')
            Text('AeroSense')
              .fontSize(34)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1A1A1A')
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Button() {
            Text('⚙')
              .fontSize(26)
              .fontColor('#1A1A1A')
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor('#FAFAFA')
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24, bottom: 12 })

        Scroll() {
          Column({ space: 32 }) {
            this.AqiGauge()
            Column({ space: 16 }) {
              Row({ space: 16 }) {
                this.MetricCard('23°C', 'Temp', '●', '#1A1A1A')
                this.MetricCard('45%', 'Humidity', '✓', '#4CAF50')
              }.width('100%')
              Row({ space: 16 }) {
                this.MetricCard('12', 'PM 2.5', '✓', '#4CAF50')
                this.MetricCard('850', 'CO2', '!', '#FF9800')
              }.width('100%')
            }.width('100%')

            Column({ space: 12 }) {
              Row({ space: 12 }) {
                Text('⌂').fontSize(24).fontColor('#1A1A1A')
                Text('Room Analysis').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#1A1A1A')
              }.width('100%')
              Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
                .fontSize(14)
                .fontColor('#757575')
                .lineHeight(22)
                .width('100%')
            }
            .padding(20)
            .width('100%')
            .border({ width: 1, color: '#EEEEEE', radius: 20 })
          }
          .padding({ top: 16, bottom: 120 })
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      Column() {
        Divider().color('#EEEEEE').strokeWidth(1)
        Row({ space: 8 }) {
          this.RoundControl('☰')
          Button() {
            Row({ space: 10 }) {
              Text('↻').fontSize(26).fontColor(Color.White)
              Text(this.refreshed ? 'Data Updated' : 'Refresh Data')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.White)
            }
            .justifyContent(FlexAlign.Center)
          }
          .layoutWeight(1)
          .height(56)
          .borderRadius(16)
          .backgroundColor('#1A1A1A')
          .onClick(() => { this.refreshed = true })
          this.RoundControl('+')
        }
        .padding({ left: 24, right: 24, top: 24, bottom: 36 })
        .width('100%')
        .backgroundColor(Color.White)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  AqiGauge() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.canvasContext)
        .width(260)
        .height(260)
        .onReady(() => {
          this.drawGauge()
        })
      Column({ space: 0 }) {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
          .letterSpacing(2)
        Text('42')
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1A1A1A')
        Text('Excellent')
          .fontSize(16)
          .fontColor('#4CAF50')
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#EAF5EB')
          .borderRadius(16)
      }
    }
    .width('100%')
    .height(300)
  }

  private drawGauge() {
    let ctx = this.canvasContext
    let centerX = 130
    let centerY = 130
    let radius = 90
    let lineWidth = 40

    ctx.clearRect(0, 0, 260, 260)
    ctx.lineWidth = lineWidth
    ctx.lineCap = 'round'

    ctx.beginPath()
    ctx.arc(centerX, centerY, radius, 135 * Math.PI / 180, 405 * Math.PI / 180)
    ctx.strokeStyle = '#FAFAFA'
    ctx.stroke()

    ctx.beginPath()
    ctx.arc(centerX, centerY, radius, 135 * Math.PI / 180, 245 * Math.PI / 180)
    ctx.strokeStyle = '#4CAF50'
    ctx.stroke()

    let dotAngle = 245 * Math.PI / 180
    let dotX = centerX + radius * Math.cos(dotAngle)
    let dotY = centerY + radius * Math.sin(dotAngle)
    ctx.beginPath()
    ctx.arc(dotX, dotY, 6, 0, 2 * Math.PI)
    ctx.fillStyle = '#FFFFFF'
    ctx.fill()
  }

  @Builder
  MetricCard(value: string, label: string, icon: string, color: string) {
    Column() {
      Row() {
        Text(icon)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(color)
        Blank()
      }
      .width('100%')
      Blank()
      Column({ space: 4 }) {
        Text(value).fontSize(24).fontWeight(FontWeight.Bold).fontColor('#1A1A1A')
        Text(label).fontSize(12).fontColor('#757575')
      }.alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .height(110)
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
  }

  @Builder
  RoundControl(label: string) {
    Button() {
      Text(label).fontSize(26).fontColor('#1A1A1A')
    }
    .width(52)
    .height(52)
    .borderRadius(26)
    .backgroundColor(Color.White)
    .border({ width: 1, color: '#EEEEEE', radius: 26 })
  }
}
