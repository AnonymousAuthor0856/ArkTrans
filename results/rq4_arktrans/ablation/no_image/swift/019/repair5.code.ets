@Entry
@Component
struct Index {
  @State fontSize: number = 16
  @State syncProgress: number = 0.5

  build() {
    Stack() {
      Column() {
        Text('Sample Subtitle Line')
          .width('100%')
          .height(200)
          .shadow({ color: '#000000', radius: 8, offsetX: 0, offsetY: 4 })
          .borderRadius(16)
          .backgroundColor('#FFFFFFFF')
          .fontColor('#FF1E1E1E')
          .fontSize(this.fontSize)

        Text(`${parseInt(this.fontSize)}sp`)
          .fontColor('#FF1E1E1E')
          .fontSize(14)

        Slider({ value: this.fontSize, min: 16, max: 48 })
          .width('100%')
          .trackColor(Color.fromHex('#FFF1E9FE'))
          .selectedColor(Color.fromHex('#FF8B5CF6'))

        Text('Sync Progress')
          .fontColor('#FF1E1E1E')
          .fontSize(14)

        Progress({ value: this.syncProgress, total: 1.0, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .trackColor(Color.fromHex('#FFF1E9FE'))
          .color(Color.fromHex('#FF8B5CF6'))

        Row() {
          Button() {
            Text('Sync +')
              .width('100%')
              .height('100%')
              .fontColor('#FFFFFFFF')
              .fontSize(18)
          }
          .onClick(() => {
            this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0)
          })
          .borderRadius(12)
          .backgroundColor('#FF8B5CF6')
          .height(48)
          .layoutWeight(1)

          Button() {
            Text('Sync -')
              .width('100%')
              .height('100%')
              .fontColor('#FFFFFFFF')
              .fontSize(18)
          }
          .onClick(() => {
            this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0)
          })
          .borderRadius(12)
          .backgroundColor('#FFD946EF')
          .height(48)
          .layoutWeight(1)
        }.width('100%').margin({ top: 16 })
      }
      .padding({ bottom: 50 })
      .width('100%')
      .height('100%')
    }.width('100%').height('100%')
  }
}