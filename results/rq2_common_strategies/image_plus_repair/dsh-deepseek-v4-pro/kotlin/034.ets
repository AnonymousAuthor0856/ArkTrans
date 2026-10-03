interface MapMarker {
  name: string;
  distance: string;
}

@Entry
@Component
struct ExploreMapPage {
  @State query: string = '';
  private markers: MapMarker[] = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' }
  ];

  build() {
    Column() {
      Row() {
        Text('Explore Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FF66')
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#000000')

      Column({ space: 16 }) {
        TextInput({ placeholder: 'Search destination', text: this.query })
          .placeholderColor('#E0E0E0')
          .fontColor('#E0E0E0')
          .caretColor('#00FF66')
          .borderRadius(10)
          .border({ width: 1, color: '#1F1F1F' })
          .backgroundColor('#0A0A0A')
          .width('100%')
          .onChange((value: string) => {
            this.query = value;
          })

        Column({ space: 12 }) {
          ForEach(this.markers, (item: MapMarker) => {
            Column() {
              Row() {
                Column() {
                  Text(item.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#E0E0E0')
                  Text(item.distance)
                    .fontSize(13)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#CCCCCC')
                }
                .alignItems(HorizontalAlign.Start)

                Button('View', { type: ButtonType.Normal })
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')
                  .backgroundColor('#00FF66')
                  .borderRadius(6)
                  .height(36)
              }
              .width('100%')
              .padding(12)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .backgroundColor('#0A0A0A')
            .borderRadius(10)
          }, (item: MapMarker) => item.name)
        }
        .width('100%')

        Row()
          .width('100%')
          .height(32)

        Button('Refresh Map', { type: ButtonType.Normal })
          .width('100%')
          .height(48)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
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
    .backgroundColor('#000000')
  }
}