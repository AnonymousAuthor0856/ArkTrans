@Entry
@Component
struct RootScreen {
  // AppTokens - Colors
  private static readonly primary: string = '#1E3A8A'
  private static readonly secondary: string = '#3B82F6'
  private static readonly tertiary: string = '#60A5FA'
  private static readonly background: string = '#F5F8FF'
  private static readonly surface: string = '#FFFFFF'
  private static readonly surfaceVariant: string = '#E8EEFA'
  private static readonly outline: string = '#CBD5E1'
  private static readonly success: string = '#22C55E'
  private static readonly warning: string = '#F59E0B'
  private static readonly error: string = '#EF4444'
  private static readonly onPrimary: string = '#FFFFFF'
  private static readonly onSecondary: string = '#FFFFFF'
  private static readonly onTertiary: string = '#0B1220'
  private static readonly onBackground: string = '#0B1220'
  private static readonly onSurface: string = '#0B1220'

  // AppTokens - Spacing
  private static readonly spacingSm: number = 6
  private static readonly spacingMd: number = 10
  private static readonly spacingLg: number = 16
  private static readonly spacingXl: number = 24
  private static readonly spacingXxl: number = 36

  // AppTokens - Shapes
  private static readonly shapeSmall: number = 6
  private static readonly shapeMedium: number = 10
  private static readonly shapeLarge: number = 16

  // AppTokens - MaterialDefaults
  private static readonly bottomAppBarHeight: number = 80
  private static readonly fabSize: number = 56
  private static readonly buttonHorizontalPadding: number = 16
  private static readonly buttonVerticalPadding: number = 8
  private static readonly fabBottomMargin: number = 16
  private static readonly fabTrailingMargin: number = 16
  private static readonly lazyColumnContentBottomPadding: number = 96

  // AppTokens - Elevation
  private static readonly elevationLevel1Opacity: number = 0.12
  private static readonly elevationLevel1Radius: number = 4
  private static readonly elevationLevel1Dy: number = 2

  // Data Model
  @State private liveList: LiveItem[] = [
    new LiveItem(1, 'Smartphone Flash Deal', 1234, '$699'),
    new LiveItem(2, 'Gaming Chair Special', 880, '$249'),
    new LiveItem(3, 'Headphones Clearance', 1640, '$99'),
    new LiveItem(4, 'Mechanical Keyboard', 512, '$129')
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // Main content area
      Column({ space: RootScreen.spacingMd }) {
        Text('Live Shop Events')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(RootScreen.primary)
          .textAlign(TextAlign.Start)
          .width('100%')

        Scroll() {
          Column({ space: RootScreen.spacingMd }) {
            ForEach(this.liveList, (item: LiveItem) => {
              LiveItemCard({ item: item })
            }, (item: LiveItem) => item.id.toString())
          }
          .width('100%')
          .padding({ bottom: RootScreen.lazyColumnContentBottomPadding })
        }
        .scrollBar(BarState.Off)
        .align(Alignment.TopStart)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(RootScreen.spacingLg)
      .linearGradient({
        angle: 180,
        colors: [[RootScreen.background, 0.0], [RootScreen.surfaceVariant, 0.5], [RootScreen.background, 1.0]]
      })
      .alignItems(HorizontalAlign.Start)

      // Floating Action Button
      Button() {
        // Action
      }
      .width(RootScreen.fabSize)
      .height(RootScreen.fabSize)
      .backgroundColor(RootScreen.secondary)
      .borderRadius(RootScreen.fabSize / 2)
      .margin({ right: RootScreen.fabTrailingMargin, bottom: RootScreen.fabBottomMargin + RootScreen.bottomAppBarHeight })
      .justifyContent(FlexAlign.Center)
      .align(Alignment.BottomEnd)
      .type(ButtonType.Normal)
      .borderRadius(RootScreen.fabSize / 2)
      .shadow({
        radius: RootScreen.elevationLevel1Radius,
        color: `rgba(0, 0, 0, ${RootScreen.elevationLevel1Opacity})`,
        offsetY: RootScreen.elevationLevel1Dy
      })
      .stateEffect(false)

      // Bottom Navigation Bar
      BottomNavBar()
        .width('100%')
        .align(Alignment.BottomStart)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RootScreen.background)
  }
}

// LiveItem Model
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

// LiveItemCard Component
@Component
struct LiveItemCard {
  @Prop item: LiveItem

  build() {
    Column({ space: 6 }) {
      // Placeholder image area
      Row()
        .width('100%')
        .height(160)
        .backgroundColor('#3B82F6')
        .borderRadius(10)

      Text(this.item.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0B1220')
        .textAlign(TextAlign.Start)
        .width('100%')

      Text(`${this.item.viewers} viewers`)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor('#60A5FA')
        .textAlign(TextAlign.Start)
        .width('100%')

      Row() {
        Text(this.item.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E3A8A')

        Blank()

        Button('Join Live')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .padding({
            top: 8,
            bottom: 8,
            left: 16,
            right: 16
          })
          .backgroundColor('#1E3A8A')
          .borderRadius(10)
          .type(ButtonType.Normal)
          .stateEffect(false)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetY: 2
    })
    .alignItems(HorizontalAlign.Start)
  }
}

// BottomNavBar Component
@Component
struct BottomNavBar {
  build() {
    Row() {
      Blank()
      Text('Home')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor('#1E3A8A')
      Blank()
      Text('Live')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor('#0B1220')
      Blank()
      Text('Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor('#0B1220')
      Blank()
      Text('Profile')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor('#0B1220')
      Blank()
    }
    .width('100%')
    .height(80)
    .backgroundColor('#FFFFFF')
    .shadow({
      radius: 0.5,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetY: -1
    })
    .alignItems(VerticalAlign.Center)
  }
}