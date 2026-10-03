@Entry
@Component
struct RootScreen {
  private stations: string[] = ["A", "B", "C", "D", "E", "F"]

  // Colors
  private colorPrimary: string = '#FF00FFFF'
  private colorSecondary: string = '#FF00B4FF'
  private colorBackground: string = '#FF0A0A1A'
  private colorSurface: string = '#FF141436'
  private colorSurfaceVariant: string = '#FF1E1E4A'
  private colorOnSurface: string = '#FFFFFFFF'
  private colorSuccess: string = '#FF00FFAA'
  private colorOnPrimary: string = '#FF0A0A1A'

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main content
      Column() {
        // Background gradient
        Column() {
          // Title
          Text('Metro Planner')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.colorPrimary)
            .margin({ bottom: 16 })

          // Metro Map Canvas
          Stack() {
            Canvas(this.context)
              .width('100%')
              .height(260)
              .onReady(() => {
                this.drawMetroMap()
              })
          }
          .width('100%')
          .height(260)
          .backgroundColor(this.colorSurfaceVariant)
          .borderRadius(22)
          .margin({ bottom: 16 })

          // Next Departures Card
          Column() {
            Text('Next Departures')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colorSecondary)
              .margin({ bottom: 6 })

            Row() {
              Text('08:45 • Line 1')
                .fontSize(14)
                .fontColor(this.colorOnSurface)
              Text('On Time')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorSuccess)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ bottom: 6 })

            Row() {
              Text('09:10 • Line 2')
                .fontSize(14)
                .fontColor(this.colorOnSurface)
              Text('On Time')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorSuccess)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ bottom: 6 })

            Row() {
              Text('09:30 • Line 3')
                .fontSize(14)
                .fontColor(this.colorOnSurface)
              Text('On Time')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colorSuccess)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(this.colorSurface)
          .borderRadius(22)
          .shadow({ radius: 8, offsetY: 4, color: '#26000000' })
        }
        .width('100%')
        .padding(16)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [0xFF0A0A1A, 0.0],
            [0xFF1E1E4A, 0.5],
            [0xFF0A0A1A, 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)

      // Bottom Bar + FAB overlay
      Stack({ alignContent: Alignment.BottomEnd }) {
        // Bottom App Bar
        Row() {
          Text('Routes')
            .fontSize(14)
            .fontColor(this.colorSecondary)
          Text('Planner')
            .fontSize(14)
            .fontColor(this.colorOnSurface)
          Text('Tickets')
            .fontSize(14)
            .fontColor(this.colorOnSurface)
          Text('Profile')
            .fontSize(14)
            .fontColor(this.colorOnSurface)
        }
        .width('100%')
        .height(60)
        .backgroundColor(this.colorSurface)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 16, right: 16 })

        // FAB
        Button('+')
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(this.colorPrimary)
          .fontColor(this.colorOnPrimary)
          .fontSize(24)
          .margin({ right: 16, bottom: 70 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorBackground)
  }

  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  )

  private drawMetroMap(): void {
    const ctx = this.context
    const width = ctx.width
    const height = ctx.height
    const stationCount = this.stations.length
    const step = width / (stationCount - 1)

    // Draw path
    const gradient = ctx.createLinearGradient(0, 0, width, 0)
    gradient.addColorStop(0, '#FF00B4FF')
    gradient.addColorStop(1, '#FF00FFFF')

    ctx.beginPath()
    ctx.strokeStyle = gradient
    ctx.lineWidth = 6

    for (let i = 0; i < stationCount; i++) {
      const x = i * step
      const y = i % 2 === 0 ? height / 4 : height * 3 / 4
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
    }
    ctx.stroke()

    // Draw station circles
    for (let i = 0; i < stationCount; i++) {
      const x = i * step
      const y = i % 2 === 0 ? height / 4 : height * 3 / 4

      ctx.beginPath()
      ctx.fillStyle = '#FF00FFFF'
      ctx.arc(x, y, 16, 0, Math.PI * 2)
      ctx.fill()

      ctx.beginPath()
      ctx.fillStyle = '#FF0A0A1A'
      ctx.arc(x, y, 6, 0, Math.PI * 2)
      ctx.fill()

      // Station labels
      ctx.fillStyle = '#FFFFFFFF'
      ctx.font = '12px sans-serif'
      ctx.textAlign = 'center'
      ctx.fillText(this.stations[i], x, y + (i % 2 === 0 ? -24 : 32))
    }
  }
}