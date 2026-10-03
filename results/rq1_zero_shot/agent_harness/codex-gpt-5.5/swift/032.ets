@Entry
@Component
struct RootScreen {
  @State private progressValue: number = 0.4;
  @State private markerX: number = 200;
  @State private markerY: number = 400;

  build() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .fill('#FFFBF2')

      Column() {
        Stack() {
          Rect()
            .width('100%')
            .height(56)
            .fill('#FFFBF2')
          Text('Transfer Wizard')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E1E1E')
        }
        .height(56)

        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(520)
            .height(520)
            .fill('#FFEED6')
          Circle()
            .width(40)
            .height(40)
            .fill('#FFA500')
            .position({ x: this.markerX, y: this.markerY })

          Column() {
            Blank()
            Text('Transfer Progress')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1E1E1E')
            Progress({ value: this.progressValue, total: 1, type: ProgressType.Linear })
              .color('#FFA500')
              .backgroundColor('#FFEED6')
              .width('80%')
              .height(8)
              .margin({ top: 16 })
            Row() {
              Button('+')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .backgroundColor('#FFA500')
                .width(64)
                .height(64)
                .borderRadius(32)
                .onClick(() => {
                  this.progressValue = Math.min(this.progressValue + 0.1, 1.0);
                })
              Button('-')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1E1E1E')
                .backgroundColor('#FFC300')
                .width(64)
                .height(64)
                .borderRadius(32)
                .margin({ left: 12 })
                .onClick(() => {
                  this.progressValue = Math.max(this.progressValue - 0.1, 0.0);
                })
            }
            .margin({ top: 16, bottom: 32 })
          }
          .width('100%')
          .height('100%')
        }
        .layoutWeight(1)
        .padding(24)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFBF2')
  }
}
