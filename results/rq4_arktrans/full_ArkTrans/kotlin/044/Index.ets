@Entry
@Component
struct Index {
  @State syncProgress: number = 0.42

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Text('Order Tracking')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')

        // Card 1
        Column() {
          Column({ space: 10 }) {
            Text('Order #25491')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#3E2723')

            Text('Estimated Delivery: 2 days')
              .fontSize(16)
              .fontColor('#FFB74D')

            Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
              .width('100%')
              .height(10)
              .color('#FF7043')
              .backgroundColor('#FFE0B2')

            Row() {
              Text('Processing')
                .fontSize(14)
                .fontColor('#FFB74D')
              Blank()
              Text(`${Math.round(this.syncProgress * 100)}%`)
                .fontSize(14)
                .fontColor('#FF7043')
            }.width('100%')
          }
          .width('100%')
          .padding(16)
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 8, color: '#1A000000', offsetY: 2 })

        // Card 2
        Column() {
          Column({ space: 10 }) {
            Text('Adjust Progress')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#3E2723')

            Slider({ value: this.syncProgress, min: 0, max: 1 })
              .width('100%')
              .selectedColor('#FF7043')
              .trackColor('#FFE0B2')
              .blockColor('#FF7043')

            Button('Mark as Delivered')
              .width('100%')
              .backgroundColor('#FF7043')
              .fontColor('#FFFFFF')
              .borderRadius(12)
              .onClick(() => {
                this.syncProgress = 1
              })
          }
          .alignItems(HorizontalAlign.Center)
          .width('100%')
          .padding(16)
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 8, color: '#1A000000', offsetY: 2 })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFF3E0')
    }
    .width('100%')
    .height('100%')
  }
}