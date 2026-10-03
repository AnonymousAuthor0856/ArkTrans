interface Item {
  title: string;
  viewers: number;
  price: string;
}

@Entry
@Component
struct Index {
  @State items: Array<Item> = [
    { title: 'Smartphone Flash Deal', viewers: 1234, price: '$699' },
    { title: 'Headphones Sale', viewers: 850, price: '$199' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 10 }) {
        Text('Live Shop Events')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E3A8A')
          .margin({ bottom: 10 })

        List({ space: 10 }) {
          ForEach(this.items, (item: Item) => {
            ListItem() {
              Column() {
                // Image placeholder
                Stack({ alignContent: Alignment.Center }) {
                  Text('Image Placeholder')
                    .fontColor('#FFFFFF')
                }
                .width('100%')
                .height(160)
                .backgroundColor('#3B82F6')
                .borderRadius({ topLeft: 12, topRight: 12 })

                Column({ space: 6 }) {
                  Text(item.title)
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0B1220')

                  Text(`${item.viewers} viewers`)
                    .fontSize(14)
                    .fontColor('#60A5FA')

                  Row({ space: 0 }) {
                    Text(item.price)
                      .fontSize(20)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#1E3A8A')

                    Blank()

                    Button() {
                      Text('Join Live')
                        .fontSize(14)
                        .fontColor('#FFFFFF')
                    }
                    .backgroundColor('#1E3A8A')
                    .borderRadius(12)
                    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
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
          }, (item: Item) => item.title)
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

      // Floating Action Button
      Button() {
        Text('+')
          .fontSize(24)
          .fontColor('#FFFFFF')
      }
      .width(56)
      .height(56)
      .backgroundColor('#3B82F6')
      .borderRadius(28)
      .position({ x: 'calc(100% - 72px)', y: 'calc(100% - 128px)' })
      .shadow({ radius: 8, color: '#3F000000' })

      // Bottom Navigation Bar
      Row({ space: 0 }) {
        Text('Home')
          .fontSize(16)
          .fontColor('#1E3A8A')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
          .padding({ top: 16, bottom: 16 })

        Text('Live')
          .fontSize(16)
          .fontColor('#0B1220')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
          .padding({ top: 16, bottom: 16 })

        Text('Cart')
          .fontSize(16)
          .fontColor('#0B1220')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
          .padding({ top: 16, bottom: 16 })

        Text('Profile')
          .fontSize(16)
          .fontColor('#0B1220')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
          .padding({ top: 16, bottom: 16 })
      }
      .width('100%')
      .height(64)
      .backgroundColor('#FFFFFF')
      .position({ x: 0, y: 'calc(100% - 64px)' })
    }
    .width('100%')
    .height('100%')
  }
}