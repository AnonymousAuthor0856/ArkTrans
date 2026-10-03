import { LengthMetrics } from '@kit.ArkUI'

// Token definitions
namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#1E3A8A'
    export const secondary: ResourceColor = '#3B82F6'
    export const tertiary: ResourceColor = '#60A5FA'
    export const background: ResourceColor = '#F5F8FF'
    export const surface: ResourceColor = '#FFFFFF'
    export const surfaceVariant: ResourceColor = '#E8EEFA'
    export const outline: ResourceColor = '#CBD5E1'
    export const success: ResourceColor = '#22C55E'
    export const warning: ResourceColor = '#F59E0B'
    export const error: ResourceColor = '#EF4444'
    export const onPrimary: ResourceColor = '#FFFFFF'
    export const onSecondary: ResourceColor = '#FFFFFF'
    export const onTertiary: ResourceColor = '#0B1220'
    export const onBackground: ResourceColor = '#0B1220'
    export const onSurface: ResourceColor = '#0B1220'
  }

  export namespace Spacing {
    export const sm: number = 6
    export const md: number = 10
    export const lg: number = 16
    export const xl: number = 24
    export const xxl: number = 36
  }
}

interface LiveItem {
  id: number
  title: string
  viewers: number
  price: string
}

const liveList: LiveItem[] = [
  { id: 1, title: 'Smartphone Flash Deal', viewers: 1234, price: '$699' },
  { id: 2, title: 'Gaming Chair Special', viewers: 880, price: '$249' },
  { id: 3, title: 'Headphones Clearance', viewers: 1640, price: '$99' },
  { id: 4, title: 'Mechanical Keyboard', viewers: 512, price: '$129' },
]

@Component
struct LiveItemCard {
  item: LiveItem = { id: 0, title: '', viewers: 0, price: '' }

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Thumbnail placeholder
      Row()
        .width('100%')
        .height(160)
        .borderRadius(10)
        .backgroundColor(AppTokens.Colors.secondary)

      // Title
      Text(this.item.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      // Viewers
      Text(`${this.item.viewers} viewers`)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.Colors.tertiary)

      // Price + Button row
      Row() {
        Text(this.item.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)

        Button('Join Live')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(10)
          .height(36)
          .padding({ left: 16, right: 16 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(16)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

@Component
struct BottomNavBar {
  build() {
    Row() {
      Text('Home')
        .fontSize(14)
        .fontColor(AppTokens.Colors.primary)
        .fontWeight(FontWeight.Normal)

      Text('Live')
        .fontSize(14)
        .fontColor(AppTokens.Colors.onSurface)
        .fontWeight(FontWeight.Normal)

      Text('Cart')
        .fontSize(14)
        .fontColor(AppTokens.Colors.onSurface)
        .fontWeight(FontWeight.Normal)

      Text('Profile')
        .fontSize(14)
        .fontColor(AppTokens.Colors.onSurface)
        .fontWeight(FontWeight.Normal)
    }
    .width('100%')
    .height(56)
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Main scrollable content
        Column({ space: AppTokens.Spacing.md }) {
          Text('Live Shop Events')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')

          List({ space: AppTokens.Spacing.md }) {
            ForEach(liveList, (item: LiveItem) => {
              ListItem() {
                LiveItemCard({ item: item })
              }
            }, (item: LiveItem) => item.id.toString())
          }
          .width('100%')
          .layoutWeight(1)
          .scrollBar(BarState.Off)
          .padding({ bottom: 96 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppTokens.Spacing.lg)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [0xFFF5F8FF, 0.0],
            [0xFFE8EEFA, 0.5],
            [0xFFF5F8FF, 1.0]
          ]
        })

        // Bottom navigation bar
        BottomNavBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // Floating Action Button
      Button('+')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .width(56)
        .height(56)
        .borderRadius(28)
        .margin({ right: AppTokens.Spacing.lg, bottom: 72 })
        .shadow({
          radius: 8,
          color: '#26000000',
          offsetX: 0,
          offsetY: 4
        })
    }
    .width('100%')
    .height('100%')
  }
}