@Entry
@Component
struct Index {
  @State fontSize: number = 24
  @State syncProgress: number = 0.3

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        // Subtitle Preview Card
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Text('Sample Subtitle Line')
              .fontSize(this.fontSize)
              .fontColor('#1E1E1E')
          }
          .width('100%')
          .height('100%')
        }
        .width('100%')
        .height(200)
        .borderRadius(24)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })

        // Font Size Label
        Text(`Font Size: ${this.fontSize}sp`)
          .fontColor('#1E1E1E')
          .fontSize(16)

        // Font Size Slider
        Slider({ value: this.fontSize, min: 16, max: 48 })
          .width('100%')
          .selectedColor('#D946EF')
          .trackColor('#F3E8FF')
          .selectedColor('#8B5CF6')

        // Sync Progress Label
        Text('Sync Progress')
          .fontColor('#1E1E1E')
          .fontSize(16)

        // Sync Progress Bar
        Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color('#8B5CF6')
          .backgroundColor('#F1E9FE')

        // Action Buttons
        Row({ space: 12 }) {
          Button('Sync +')
            .type(ButtonType.Normal)
            .backgroundColor('#8B5CF6')
            .fontColor('#FFFFFF')
            .height(48)
            .borderRadius(16)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.min(1, this.syncProgress + 0.1)
            })

          Button('Sync -')
            .type(ButtonType.Normal)
            .backgroundColor('#D946EF')
            .fontColor('#FFFFFF')
            .height(48)
            .borderRadius(16)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.max(0, this.syncProgress - 0.1)
            })
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [['#F3E8FF', 0], ['#FAF5FF', 0.5], ['#FFFFFF', 1]]
      })

      // Top App Bar
      Row() {
        Text('Subtitle Editor')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}