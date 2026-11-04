@Entry
@Component
struct Index {
  private cPrimary: string = '#38BDF8'
  private cSecondary: string = '#A78BFA'
  private cTertiary: string = '#7DD3FC'
  private cBackground: string = '#F1F5F9'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#E2E8F0'
  private cOutline: string = '#CBD5E1'
  private cText: string = '#1E1E1E'
  private lines: string[] = [
    'This is a sample line of text content number 1.',
    'This is a sample line of text content number 2.',
    'This is a sample line of text content number 3.',
    'This is a sample line of text content number 4.',
    'This is a sample line of text content number 5.',
    'This is a sample line of text content number 6.',
    'This is a sample line of text content number 7.',
    'This is a sample line of text content number 8.'
  ]

  @Builder
  ReaderCard() {
    Column() {
      Text('Document Reader')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.cPrimary)
        .width('100%')
        .margin({ bottom: 12 })
      ForEach(this.lines, (line: string) => {
        Text(line)
          .fontSize(14)
          .fontColor(this.cText)
          .width('100%')
          .margin({ bottom: 12 })
      }, (line: string) => line)
      Blank()
    }
    .width('90%')
    .height(400)
    .padding(16)
    .backgroundColor('#B3FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
  }

  build() {
    Column() {
      Text('Glass Doc Reader')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.cText)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 36, bottom: 16 })
        .backgroundColor(this.cBackground)

      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .width('100%')
          .height('100%')
          .fill(this.cSurfaceVariant)
        this.ReaderCard()
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}
