const COLOR_PRIMARY: string = '#00FFFF'
const COLOR_SECONDARY: string = '#00B4FF'
const COLOR_BACKGROUND: string = '#0A0A1A'
const COLOR_SURFACE: string = '#141436'
const COLOR_SURFACE_VARIANT: string = '#1E1E4A'
const COLOR_SUCCESS: string = '#00FFAA'
const COLOR_ON_PRIMARY: string = '#0A0A1A'
const COLOR_ON_SURFACE: string = '#FFFFFF'

const SPACING_SM: number = 6
const SPACING_MD: number = 10
const SPACING_LG: number = 16

const stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F']

interface DepartureItem {
  time: string
  status: string
}

@Entry
@Component
struct RootScreen {
  private departures: DepartureItem[] = [
    { time: '08:45 • Line 1', status: 'On Time' },
    { time: '09:10 • Line 2', status: 'On Time' },
    { time: '09:30 • Line 3', status: 'On Time' }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Column() {
          Text('Metro Planner')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_PRIMARY)
            .margin({ bottom: SPACING_LG })

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
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .borderRadius(22)
          .margin({ bottom: SPACING_LG })
          .clip(true)

          Column() {
            Text('Next Departures')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_SECONDARY)
              .margin({ bottom: SPACING_SM })

            ForEach(this.departures, (item: DepartureItem) => {
              Row() {
                Text(item.time)
                  .fontSize(14)
                  .fontColor(COLOR_ON_SURFACE)
                Blank()
                Text(item.status)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_SUCCESS)
              }
              .width('100%')
              .margin({ top: SPACING_SM })
            })
          }
          .width('100%')
          .padding(SPACING_LG)
          .backgroundColor(COLOR_SURFACE)
          .borderRadius(22)
          .margin({ bottom: SPACING_MD })
        }
        .width('100%')
        .padding(SPACING_LG)
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Row() {
          Text('Routes')
            .fontSize(14)
            .fontColor(COLOR_SECONDARY)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Text('Planner')
            .fontSize(14)
            .fontColor(COLOR_ON_SURFACE)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Text('Tickets')
            .fontSize(14)
            .fontColor(COLOR_ON_SURFACE)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Text('Profile')
            .fontSize(14)
            .fontColor(COLOR_ON_SURFACE)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(56)
        .backgroundColor(COLOR_SURFACE)
        .padding({ left: SPACING_LG, right: SPACING_LG })
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [0xFF0A0A1A, 0.0],
          [0xFF1E1E4A, 0.5],
          [0xFF0A0A1A, 1.0]
        ]
      })

      Button('+')
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(COLOR_PRIMARY)
        .fontColor(COLOR_ON_PRIMARY)
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .margin({ right: SPACING_LG, bottom: 72 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }

  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  )

  private drawMetroMap(): void {
    const ctx: CanvasRenderingContext2D = this.context
    const w: number = ctx.width
    const h: number = ctx.height
    const count: number = stations.length
    const step: number = w / (count - 1)

    ctx.clearRect(0, 0, w, h)

    const grad: CanvasGradient = ctx.createLinearGradient(0, 0, w, 0)
    grad.addColorStop(0, '#00B4FF')
    grad.addColorStop(1, '#00FFFF')
    ctx.strokeStyle = grad
    ctx.lineWidth = 6
    ctx.lineJoin = 'round'
    ctx.beginPath()
    for (let i: number = 0; i < count; i++) {
      const x: number = i * step
      const y: number = (i % 2 === 0) ? h / 4 : h * 3 / 4
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
    }
    ctx.stroke()

    for (let i: number = 0; i < count; i++) {
      const x: number = i * step
      const y: number = (i % 2 === 0) ? h / 4 : h * 3 / 4

      ctx.beginPath()
      ctx.arc(x, y, 16, 0, Math.PI * 2)
      ctx.fillStyle = '#00FFFF'
      ctx.fill()

      ctx.beginPath()
      ctx.arc(x, y, 6, 0, Math.PI * 2)
      ctx.fillStyle = '#0A0A1A'
      ctx.fill()
    }
  }
}