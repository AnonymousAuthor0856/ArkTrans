@Entry
@Component
struct AeroSense {
  private readonly ink: string = '#1A1A1A'
  private readonly muted: string = '#757575'
  private readonly green: string = '#4CAF50'
  private readonly paper: string = '#FFFFFF'
  private readonly pale: string = '#FAFAFA'
  private readonly line: string = '#EEEEEE'
  private ringContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawRing() {
    const ctx = this.ringContext
    const cx = 120
    const cy = 120
    const radius = 100
    ctx.clearRect(0, 0, 240, 240)
    ctx.lineWidth = 20
    ctx.lineCap = 'round'
    ctx.beginPath()
    ctx.arc(cx, cy, radius, Math.PI * 0.75, Math.PI * 2.25, false)
    ctx.strokeStyle = this.pale
    ctx.stroke()
    ctx.beginPath()
    ctx.arc(cx, cy, radius, Math.PI * 0.75, Math.PI * 0.75 + Math.PI * 0.61, false)
    ctx.strokeStyle = this.green
    ctx.stroke()
  }

  @Builder
  private metric(value: string, label: string, icon: string, color: string) {
    Column() {
      Row() {
        Text(icon)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(color)
      }
      .width('100%')
      .height(24)
      .alignItems(VerticalAlign.Center)

      Column({ space: 2 }) {
        Text(value)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.ink)
        Text(label)
          .fontSize(12)
          .fontColor(this.muted)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 14 })
    }
    .layoutWeight(1)
    .height(110)
    .padding(16)
    .backgroundColor(this.pale)
    .borderRadius(24)
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      Row() {
        Column() {
          Text('Living Room')
            .fontSize(16)
            .fontColor(this.muted)
          Text('AeroSense')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.ink)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Text('⚙')
          .fontSize(25)
          .fontColor(this.ink)
          .width(48)
          .height(48)
          .textAlign(TextAlign.Center)
          .backgroundColor(this.pale)
          .borderRadius(24)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Canvas(this.ringContext)
              .width(240)
              .height(240)
              .onReady(() => this.drawRing())
            Column() {
              Text('AQI')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.muted)
                .letterSpacing(2)
              Text('42')
                .fontSize(80)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.ink)
                .margin({ top: 6, bottom: 4 })
              Text('Excellent')
                .fontSize(16)
                .fontColor(this.green)
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                .backgroundColor('#EAF5EB')
                .borderRadius(16)
            }
            .alignItems(HorizontalAlign.Center)
          }
          .width(260)
          .height(260)
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Row({ space: 16 }) {
          this.metric('23°C', 'Temp', '●', this.ink)
          this.metric('45%', 'Humidity', '✓', this.green)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 14 })
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Divider().height(1).color(this.line)
        Row() {
          Text('☰')
            .fontSize(22)
            .fontColor(this.ink)
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .border({ width: 1, color: this.line })
            .borderRadius(24)

          Button() {
            Row({ space: 8 }) {
              Text('⟳').fontSize(22).fontColor(this.paper)
              Text('Refresh Data').fontSize(16).fontColor(this.paper)
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
          }
          .layoutWeight(1)
          .height(52)
          .margin({ left: 20, right: 20 })
          .backgroundColor(this.ink)
          .borderRadius(16)

          Text('+')
            .fontSize(30)
            .fontColor(this.ink)
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .border({ width: 1, color: this.line })
            .borderRadius(24)
        }
        .width('100%')
        .padding(24)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor(this.paper)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.paper)
  }
}
