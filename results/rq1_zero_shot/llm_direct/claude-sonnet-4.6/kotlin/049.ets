import { LengthMetrics } from '@kit.ArkUI'

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FFFF7043'
    export const secondary: string = '#FFFFB74D'
    export const tertiary: string = '#FFFFD180'
    export const background: string = '#FFFFF8F2'
    export const surface: string = '#FFFFFFFF'
    export const surfaceVariant: string = '#FFFFE0B2'
    export const outline: string = '#FFD7CCC8'
    export const success: string = '#FF43A047'
    export const warning: string = '#FFFFB300'
    export const error: string = '#FFE53935'
    export const onPrimary: string = '#FFFFFFFF'
    export const onSecondary: string = '#FF3E2723'
    export const onTertiary: string = '#FF3E2723'
    export const onBackground: string = '#FF3E2723'
    export const onSurface: string = '#FF3E2723'
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28
    export const titleSize: number = 18
    export const bodySize: number = 14
    export const labelSize: number = 12
  }

  export namespace Spacing {
    export const sm: number = 6
    export const md: number = 10
    export const lg: number = 16
    export const xl: number = 24
    export const xxl: number = 36
  }
}

interface TripCard {
  id: number
  title: string
  days: number
  price: string
}

const trips: TripCard[] = [
  { id: 1, title: 'Kyoto Cherry Trail', days: 4, price: '$460' },
  { id: 2, title: 'Tokyo City Break', days: 3, price: '$390' },
  { id: 3, title: 'Osaka Gourmet Tour', days: 5, price: '$520' },
  { id: 4, title: 'Mount Fuji Escape', days: 2, price: '$280' },
  { id: 5, title: 'Okinawa Beach Week', days: 6, price: '$740' },
  { id: 6, title: 'Hokkaido Winter Lights', days: 5, price: '$680' },
]

@Component
struct TripCardItem {
  trip: TripCard = { id: 0, title: '', days: 0, price: '' }

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Image placeholder
      Row() {
      }
      .width('100%')
      .height(100)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(14)

      // Title
      Text(this.trip.title)
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')

      // Days
      Text(`${this.trip.days} days`)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor('#B33E2723')
        .width('100%')

      // Price + Button row
      Row() {
        Text(this.trip.price)
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)

        Button('Details')
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(14)
          .height(36)
          .padding({ left: 12, right: 12, top: 0, bottom: 0 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(20)
    .padding(AppTokens.Spacing.md)
    .shadow({
      radius: 8,
      color: '#26000000',
      offsetX: 0,
      offsetY: 4
    })
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      // Header
      Text('Itinerary Planner')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')

      // Grid
      Grid() {
        ForEach(trips, (trip: TripCard) => {
          GridItem() {
            TripCardItem({ trip: trip })
          }
        }, (trip: TripCard) => trip.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppTokens.Spacing.lg)
      .rowsGap(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .padding({ bottom: AppTokens.Spacing.xxl })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#4DFFB74D', 0.0],
        ['#FFFFF8F2', 0.5],
        ['#4DFF7043', 1.0]
      ]
    })
  }
}