@Entry
@Component
struct Index {
  @State fontSize: number = 24
  @State syncProgress: number = 0.3

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Subtitle Editor')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F9F5FF')

      // Content
      Column({ space: 16 }) {
        // Preview Surface
        Stack() {
          Column() {
            Text('Sample Subtitle Line')
              .fontSize(this.fontSize)
              .fontColor('#1E1E1E')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height(200)
        .backgroundColor('#FFFFFF')
        .borderRadius(22)
        .shadow({
          radius: 12,
          color: '#29000000',
          offsetX: 0,
          offsetY: 6
        })

        // Font Size Label
        Text(`Font Size: ${Math.round(this.fontSize)}sp`)
          .fontSize(14)
          .fontColor('#1E1E1E')
          .fontWeight(FontWeight.Normal)

        // Font Size Slider
        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor('#F1E9FE')
          .selectedColor('#8B5CF6')
          .blockColor('#D946EF')
          .onChange((value: number) => {
            this.fontSize = value
          })

        // Sync Progress Label
        Text('Sync Progress')
          .fontSize(14)
          .fontColor('#1E1E1E')
          .fontWeight(FontWeight.Normal)

        // Progress Bar
        Progress({
          value: this.syncProgress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color('#8B5CF6')
          .backgroundColor('#F1E9FE')

        // Buttons Row
        Row({ space: 12 }) {
          Button('Sync +')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#8B5CF6')
            .borderRadius(14)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0)
            })

          Button('Sync -')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#D946EF')
            .borderRadius(14)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0)
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        angle: 135,
        colors: [['#F1E9FE', 0.0], ['#F9F5FF', 0.5], ['#FFFFFF', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9F5FF')
  }
}