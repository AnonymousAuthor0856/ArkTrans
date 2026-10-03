interface ColorPalette {
  background: number
  surfaceVariant: number
  surface: number
  primary: number
  onSurface: number
}

const COLORS: ColorPalette = {
  background: 0xFFF1F5F9,
  surfaceVariant: 0xFFE2E8F0,
  surface: 0xFFFFFFFF,
  primary: 0xFF38BDF8,
  onSurface: 0xFF1E1E1E
}

@Entry
@Component
struct GlassDocReader {
  @State private panelOffsetY: number = 0

  private readonly lines: string[] = [
    'This is a sample line of text content number 1.',
    'This is a sample line of text content number 2.',
    'This is a sample line of text content number 3.',
    'This is a sample line of text content number 4.',
    'This is a sample line of text content number 5.',
    'This is a sample line of text content number 6.',
    'This is a sample line of text content number 7.',
    'This is a sample line of text content number 8.'
  ]

  build() {
    Column() {
      Text('Glass Doc Reader')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 20, bottom: 16 })
        .backgroundColor(COLORS.background)

      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 90,
            colors: [
              [COLORS.surfaceVariant, 0.0],
              [COLORS.background, 0.5],
              [COLORS.surfaceVariant, 1.0]
            ]
          })

        Column({ space: 12 }) {
          Text('Document Reader')
            .fontSize(18)
            .fontColor(COLORS.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          ForEach(this.lines, (line: string) => {
            Text(line)
              .fontSize(14)
              .fontColor(COLORS.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)
          })

          Blank()
            .layoutWeight(1)
        }
        .width('90%')
        .height(400)
        .padding(16)
        .backgroundColor(0xB3FFFFFF)
        .borderRadius(20)
        .shadow({
          radius: 8,
          color: 0x2E000000,
          offsetY: 4
        })
        .translate({ y: this.panelOffsetY })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.panelOffsetY = Math.max(-120, Math.min(120, event.offsetY / 5))
            })
            .onActionEnd(() => {
              this.panelOffsetY = 0
            })
        )
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}
