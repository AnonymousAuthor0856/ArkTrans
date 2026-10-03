const NAME: string = '063*LiveShop*en'
const UI_TYPE: string = 'ECommerce'
const STYLE_THEME: string = 'Modern Blue'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

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

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

class AppRadii {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 16
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
struct Index {
  private liveList: LiveItem[] = [
    new LiveItem(1, 'Smartphone Flash Deal', 1234, '$699'),
    new LiveItem(2, 'Gaming Chair Special', 880, '$249'),
    new LiveItem(3, 'Headphones Clearance', 1640, '$99'),
    new LiveItem(4, 'Mechanical Keyboard', 512, '$129')
  ]

  @Builder
  LiveCard(item: LiveItem) {
    Column({ space: AppSpacing.sm }) {
      Blank()
        .width('100%')
        .height(160)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppRadii.medium)

      Text(item.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .margin({ top: 6 })

      Text(`${item.viewers} viewers`)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.tertiary)
        .width('100%')

      Row() {
        Text(item.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        Button('Join Live', { type: ButtonType.Normal, stateEffect: true })
          .width(96)
          .height(40)
          .borderRadius(AppRadii.medium)
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 10 })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadii.large)
    .shadow({
      radius: 8,
      color: '#26000000',
      offsetX: 0,
      offsetY: 2
    })
    .margin({ bottom: AppSpacing.md })
  }

  @Builder
  BottomNavigation() {
    Row() {
      Text('Home')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.primary)

      Text('Live')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)

      Text('Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)

      Text('Profile')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(72)
    .padding({ left: AppSpacing.xl, right: AppSpacing.xl })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  FloatingButton() {
    Button('+', { type: ButtonType.Circle, stateEffect: true })
      .width(56)
      .height(56)
      .fontSize(28)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSecondary)
      .backgroundColor(AppColors.secondary)
      .shadow({
        radius: 12,
        color: '#33000000',
        offsetX: 0,
        offsetY: 6
      })
  }

  build() {
    Stack() {
      Column({ space: AppSpacing.md }) {
        Text('Live Shop Events')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .width('100%')
          .lineHeight(34)

        Scroll() {
          Column() {
            ForEach(this.liveList, (item: LiveItem) => {
              this.LiveCard(item)
            }, (item: LiveItem) => item.id.toString())
          }
          .width('100%')
          .padding({ bottom: 96 })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: 32
      })
      .backgroundColor(AppColors.background)
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
          .layoutWeight(1)

        this.BottomNavigation()
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
          .layoutWeight(1)

        Row() {
          Blank()
            .layoutWeight(1)

          this.FloatingButton()
        }
        .width('100%')
        .padding({
          right: AppSpacing.lg,
          bottom: 56
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}