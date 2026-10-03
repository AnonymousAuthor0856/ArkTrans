interface LiveItem {
  id: number;
  title: string;
  viewers: number;
  price: string;
}

@Entry
@Component
struct LiveShopEvents {
  @State liveList: Array<LiveItem> = [
    { id: 1, title: "Smartphone Flash Deal", viewers: 1234, price: "$699" },
    { id: 2, title: "Gaming Chair Special", viewers: 880, price: "$249" },
    { id: 3, title: "Headphones Clearance", viewers: 1640, price: "$99" },
    { id: 4, title: "Mechanical Keyboard", viewers: 512, price: "$129" }
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Header
        Text('Live Shop Events')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E3A8A')
          .margin({ left: 16, right: 16, top: 16, bottom: 10 })

        // List
        List({ space: 10 }) {
          ForEach(this.liveList, (item: LiveItem) => {
            ListItem() {
              Column() {
                // Image Placeholder
                Row()
                  .width('100%')
                  .height(160)
                  .backgroundColor('#3B82F6')
                  .borderRadius(10)

                // Title
                Text(item.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                  .margin({ top: 10, bottom: 0 })

                // Viewers
                Text(`${item.viewers} viewers`)
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .fontColor('#60A5FA')
                  .margin({ top: 0, bottom: 10 })

                // Price and Button Row
                Row() {
                  Text(item.price)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1E3A8A')
                  
                  Blank()

                  Button('Join Live')
                    .backgroundColor('#1E3A8A')
                    .fontColor('#FFF')
                    .borderRadius(10)
                    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                }.width('100%')
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFF')
              .borderRadius(16)
              .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
            }
          }, (item: LiveItem) => item.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, bottom: 96 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F8FF')

      // Floating Action Button
      Button('+')
        .width(56)
        .height(56)
        .backgroundColor('#3B82F6')
        .fontColor('#FFF')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .borderRadius(28)
        .shadow({ radius: 6, color: '#3F000000' })
        .margin(24)

      // Bottom Navigation Bar
      Row() {
        Text('Home')
          .fontSize(14)
          .fontColor('#1E3A8A')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        
        Text('Live')
          .fontSize(14)
          .fontColor('#0B1220')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
          
        Text('Cart')
          .fontSize(14)
          .fontColor('#0B1220')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
          
        Text('Profile')
          .fontSize(14)
          .fontColor('#0B1220')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
      }
      .width('100%')
      .height(60)
      .backgroundColor('#FFF')
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}