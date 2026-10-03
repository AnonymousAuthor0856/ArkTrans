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

class AppColors {
  static readonly primary: string = '#1E3A8A'
  static readonly secondary: string = '#3B82F6'
  static readonly tertiary: string = '#60A5FA'
  static readonly background: string = '#F5F8FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E8EEFA'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSurface: string = '#0B1220'
}

@Entry
@Component
struct RootScreen {
  private liveList: LiveItem[] = [
    new LiveItem(1, 'Smartphone Flash Deal', 1234, '$699'),
    new LiveItem(2, 'Gaming Chair Special', 880, '$249'),
    new LiveItem(3, 'Headphones Clearance', 1640, '$99'),
    new LiveItem(4, 'Mechanical Keyboard', 512, '$129')
  ]

  @Builder
  LiveCard(item: LiveItem) {
    Column({ space: 6 }) {
      Blank()
        .width('100%')
        .height(160)
        .backgroundColor(AppColors.secondary)
        .borderRadius(10)

      Text(item.title)
        .width('100%')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .margin({ top: 4 })

      Text(`${item.viewers} viewers`)
        .width('100%')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.tertiary)

      Row() {
        Text(item.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        Button('Join Live')
          .width(96)
          .height(40)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(10)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 12 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  BottomNavigation() {
    Row() {
      Text('Home')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.primary)

      Text('Live')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)

      Text('Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)

      Text('Profile')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(64)
    .padding({ left: 20, right: 20 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column({ space: 10 }) {
        Text('Live Shop Events')
          .width('100%')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .margin({ bottom: 16 })

        List({ space: 10 }) {
          ForEach(this.liveList, (item: LiveItem) => {
            ListItem() {
              this.LiveCard(item)
            }
          }, (item: LiveItem) => item.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .edgeEffect(EdgeEffect.None)
        .padding({ bottom: 96 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 22, bottom: 64 })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.background, 0.0],
          [AppColors.surfaceVariant, 0.5],
          [AppColors.background, 1.0]
        ]
      })

      this.BottomNavigation()

      Button('+')
        .width(56)
        .height(56)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(28)
        .shadow({
          radius: 10,
          color: '#33000000',
          offsetX: 0,
          offsetY: 6
        })
        .margin({ right: 16, bottom: 56 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
