interface TripCard {
  id: number;
  title: string;
  days: number;
  price: string;
}

@Entry
@Component
struct RootScreen {
  @State trips: TripCard[] = [
    { id: 1, title: 'Kyoto Cherry Trail', days: 4, price: '$460' },
    { id: 2, title: 'Tokyo City Break', days: 3, price: '$390' },
    { id: 3, title: 'Osaka Gourmet Tour', days: 5, price: '$520' },
    { id: 4, title: 'Mount Fuji Escape', days: 2, price: '$280' },
    { id: 5, title: 'Okinawa Beach Week', days: 6, price: '$740' },
    { id: 6, title: 'Hokkaido Winter Lights', days: 5, price: '$680' }
  ]

  build() {
    // === Column ===
    // props: { space: 10 }
    // modifier: { width: '100%', height: '100%', padding: { left: 16, right: 16 }, background: LinearGradient({ direction: GradientDirection.BOTTOM, colors: [['#FFB74D', 0.3], '#FFF8F2', ['#FF7043', 0.3]] }) }
    // children: 2
    Column() {
      // === Text ===
      // props: { text: 'Itinerary Planner' }
      // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#FF7043' }
      Text('Itinerary Planner').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#FF7043')

      // === Grid ===
      // props: { columnsTemplate: '1fr 1fr', columnsGap: 16, rowsGap: 16 }
      // modifier: { width: '100%', layoutWeight: 1 }
      // children: 6
      Grid() {
        ForEach(this.trips, (trip: TripCard) => {
          // === GridItem ===
          // children: 1
          GridItem() {
            // === Column ===
            // props: { space: 6 }
            // modifier: { backgroundColor: '#FFF', borderRadius: 20, padding: 10, shadow: { radius: 8, color: '#26000000', offsetY: 4 } }
            // children: 4
            Column() {
              // === Image ===
              // modifier: { width: '100%', height: 100, borderRadius: 14, objectFit: ImageFit.Cover, backgroundColor: '#FFE0B2' }
              Image($r('app.media.startIcon')).width('100%').height(100).borderRadius(14).objectFit(ImageFit.Cover).backgroundColor('#FFE0B2')

              // === Text ===
              // props: { text: trip.title }
              // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#3E2723', maxWidth: '100%' }
              Text(trip.title).fontSize(18).fontWeight(FontWeight.Medium).fontColor('#3E2723').maxLines(2)

              // === Text ===
              // props: { text: `${trip.days} days` }
              // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#3E2723', opacity: 0.7 }
              Text(`${trip.days} days`).fontSize(14).fontWeight(FontWeight.Normal).fontColor('#3E2723').opacity(0.7)

              // === Row ===
              // props: { justifyContent: FlexSpace.SpaceBetween }
              // modifier: { width: '100%' }
              // children: 2
              Row() {
                // === Text ===
                // props: { text: trip.price }
                // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#FF7043' }
                Text(trip.price).fontSize(18).fontWeight(FontWeight.Medium).fontColor('#FF7043')

                // === Button ===
                // props: { type: ButtonType.Normal }
                // modifier: { backgroundColor: '#FF7043', borderRadius: 14, padding: { left: 10, right: 10, top: 3, bottom: 3 } }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: 'Details' }
                  // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#FFF' }
                  Text('Details').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#FFF')
                }.backgroundColor('#FF7043').borderRadius(14).padding({ left: 10, right: 10, top: 3, bottom: 3 })
              }
            }
          }
        })
      }.columnsTemplate('1fr 1fr').columnsGap(16).rowsGap(16).width('100%').layoutWeight(1)
    }.width('100%').height('100%').padding({ left: 16, right: 16 }).background(new LinearGradient({ direction: GradientDirection.Bottom, colors: [['#FFB74D', 0.3], ['#FFF8F2', 0.5], ['#FF7043', 0.3]] }))
  }
}