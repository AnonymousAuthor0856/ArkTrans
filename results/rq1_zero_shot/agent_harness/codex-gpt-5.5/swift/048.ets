class LiveItem {
  id: number;
  title: string;
  viewers: number;
  price: string;

  constructor(id: number, title: string, viewers: number, price: string) {
    this.id = id;
    this.title = title;
    this.viewers = viewers;
    this.price = price;
  }
}

@Entry
@Component
struct RootScreen {
  private liveList: LiveItem[] = [
    new LiveItem(1, 'Smartphone Flash Deal', 1234, '$699'),
    new LiveItem(2, 'Gaming Chair Special', 880, '$249'),
    new LiveItem(3, 'Headphones Clearance', 1640, '$99'),
    new LiveItem(4, 'Mechanical Keyboard', 512, '$129')
  ];

  @Builder
  LiveItemCard(item: LiveItem) {
    Column() {
      Rect()
        .width('100%')
        .height(160)
        .fill('#3B82F6')
        .radius(10)
      Text(item.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0B1220')
        .margin({ top: 6 })
      Text(item.viewers.toString() + ' viewers')
        .fontSize(14)
        .fontColor('#60A5FA')
        .margin({ top: 6 })
      Row() {
        Text(item.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E3A8A')
        Blank()
        Button('Join Live')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#1E3A8A')
          .height(34)
          .padding({ left: 16, right: 16 })
          .borderRadius(10)
      }
      .width('100%')
      .margin({ top: 6 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  BottomNavBar() {
    Row() {
      Blank()
      Text('Home').fontSize(14).fontColor('#1E3A8A')
      Blank()
      Text('Live').fontSize(14).fontColor('#0B1220')
      Blank()
      Text('Cart').fontSize(14).fontColor('#0B1220')
      Blank()
      Text('Profile').fontSize(14).fontColor('#0B1220')
      Blank()
    }
    .width('100%')
    .height(80)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 0.5, color: '#1A000000', offsetX: 0, offsetY: -1 })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column() {
          Text('Live Shop Events')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E3A8A')
            .width('100%')
          Scroll() {
            Column() {
              ForEach(this.liveList, (item: LiveItem) => {
                this.LiveItemCard(item)
                  .margin({ bottom: 10 })
              }, (item: LiveItem) => item.id.toString())
              Blank().height(96)
            }
            .width('100%')
          }
          .layoutWeight(1)
          .margin({ top: 10 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .backgroundColor('#F5F8FF')
        this.BottomNavBar()
      }
      .width('100%')
      .height('100%')

      Button('+')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#3B82F6')
        .width(56)
        .height(56)
        .borderRadius(28)
        .margin({ right: 16, bottom: 96 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F8FF')
  }
}
