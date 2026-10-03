// Color tokens
class ColorsClass {
  primary: string = '#FF7043'
  secondary: string = '#FFB74D'
  tertiary: string = '#FFD180'
  background: string = '#FFF8F2'
  surface: string = '#FFFFFF'
  surfaceVariant: string = '#FFE0B2'
  outline: string = '#D7CCC8'
  success: string = '#43A047'
  warning: string = '#FFB300'
  error: string = '#E53935'
  onPrimary: string = '#FFFFFF'
  onSecondary: string = '#3E2723'
  onTertiary: string = '#3E2723'
  onBackground: string = '#3E2723'
  onSurface: string = '#3E2723'
}

class SpacingClass {
  sm: number = 6
  md: number = 10
  lg: number = 16
  xl: number = 24
  xxl: number = 36
}

class ShapesClass {
  small: number = 8
  medium: number = 14
  large: number = 20
}

const Colors = new ColorsClass()
const Spacing = new SpacingClass()
const Shapes = new ShapesClass()

interface TripCard {
  id: number;
  title: string;
  days: number;
  price: string;
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
struct TripCardView {
  trip: TripCard = { id: 0, title: '', days: 0, price: '' }

  build() {
    Column({ space: Spacing.sm }) {
      Row() {
      }
      .width('100%')
      .height(100)
      .backgroundColor(Colors.surfaceVariant)
      .borderRadius(Shapes.medium)

      Text(this.trip.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
        .width('100%')

      Text(`${this.trip.days} days`)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor('#803E2723')
        .width('100%')

      Row() {
        Text(this.trip.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.primary)

        Blank()

        Button('Details')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(Shapes.medium)
          .height(36)
          .padding({
            left: Spacing.md,
            right: Spacing.md,
            top: Spacing.sm / 2,
            bottom: Spacing.sm / 2
          })
          .onClick(() => {
            console.log(`Details for ${this.trip.title}`)
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(Shapes.large)
    .shadow({
      radius: 8,
      color: '#26000000',
      offsetX: 0,
      offsetY: 4,
    })
    .width('100%')
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Column({ space: Spacing.md }) {
      Text('Itinerary Planner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.primary)
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.lg })
        .width('100%')

      Scroll() {
        GridRow({ columns: 2, gutter: { x: Spacing.lg, y: Spacing.lg } }) {
          ForEach(trips, (trip: TripCard) => {
            GridCol() {
              TripCardView({ trip: trip })
            }
          }, (trip: TripCard) => trip.id.toString())
        }
        .padding({ left: Spacing.lg, right: Spacing.lg, bottom: Spacing.xxl })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#4DFFB74D', 0.0],
        ['#FFF8F2', 0.5],
        ['#4DFF7043', 1.0],
      ]
    })
  }
}