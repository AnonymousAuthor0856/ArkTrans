@Entry
@Component
struct RootScreen {
  @State private spending: number = 500;
  private goal: number = 1000;

  @Builder
  SpendingCard() {
    Column() {
      Text('Current Spending')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#06B6D4')
      Blank()
      Text('$' + Math.floor(this.spending).toString() + ' / $' + Math.floor(this.goal).toString())
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
      Blank()
      Progress({ value: this.spending, total: this.goal, type: ProgressType.Linear })
        .color('#06B6D4')
        .backgroundColor('#E0F2FE')
        .width('100%')
        .height(8)
    }
    .width('100%')
    .height(160)
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#E6FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Stack() {
        Rect()
          .width('100%')
          .height(56)
          .fill('#F0F9FF')
        Text('Bill Calendar')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .height(56)

      Scroll() {
        Column() {
          this.SpendingCard()
          Text('Adjust Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')
            .margin({ top: 16 })
          Slider({ value: this.spending, min: 0, max: 2000, step: 1 })
            .selectedColor('#06B6D4')
            .trackColor('#E0F2FE')
            .width('100%')
            .margin({ top: 16 })
            .onChange((value: number) => {
              this.spending = value;
            })
          Button('Reset')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#8B5CF6')
            .width('100%')
            .height(48)
            .borderRadius(12)
            .margin({ top: 16 })
            .onClick(() => {
              this.spending = 0;
            })
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .backgroundColor('#F0F9FF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}
