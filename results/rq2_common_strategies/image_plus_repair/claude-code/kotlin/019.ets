@Entry
@Component
struct SubtitleEditor {
  @State fontSize: number = 24
  @State syncProgress: number = 0.3

  private readonly primary = '#8B5CF6'
  private readonly secondary = '#D946EF'
  private readonly bgColor = '#F9F5FF'
  private readonly surface = '#FFFFFF'
  private readonly surfaceVariant = '#F1E9FE'
  private readonly onSurface = '#1E1E1E'
  private readonly onPrimary = '#FFFFFF'

  build() {
    Column() {
      Text('Subtitle Editor')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 24 })

      Column() {
        Column() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(this.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(this.surface)
        .borderRadius(22)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .shadow({
          radius: 12,
          color: 'rgba(139, 92, 246, 0.18)',
          offsetY: 6
        })
      }
      .width('100%')
      .padding({ bottom: 16 })

      Text(`Font Size: ${Math.round(this.fontSize)}sp`)
        .fontSize(14)
        .fontColor(this.onSurface)
        .margin({ bottom: 8 })

      Slider({
        value: this.fontSize,
        min: 16,
        max: 48,
        step: 1,
        style: SliderStyle.OutSet
      })
        .blockColor(this.secondary)
        .selectedColor(this.primary)
        .trackColor(this.surfaceVariant)
        .width('100%')
        .onChange((value: number) => {
          this.fontSize = value
        })

      Text('Sync Progress')
        .fontSize(14)
        .fontColor(this.onSurface)
        .margin({ top: 16, bottom: 8 })

      Progress({ value: this.syncProgress * 100, total: 100, type: ProgressType.Linear })
        .color(this.primary)
        .backgroundColor(this.surfaceVariant)
        .width('100%')
        .height(6)
        .borderRadius(3)

      Row() {
        Button('Sync +')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onPrimary)
          .backgroundColor(this.primary)
          .borderRadius(14)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0)
          })

        Button('Sync -')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onPrimary)
          .backgroundColor(this.secondary)
          .borderRadius(14)
          .height(48)
          .layoutWeight(1)
          .margin({ left: 12 })
          .onClick(() => {
            this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0)
          })
      }
      .width('100%')
      .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor(this.bgColor)
  }
}
