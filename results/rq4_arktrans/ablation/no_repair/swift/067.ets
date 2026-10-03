@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        // Header
        Stack() {
          Text('Client Detail')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#3E2723')
            .textAlign(TextAlign.Center)
            .width('100%')
        }
        .height(56)
        .width('100%')

        Scroll() {
          Column() {
            // Regional Client Map Card
            Text('Regional Client Map')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .textAlign(TextAlign.Center)
              .width('100%')
              .height(200)
              .borderRadius(24)
              .linearGradient({
                angle: 90,
                colors: [['#FFB74D', 0], ['#FF7043', 1]]
              })
              .margin({ top: 8, left: 12, right: 12 })

            // Map Area
            Stack() {
              // Grid Background
              Column() {
                Row().height(1).width('100%').backgroundColor('#FFE0B2')
                Row().height(1).width('100%').backgroundColor('#FFE0B2')
                Row().height(1).width('100%').backgroundColor('#FFE0B2')
                Row().height(1).width('100%').backgroundColor('#FFE0B2')
                Row().height(1).width('100%').backgroundColor('#FFE0B2')
              }.width('100%').layoutWeight(1)

              Column() {
                Column().width(1).height('100%').backgroundColor('#FFE0B2')
                Column().width(1).height('100%').backgroundColor('#FFE0B2')
                Column().width(1).height('100%').backgroundColor('#FFE0B2')
                Column().width(1).height('100%').backgroundColor('#FFE0B2')
              }.height('100%').layoutWeight(1)

              // Markers
              // Sunrise Tech (Top Leftish)
              Stack({ alignContent: Alignment.Start }) {
                Circle().width(24).height(24).fill('#FF7043')
                Text('Sunrise Tech')
                  .fontSize(16)
                  .fontColor('#5D4037')
                  .padding({ left: 8, right: 12, top: 4, bottom: 4 })
                  .backgroundColor('#FFE0B2')
                  .borderRadius(12)
                  .shadow({ radius: 4, color: '#40000000', offsetY: 2 })
              }
              .position({ x: '25%', y: '25%' })

              // Delta Logistics (Middle Center)
              Stack({ alignContent: Alignment.Start }) {
                Circle().width(24).height(24).fill('#FFB74D')
                Text('Delta Logistics')
                  .fontSize(16)
                  .fontColor('#5D4037')
                  .padding({ left: 8, right: 12, top: 4, bottom: 4 })
                  .backgroundColor('#FFE0B2')
                  .borderRadius(12)
                  .shadow({ radius: 4, color: '#40000000', offsetY: 2 })
              }
              .position({ x: '45%', y: '45%' })

              // Oceanic Foods (Right Middle)
              Stack({ alignContent: Alignment.Start }) {
                Circle().width(24).height(24).fill('#FF7043')
                Text('Oceanic Foods')
                  .fontSize(16)
                  .fontColor('#5D4037')
                  .padding({ left: 8, right: 12, top: 4, bottom: 4 })
                  .backgroundColor('#FFE0B2')
                  .borderRadius(12)
                  .shadow({ radius: 4, color: '#40000000', offsetY: 2 })
              }
              .position({ x: '75%', y: '60%' })

              // Horizon Ltd. (Bottom Leftish)
              Stack({ alignContent: Alignment.Start }) {
                Circle().width(24).height(24).fill('#FFCA28')
                Text('Horizon Ltd.')
                  .fontSize(16)
                  .fontColor('#5D4037')
                  .padding({ left: 8, right: 12, top: 4, bottom: 4 })
                  .backgroundColor('#FFE0B2')
                  .borderRadius(12)
                  .shadow({ radius: 4, color: '#40000000', offsetY: 2 })
              }
              .position({ x: '35%', y: '80%' })

            }
            .width('100%')
            .height(360)
            .borderRadius(24)
            .border({ width: 1, color: '#FFE0B2' })
            .margin({ top: 12, left: 12, right: 12 })
            .backgroundColor('#FFF8E1')

          }
          .padding({ bottom: 32 })
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFF8E1')
    }
    .width('100%')
    .height('100%')
  }
}