class DocColors {
  static primary: string = '#38BDF8';
  static secondary: string = '#A78BFA';
  static background: string = '#F1F5F9';
  static surface: string = '#FFFFFF';
  static translucentSurface: string = '#B3FFFFFF';
  static surfaceVariant: string = '#E2E8F0';
  static outline: string = '#CBD5E1';
  static onSurface: string = '#1E1E1E';
}

@Entry
@Component
struct Index {
  @State offsetY: number = 0;

  private lines: string[] = [
    'This is a sample line of text content number 1.',
    'This is a sample line of text content number 2.',
    'This is a sample line of text content number 3.',
    'This is a sample line of text content number 4.',
    'This is a sample line of text content number 5.',
    'This is a sample line of text content number 6.',
    'This is a sample line of text content number 7.',
    'This is a sample line of text content number 8.'
  ];

  @Builder
  DocumentCard() {
    Column() {
      Text('Document Reader')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(DocColors.primary)
        .lineHeight(24)
        .width('100%')

      ForEach(this.lines, (line: string) => {
        Text(line)
          .fontSize(14)
          .fontColor(DocColors.onSurface)
          .lineHeight(20)
          .width('100%')
          .margin({ top: 12 })
      }, (line: string) => line)
    }
    .width('90%')
    .height(400)
    .padding(16)
    .backgroundColor(DocColors.translucentSurface)
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
    .translate({ y: this.offsetY / 5 })
  }

  build() {
    Column() {
      Text('Glass Doc Reader')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(DocColors.onSurface)
        .lineHeight(34)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Column() {
        this.DocumentCard()
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[DocColors.surfaceVariant, 0.0], [DocColors.background, 0.5], [DocColors.surfaceVariant, 1.0]]
      })
      .gesture(
        PanGesture()
          .onActionUpdate((event: GestureEvent) => {
            this.offsetY += event.offsetY;
          })
      )
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DocColors.background)
  }
}
