class LiveItem {
  id: number
  title: string
  viewers: string
  price: string

  constructor(id: number, title: string, viewers: string, price: string) {
    this.id = id
    this.title = title
    this.viewers = viewers
    this.price = price
  }
}

@Entry
@Component
struct LiveShopApp {
  private readonly primary: string = '#1E3A8A'
  private readonly secondary: string = '#3B82F6'
  private readonly tertiary: string = '#60A5FA'
  private readonly appBackground: string = '#F5F8FF'
  private readonly surface: string = '#FFFFFF'
  private readonly surfaceVariant: string = '#E8EEFA'
  private readonly ink: string = '#0B1220'

  @State private liveList: LiveItem[] = [
    new LiveItem(1, 'Smartphone Flash Deal', '1,234 viewers', '$699'),
    new LiveItem(2, 'Gaming Chair Special', '880 viewers', '$249'),
    new LiveItem(3, 'Headphones Clearance', '1,640 viewers', '$99'),
    new LiveItem(4, 'Mechanical Keyboard', '512 viewers', '$129')
  ]

  @Builder
  private liveCard(item: LiveItem) {
    Column() {
      Blank()
        .width('100%')
        .height(320)
        .backgroundColor(this.secondary)
        .borderRadius(22)

      Text(item.title)
        .fontSize(36)
        .fontColor(this.ink)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ top: 12 })

      Text(item.viewers)
        .fontSize(28)
        .fontColor(this.tertiary)
        .width('100%')
        .margin({ top: 10 })

      Row() {
        Text(item.price)
          .fontSize(36)
          .fontColor(this.primary)
          .fontWeight(FontWeight.Medium)

        Blank()

        Button('Join Live', { type: ButtonType.Normal })
          .width(168)
          .height(61)
          .fontSize(24)
          .fontColor('#FFFFFF')
          .backgroundColor(this.primary)
          .borderRadius(20)
          .onClick(() => {})
      }
      .width('100%')
      .height(61)
      .margin({ top: 12 })
    }
    .width('100%')
    .padding(32)
    .backgroundColor(this.surface)
    .borderRadius(32)
    .shadow({
      radius: 8,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  private bottomBar() {
    Row() {
      Text('Home')
        .fontSize(26)
        .fontColor(this.primary)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Live')
        .fontSize(26)
        .fontColor(this.ink)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Cart')
        .fontSize(26)
        .fontColor(this.ink)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Profile')
        .fontSize(26)
        .fontColor(this.ink)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(160)
    .backgroundColor(this.surface)
    .shadow({
      radius: 2,
      color: '#19000000',
      offsetX: 0,
      offsetY: -2
    })
    .padding({ top: 54, bottom: 30 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Text('Live Shop Events')
          .fontSize(54)
          .fontColor(this.primary)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .margin({ bottom: 24 })

        Scroll() {
          Column({ space: 20 }) {
            ForEach(this.liveList, (item: LiveItem) => {
              this.liveCard(item)
            }, (item: LiveItem) => item.id.toString())
          }
          .width('100%')
          .padding({ bottom: 190 })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding({ left: 32, right: 32, top: 28 })
      .backgroundColor(this.appBackground)

      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(112)
          .height(112)
          .fill(this.secondary)

        Text('+')
          .fontSize(40)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Medium)
      }
        .width(112)
        .height(112)
        .position({ x: 606, y: 1034 })
        .onClick(() => {})

      this.bottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.appBackground)
  }
}
