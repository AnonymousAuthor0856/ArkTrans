// MARK: - AppTokens Colors
class AppColors {
  static primary: string = '#FF7043'
  static secondary: string = '#FFB74D'
  static tertiary: string = '#FFD180'
  static background: string = '#FFF8F2'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#FFE0B2'
  static outline: string = '#D7CCC8'
  static success: string = '#43A047'
  static warning: string = '#FFB300'
  static error: string = '#E53935'
  static onPrimary: string = '#FFFFFF'
  static onSecondary: string = '#3E2723'
  static onTertiary: string = '#3E2723'
  static onBackground: string = '#3E2723'
  static onSurface: string = '#3E2723'
}

class AppTypography {
  static displaySize: number = 28
  static displayWeight: FontWeight = FontWeight.Bold
  static titleSize: number = 18
  static titleWeight: FontWeight = FontWeight.Medium
  static bodySize: number = 14
  static bodyWeight: FontWeight = FontWeight.Normal
  static labelSize: number = 12
  static labelWeight: FontWeight = FontWeight.Medium
}

class AppShapes {
  static small: number = 8
  static medium: number = 14
  static large: number = 20
}

class AppSpacing {
  static sm: number = 6
  static md: number = 10
  static lg: number = 16
  static xl: number = 24
  static xxl: number = 36
}

class AppShadow {
  static level2Radius: number = 8
  static level2Dy: number = 4
  static level2Color: string = '#26000000'
}

// MARK: - Data Model
interface TripCard {
  id: number
  title: string
  days: number
  price: string
}

// MARK: - TripCardView
@Component
struct TripCardView {
  trip: TripCard = { id: 0, title: '', days: 0, price: '' }

  build() {
    Column({ space: AppSpacing.sm }) {
      // Image placeholder
      Row() {
      }
      .width('100%')
      .height(100)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)

      Text(this.trip.title)
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.onSurface)
        .width('100%')

      Text(`${this.trip.days} days`)
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor('#803E2723')
        .width('100%')

      Row() {
        Text(this.trip.price)
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.primary)

        Blank()

        Button('Details')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .height(36)
          .padding({
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.sm / 2,
            bottom: AppSpacing.sm / 2,
          })
          .onClick(() => {
            console.log(`Details for ${this.trip.title}`)
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppShadow.level2Radius,
      color: AppShadow.level2Color,
      offsetX: 0,
      offsetY: AppShadow.level2Dy,
    })
    .width('100%')
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  private trips: TripCard[] = [
    { id: 1, title: 'Kyoto Cherry Trail', days: 4, price: '$460' },
    { id: 2, title: 'Tokyo City Break', days: 3, price: '$390' },
    { id: 3, title: 'Osaka Gourmet Tour', days: 5, price: '$520' },
    { id: 4, title: 'Mount Fuji Escape', days: 2, price: '$280' },
    { id: 5, title: 'Okinawa Beach Week', days: 6, price: '$740' },
    { id: 6, title: 'Hokkaido Winter Lights', days: 5, price: '$680' },
  ]

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Itinerary Planner')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.primary)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .width('100%')

      Scroll() {
        GridRow({ columns: 2, gutter: { x: AppSpacing.lg, y: AppSpacing.lg } }) {
          ForEach(this.trips, (trip: TripCard) => {
            GridCol({ span: 1 }) {
              TripCardView({ trip: trip })
            }
          }, (trip: TripCard) => trip.id.toString())
        }
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          bottom: AppSpacing.xxl,
        })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#4DFFB74D', 0.0],
        ['#FFF8F2', 0.5],
        ['#4DFF7043', 1.0],
      ],
    })
    .padding({ top: 44 })
  }
}