class AppColors {
  static readonly primary: string = '#1E3A8A'
  static readonly secondary: string = '#3B82F6'
  static readonly tertiary: string = '#60A5FA'
  static readonly background: string = '#F5F8FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E8EEFA'
  static readonly outline: string = '#CBD5E1'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#0B1220'
  static readonly onBackground: string = '#0B1220'
  static readonly onSurface: string = '#0B1220'
}

class FontSpec {
  size: number
  weight: FontWeight

  constructor(size: number, weight: FontWeight) {
    this.size = size
    this.weight = weight
  }
}

class AppTypographyTokens {
  static readonly display: FontSpec = new FontSpec(28, FontWeight.Bold)
  static readonly title: FontSpec = new FontSpec(18, FontWeight.Medium)
  static readonly body: FontSpec = new FontSpec(14, FontWeight.Normal)
  static readonly label: FontSpec = new FontSpec(12, FontWeight.Medium)
}

class RoundedCornerShape {
  cornerRadius: number

  constructor(cornerRadius: number) {
    this.cornerRadius = cornerRadius
  }
}

class AppShapes {
  static readonly small: RoundedCornerShape = new RoundedCornerShape(6)
  static readonly medium: RoundedCornerShape = new RoundedCornerShape(10)
  static readonly large: RoundedCornerShape = new RoundedCornerShape(16)
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15)
  static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18)
}

class AppMaterialDefaults {
  static readonly bottomAppBarHeight: number = 80
  static readonly fabSize: number = 56
  static readonly buttonHorizontalPadding: number = 16
  static readonly buttonVerticalPadding: number = 8
  static readonly fabBottomMargin: number = 16
  static readonly fabTrailingMargin: number = 16
  static readonly lazyColumnContentBottomPadding: number = 96
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

@Entry
@Component
struct LiveShopApp {
  build() {
    RootScreen()
  }
}

@Component
struct RootScreen {
  private liveList: LiveItem[] = [
    new LiveItem(1, 'Smartphone Flash Deal', 1234, '$699'),
    new LiveItem(2, 'Gaming Chair Special', 880, '$249'),
    new LiveItem(3, 'Headphones Clearance', 1640, '$99'),
    new LiveItem(4, 'Mechanical Keyboard', 512, '$129')
  ]

  build() {
    Stack() {
      Column({ space: AppSpacing.md }) {
        Text('Live Shop Events')
          .fontSize(AppTypographyTokens.display.size)
          .fontWeight(AppTypographyTokens.display.weight)
          .fontColor(AppColors.primary)

        Scroll() {
          Column({ space: AppSpacing.md }) {
            ForEach(this.liveList, (item: LiveItem) => {
              LiveItemCard({ item: item })
            }, (item: LiveItem) => item.id.toString())
          }
          .width('100%')
          .padding({ bottom: AppMaterialDefaults.lazyColumnContentBottomPadding })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(AppSpacing.lg)
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.background, 0.0],
          [AppColors.surfaceVariant, 0.5],
          [AppColors.background, 1.0]
        ]
      })

      Column() {
        Blank()

        Row() {
          Blank()

          Button('+', { type: ButtonType.Circle, stateEffect: true })
            .width(AppMaterialDefaults.fabSize)
            .height(AppMaterialDefaults.fabSize)
            .fontSize(AppTypographyTokens.title.size)
            .fontWeight(AppTypographyTokens.title.weight)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
        }
        .width('100%')
        .padding({
          right: AppMaterialDefaults.fabTrailingMargin,
          bottom: AppMaterialDefaults.fabBottomMargin + AppMaterialDefaults.bottomAppBarHeight
        })
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        BottomNavBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Component
struct LiveItemCard {
  item: LiveItem = new LiveItem(0, '', 0, '')

  build() {
    Column({ space: AppSpacing.sm }) {
      Stack()
        .width('100%')
        .height(160)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.medium.cornerRadius)

      Text(this.item.title)
        .fontSize(AppTypographyTokens.title.size)
        .fontWeight(AppTypographyTokens.title.weight)
        .fontColor(AppColors.onSurface)

      Text(`${this.item.viewers} viewers`)
        .fontSize(AppTypographyTokens.body.size)
        .fontWeight(AppTypographyTokens.body.weight)
        .fontColor(AppColors.tertiary)

      Row() {
        Text(this.item.price)
          .fontSize(AppTypographyTokens.title.size)
          .fontWeight(AppTypographyTokens.title.weight)
          .fontColor(AppColors.primary)

        Blank()

        Button('Join Live', { type: ButtonType.Normal, stateEffect: true })
          .fontSize(AppTypographyTokens.label.size)
          .fontWeight(AppTypographyTokens.label.weight)
          .fontColor(AppColors.onPrimary)
          .padding({
            top: AppMaterialDefaults.buttonVerticalPadding,
            bottom: AppMaterialDefaults.buttonVerticalPadding,
            left: AppMaterialDefaults.buttonHorizontalPadding,
            right: AppMaterialDefaults.buttonHorizontalPadding
          })
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium.cornerRadius)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large.cornerRadius)
    .shadow({
      radius: AppElevationMapping.level1.radius,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: AppElevationMapping.level1.dy
    })
  }
}

@Component
struct BottomNavBar {
  build() {
    Row() {
      Text('Home')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .fontSize(AppTypographyTokens.body.size)
        .fontWeight(AppTypographyTokens.body.weight)
        .fontColor(AppColors.primary)

      Text('Live')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .fontSize(AppTypographyTokens.body.size)
        .fontWeight(AppTypographyTokens.body.weight)
        .fontColor(AppColors.onSurface)

      Text('Cart')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .fontSize(AppTypographyTokens.body.size)
        .fontWeight(AppTypographyTokens.body.weight)
        .fontColor(AppColors.onSurface)

      Text('Profile')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .fontSize(AppTypographyTokens.body.size)
        .fontWeight(AppTypographyTokens.body.weight)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(AppMaterialDefaults.bottomAppBarHeight)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: 0.5,
      color: 'rgba(0, 0, 0, 0.10)',
      offsetX: 0,
      offsetY: -1
    })
  }
}