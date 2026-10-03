class MapMarker {
  name: string;
  distance: string;

  constructor(name: string, distance: string) {
    this.name = name;
    this.distance = distance;
  }
}

@Entry
@Component
struct RootScreen {
  @State private query: string = '';

  private markers: MapMarker[] = [
    new MapMarker('Central Plaza', '1.2 km'),
    new MapMarker('Museum District', '3.4 km'),
    new MapMarker('Tech Park', '5.6 km'),
    new MapMarker('Old Town Gate', '7.8 km')
  ];

  @Builder
  CardView(marker: MapMarker) {
    Row() {
      Column() {
        Text(marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E0E0E0')
        Text(marker.distance)
          .fontSize(13)
          .fontColor('#CCCCCC')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      Button('View')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .backgroundColor('#00FF66')
        .height(28)
        .padding({ left: 12, right: 12 })
        .borderRadius(6)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#0A0A0A')
    .borderRadius(10)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      Text('Explore Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FF66')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor('#000000')

      Column() {
        TextInput({ text: this.query, placeholder: 'Search destination' })
          .fontSize(13)
          .fontColor('#E0E0E0')
          .placeholderColor('#999999')
          .backgroundColor('#111111')
          .border({ width: 1, color: '#1F1F1F', radius: 10 })
          .borderRadius(10)
          .height(48)
          .padding({ left: 12, right: 12 })
          .width('100%')
          .onChange((value: string) => {
            this.query = value;
          })

        Column() {
          ForEach(this.markers, (marker: MapMarker) => {
            this.CardView(marker)
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
          .backgroundColor('#00FF66')
          .width('100%')
          .height(48)
          .borderRadius(14)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor('#000000')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}
