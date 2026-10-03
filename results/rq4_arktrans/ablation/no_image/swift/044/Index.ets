@Entry
@Component
struct Index {
  @State progress: number = 0.5
  @State value: number = 0.5

  build() {
    Stack() {
      Column({ space: 24 }) {
        Text('Order Tracking')
          .width('100%')
          .textAlign(TextAlign.Start)
          .fontColor('#3D2623')
          .fontSize(28)

        Column({ space: 16 }) {
          Text('Order #25491')
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontColor('#3D2623')
            .fontSize(18)

          Text('Estimated Delivery: 2 days')
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontColor('#757575')
            .fontSize(14)

          Stack({ alignContent: Alignment.Start }) {
            Rect()
              .height(10)
              .fill('#FFE0B2')
              .borderRadius(5)

            Rect()
              .width(`${this.progress * 100}%`)
              .height(10)
              .fill('#FF7042')
              .borderRadius(5)
          }

          Row() {
            Text('Processing')
              .fontColor('#FFB74C')
              .fontSize(12)

            Blank()

            Text(`${Math.round(this.progress * 100)}%`)
              .fontColor('#FF7042')
              .fontSize(12)
          }
        }
        .padding(24)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.15)', offsetX: 0, offsetY: 4 })

        Column({ space: 16 }) {
          Text('Adjust Progress')
            .width('100%')
            .textAlign(TextAlign.Center)
            .fontColor('#3D2623')
            .fontSize(18)

          Stack({ alignContent: Alignment.Start }) {
            // Track Background
            Rect()
              .height(10)
              .fill('#E0E0E0')
              .borderRadius(5)

            // Active Track
            Rect()
              .width(`${this.value * 100}%`)
              .height(10)
              .fill('#FF7042')
              .borderRadius(5)

            // Thumb
            Circle()
              .width(24)
              .height(24)
              .fill('#FFFFFF')
              .shadow({ radius: 2, color: '#000000', offsetX: 0, offsetY: 1 })
              .margin({ left: `${this.value * 100}%` })
              .translate({ x: -12 })
              .gesture(
                PanGesture()
                  .onActionEnd((event?: GestureEvent) => {
                    if (event) {
                      let newX = event.offsetX + (this.value * 100); 
                      // Simplified gesture logic for ArkTS compatibility without complex geometry calculations in UI thread
                      // In a real app, use Slider component or more robust gesture handling
                    }
                  })
              )
          }
          .width('100%')
          .height(40)
          .alignItems(HorizontalAlign.Start)

          Button() {
            Text('Complete Order')
              .fontColor('#FF7042')
          }
          .type(ButtonType.Normal)
          .backgroundColor('transparent')
          .onClick(() => {
            this.value = 1.0
            this.progress = 1.0
          })
        }
        .padding(24)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
      }
      .padding(24)
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
  }
}