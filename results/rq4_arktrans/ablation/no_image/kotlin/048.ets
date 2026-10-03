@Entry
@Component
struct Index {
  @State itemTitle: string = 'item.title'
  @State itemPrice: string = 'item.price'
  @State itemViewers: number = 0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 10 }) {
        Text('Live Shop Events')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E3A8A')

        List({ space: 10 }) {
          ListItem() {
            Column() {
              Column({ space: 6 }) {
                Stack({ alignContent: Alignment.Center }) {
                  // Placeholder for image/content as per skeleton structure
                }
                .width('100%')
                .height(160)
                .backgroundColor('#3B82F6')
                .borderRadius(8)

                Text(this.itemTitle)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#0B1220')

                Text(`${this.itemViewers} viewers`)
                  .fontSize(14)
                  .fontColor('#60A5FA')

                Row({ space: 0 }) {
                  Text(this.itemPrice)
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#1E3A8A')

                  Blank()

                  Button() {
                    Text('Join Live')
                      .fontSize(14)
                      .fontColor('#FFFFFF')
                  }
                  .backgroundColor('#3B82F6')
                  .borderRadius(8)
                  .onClick(() => {
                    // onClick handler
                  })
                }
                .alignItems(VerticalAlign.Center)
                .width('100%')
              }
              .width('100%')
              .padding(16)
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
          }
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#F5F8FF', 0], ['#E2E8F0', 0.5], ['#F5F8FF', 1]]
      })

      Button() {
        Text('+')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .type(ButtonType.Circle)
      .backgroundColor('#3B82F6')
      .position({ x: 'calc(100% - 72px)', y: 'calc(100% - 120px)' })
      .onClick(() => {
        // onClick handler
      })

      Row({ space: 0 }) {
        Text('Home')
          .fontSize(14)
          .fontColor('#1E3A8A')
        
        Text('Live')
          .fontSize(14)
          .fontColor('#0B1220')
          
        Text('Cart')
          .fontSize(14)
          .fontColor('#0B1220')
          
        Text('Profile')
          .fontSize(14)
          .fontColor('#0B1220')
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#FFFFFF')
      .position({ x: 0, y: 'calc(100% - 60px)' })
    }
    .width('100%')
    .height('100%')
  }
}