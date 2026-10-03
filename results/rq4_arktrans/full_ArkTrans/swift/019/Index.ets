@Entry
@Component
struct Index {
  @State fontSize: number = 23
  @State syncProgress: number = 0.5

  build() {
    Column() {
      // Subtitle Preview Card
      Text('Sample Subtitle Line')
        .fontSize(this.fontSize)
        .fontColor('#1E1E1E')
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(200)
        .backgroundColor('#FFFFFF')
        .borderRadius(32)
        .shadow({ radius: 16, color: '#1F000000', offsetY: 4 })
        .margin({ top: 40, bottom: 24 })

      // Font Size Label
      Text(`Font Size: ${this.fontSize}sp`)
        .fontSize(16)
        .fontColor('#1E1E1E')
        .margin({ bottom: 16 })

      // Slider
      Slider({ value: this.fontSize, min: 16, max: 48 })
        .width('100%')
        .trackColor('#E0E0E0')
        .selectedColor('#8B5CF6')
        .blockColor('#FFFFFF')
        .margin({ bottom: 32 })

      // Sync Progress Label
      Text('Sync Progress')
        .fontSize(16)
        .fontColor('#1E1E1E')
        .margin({ bottom: 16 })

      // Progress Bar
      Progress({ value: this.syncProgress, total: 1.0, type: ProgressType.Linear })
        .width('100%')
        .height(6)
        .color('#8B5CF6')
        .backgroundColor('#F1E9FE')
        .margin({ bottom: 24 })

      // Buttons Row
      Row() {
        Button() {
          Text('Sync +')
            .fontSize(18)
            .fontColor('#FFFFFF')
        }
        .backgroundColor('#8B5CF6')
        .borderRadius(16)
        .height(48)
        .layoutWeight(1)
        .margin({ right: 12 })

        Button() {
          Text('Sync -')
            .fontSize(18)
            .fontColor('#FFFFFF')
        }
        .backgroundColor('#D946EF')
        .borderRadius(16)
        .height(48)
        .layoutWeight(1)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#F5F0FF')
  }
}