class LiveItem {
  id: number
  title: string
  viewers: number
  price: string

  constructor(id: number, title: string, viewers: number, price: string) {
    this.id = id
    this.title = title
    this.viewers = viewers
    this.price = price
  }
}

@Entry
@Component
struct Index {
  private liveList: LiveItem[] = [
    new LiveItem(1, 'Smartphone Flash Deal', 1234, '$699'),
    new LiveItem(2, 'Gaming Chair Special', 880, '$249'),
    new LiveItem(3, 'Headphones Clearance', 1640, '$99'),
    new LiveItem(4, 'Mechanical Keyboard', 512, '$129')
  ]

  @Builder
  LiveItemCard(item: LiveItem) {
    Column() {
      Rect()
        .width('100%')
        .height(160)
        .radius(10)
        .fill('#3B82F6')

      Text(item.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0B1220')
        .width('100%')
        .margin({ top: 6 })

      Text(`${item.viewers} viewers`)
        .fontSize(14)
        .fontColor('#60A5FA')
        .width('100%')
        .margin({ top: 6 })

      Row() {
        Text(item.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E3A8A')
          .layoutWeight(1)

        Button('Join Live')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .height(34)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#1E3A8A')
          .borderRadius(10)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 6 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }

  @Builder
  BottomNavBar() {
    Row() {
      Text('Home')
        .fontSize(14)
        .fontColor('#1E3A8A')
      Blank()
      Text('Live')
        .fontSize(14)
        .fontColor('#0B1220')
      Blank()
      Text('Cart')
        .fontSize(14)
        .fontColor('#0B1220')
      Blank()
      Text('Profile')
        .fontSize(14)
        .fontColor('#0B1220')
    }
    .width('100%')
    .height(80)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 1, color: '#1A000000', offsetY: -1 })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Text('Live Shop Events')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E3A8A')
          .width('100%')

        Scroll() {
          Column() {
            ForEach(this.liveList, (item: LiveItem) => {
              Column() {
                this.LiveItemCard(item)
              }
              .margin({ bottom: 10 })
            }, (item: LiveItem) => item.id.toString())
            Blank().height(96)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .margin({ top: 10 })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [['#F5F8FF', 0.0], ['#E8EEFA', 0.5], ['#F5F8FF', 1.0]]
      })

      Column() {
        this.BottomNavBar()
      }
      .width('100%')
      .alignSelf(ItemAlign.End)

      Button('+')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .width(56)
        .height(56)
        .backgroundColor('#3B82F6')
        .borderRadius(28)
        .margin({ right: 16, bottom: 96 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F8FF')
  }
}
