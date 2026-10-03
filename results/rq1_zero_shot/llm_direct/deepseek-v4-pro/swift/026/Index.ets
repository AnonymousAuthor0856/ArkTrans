@Entry
@Component
struct RootScreen {
  @State private scrollOffsetY: number = 0
  private lastDragY: number = 0

  // Color tokens
  private primary: string = '#38BDF8'
  private secondary: string = '#A78BFA'
  private tertiary: string = '#7DD3FC'
  private background: string = '#F1F5F9'
  private surface: string = '#FFFFFF'
  private surfaceVariant: string = '#E2E8F0'
  private outline: string = '#CBD5E1'
  private success: string = '#22C55E'
  private warning: string = '#F59E0B'
  private error: string = '#EF4444'
  private onPrimary: string = '#FFFFFF'
  private onSecondary: string = '#1E1E1E'
  private onTertiary: string = '#1E1E1E'
  private onBackground: string = '#1E1E1E'
  private onSurface: string = '#1E1E1E'

  // Shape tokens
  private shapeSmall: number = 6
  private shapeMedium: number = 12
  private shapeLarge: number = 20

  // Spacing tokens
  private spacingSm: number = 8
  private spacingMd: number = 12
  private spacingLg: number = 16
  private spacingXl: number = 24
  private spacingXxl: number = 32

  // Shadow tokens
  private shadowLevel1Radius: number = 4
  private shadowLevel1Dy: number = 2
  private shadowLevel1Opacity: number = 0.12
  private shadowLevel2Radius: number = 8
  private shadowLevel2Dy: number = 4
  private shadowLevel2Opacity: number = 0.18

  build() {
    Column() {
      // Top App Bar
      Text('Glass Doc Reader')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 20, bottom: this.spacingLg })
        .backgroundColor(this.background)

      // Main content area
      Stack({ alignContent: Alignment.Center }) {
        // Background gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 180,
            colors: [
              [this.surfaceVariant + 'CC', 0.0],
              [this.background, 0.5],
              [this.surfaceVariant + 'CC', 1.0]
            ]
          })

        // Surface card
        Column({ space: this.spacingMd }) {
          Text('Document Reader')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.primary)

          ForEach(Array.from({ length: 8 }, (_, i) => i), (index: number) => {
            Text(`This is a sample line of text content number ${index + 1}.`)
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor(this.onSurface)
              .width('100%')
          })

          Blank()
            .layoutWeight(1)
        }
        .width('90%')
        .height(400)
        .padding(this.spacingLg)
        .alignItems(HorizontalAlign.Start)
        .backgroundColor(this.surface + 'B3')
        .borderRadius(this.shapeLarge)
        .shadow({
          radius: this.shadowLevel2Radius,
          color: `rgba(0, 0, 0, ${this.shadowLevel2Opacity})`,
          offsetX: 0,
          offsetY: this.shadowLevel2Dy
        })
        .translate({ y: this.scrollOffsetY / 5 })
        .gesture(
          PanGesture()
            .onActionStart((event: GestureEvent) => {
              this.lastDragY = event.offsetY
            })
            .onActionUpdate((event: GestureEvent) => {
              this.scrollOffsetY += event.offsetY - this.lastDragY
              this.lastDragY = event.offsetY
            })
        )
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}