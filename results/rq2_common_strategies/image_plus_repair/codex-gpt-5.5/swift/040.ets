@Entry
@Component
struct RootPage {
  @State query: string = ''
  @State knobX: number = 144
  @State knobY: number = 104
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D()
  private filters: string[] = ['Popular', 'New', 'Discount', 'Premium']
  private results: string[] = ['Result 1', 'Result 2', 'Result 3', 'Result 4', 'Result 5', 'Result 6']

  build() {
    Scroll() {
      Column({ space: 12 }) {
        Text('Retro Filter Search')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')
          .width('100%')
          .textAlign(TextAlign.Start)

        TextInput({ text: this.query, placeholder: 'Search products' })
          .onChange((value: string) => { this.query = value })
          .fontSize(14)
          .fontColor('#3E2723')
          .padding({ left: 16, right: 16 })
          .height(56)
          .backgroundColor('#FFFFFF')
          .borderRadius(10)
          .border({ width: 1, color: '#E0C080' })

        Row({ space: 8 }) {
          ForEach(this.filters, (filter: string) => {
            Text(filter)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#3E2723')
              .padding({ left: 12, right: 12 })
              .height(36)
              .backgroundColor('#FFD166')
              .borderRadius(6)
              .textAlign(TextAlign.Center)
          }, (filter: string) => filter)
        }
        .width('100%')

        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height(180)
            .onReady(() => {
              const context = this.canvasContext
              const width = 320
              const height = 148
              context.fillStyle = '#FFF0C1'
              context.fillRect(0, 0, width, height)
              const gradient = context.createRadialGradient(width / 2, height / 2, 0, width / 2, height / 2, 60)
              gradient.addColorStop(0, '#FFD166')
              gradient.addColorStop(1, '#FF7B00')
              context.fillStyle = gradient
              context.beginPath()
              context.arc(width / 2, height / 2, 120, 0, Math.PI * 2)
              context.fill()
              context.fillStyle = '#FF7B00'
              context.beginPath()
              context.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2)
              context.fill()
            })
            .padding(16)
            .onTouch((event: TouchEvent) => {
              if (event.touches.length > 0) {
                this.knobX = event.touches[0].x
                this.knobY = event.touches[0].y
              }
            })
        }
        .width('100%')
        .height(180)
        .backgroundColor('#FFFFFF')
        .borderRadius(14)
        .clip(true)

        Grid() {
          ForEach(this.results, (title: string) => {
            GridItem() {
              Column({ space: 8 }) {
                Blank()
                  .width(192)
                  .height(192)
                  .backgroundColor('#FFF0C1')
                  .borderRadius(20)

                Text(title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#3E2723')
                  .height(47)
                  .textAlign(TextAlign.Center)
                  .width('100%')

                Button('Add')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
                  .width('100%')
                  .height(102)
                  .backgroundColor('#FF7B00')
                  .borderRadius(20)
              }
              .padding(32)
              .width('100%')
              .backgroundColor('#FFFFFF')
              .borderRadius(28)
              .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
            }
          }, (title: string) => title)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(32)
        .rowsGap(32)
        .width('100%')
        .padding({ bottom: 24 })
      }
      .padding(32)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF6E5')
    .scrollBar(BarState.Off)
  }
}
