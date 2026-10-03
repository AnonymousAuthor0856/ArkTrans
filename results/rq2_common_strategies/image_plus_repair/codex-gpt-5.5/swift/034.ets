interface MapMarker {
  name: string
  distance: string
}

@Entry
@Component
struct ExploreMapPage {
  @State query: string = ''
  @State searchFocused: boolean = false

  private readonly markers: MapMarker[] = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' }
  ]

  build() {
    Column() {
      Text('Explore Map')
        .fontSize(54)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FF66')
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 4, bottom: 66 })

      TextInput({ placeholder: 'Search destination', text: this.query })
        .fontSize(24)
        .fontColor('#E0E0E0')
        .placeholderColor('#1F1F1F')
        .caretColor('#00FF66')
        .padding({ left: 24, right: 24 })
        .height(84)
        .width('100%')
        .backgroundColor('#111111')
        .border({
          width: 2,
          color: this.searchFocused ? '#00FF66' : '#1F1F1F'
        })
        .borderRadius(22)
        .onChange((value: string) => {
          this.query = value
        })
        .onFocus(() => {
          this.searchFocused = true
        })
        .onBlur(() => {
          this.searchFocused = false
        })

      Column({ space: 24 }) {
        ForEach(this.markers, (marker: MapMarker) => {
          Row() {
            Column() {
              Text(marker.name)
                .fontSize(32)
                .fontColor('#E0E0E0')
                .fontWeight(FontWeight.Medium)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Text(marker.distance)
                .fontSize(26)
                .fontColor('#CCCCCC')
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Button('View', { type: ButtonType.Capsule })
              .fontSize(24)
              .fontColor('#000000')
              .fontWeight(FontWeight.Regular)
              .backgroundColor('#00FF66')
              .width(100)
              .height(44)
              .padding(0)
              .onClick(() => {
                console.info(`View ${marker.name} Tapped`)
              })
          }
          .width('100%')
          .height(120)
          .padding({ left: 24, right: 24 })
          .backgroundColor('#0A0A0A')
          .borderRadius(20)
        })
      }
      .width('100%')
      .margin({ top: 32 })

      Blank()
        .layoutWeight(1)

      Button('Refresh Map', { type: ButtonType.Capsule })
        .fontSize(32)
        .fontColor('#000000')
        .fontWeight(FontWeight.Regular)
        .backgroundColor('#00FF66')
        .width('100%')
        .height(96)
        .padding(0)
        .margin({ bottom: 0 })
        .onClick(() => {
          console.info('Refresh Map Tapped')
        })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32, top: 34, bottom: 32 })
    .backgroundColor('#000000')
  }
}
