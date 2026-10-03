class AppTokens {
  static readonly Colors = {
    primary: '#FF1E3A8A',
    secondary: '#FF3B82F6',
    tertiary: '#FF60A5FA',
    background: '#FFF5F8FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE8EEFA',
    outline: '#FFCBD5E1',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF0B1220',
    onBackground: '#FF0B1220',
    onSurface: '#FF0B1220',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16,
  }
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36,
  }
}

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

@Component
struct LiveItemCard {
  @Prop title: string
  @Prop viewers: number
  @Prop price: string

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Column()
        .width('100%')
        .height(160)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.title)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(`${this.viewers} viewers`)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.tertiary)

      Row() {
        Text(this.price)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.primary)
          .layoutWeight(1)

        Button('Join Live')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
      }
      .width('100%')
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }
}

@Component
struct BottomNavBar {
  build() {
    Row() {
      Text('Home')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.primary)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Live')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Cart')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Profile')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(80)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 1, color: '#1A000000', offsetY: -1 })
  }
}

@Entry
@Component
struct RootScreen {
  private liveList: LiveItem[] = [
    new LiveItem(1, 'Smartphone Flash Deal', 1234, '$699'),
    new LiveItem(2, 'Gaming Chair Special', 880, '$249'),
    new LiveItem(3, 'Headphones Clearance', 1640, '$99'),
    new LiveItem(4, 'Mechanical Keyboard', 512, '$129'),
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column({ space: AppTokens.Spacing.md }) {
        Text('Live Shop Events')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.primary)

        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.liveList, (item: LiveItem) => {
              LiveItemCard({ title: item.title, viewers: item.viewers, price: item.price })
            })
          }
          .padding({ bottom: 96 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 0.5], [AppTokens.Colors.background, 1.0]]
      })

      Stack({ alignContent: Alignment.BottomEnd }) {
        Button('+')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSecondary)
          .width(56)
          .height(56)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(28)
          .margin({ right: 16, bottom: 96 })
      }
      .width('100%')
      .height('100%')

      BottomNavBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}