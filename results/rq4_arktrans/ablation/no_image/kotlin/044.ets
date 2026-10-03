@Entry
@Component
struct Index {
  @State syncProgress: number = 0.3

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Text('Order Tracking')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')

        Column() {
          Column({ space: 10 }) {
            Text('Order #25491')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#3E2723')

            Text('Estimated Delivery: 2 days')
              .fontSize(14)
              .fontColor('#FFB74D')

            Progress({
              value: this.syncProgress * 100,
              total: 100,
              type: ProgressType.Linear
            })
              .width('100%')
              .height(10)
              .color('#FF7043')
              .backgroundColor('#FFE0B2')

            Row({ space: 0 }) {
              Text('Processing')
                .fontSize(12)
                .fontColor('#FFB74D')

              Blank()

              Text(`${Math.round(this.syncProgress * 100)}%`)
                .fontSize(12)
                .fontColor('#FF7043')
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .padding(16)
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000' })
        .width('100%')

        Stack({ alignContent: Alignment.Center }) {
          Column({ space: 10 }) {
            Text('Adjust Progress')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#3E2723')

            Slider({
              value: this.syncProgress,
              min: 0,
              max: 1
            })
              .width('100%')
              .onChange((value: number) => {
                this.syncProgress = value
              })

            Button() {
              Text('Mark as Delivered')
                .fontSize(12)
                .fontColor('#FFFFFF')
            }
            .width('100%')
            .backgroundColor('#FF7043')
            .borderRadius(8)
            .onClick(() => {
              this.syncProgress = 1
            })
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .padding(16)
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