@Entry
@Component
struct Index {
  @State spending: number = 500

  build() {
    Stack() {
      Column() {
        // Header
        Stack({ alignContent: Alignment.Center }) {
          Text('Bill Calendar')
            .fontColor('#0F172A')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height(56)
        .backgroundColor('#F0F9FF')

        // Scrollable Content
        Scroll() {
          Column() {
            // Card Component
            Column() {
              Row() {
                Text('Current Spending')
                  .fontColor('#06B6D4')
                  .fontSize(24)
                  .fontWeight(FontWeight.Medium)
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)

              Blank()

              Row() {
                Text(`$${this.spending} / $1,000`)
                  .fontColor('#0F172A')
                  .fontSize(40)
                  .fontWeight(FontWeight.Bold)
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)

              Blank()

              Progress({ value: this.spending, total: 1000, type: ProgressType.Linear })
                .width('100%')
                .height(8)
                .color('#06B6D4')
                .trackColor('#E0F2FE')
                .borderRadius(4)
            }
            .width('100%')
            .height(160)
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .shadow({ radius: 12, color: '#1A000000', offsetY: 4 })

            // Adjust Section
            Text('Adjust Spending')
              .fontColor('#0F172A')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .margin({ top: 24, bottom: 16 })

            Slider({ value: this.spending, min: 0, max: 1000, step: 1 })
              .width('100%')
              .blockColor('#06B6D4')
              .trackColor('#E0F2FE')
              .selectedColor('#06B6D4')

            Button('Reset')
              .width('100%')
              .height(48)
              .backgroundColor('#8B5CF6')
              .borderRadius(16)
              .fontColor('#FFFFFF')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .margin({ top: 24 })
              .onClick(() => {
                this.spending = 0
              })
          }
          .width('100%')
          .padding(24)
        }
        .width('100%')
        .layoutWeight(1)
        .linearGradient({
          angle: 90,
          colors: [['#3B82F6', 0.3], ['#F0F9FF', 0.5], ['#06B6D4', 0.2]]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F0F9FF')
    }
    .width('100%')
    .height('100%')
  }
}