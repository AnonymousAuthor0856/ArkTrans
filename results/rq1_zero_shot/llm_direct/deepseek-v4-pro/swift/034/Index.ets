@Entry
@Component
struct RootScreen {
  @State private var query: string = ''
  @State private var isSearchFieldFocused: boolean = false

  private markers: MapMarker[] = [
    new MapMarker('Central Plaza', '1.2 km'),
    new MapMarker('Museum District', '3.4 km'),
    new MapMarker('Tech Park', '5.6 km'),
    new MapMarker('Old Town Gate', '7.8 km')
  ]

  build() {
    Stack() {
      Column() {
        Text('Explore Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FF66')
          .width('100%')
          .padding({ top: 16, bottom: 16 })
          .backgroundColor('#000000')

        Column({ space: 16 }) {
          TextInput({ placeholder: 'Search destination', text: this.query })
            .fontSize(13)
            .fontColor('#E0E0E0')
            .placeholderColor('#999999')
            .caretColor('#00FF66')
            .padding(12)
            .backgroundColor('#111111')
            .borderRadius(10)
            .border({
              width: 1,
              color: this.isSearchFieldFocused ? '#00FF66' : '#1F1F1F'
            })
            .width('100%')
            .onFocus(() => {
              this.isSearchFieldFocused = true
            })
            .onBlur(() => {
              this.isSearchFieldFocused = false
            })

          Column({ space: 12 }) {
            ForEach(this.markers, (marker: MapMarker) => {
              CardView({ marker: marker })
            })
          }
          .width('100%')

          Blank()

          Button('Refresh Map')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .width('100%')
            .height(48)
            .backgroundColor('#00FF66')
            .borderRadius(14)
            .onClick(() => {
              console.log('Refresh Map Tapped')
            })
        }
        .padding(16)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#000000')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}

@Component
struct CardView {
  @Prop marker: MapMarker

  build() {
    Row({ space: 0 }) {
      Column({ space: 0 }) {
        Text(this.marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E0E0E0')
        Text(this.marker.distance)
          .fontSize(13)
          .fontColor('#CCCCCC')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('View')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .padding({ left: 12, right: 12, top: 4, bottom: 4 })
        .backgroundColor('#00FF66')
        .borderRadius(6)
        .onClick(() => {
          console.log(`View ${this.marker.name} Tapped`)
        })
    }
    .alignItems(VerticalAlign.Center)
    .padding(12)
    .backgroundColor('#0A0A0A')
    .borderRadius(10)
    .shadow({
      radius: 4,
      offsetY: 2,
      color: 'rgba(0, 0, 0, 0.12)'
    })
    .width('100%')
  }
}

class MapMarker {
  name: string
  distance: string

  constructor(name: string, distance: string) {
    this.name = name
    this.distance = distance
  }
}