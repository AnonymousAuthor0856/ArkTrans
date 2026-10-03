@Entry
@Component
struct Index {
  @State pins: string[] = ['Group A', 'Group B', 'Group C']

  build() {
    Stack() {
      Column({ space: 24 }) {
        Text('Retro Group Buy')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')
          .width('100%')
          .textAlign(TextAlign.Start)

        // Live Deals Map Card
        Column() {
          Text('Live Deals Map')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3E2723')
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: 16 })

          Stack() {
            // Simulating the map area with a colored background
            Row()
              .width('100%')
              .height('100%')
              .backgroundColor('#FFE082')
          }
          .width('100%')
          .height(220)
          .borderRadius(16)
          .padding(8)
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .shadow({ radius: 10, color: '#1F000000', offsetY: 4 })

        // Action Buttons
        Row({ space: 16 }) {
          Button() {
            Text('Add Group')
              .fontSize(16)
              .fontColor('#3E2723')
              .fontWeight(FontWeight.Medium)
          }
          .width('50%')
          .height(48)
          .backgroundColor('#FFC107')
          .borderRadius(12)

          Button() {
            Text('Clear')
              .fontSize(16)
              .fontColor('#3E2723')
              .fontWeight(FontWeight.Medium)
          }
          .width('50%')
          .height(48)
          .backgroundColor('#FF8C00')
          .borderRadius(12)
        }
        .width('100%')

        // Active Groups Card
        Column() {
          Text('Active Groups')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF8C00')
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: 16 })

          Column({ space: 12 }) {
            ForEach(this.pins, (pin: string) => {
              Row() {
                Text(pin)
                  .fontSize(16)
                  .fontColor('#3E2723')
                
                Blank()

                Circle()
                  .width(14)
                  .height(14)
                  .fill('#FF8C00')
              }
              .width('100%')
            })
          }
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .shadow({ radius: 10, color: '#1F000000', offsetY: 4 })

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .backgroundColor('#FFF8E1')
    }
    .width('100%')
    .height('100%')
  }
}