@Entry
@Component
struct ExploreMapPage {
  @State query: string = ''
  @State isFocused: boolean = false
  private markers: MapMarker[] = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' }
  ]

  build() {
    Stack() {
      Column() {
        Text('Explore Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FF66')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 16, bottom: 16 })

        Column({ space: 16 }) {
          TextInput({ placeholder: 'Search destination', text: this.query })
            .fontSize(13)
            .fontColor('#E0E0E0')
            .placeholderColor('#999999')
            .caretColor('#00FF66')
            .backgroundColor('#111111')
            .borderRadius(10)
            .border({
              width: 1,
              color: this.isFocused ? '#00FF66' : '#1F1F1F'
            })
            .padding(12)
            .width('100%')
            .onFocus(() => { this.isFocused = true })
            .onBlur(() => { this.isFocused = false })
            .onChange((value: string) => { this.query = value })

          Column({ space: 12 }) {
            ForEach(this.markers, (item: MapMarker) => {
              CardView({ marker: item })
            }, (item: MapMarker) => item.name)
          }
          .width('100%')

          Blank()

          Button('Refresh Map')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .backgroundColor('#00FF66')
            .borderRadius(14)
            .width('100%')
            .height(48)
            .onClick(() => {
              console.info('Refresh Map Tapped')
            })
        }
        .padding(16)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}

interface MapMarker {
  name: string
  distance: string
}

@Component
struct CardView {
  @ObjectLink marker: MapMarker

  build() {
    Row() {
      Column({ space: 4 }) {
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
        .backgroundColor('#00FF66')
        .borderRadius(6)
        .padding({ left: 12, right: 12, top: 4, bottom: 4 })
        .onClick(() => {
          console.info('View ' + this.marker.name + ' Tapped')
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(12)
    .backgroundColor('#0A0A0A')
    .borderRadius(10)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetY: 2
    })
  }
}
