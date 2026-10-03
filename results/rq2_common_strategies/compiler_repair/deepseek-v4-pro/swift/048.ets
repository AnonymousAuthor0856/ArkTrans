@Entry
@Component
struct RootScreen {
  private liveList: LiveItem[] = [
    { id: 1, title: "Smartphone Flash Deal", viewers: 1234, price: "$699" },
    { id: 2, title: "Gaming Chair Special", viewers: 880, price: "$249" },
    { id: 3, title: "Headphones Clearance", viewers: 1640, price: "$99" },
    { id: 4, title: "Mechanical Keyboard", viewers: 512, price: "$129" }
  ]

  build() {
    Stack() {
      // Main content area with gradient background
      Column({ space: 10 }) {
        Text('Live Shop Events')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#FF1E3A8A')

        // Scrollable list of cards
        List({ space: 10 }) {
          ForEach(this.liveList, (item: LiveItem) => {
            ListItem() {
              Column({ space: 6 }) {
                // Image placeholder
                Button() { }
                  .width('100%')
                  .height(160)
                  .backgroundColor('#FF3B82F6')
                  .borderRadius(10)

                Text(item.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FF0B1220')

                Text(item.viewers.toString() + ' viewers')
                  .fontSize(14)
                  .fontWeight(FontWeight.Regular)
                  .foregroundColor('#FF60A5FA')

                Row({ space: 0 }) {
                  Text(item.price)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#FF1E3A8A')

                  Blank().layoutWeight(1)

                  Button() {
                    Text('Join Live')
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .foregroundColor('#FFFFFFFF')
                      .padding({ top: 8, bottom: 8, left: 16, right: 16 })
                  }
                  .backgroundColor('#FF1E3A8A')
                  .borderRadius(10)
                  .onClick(() => {})
                }
                .width('100%')
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFFFF')
              .borderRadius(16)
              .shadow({
                radius: 4,
                color: 'rgba(0,0,0,0.12)',
                offsetX: 0,
                offsetY: 2
              })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: 96 }) // space for FAB and bottom bar
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .linearGradient({
        colors: [['#FFF5F8FF', 0], ['#FFE8EEFA', 0.5], ['#FFF5F8FF', 1]],
        direction: GradientDirection.Bottom
      })

      // FAB button positioned bottom right
      Column() {
        Blank().layoutWeight(1)
        Row() {
          Blank().layoutWeight(1)
          Button() {
            Text('+')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FFFFFFFF')
          }
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor('#FF3B82F6')
          .margin({ right: 16, bottom: 112 }) // 96 + 16 for bottom bar height
          .onClick(() => {})
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom navigation bar
      Column() {
        Blank().layoutWeight(1)
        Row({ space: 0 }) {
          Blank().layoutWeight(1)
          Text('Home')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .foregroundColor('#FF1E3A8A')
          Blank().layoutWeight(1)
          Text('Live')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .foregroundColor('#FF0B1220')
          Blank().layoutWeight(1)
          Text('Cart')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .foregroundColor('#FF0B1220')
          Blank().layoutWeight(1)
          Text('Profile')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .foregroundColor('#FF0B1220')
          Blank().layoutWeight(1)
        }
        .width('100%')
        .height(80)
        .backgroundColor('#FFFFFFFF')
        .shadow({ radius: 0.5, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: -1 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF5F8FF')
  }
}

interface LiveItem {
  id: number
  title: string
  viewers: number
  price: string
}