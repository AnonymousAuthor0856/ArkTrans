@Entry
@Component
struct Index {
  @State fontSize: number = 24
  @State syncProgress: number = 0.3

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        // Surface equivalent
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Text('Sample Subtitle Line')
              .fontSize(this.fontSize)
              .fontColor('#1E1E1E')
          }
          .width('100%')
          .height('100%')
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
        .width('100%')
        .height(200)

        // Font Size Label
        Text(`Font Size: ${Math.round(this.fontSize)}sp`)
          .fontColor('#1E1E1E')
          .fontSize(14)

        // Slider
        Slider({ value: this.fontSize, min: 16, max: 48 })
          .width('100%')
          .onChange((value: number) => {
            this.fontSize = value
          })

        // Sync Progress Label
        Text('Sync Progress')
          .fontColor('#1E1E1E')
          .fontSize(14)

        // Linear Progress Indicator
        Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color('#8B5CF6')
          .linearGradient({
            direction: GradientDirection.Right,
            colors: [['#F1E9FE', 0], ['#F1E9FE', 1]]
          })

        // Row with Buttons
        Row({ space: 12 }) {
          Button() {
            Text('Sync +')
              .fontColor('#FFFFFF')
              .fontSize(16)
          }
          .backgroundColor('#8B5CF6')
          .borderRadius(8)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0)
          })

          Button() {
            Text('Sync -')
              .fontColor('#FFFFFF')
              .fontSize(16)
          }
          .backgroundColor('#D1C4E9')
          .borderRadius(8)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0)
          })
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#EADDFF', 0], ['#F9F5FF', 0.5], ['#FFFFFF', 1]]
      })

      // Top App Bar Equivalent
      Row() {
        Text('Subtitle Editor')
          .fontColor('#1E1E1E')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F9F5FF')
    }
    .width('100%')
    .height('100%')
  }
}