@Entry
@Component
struct Index {
  @State progress: number = 0.42

  build() {
    Stack() {
      Column({ space: 24 }) {
        Text('Order Tracking')
          .width('100%')
          .textAlign(TextAlign.Start)
          .fontColor('#3D2623')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)

        // Card 1: Order Info
        Column({ space: 16 }) {
          Text('Order #25491')
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontColor('#3D2623')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)

          Text('Estimated Delivery: 2 days')
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontColor('#FFB74C')
            .fontSize(16)

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            Rect().fill('#FFE0B2').height(10).borderRadius(5)
            Rect().fill('#FF7042').height(10).borderRadius(5).width(`${this.progress * 100}%`)
          }.width('100%')

          Row() {
            Text('Processing').fontColor('#FFB74C').fontSize(14)
            Blank()
            Text(`${Math.round(this.progress * 100)}%`).fontColor('#FF7042').fontSize(14)
          }.width('100%')
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .shadow({ radius: 10, color: '#1F000000', offsetY: 4 })

        // Card 2: Adjust Progress
        Column({ space: 24 }) {
          Text('Adjust Progress')
            .width('100%')
            .textAlign(TextAlign.Center)
            .fontColor('#3D2623')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)

          // Custom Slider
          Stack({ alignContent: Alignment.Start }) {
            Rect().fill('#FFE0B2').height(10).borderRadius(5)
            Rect().fill('#FF7042').height(10).borderRadius(5).width(`${this.progress * 100}%`)
            
            Circle()
              .fill('#FF7042')
              .width(24)
              .height(24)
              .margin({ left: `${this.progress * 100}%` })
              .translate({ x: -12 })
              .shadow({ radius: 4, color: '#1F000000' })
              .onTouch((event: TouchEvent) => {
                if (event.type === TouchType.Down || event.type === TouchType.Move) {
                  const location = event.touches[0].windowX
                  // Approximate calculation based on screen width for simplicity in this context
                  // In a real app, use GeometryReader or getComponentRect
                  let val = location / 375 // Assuming standard width, adjust as needed
                  if (val < 0) val = 0
                  if (val > 1) val = 1
                  this.progress = val
                }
              })
          }
          .width('100%')
          .height(40) // Hit area height

          Button('Mark as Delivered')
            .width('100%')
            .height(48)
            .backgroundColor('#FF7042')
            .borderRadius(16)
            .fontColor('#FFFFFF')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.progress = 1.0
            })
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#FFF3E0')
    }
    .width('100%')
    .height('100%')
  }
}