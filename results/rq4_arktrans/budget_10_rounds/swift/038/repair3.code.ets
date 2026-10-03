@Entry
@Component
struct Index {
  @State scanning: boolean = false

  build() {
    Stack() {
      Column() {
        // Header
        Text('Invoice Scanner')
          .backgroundColor('#F0F9FF')
          .padding({ top: 12, bottom: 12 })
          .width('100%')
          .fontColor('#0F172A')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)

        // Main Content Area with Gradient Background
        Column() {
          // Surface View (Card)
          Column() {
            // Canvas / Scanning Area
            Stack() {
              // Large light blue circle background
              Circle()
                .width('60%')
                .height('60%')
                .fill('#E0F2FE')

              // Center dot marker
              Circle()
                .width(24)
                .height(24)
                .fill('#06B6D4')
            }
            .width('100%')
            .height('100%')
            .alignContent(Alignment.Center)
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .height(400)
          .backgroundColor('#FAFAFA')
          .borderRadius(32)
          .shadow({ radius: 10, color: '#1F000000', offsetY: 4 })
          .margin({ top: 24, bottom: 24 })

          // Controls Row
          Row() {
            Text('Scanning Active')
              .fontColor('#0F172A')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
            
            Blank()

            // Custom Toggle Implementation
            Stack() {
              if (this.scanning) {
                Circle()
                  .width(24)
                  .height(24)
                  .fill('#3B82F6')
                  .position({ x: 28, y: 4 })
              } else {
                Circle()
                  .width(24)
                  .height(24)
                  .fill('#BAE6FD')
                  .position({ x: 4, y: 4 })
              }
              
              Capsule()
                .width(52)
                .height(32)
                .fill(this.scanning ? '#3B82F6' : '#E0F2FE')
                .onClick(() => {
                  this.scanning = !this.scanning
                })
            }
            .width(52)
            .height(32)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: 16 })

          // Action Button
          Button('Add Marker')
            .width('100%')
            .height(48)
            .backgroundColor('#06B6D4')
            .fontColor('#FFFFFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .borderRadius(16)
        }
        .width('100%')
        .layoutWeight(1)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#DBEAFE', 0], ['#CCFBF1', 1]]
        })
        .padding(16)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}