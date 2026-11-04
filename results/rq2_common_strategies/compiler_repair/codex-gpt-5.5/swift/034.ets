class MapMarker {
  name: string
  distance: string

  constructor(name: string, distance: string) {
    this.name = name
    this.distance = distance
  }
}

@Entry
@Component
struct Index {
  @State query: string = ''

  private markers: MapMarker[] = [
    new MapMarker('Central Plaza', '1.2 km'),
    new MapMarker('Museum District', '3.4 km'),
    new MapMarker('Tech Park', '5.6 km'),
    new MapMarker('Old Town Gate', '7.8 km')
  ]

  @Builder
  MarkerCard(marker: MapMarker) {
    Row() {
      Column() {
        Text(marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E0E0E0')
          .width('100%')
        Text(marker.distance)
          .fontSize(13)
          .fontColor('#CCCCCC')
          .width('100%')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('View')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .height(30)
        .backgroundColor('#00FF66')
        .borderRadius(6)
        .padding({ left: 12, right: 12 })
    }
    .width('100%')
    .padding(12)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#0A0A0A')
    .borderRadius(10)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }

  build() {
    Stack() {
      Column() {
        Text('Explore Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FF66')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 16, bottom: 16 })
          .backgroundColor('#000000')

        Column() {
          TextInput({ placeholder: 'Search destination', text: this.query })
            .fontSize(13)
            .fontColor('#E0E0E0')
            .placeholderColor('#999999')
            .caretColor('#00FF66')
            .height(48)
            .width('100%')
            .padding(12)
            .backgroundColor('#111111')
            .border({ width: 1, color: '#1F1F1F', radius: 10 })
            .onChange((value: string) => {
              this.query = value
            })

          Column() {
            ForEach(this.markers, (marker: MapMarker) => {
              Column() {
                this.MarkerCard(marker)
              }
              .margin({ bottom: 12 })
            }, (marker: MapMarker) => marker.name)
          }
          .width('100%')
          .margin({ top: 16 })

          Blank()

          Button('Refresh Map')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .width('100%')
            .height(48)
            .backgroundColor('#00FF66')
            .borderRadius(14)
        }
        .layoutWeight(1)
        .width('100%')
        .padding(16)
        .backgroundColor('#000000')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}
