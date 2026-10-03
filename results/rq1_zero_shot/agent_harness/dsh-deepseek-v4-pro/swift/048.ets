// MARK: - AppTokens (Equivalent to Kotlin's AppTokens object)
interface ColorTokens { [key: string]: string }
interface FontToken { size: number; weight: FontWeight }
interface TypographyTokens { [key: string]: FontToken }
interface NumberTokens { [key: string]: number }
interface ShadowSpec { elevation: number; radius: number; dy: number; opacity: number }
interface ElevationTokens { [key: string]: ShadowSpec }

class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#1E3A8A',
    secondary: '#3B82F6',
    tertiary: '#60A5FA',
    background: '#F5F8FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E8EEFA',
    outline: '#CBD5E1',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0B1220',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  }

  static readonly Typography: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: NumberTokens = {
    small: 6, medium: 10, large: 16
  }

  static readonly Spacing: NumberTokens = {
    sm: 6, md: 10, lg: 16, xl: 24, xxl: 36
  }

  static readonly ElevationMapping: ElevationTokens = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
  }

  static readonly MaterialDefaults: NumberTokens = {
    bottomAppBarHeight: 80,
    fabSize: 56,
    buttonHorizontalPadding: 16,
    buttonVerticalPadding: 8,
    fabBottomMargin: 16,
    fabTrailingMargin: 16,
    lazyColumnContentBottomPadding: 96
  }
}

// MARK: - Data Model
class LiveItem {
  id: number
  title: string
  viewers: number
  price: string

  constructor(id: number = 0, title: string = '', viewers: number = 0, price: string = '') {
    this.id = id
    this.title = title
    this.viewers = viewers
    this.price = price
  }
}

// MARK: - RootScreen View
@Entry
@Component
struct Index {
  liveList: LiveItem[] = [
    new LiveItem(1, 'Smartphone Flash Deal', 1234, '$699'),
    new LiveItem(2, 'Gaming Chair Special', 880, '$249'),
    new LiveItem(3, 'Headphones Clearance', 1640, '$99'),
    new LiveItem(4, 'Mechanical Keyboard', 512, '$129')
  ]

  build() {
    Stack() {
      // 主要内容区域。
      Column({ space: AppTokens.Spacing.md }) {
        Text('Live Shop Events')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.primary)

        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.liveList, (item: LiveItem) => {
              LiveItemCard({ item: item })
            }, (item: LiveItem) => item.id.toString())
          }
          .width('100%')
          .padding({ bottom: AppTokens.MaterialDefaults.lazyColumnContentBottomPadding })
        }
        .scrollable(ScrollDirection.Vertical)
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          ['#F5F8FF', 0.0],
          ['#E8EEFA', 0.5],
          ['#F5F8FF', 1.0]
        ]
      })

      // 浮动操作按钮 (FAB)。
      Stack({ alignContent: Alignment.BottomEnd }) {
        Button('+')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSecondary)
          .width(AppTokens.MaterialDefaults.fabSize)
          .height(AppTokens.MaterialDefaults.fabSize)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.MaterialDefaults.fabSize / 2)
          .margin({
            right: AppTokens.MaterialDefaults.fabTrailingMargin,
            bottom: AppTokens.MaterialDefaults.fabBottomMargin + AppTokens.MaterialDefaults.bottomAppBarHeight
          })
          .onClick(() => {})
      }
      .width('100%')
      .height('100%')

      // 底部导航栏。
      Stack({ alignContent: Alignment.Bottom }) {
        BottomNavBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - LiveItemCard View
@Component
struct LiveItemCard {
  item: LiveItem = new LiveItem()

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Column()
        .width('100%')
        .height(160)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.item.title)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(this.item.viewers.toString() + ' viewers')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.tertiary)

      Row() {
        Text(this.item.price)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.primary)

        Blank()

        Button('Join Live')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({
            top: AppTokens.MaterialDefaults.buttonVerticalPadding,
            bottom: AppTokens.MaterialDefaults.buttonVerticalPadding,
            left: AppTokens.MaterialDefaults.buttonHorizontalPadding,
            right: AppTokens.MaterialDefaults.buttonHorizontalPadding
          })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

// MARK: - BottomNavBar View
@Component
struct BottomNavBar {
  build() {
    Row() {
      Blank()
      Text('Home')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.primary)
      Blank()
      Text('Live')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
      Blank()
      Text('Cart')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
      Blank()
      Text('Profile')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
      Blank()
    }
    .width('100%')
    .height(AppTokens.MaterialDefaults.bottomAppBarHeight)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 0.5, color: 'rgba(0, 0, 0, 0.1)', offsetX: 0, offsetY: -1 })
  }
}
