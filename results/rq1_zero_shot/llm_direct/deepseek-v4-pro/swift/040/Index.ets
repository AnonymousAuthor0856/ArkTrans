@Entry
@Component
struct RootScreen {
  @State private var query: string = ''
  @State private var knobOffsetX: number = 144
  @State private var knobOffsetY: number = 104
  @State private var isTextFieldFocused: boolean = false
  private results: ResultItem[] = [
    { id: 0, title: 'Result 1' },
    { id: 1, title: 'Result 2' },
    { id: 2, title: 'Result 3' },
    { id: 3, title: 'Result 4' },
    { id: 4, title: 'Result 5' },
    { id: 5, title: 'Result 6' }
  ]

  build() {
    Stack() {
      Column({ space: 12 }) {
        Text('Retro Filter Search')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')
          .width('100%')
          .textAlign(TextAlign.Start)

        TextInput({ placeholder: 'Search products', text: $$this.query })
          .fontSize(14)
          .fontColor('#3E2723')
          .placeholderColor('#663E2723')
          .height(56)
          .backgroundColor('#FFFFFF')
          .borderRadius(10)
          .border({
            width: 1,
            color: this.isTextFieldFocused ? '#FF7B00' : '#E0C080'
          })
          .padding({ left: 16, right: 16 })
          .onFocus(() => {
            this.isTextFieldFocused = true
          })
          .onBlur(() => {
            this.isTextFieldFocused = false
          })

        Row({ space: 8 }) {
          ForEach(['Popular', 'New', 'Discount', 'Premium'], (item: string) => {
            Button(item)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#3E2723')
              .height(36)
              .padding({ left: 12, right: 12 })
              .backgroundColor('#FFD166')
              .borderRadius(6)
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height(148)
            .backgroundColor('#FFFFFF')
            .borderRadius(14)
            .padding(16)
            .gesture(
              PanGesture()
                .onActionStart((event: GestureEvent) => {
                  this.knobOffsetX = Math.max(8, Math.min(event.offsetX, 8))
                  this.knobOffsetY = Math.max(8, Math.min(event.offsetY, 8))
                })
                .onActionUpdate((event: GestureEvent) => {
                  this.knobOffsetX = Math.max(8, Math.min(event.offsetX, 8))
                  this.knobOffsetY = Math.max(8, Math.min(event.offsetY, 8))
                })
            )
        }
        .width('100%')
        .height(180)

        Grid() {
          ForEach(this.results, (item: ResultItem) => {
            GridItem() {
              CardView({ item: item })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        .padding({ bottom: 24 })
      }
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF6E5')
  }

  @Builder
  canvasContext(context: CanvasRenderingContext2D) {
    context.fillStyle = '#FFF0C1'
    context.fillRect(0, 0, context.width, context.height)

    let centerX = context.width / 2
    let centerY = context.height / 2
    let gradient = context.createRadialGradient(centerX, centerY, 0, centerX, centerY, 60)
    gradient.addColorStop(0, '#FFD166')
    gradient.addColorStop(1, '#FF7B00')
    context.fillStyle = gradient
    context.beginPath()
    context.arc(centerX, centerY, 60, 0, Math.PI * 2)
    context.fill()

    context.fillStyle = '#FF7B00'
    context.beginPath()
    context.arc(this.knobOffsetX, this.knobOffsetY, 16, 0, Math.PI * 2)
    context.fill()
  }
}

@Component
struct CardView {
  @Prop item: ResultItem

  build() {
    Column({ space: 8 }) {
      Row()
        .width(96)
        .height(96)
        .backgroundColor('#FFF0C1')
        .borderRadius(10)

      Text(this.item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#3E2723')

      Button('Add')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .width('100%')
        .height(48)
        .backgroundColor('#FF7B00')
        .borderRadius(10)
    }
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(14)
    .shadow({
      radius: 8,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 4
    })
  }
}

interface ResultItem {
  id: number
  title: string
}