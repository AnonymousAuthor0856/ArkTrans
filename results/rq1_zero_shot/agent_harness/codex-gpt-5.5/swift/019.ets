@Entry
@Component
struct RootScreen {
  @State private fontSize: number = 23.0;
  @State private syncProgress: number = 0.3;

  build() {
    Column() {
      Text('Subtitle Editor')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E1E1E')
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor('#F9F5FF')

      Column() {
        Stack() {
          Rect()
            .width('100%')
            .height(200)
            .fill('#FFFFFF')
            .radius(22)
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor('#1E1E1E')
        }
        .width('100%')
        .height(200)
        .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 6 })

        Text('Font Size: ' + Math.floor(this.fontSize).toString() + 'sp')
          .fontSize(14)
          .fontColor('#1E1E1E')
          .margin({ top: 24 })

        Slider({ value: this.fontSize, min: 16, max: 48, step: 1 })
          .selectedColor('#8B5CF6')
          .trackColor('#F1E9FE')
          .width('100%')
          .onChange((value: number) => {
            this.fontSize = value;
          })
          .margin({ top: 24 })

        Text('Sync Progress')
          .fontSize(14)
          .fontColor('#1E1E1E')
          .margin({ top: 24 })

        Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
          .color('#8B5CF6')
          .backgroundColor('#F1E9FE')
          .width('100%')
          .height(6)
          .margin({ top: 24 })

        Row() {
          Button('Sync +')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#8B5CF6')
            .height(48)
            .borderRadius(14)
            .layoutWeight(1)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
            })
          Button('Sync -')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#D946EF')
            .height(48)
            .borderRadius(14)
            .layoutWeight(1)
            .margin({ left: 12 })
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress - 0.1, 0.0);
            })
        }
        .width('100%')
        .margin({ top: 24 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 16, bottom: 66 })
      .backgroundColor('#F1E9FE')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9F5FF')
  }
}
