@Entry
@Component
struct SubtitleEditorPage {
  @State private fontSize: number = 24
  @State private syncProgress: number = 0.3

  private readonly primary: string = '#8B5CF6'
  private readonly secondary: string = '#D946EF'
  private readonly backgroundColorValue: string = '#F9F5FF'
  private readonly surface: string = '#FFFFFF'
  private readonly surfaceVariant: string = '#F1E9FE'
  private readonly onSurface: string = '#1E1E1E'

  build() {
    Column() {
      Text('Subtitle Editor')
        .fontSize(52)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 32, bottom: 68 })

      Column() {
        Stack() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize * 2)
            .fontColor(this.onSurface)
            .fontWeight(FontWeight.Regular)
            .maxLines(1)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(400)
        .backgroundColor(this.surface)
        .borderRadius(40)
        .shadow({
          radius: 24,
          color: '#26000000',
          offsetX: 0,
          offsetY: 8
        })
        .alignContent(Alignment.Center)

        Text(`Font Size: ${Math.round(this.fontSize)}sp`)
          .fontSize(27)
          .fontColor(this.onSurface)
          .fontWeight(FontWeight.Regular)
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ top: 29, bottom: 21 })

        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .blockColor(this.secondary)
          .trackColor(this.surfaceVariant)
          .selectedColor(this.primary)
          .showTips(false)
          .width('100%')
          .height(60)
          .onChange((value: number) => {
            this.fontSize = value
          })

        Text('Sync Progress')
          .fontSize(27)
          .fontColor(this.onSurface)
          .fontWeight(FontWeight.Regular)
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ top: 24, bottom: 27 })

        Progress({
          value: this.syncProgress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(12)
          .color(this.primary)
          .backgroundColor(this.surfaceVariant)
          .borderRadius(6)

        Row({ space: 24 }) {
          Button('Sync +')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .backgroundColor(this.primary)
            .borderRadius(28)
            .height(96)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.min(1, this.syncProgress + 0.1)
            })

          Button('Sync -')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .backgroundColor(this.secondary)
            .borderRadius(28)
            .height(96)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.max(0, this.syncProgress - 0.1)
            })
        }
        .width('100%')
        .height(96)
        .margin({ top: 32 })
      }
      .width('100%')
      .padding({ left: 32, right: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColorValue)
    .linearGradient({
      angle: 180,
      colors: [
        [this.surfaceVariant, 0.0],
        [this.backgroundColorValue, 0.58],
        [this.surface, 1.0]
      ]
    })
  }
}
