@Entry
@Component
struct RootScreen {
  @State progress: number = 0.42

  build() {
    Stack() {
      // Background
      Column() {}
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFBE0')

      // Main content
      Column({ space: 16 }) {
        // Title
        Text('Order Tracking')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#FF3D2624')
          .width('100%')
          .textAlign(TextAlign.Start)

        // Order info card
        Column({ space: 10 }) {
          Text('Order #25491')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FF3D2624')
            .width('100%')
            .textAlign(TextAlign.Start)

          Text('Estimated Delivery: 2 days')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .foregroundColor('#FFFFB84D')
            .width('100%')
            .textAlign(TextAlign.Start)

          // Progress bar
          Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(10)
            .color('#FFFF7042')
            .backgroundColor('#FFFFE0B3')
            .borderRadius(5)

          // Progress labels
          Row({ space: 0 }) {
            Text('Processing')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FFFFB84D')
            Blank().layoutWeight(1)
            Text((this.progress * 100).toFixed(0) + '%')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FFFF7042')
          }
          .width('100%')
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFFFF')
        .borderRadius(16)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.15)', offsetX: 0, offsetY: 4 })

        // Adjust progress card
        Column({ space: 10 }) {
          Text('Adjust Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FF3D2624')
            .width('100%')
            .textAlign(TextAlign.Center)

          // Slider
          Slider({ value: this.progress, min: 0, max: 1, step: 0.01 })
            .width('100%')
            .height(20)
            .onChange((value: number) => {
              this.progress = value
            })

          Button() {
            Text('Mark as Delivered')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FFFFFFFF')
              .padding({ top: 10, bottom: 10 })
          }
          .width('100%')
          .backgroundColor('#FFFF7042')
          .borderRadius(10)
          .onClick(() => {
            this.progress = 1.0
          })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFFFF')
        .borderRadius(16)
      }
      .width('100%')
      .height('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
  }
}