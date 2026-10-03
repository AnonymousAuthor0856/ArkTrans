interface PinItem {
  label: string
}

@Entry
@Component
struct Index {
  @State pins: Array<PinItem> = [
    { label: "Group A" },
    { label: "Group B" },
    { label: "Group C" }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Text('Retro Group Buy')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')

        // Card 1: Live Deals Map
        Column() {
          Column({ space: 10 }) {
            Text('Live Deals Map')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#3E2723')

            // Map Area with Pins
            Stack({ alignContent: Alignment.Center }) {
              // Pin 1 (Top Leftish)
              Circle().width(14).height(14).fill('#FF8C00').position({ x: '30%', y: '30%' })
              // Pin 2 (Bottom Center)
              Circle().width(14).height(14).fill('#FF8C00').position({ x: '50%', y: '90%' })
              // Pin 3 (Right Middle)
              Circle().width(14).height(14).fill('#FF8C00').position({ x: '85%', y: '60%' })
            }
            .width('100%')
            .height(220)
            .backgroundColor('#FFE0B2')
            .borderRadius(12)
          }
          .width('100%')
          .padding(16)
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .shadow({ radius: 10, color: '#1A000000' })

        Blank().height(16)

        // Buttons Row
        Row({ space: 16 }) {
          Button('Add Group')
            .layoutWeight(1)
            .height(48)
            .backgroundColor('#FFC107')
            .borderRadius(12)
            .fontColor('#3E2723')
            .fontWeight(FontWeight.Medium)

          Button('Clear')
            .layoutWeight(1)
            .height(48)
            .backgroundColor('#FF8C00')
            .borderRadius(12)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')

        // Card 2: Active Groups
        Column() {
          Column({ space: 6 }) {
            Text('Active Groups')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF8C00')

            ForEach(this.pins, (item: PinItem) => {
              Row({ space: 0 }) {
                Text(item.label)
                  .fontSize(18)
                  .fontColor('#3E2723')
                  .layoutWeight(1)
                
                Circle()
                  .width(14)
                  .height(14)
                  .fill('#FF8C00')
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
            })
          }
          .width('100%')
          .padding(16)
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .shadow({ radius: 10, color: '#1A000000' })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFF8E1')
    }
    .width('100%')
    .height('100%')
  }
}