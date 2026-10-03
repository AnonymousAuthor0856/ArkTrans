@Entry
@Component
struct GlassDocReader {
  // AppTokens Colors
  private readonly primary = '#38BDF8'
  private readonly secondary = '#A78BFA'
  private readonly tertiary = '#7DD3FC'
  private readonly backgroundColor: ResourceColor = Color('#F1F5F9')
  private readonly surface = '#FFFFFF'
  private readonly surfaceVariant = '#E2E8F0'
  private readonly outlineColor: ResourceColor = Color('#CBD5E1')
  private readonly onSurface = '#1E1E1E'

  @State scrollOffset: number = 0

  build() {
    Column() {
      // Top Bar Area
      Column() {
        Text('Glass Doc Reader')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onSurface)
          .margin({ bottom: 40 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)

      // Main Content Area with Gradient Background
      Stack({ alignContent: Alignment.Center }) {
        // Invisible touch area for scrolling simulation
        Column()
          .width('100%')
          .height('100%')
          .gesture(
            PanGesture()
              .onActionUpdate((event?: GestureEvent) => {
                if (event) {
                  this.scrollOffset += event.offsetY
                }
              })
          )

        // The Glass Card
        Column() {
          Text('Document Reader')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.primary)
            .margin({ bottom: 12 })

          // Sample text lines
          ForEach([1, 2, 3, 4, 5, 6, 7, 8], (index: number) => {
            Text(`This is a sample line of text content number ${index}.`)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(this.onSurface)
              .lineHeight(24)
              .margin({ bottom: 8 })
          })
        }
        .width('90%')
        .height(400)
        .padding(16)
        .backgroundColor(Color.White)
        .opacity(0.7) // Simulating glassmorphism alpha
        .borderRadius(20)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetX: 0,
          offsetY: 4
        })
        .translate({ y: this.scrollOffset / 5 })
      }
      .layoutWeight(1)
      .linearGradient({
        angle: 90,
        colors: [
          ['rgba(226, 232, 240, 0.8)', 0],
          ['#F1F5F9', 0.5],
          ['rgba(226, 232, 240, 0.8)', 1]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}