const Colors = {
  primary: '#00FFFF',
  secondary: '#00B4FF',
  tertiary: '#8A2BE2',
  background: '#0A0A1A',
  surface: '#141436',
  surfaceVariant: '#1E1E4A',
  outline: '#2E2E5C',
  success: '#00FFAA',
  warning: '#FFCC00',
  error: '#FF4444',
  onPrimary: '#0A0A1A',
  onSecondary: '#FFFFFF',
  onBackground: '#FFFFFF',
  onSurface: '#FFFFFF'
}

@Entry
@Component
struct Index {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F']

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column({ space: 16 }) {
          Text('Metro Planner')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.primary)

          Canvas(this.context)
            .width('100%')
            .height(260)
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(22)
            .onReady(() => {
              this.drawMetro()
            })

          Column({ space: 6 }) {
            Text('Next Departures')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.secondary)
            ForEach(['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3'], (item: string) => {
              Row() {
                Text(item)
                  .fontSize(14)
                  .fontColor(Colors.onSurface)
                Text('On Time')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.success)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }, (item: string) => item)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Colors.surface)
          .borderRadius(22)
          .shadow({ radius: 8, color: '#00000026', offsetX: 0, offsetY: 4 })

          Blank().height(10)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#0A0A1A', 0.0], ['#1E1E4A', 0.5], ['#0A0A1A', 1.0]]
        })

        Row() {
          Text('Routes').fontSize(14).fontColor(Colors.secondary)
          Text('Planner').fontSize(14).fontColor(Colors.onSurface)
          Text('Tickets').fontSize(14).fontColor(Colors.onSurface)
          Text('Profile').fontSize(14).fontColor(Colors.onSurface)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(Colors.surface)
      }
      .width('100%')
      .height('100%')

      Button('+', { type: ButtonType.Normal })
        .width(56)
        .height(56)
        .borderRadius(28)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .backgroundColor(Colors.primary)
        .fontColor(Colors.onPrimary)
        .margin({ right: 16, bottom: 72 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }

  private drawMetro(): void {
    const ctx = this.context
    ctx.clearRect(0, 0, ctx.width, ctx.height)
    const step = ctx.width / (this.stations.length - 1)
    ctx.beginPath()
    this.stations.forEach((s: string, i: number) => {
      const x = i * step
      const y = (i % 2 === 0) ? ctx.height / 4 : ctx.height * 3 / 4
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
    })
    const grad = ctx.createLinearGradient(0, 0, ctx.width, 0)
    grad.addColorStop(0, Colors.secondary)
    grad.addColorStop(1, Colors.primary)
    ctx.strokeStyle = grad
    ctx.lineWidth = 6
    ctx.stroke()
    this.stations.forEach((s: string, i: number) => {
      const x = i * step
      const y = (i % 2 === 0) ? ctx.height / 4 : ctx.height * 3 / 4
      ctx.fillStyle = Colors.primary
      ctx.beginPath()
      ctx.arc(x, y, 16, 0, 2 * Math.PI)
      ctx.fill()
      ctx.fillStyle = Colors.background
      ctx.beginPath()
      ctx.arc(x, y, 6, 0, 2 * Math.PI)
      ctx.fill()
    })
  }
}
