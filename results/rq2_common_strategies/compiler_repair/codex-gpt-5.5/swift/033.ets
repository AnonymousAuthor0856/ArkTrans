@Entry
@Component
struct Index {
  @State spending: number = 500
  private goal: number = 1000

  @Builder
  SpendingProgress() {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(8)
        .radius(4)
        .fill('#E0F2FE')
      Rect()
        .width(`${Math.max(0, Math.min(100, this.spending / this.goal * 100))}%`)
        .height(8)
        .radius(4)
        .fill('#06B6D4')
    }
    .width('100%')
    .height(8)
  }

  @Builder
  SpendingCard() {
    Column() {
      Text('Current Spending')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#06B6D4')
        .width('100%')

      Blank()

      Text(`$${Math.round(this.spending)} / $${Math.round(this.goal)}`)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .width('100%')

      Blank()

      this.SpendingProgress()
    }
    .width('100%')
    .height(160)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#E6FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
  }

  build() {
    Column() {
      Stack() {
        Text('Bill Calendar')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(56)
      .backgroundColor('#F0F9FF')

      Scroll() {
        Column() {
          this.SpendingCard()

          Text('Adjust Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')
            .margin({ top: 16 })

          Slider({ value: this.spending, min: 0, max: 2000, step: 1 })
            .blockColor('#3B82F6')
            .selectedColor('#06B6D4')
            .trackColor('#E0F2FE')
            .width('100%')
            .margin({ top: 16 })
            .onChange((value: number) => {
              this.spending = value
            })

          Button('Reset')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .width('100%')
            .height(48)
            .backgroundColor('#8B5CF6')
            .borderRadius(12)
            .margin({ top: 16 })
            .onClick(() => {
              this.spending = 0
            })
        }
        .width('100%')
        .padding(16)
        .linearGradient({
          angle: 180,
          colors: [['#4D3B82F6', 0.0], ['#F0F9FF', 0.5], ['#3306B6D4', 1.0]]
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}
