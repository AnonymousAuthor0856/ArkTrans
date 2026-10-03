interface TripCard {
  id: number
  title: string
  days: number
  price: string
}

class AppTokens {
  static readonly primary: ResourceColor = '#FF7043'
  static readonly secondary: ResourceColor = '#FFB74D'
  static readonly background: ResourceColor = '#FFF8F2'
  static readonly surface: ResourceColor = '#FFFFFF'
  static readonly surfaceVariant: ResourceColor = '#FFE0B2'
  static readonly onSurface: ResourceColor = '#3E2723'
  static readonly cardRadius: number = 20
  static readonly imageRadius: number = 14
  static readonly gridGap: number = 16
}

@Component
struct TripCardView {
  @Prop trip: TripCard

  build() {
    Column({ space: 10 }) {
      Row()
        .width('100%')
        .height(200)
        .borderRadius(AppTokens.imageRadius)
        .backgroundColor(AppTokens.surfaceVariant)

      Text(this.trip.title)
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)
        .lineHeight(29)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .height(58)
        .textAlign(TextAlign.Start)

      Text(`${this.trip.days} days`)
        .fontSize(20)
        .fontColor('#996F69')
        .width('100%')
        .height(28)
        .textAlign(TextAlign.Start)

      Row() {
        Text(this.trip.price)
          .fontSize(30)
          .fontColor(AppTokens.primary)
          .fontWeight(FontWeight.Medium)

        Blank()
          .layoutWeight(1)

        Button('Details', { type: ButtonType.Normal })
          .fontSize(18)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Medium)
          .height(42)
          .padding({ left: 20, right: 20 })
          .backgroundColor(AppTokens.primary)
          .borderRadius(22)
          .onClick(() => {
            console.info(`Details for ${this.trip.title}`)
          })
      }
      .width('100%')
      .height(44)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(468)
    .padding(20)
    .backgroundColor(AppTokens.surface)
    .borderRadius(AppTokens.cardRadius)
    .shadow({
      radius: 14,
      color: '#26000000',
      offsetX: 0,
      offsetY: 6
    })
  }
}

@Entry
@Component
struct ItineraryPlanner {
  private readonly trips: TripCard[] = [
    { id: 1, title: 'Kyoto Cherry Trail', days: 4, price: '$460' },
    { id: 2, title: 'Tokyo City Break', days: 3, price: '$390' },
    { id: 3, title: 'Osaka Gourmet Tour', days: 5, price: '$520' },
    { id: 4, title: 'Mount Fuji Escape', days: 2, price: '$280' },
    { id: 5, title: 'Okinawa Beach Week', days: 6, price: '$740' },
    { id: 6, title: 'Hokkaido Winter Lights', days: 5, price: '$680' }
  ]

  build() {
    Scroll() {
      Column({ space: 16 }) {
        Text('Itinerary Planner')
          .fontSize(52)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.primary)
          .width('100%')
          .height(64)
          .textAlign(TextAlign.Start)

        Grid() {
          ForEach(this.trips, (trip: TripCard) => {
            GridItem() {
              TripCardView({ trip: trip })
            }
          }, (trip: TripCard) => trip.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(AppTokens.gridGap)
        .columnsGap(AppTokens.gridGap)
        .width('100%')
        .padding({ bottom: 36 })
      }
      .width('100%')
      .padding({ left: 32, right: 32, top: 8 })
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}
