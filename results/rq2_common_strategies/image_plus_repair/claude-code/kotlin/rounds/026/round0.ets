@Entry
@Component
struct GlassDocReader {
  @State scrollOffsetY: number = 0;

  private readonly colors = {
    primary: '#38BDF8',
    secondary: '#A78BFA',
    tertiary: '#7DD3FC',
    background: '#F1F5F9',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    onSurface: '#1E1E1E',
  };

  private readonly lines: string[] = [
    'This is a sample line of text content number 1.',
    'This is a sample line of text content number 2.',
    'This is a sample line of text content number 3.',
    'This is a sample line of text content number 4.',
    'This is a sample line of text content number 5.',
    'This is a sample line of text content number 6.',
    'This is a sample line of text content number 7.',
    'This is a sample line of text content number 8.',
  ];

  build() {
    Column() {
      Text('Glass Doc Reader')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 24, bottom: 24 })

      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              [this.colors.surfaceVariant + 'CC', 0],
              [this.colors.background, 0.5],
              [this.colors.surfaceVariant + 'CC', 1],
            ]
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Move) {
              this.scrollOffsetY += event.touches[0].y - event.touches[0].y;
            }
          })

        Column() {
          Column() {
            Text('Document Reader')
              .fontSize(36)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.primary)
              .width('100%')
              .margin({ bottom: 20 })

            ForEach(this.lines, (line: string) => {
              Text(line)
                .fontSize(28)
                .fontColor(this.colors.onSurface)
                .width('100%')
                .margin({ bottom: 20 })
            })
          }
          .width('100%')
          .height('100%')
          .padding(28)
          .backgroundColor('rgba(255, 255, 255, 0.7)')
          .borderRadius(40)
        }
        .width('90%')
        .height(800)
        .translate({ y: this.scrollOffsetY / 5 })
        .backgroundColor('rgba(255, 255, 255, 0.5)')
        .borderRadius(48)
        .shadow({
          radius: 24,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetY: 12,
        })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }
}
