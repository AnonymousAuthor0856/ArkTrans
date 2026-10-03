class AppTokens {
  static readonly Colors = {
    primary: '#FFFF7B00',
    secondary: '#FFFFD166',
    background: '#FFFFF6E5',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFFFF0C1',
    outline: '#FFE0C080',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF3E2723',
    onBackground: '#FF3E2723',
    onSurface: '#FF3E2723',
    onSurface40: '#663E2723'
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  }
}

class ResultItem {
  id: number
  title: string

  constructor(id: number, title: string) {
    this.id = id
    this.title = title
  }
}

@Component
struct ResultCard {
  @Prop title: string

  build() {
    Column() {
      Row()
        .width(96)
        .height(96)
        .borderRadius(10)
        .backgroundColor(AppTokens.Colors.surfaceVariant)

      Text(this.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: 8 })

      Text('Add')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')
        .padding({ top: 10, bottom: 10 })
        .borderRadius(10)
        .backgroundColor(AppTokens.Colors.primary)
        .margin({ top: 8 })
    }
    .padding(16)
    .borderRadius(14)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
  }
}

@Entry
@Component
struct RetroFilterSearch {
  @State query: string = ''
  @State knobX: number = 144
  @State knobY: number = 104

  private filters: string[] = ['Popular', 'New', 'Discount', 'Premium']
  private results: ResultItem[] = [
    new ResultItem(0, 'Result 1'),
    new ResultItem(1, 'Result 2'),
    new ResultItem(2, 'Result 3'),
    new ResultItem(3, 'Result 4'),
    new ResultItem(4, 'Result 5'),
    new ResultItem(5, 'Result 6')
  ]

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawCanvas() {
    const ctx = this.canvasContext
    const w: number = 328
    const h: number = 148
    const centerX = w / 2
    const centerY = h / 2

    ctx.clearRect(0, 0, w, h)

    ctx.fillStyle = '#FFFFF0C1'
    ctx.fillRect(0, 0, w, h)

    const gradient = ctx.createRadialGradient(centerX, centerY, 0, centerX, centerY, 60)
    gradient.addColorStop(0, '#FFFFD166')
    gradient.addColorStop(1, '#FFFF7B00')
    ctx.beginPath()
    ctx.arc(centerX, centerY, 60, 0, Math.PI * 2)
    ctx.fillStyle = gradient
    ctx.fill()

    ctx.beginPath()
    ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2)
    ctx.fillStyle = '#FFFF7B00'
    ctx.fill()
  }

  build() {
    Scroll() {
      Column() {
        Text('Retro Filter Search')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')

        TextInput({ text: this.query, placeholder: 'Search products' })
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: 16, right: 16 })
          .height(56)
          .borderRadius(10)
          .backgroundColor(AppTokens.Colors.surface)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .placeholderColor(AppTokens.Colors.onSurface40)
          .onChange((value: string) => {
            this.query = value
          })
          .margin({ top: 12 })

        Row() {
          ForEach(this.filters, (filter: string) => {
            Text(filter)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
              .padding({ left: 12, right: 12, top: 12, bottom: 12 })
              .borderRadius(6)
              .backgroundColor(AppTokens.Colors.secondary)
              .margin({ left: filter === 'Popular' ? 0 : 8 })
          })
        }
        .width('100%')
        .margin({ top: 12 })

        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .padding(16)
            .onReady(() => {
              this.drawCanvas()
            })
            .gesture(
              PanGesture()
                .onActionUpdate((event: GestureEvent) => {
                  this.knobX = event.fingerList[0].localX
                  this.knobY = event.fingerList[0].localY
                  this.drawCanvas()
                })
            )
        }
        .width('100%')
        .height(180)
        .borderRadius(14)
        .backgroundColor(AppTokens.Colors.surface)
        .margin({ top: 12 })

        Row() {
          ResultCard({ title: this.results[0].title })
            .layoutWeight(1)
            .margin({ right: 8 })
          ResultCard({ title: this.results[1].title })
            .layoutWeight(1)
            .margin({ left: 8 })
        }
        .width('100%')
        .margin({ top: 16 })

        Row() {
          ResultCard({ title: this.results[2].title })
            .layoutWeight(1)
            .margin({ right: 8 })
          ResultCard({ title: this.results[3].title })
            .layoutWeight(1)
            .margin({ left: 8 })
        }
        .width('100%')
        .margin({ top: 16 })

        Row() {
          ResultCard({ title: this.results[4].title })
            .layoutWeight(1)
            .margin({ right: 8 })
          ResultCard({ title: this.results[5].title })
            .layoutWeight(1)
            .margin({ left: 8 })
        }
        .width('100%')
        .margin({ top: 16 })
      }
      .padding(16)
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}