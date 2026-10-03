// Design tokens
class ColorsClass {
  primary: string = '#1E3A8A'
  secondary: string = '#3B82F6'
  tertiary: string = '#60A5FA'
  background: string = '#F5F8FF'
  surface: string = '#FFFFFF'
  surfaceVariant: string = '#E8EEFA'
  outline: string = '#CBD5E1'
  success: string = '#22C55E'
  warning: string = '#F59E0B'
  error: string = '#EF4444'
  onPrimary: string = '#FFFFFF'
  onSecondary: string = '#FFFFFF'
  onTertiary: string = '#0B1220'
  onBackground: string = '#0B1220'
  onSurface: string = '#0B1220'
}

class SpacingClass {
  sm: number = 6
  md: number = 10
  lg: number = 16
  xl: number = 24
  xxl: number = 36
}

class MaterialDefaultsClass {
  bottomAppBarHeight: number = 80
  fabSize: number = 56
  buttonHorizontalPadding: number = 16
  buttonVerticalPadding: number = 8
  fabBottomMargin: number = 16
  fabTrailingMargin: number = 16
  lazyColumnContentBottomPadding: number = 96
}

const Colors: ColorsClass = new ColorsClass()
const SpacingTokens: SpacingClass = new SpacingClass()
const MaterialDefaults: MaterialDefaultsClass = new MaterialDefaultsClass()

class LiveItem {
  id: number = 0
  title: string = ''
  viewers: number = 0
  price: string = ''

  constructor(id: number, title: string, viewers: number, price: string) {
    this.id = id
    this.title = title
    this.viewers = viewers
    this.price = price
  }
}

const liveList: LiveItem[] = [
  new LiveItem(1, 'Smartphone Flash Deal', 1234, '$699'),
  new LiveItem(2, 'Gaming Chair Special', 880, '$249'),
  new LiveItem(3, 'Headphones Clearance', 1640, '$99'),
  new LiveItem(4, 'Mechanical Keyboard', 512, '$129'),
]

@Component
struct LiveItemCard {
  item: LiveItem = new LiveItem(0, '', 0, '')

  build() {
    Column({ space: SpacingTokens.sm }) {
      Row()
        .width('100%')
        .height(160)
        .backgroundColor(Colors.secondary)
        .borderRadius(10)

      Text(this.item.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)

      Text(`${this.item.viewers} viewers`)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(Colors.tertiary)

      Row() {
        Text(this.item.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.primary)

        Blank()

        Button('Join Live')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(10)
          .padding({
            top: MaterialDefaults.buttonVerticalPadding,
            bottom: MaterialDefaults.buttonVerticalPadding,
            left: MaterialDefaults.buttonHorizontalPadding,
            right: MaterialDefaults.buttonHorizontalPadding,
          })
          .height('auto')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(SpacingTokens.lg)
    .width('100%')
    .backgroundColor(Colors.surface)
    .borderRadius(16)
    .shadow({
      color: '#1F000000',
      radius: 4,
      offsetX: 0,
      offsetY: 2,
    })
  }
}

@Component
struct BottomNavBar {
  build() {
    Row() {
      Blank()
      Text('Home')
        .fontSize(14)
        .fontColor(Colors.primary)
      Blank()
      Text('Live')
        .fontSize(14)
        .fontColor(Colors.onSurface)
      Blank()
      Text('Cart')
        .fontSize(14)
        .fontColor(Colors.onSurface)
      Blank()
      Text('Profile')
        .fontSize(14)
        .fontColor(Colors.onSurface)
      Blank()
    }
    .width('100%')
    .height(MaterialDefaults.bottomAppBarHeight)
    .backgroundColor(Colors.surface)
    .shadow({
      color: '#1A000000',
      radius: 2,
      offsetX: 0,
      offsetY: -1,
    })
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Column({ space: SpacingTokens.md }) {
          Text('Live Shop Events')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.primary)
            .alignSelf(ItemAlign.Start)

          Scroll() {
            Column({ space: SpacingTokens.md }) {
              ForEach(liveList, (item: LiveItem) => {
                LiveItemCard({ item: item })
              }, (item: LiveItem) => item.id.toString())

              Row().height(MaterialDefaults.lazyColumnContentBottomPadding)
            }
            .width('100%')
          }
          .scrollBar(BarState.Off)
          .layoutWeight(1)
        }
        .padding(SpacingTokens.lg)
        .width('100%')
        .height('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [
          [Colors.background, 0.0],
          [Colors.surfaceVariant, 0.5],
          [Colors.background, 1.0],
        ]
      })

      // Bottom nav bar
      BottomNavBar()

      // FAB
      Row() {
        Blank()
        Button('+')
          .fontSize(24)
          .fontColor(Colors.onSecondary)
          .width(MaterialDefaults.fabSize)
          .height(MaterialDefaults.fabSize)
          .borderRadius(MaterialDefaults.fabSize / 2)
          .backgroundColor(Colors.secondary)
          .margin({
            right: MaterialDefaults.fabTrailingMargin,
            bottom: MaterialDefaults.fabBottomMargin + MaterialDefaults.bottomAppBarHeight,
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Bottom)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}