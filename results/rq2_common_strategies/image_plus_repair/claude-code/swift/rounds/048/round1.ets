namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#1E3A8A'
    export const secondary: string = '#3B82F6'
    export const tertiary: string = '#60A5FA'
    export const background: string = '#F5F8FF'
    export const surface: string = '#FFFFFF'
    export const surfaceVariant: string = '#E8EEFA'
    export const onPrimary: string = '#FFFFFF'
    export const onSecondary: string = '#FFFFFF'
    export const onSurface: string = '#0B1220'
  }

  export namespace Spacing {
    export const sm: number = 6
    export const md: number = 10
    export const lg: number = 16
    export const xl: number = 24
    export const xxl: number = 36
  }

  export namespace Shapes {
    export const small: number = 6
    export const medium: number = 10
    export const large: number = 16
  }

  export namespace MaterialDefaults {
    export const bottomAppBarHeight: number = 80
    export const fabSize: number = 56
    export const buttonHorizontalPadding: number = 16
    export const buttonVerticalPadding: number = 8
    export const fabBottomMargin: number = 16
    export const fabTrailingMargin: number = 16
    export const lazyColumnContentBottomPadding: number = 96
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
  item: LiveItem

  build() {
    Column() {
      Stack() {
      }
      .width('100%')
      .height(160)
      .backgroundColor(AppTokens.Colors.secondary)
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
    Stack({ alignContent: Alignment.TopStart }) {
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
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.background, 0.0],
          [AppTokens.Colors.surfaceVariant, 0.5],
          [AppTokens.Colors.background, 1.0]
        ]
      })

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
