@Entry
@Component
struct RootScreen {
  @State fontSize: number = 24;
  @State syncProgress: number = 0.3;

  build() {
    Column() {
      // Top app bar
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

      Column({ space: 16 }) {
        // Subtitle preview surface
        Stack() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor('#1E1E1E')
        }
        .width('100%')
        .height(200)
        .alignContent(Alignment.Center)
        .backgroundColor('#FFFFFF')
        .borderRadius(22)

        Text('Font Size: ' + Math.floor(this.fontSize) + 'sp')
          .fontSize(14)
          .fontColor('#1E1E1E')

        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .onChange((value: number) => {
            this.fontSize = value
          })
          .selectedColor('#8B5CF6')
          .blockColor('#D946EF')
          .trackColor('#F1E9FE')

        Text('Sync Progress')
          .fontSize(14)
          .fontColor('#1E1E1E')

        Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color('#8B5CF6')
          .backgroundColor('#F1E9FE')

        Row({ space: 12 }) {
          Button() {
            Text('Sync +')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor('#8B5CF6')
          .borderRadius(14)
          .onClick(() => {
            this.syncProgress = Math.min(this.syncProgress + 0.1, 1)
          })

          Button() {
            Text('Sync -')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor('#D946EF')
          .borderRadius(14)
          .onClick(() => {
            this.syncProgress = Math.max(this.syncProgress - 0.1, 0)
          })
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [['#F1E9FE', 0], ['#F9F5FF', 0.5], ['#FFFFFF', 1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9F5FF')
  }
}
