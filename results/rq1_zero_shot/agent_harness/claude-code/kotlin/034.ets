class MapMarker {
  name: string = ''
  distance: string = ''
}

@Entry
@Component
struct ExploreMapPage {
  @State query: string = ''

  private markers: MapMarker[] = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' }
  ]

  build() {
    Column() {
      // Top Bar
      Text('Explore Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FF66')
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 8, bottom: 16 })

      // Search Field
      Row() {
        TextInput({ placeholder: 'Search destination', text: this.query })
          .placeholderColor('#E0E0E0')
          .fontColor('#E0E0E0')
          .caretColor('#00FF66')
          .backgroundColor('#0A0A0A')
          .borderRadius(10)
          .border({ width: 1, color: '#1F1F1F' })
          .padding({ left: 12, right: 12, top: 12, bottom: 12 })
          .width('100%')
          .onChange((value: string) => {
            this.query = value
          })
      }
      .margin({ bottom: 16 })

      // Marker Cards List
      Column({ space: 12 }) {
        ForEach(this.markers, (marker: MapMarker, index: number) => {
          Row() {
            Column() {
              Text(marker.name)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#E0E0E0')
              Text(marker.distance)
                .fontSize(13)
                .fontColor('#CCCCCC')
                .margin({ top: 4 })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            Button('View')
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .backgroundColor('#00FF66')
              .borderRadius(6)
              .height(32)
              .padding({ left: 12, right: 12 })
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#0A0A0A')
          .borderRadius(10)
          .alignItems(VerticalAlign.Center)
        }, (marker: MapMarker) => marker.name)
      }
      .width('100%')

      // Spacer
      Blank()

      // Refresh Button
      Button('Refresh Map')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .backgroundColor('#00FF66')
        .borderRadius(14)
        .width('100%')
        .height(48)
        .margin({ top: 32, bottom: 8 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
    .padding({ left: 16, right: 16, top: 16, bottom: 16 })
  }
}
