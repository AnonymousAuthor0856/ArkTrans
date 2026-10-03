@Entry
@Component
struct OrderTrackingApp {
  @State progress: number = 42

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Top }
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack({ alignContent: Alignment.Top }) {
      // === Column ===
      // props: { space: 16 }
      // modifier: { width: '100%', padding: 16, backgroundColor: '#FFF5E6' }
      // children: 3
      Column({ space: 16 }) {
        // === Text ===
        // props: { text: 'Order Tracking' }
        // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#3D2B2A', textAlign: TextAlign.Start }
        Text('Order Tracking')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3D2B2A')
          .textAlign(TextAlign.Start)

        // === Column (Card 1) ===
        // props: { space: 10 }
        // modifier: { width: '100%', padding: 16, backgroundColor: '#FFFFFF', borderRadius: 16, shadow: { radius: 8, color: '#26000000', offsetY: 4 } }
        // children: 4
        Column({ space: 10 }) {
          // === Text ===
          // props: { text: 'Order #25491' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#3D2B2A', textAlign: TextAlign.Start }
          Text('Order #25491')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3D2B2A')
            .textAlign(TextAlign.Start)

          // === Text ===
          // props: { text: 'Estimated Delivery: 2 days' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, color: '#FFB74D', textAlign: TextAlign.Start }
          Text('Estimated Delivery: 2 days')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#FFB74D')
            .textAlign(TextAlign.Start)

          // === Progress ===
          // props: { value: this.progress, total: 100, type: ProgressType.Linear }
          // modifier: { width: '100%', height: 10, color: '#FF7043', trackColor: '#FFE0B2' }
          Progress({ value: this.progress, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(10)
            .color('#FF7043')
            .backgroundColor('#FFE0B2')

          // === Row ===
          // props: { space: 0 }
          // modifier: { width: '100%' }
          // children: 2
          Row() {
            // === Text ===
            // props: { text: 'Processing' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#FFB74D' }
            Text('Processing')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFB74D')

            // === Blank ===
            Blank()

            // === Text ===
            // props: { text: '42%' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#FF7043' }
            Text(`${this.progress}%`)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF7043')
          }.width('100%')
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 8, color: '#26000000', offsetY: 4 })

        // === Column (Card 2) ===
        // props: { space: 10 }
        // modifier: { width: '100%', padding: 16, backgroundColor: '#FFFFFF', borderRadius: 16 }
        // children: 3
        Column({ space: 10 }) {
          // === Text ===
          // props: { text: 'Adjust Progress' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#3D2B2A', textAlign: TextAlign.Center }
          Text('Adjust Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3D2B2A')
            .textAlign(TextAlign.Center)

          // === Slider ===
          // props: { value: this.progress, min: 0, max: 100 }
          // modifier: { width: '100%', selectedColor: '#FF7043', unselectedColor: '#FFE0B2' }
          Slider({ value: this.progress, min: 0, max: 100 })
            .width('100%')
            .selectedColor('#FF7043')
            .trackColor('#FFE0B2')

          // === Button ===
          // modifier: { width: '100%', height: 40, backgroundColor: '#FF7043', borderRadius: 10 }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Mark as Delivered' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#FFFFFF' }
            Text('Mark as Delivered')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
          .width('100%')
          .height(40)
          .backgroundColor('#FF7043')
          .borderRadius(10)
          .onClick(() => {
            this.progress = 100
          })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFF5E6')
    }
    .width('100%')
    .height('100%')
  }
}