// AppTokens - Design system constants
class AppTokens {
  static class Colors {
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

  static class Spacing {
    static readonly sm: number = 6
    static readonly md: number = 10
    static readonly lg: number = 16
    static readonly xl: number = 24
    static readonly xxl: number = 36
  }

  static class Shapes {
    static readonly small: number = 6
    static readonly medium: number = 10
    static readonly large: number = 16
  }

  static class MaterialDefaults {
    static readonly bottomAppBarHeight: number = 80
    static readonly fabSize: number = 56
    static readonly buttonHorizontalPadding: number = 16
    static readonly buttonVerticalPadding: number = 8
    static readonly fabBottomMargin: number = 16
    static readonly fabTrailingMargin: number = 16
    static readonly lazyColumnContentBottomPadding: number = 96
  }
}

// Data model
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

// LiveItemCard component
@Component
struct LiveItemCard {
  item: LiveItem

  build() {
    Column() {
      // Placeholder image area
      Rectangle()
        .fill(AppTokens.Colors.secondary)
        .width('100%')
        .height(160)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.item.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Text(`${this.item.viewers} viewers`)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.Colors.tertiary)
        .margin({ top: AppTokens.Spacing.sm })

      Row() {
        Text(this.item.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)

        Blank()

        Button('Join Live')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({
            left: AppTokens.MaterialDefaults.buttonHorizontalPadding,
            right: AppTokens.MaterialDefaults.buttonHorizontalPadding,
            top: AppTokens.MaterialDefaults.buttonVerticalPadding,
            bottom: AppTokens.MaterialDefaults.buttonVerticalPadding
          })
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: 2
    })
  }
}

// BottomNavBar component
@Component
struct BottomNavBar {
  build() {
    Row() {
      Blank()
      Text('Home')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.Colors.primary)
      Blank()
      Text('Live')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.Colors.onSurface)
      Blank()
      Text('Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.Colors.onSurface)
      Blank()
      Text('Profile')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.Colors.onSurface)
      Blank()
    }
    .width('100%')
    .height(AppTokens.MaterialDefaults.bottomAppBarHeight)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: 0.5,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: -1
    })
  }
}

// RootScreen - main entry
@Entry
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
      // Main content area
      Column() {
        Text('Live Shop Events')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.md })

        List({ space: AppTokens.Spacing.md }) {
          ForEach(this.liveList, (item: LiveItem) => {
            ListItem() {
              LiveItemCard({ item: item })
            }
          }, (item: LiveItem) => item.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: AppTokens.MaterialDefaults.lazyColumnContentBottomPadding })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
      .backgroundImage([
        {
          color: [AppTokens.Colors.background, AppTokens.Colors.surfaceVariant, AppTokens.Colors.background],
          direction: GradientDirection.Bottom
        }
      ])

      // Floating Action Button
      Column() {
        Blank()
        Row() {
          Blank()
          Button({ type: ButtonType.Circle }) {
            Text('+')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
          }
          .width(AppTokens.MaterialDefaults.fabSize)
          .height(AppTokens.MaterialDefaults.fabSize)
          .backgroundColor(AppTokens.Colors.secondary)
          .margin({
            right: AppTokens.MaterialDefaults.fabTrailingMargin,
            bottom: AppTokens.MaterialDefaults.fabBottomMargin + AppTokens.MaterialDefaults.bottomAppBarHeight
          })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom Navigation Bar
      Column() {
        Blank()
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
