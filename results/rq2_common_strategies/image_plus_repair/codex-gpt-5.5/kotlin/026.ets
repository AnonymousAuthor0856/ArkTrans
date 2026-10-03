const PAGE_BACKGROUND: string = '#F1F5F9'
const PANEL_BACKGROUND: string = '#BFFFFFFF'
const DOCUMENT_BACKGROUND: string = '#FCFDFE'
const TEXT_COLOR: string = '#1E1E1E'
const PRIMARY_COLOR: string = '#38BDF8'

@Entry
@Component
struct MainPage {
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
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        Text('Glass Doc Reader')
          .fontSize(54)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_COLOR)
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ top: 30 })

        Column() {
          Column() {
            Text('Document Reader')
              .fontSize(36)
              .fontWeight(FontWeight.Medium)
              .fontColor(PRIMARY_COLOR)
              .width('100%')
              .textAlign(TextAlign.Start)
              .margin({ bottom: 22 })

            ForEach(this.lines, (line: string) => {
              Text(line)
                .fontSize(28)
                .fontColor(TEXT_COLOR)
                .fontWeight(FontWeight.Normal)
                .width('100%')
                .textAlign(TextAlign.Start)
                .margin({ bottom: 20 })
            }, (line: string) => line)
          }
          .width('89%')
          .height('91%')
          .margin({ top: 44 })
          .padding({ top: 0, right: 0, bottom: 0, left: 0 })
          .backgroundColor(DOCUMENT_BACKGROUND)
          .justifyContent(FlexAlign.Start)
        }
        .width('90%')
        .height('800')
        .margin({ top: 215 })
        .padding({ top: 0 })
        .backgroundColor(PANEL_BACKGROUND)
        .borderRadius(40)
        .shadow({
          radius: 18,
          color: '#35000000',
          offsetX: 0,
          offsetY: 8
        })
        .translate({ x: 0, y: this.panelOffsetY / 5 })
        .clip(true)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(PAGE_BACKGROUND)
      .linearGradient({
        angle: 90,
        colors: [
          ['#E2E8F0CC', 0.0],
          ['#F1F5F9FF', 0.5],
          ['#E2E8F0CC', 1.0]
        ]
      })
      .gesture(
        GestureGroup(GestureMode.Exclusive,
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.panelOffsetY += event.offsetY
            })
        )
      )
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PAGE_BACKGROUND)
  }
}
