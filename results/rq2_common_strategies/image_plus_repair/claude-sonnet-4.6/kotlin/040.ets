// Index.ets

// Color tokens
const COLOR_PRIMARY: string = '#FFFF7B00'
const COLOR_SECONDARY: string = '#FFFFD166'
const COLOR_BACKGROUND: string = '#FFFFF6E5'
const COLOR_SURFACE: string = '#FFFFFFFF'
const COLOR_SURFACE_VARIANT: string = '#FFFFF0C1'
const COLOR_OUTLINE: string = '#FFE0C080'
const COLOR_ON_PRIMARY: string = '#FFFFFFFF'
const COLOR_ON_SECONDARY: string = '#FF3E2723'
const COLOR_ON_BACKGROUND: string = '#FF3E2723'
const COLOR_ON_SURFACE: string = '#FF3E2723'

// Spacing
const SPACING_SM: number = 8
const SPACING_MD: number = 12
const SPACING_LG: number = 16

interface ResultItem {
  id: number
  title: string
}

@Entry
@Component
struct RootScreen {
  @State query: string = ''
  @State knobX: number = 160
  @State knobY: number = 120
  @State results: ResultItem[] = [
    { id: 0, title: 'Result 1' },
    { id: 1, title: 'Result 2' },
    { id: 2, title: 'Result 3' },
    { id: 3, title: 'Result 4' },
    { id: 4, title: 'Result 5' },
    { id: 5, title: 'Result 6' },
  ]

  private filterTags: string[] = ['Popular', 'New', 'Discount', 'Premium']

  build() {
    Scroll() {
      Column({ space: SPACING_MD }) {
        // Title
        Text('Retro Filter Search')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_BACKGROUND)
          .width('100%')

        // Search field
        TextInput({ placeholder: 'Search products', text: this.query })
          .placeholderColor('#663E2723')
          .placeholderFont({ size: 14 })
          .fontSize(14)
          .fontColor(COLOR_ON_SURFACE)
          .backgroundColor(COLOR_SURFACE)
          .borderRadius(10)
          .border({ width: 1, color: COLOR_OUTLINE })
          .padding({ left: 12, right: 12, top: 10, bottom: 10 })
          .width('100%')
          .onChange((val: string) => {
            this.query = val
          })

        // Filter buttons row
        Row({ space: SPACING_SM }) {
          ForEach(this.filterTags, (tag: string) => {
            Button(tag)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_ON_SECONDARY)
              .backgroundColor(COLOR_SECONDARY)
              .borderRadius(6)
              .height(36)
              .padding({ left: 12, right: 12 })
          })
        }
        .width('100%')

        // Canvas knob area
        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height(148)
            .borderRadius(14)
            .onReady(() => {
              this.drawCanvas()
            })
            .gesture(
              PanGesture()
                .onActionUpdate((event: GestureEvent) => {
                  this.knobX = event.offsetX
                  this.knobY = event.offsetY
                  this.drawCanvas()
                })
            )
        }
        .width('100%')
        .height(180)
        .backgroundColor(COLOR_SURFACE)
        .borderRadius(14)
        .padding(16)

        // Results grid
        Grid() {
          ForEach(this.results, (item: ResultItem) => {
            GridItem() {
              Column({ space: SPACING_SM }) {
                // Placeholder image box
                Row()
                  .width(96)
                  .height(96)
                  .backgroundColor(COLOR_SURFACE_VARIANT)
                  .borderRadius(10)

                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_ON_SURFACE)

                Button('Add')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_ON_PRIMARY)
                  .backgroundColor(COLOR_PRIMARY)
                  .borderRadius(10)
                  .width('100%')
                  .height(36)
              }
              .width('100%')
              .padding(SPACING_LG)
              .alignItems(HorizontalAlign.Center)
              .backgroundColor(COLOR_SURFACE)
              .borderRadius(14)
              .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(SPACING_LG)
        .rowsGap(SPACING_LG)
        .width('100%')
        .height(600)
        .padding({ bottom: 24 })
      }
      .padding(SPACING_LG)
      .width('100%')
    }
    .backgroundColor(COLOR_BACKGROUND)
    .width('100%')
    .height('100%')
  }

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  )

  private drawCanvas(): void {
    const ctx = this.canvasContext
    const w = ctx.width
    const h = ctx.height

    ctx.clearRect(0, 0, w, h)

    // Background fill
    ctx.fillStyle = COLOR_SURFACE_VARIANT
    ctx.fillRect(0, 0, w, h)

    // Radial gradient circle
    const cx = w / 2
    const cy = h / 2
    const grad = ctx.createRadialGradient(cx, cy, 0, cx, cy, 80)
    grad.addColorStop(0, COLOR_SECONDARY)
    grad.addColorStop(1, COLOR_PRIMARY)
    ctx.fillStyle = grad
    ctx.beginPath()
    ctx.arc(cx, cy, 80, 0, Math.PI * 2)
    ctx.fill()

    // Draggable knob
    ctx.fillStyle = COLOR_PRIMARY
    ctx.beginPath()
    ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2)
    ctx.fill()
  }
}