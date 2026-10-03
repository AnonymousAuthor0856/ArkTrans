interface MapMarker {
  name: string;
  distance: string;
}

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  private markers: MapMarker[] = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' }
  ];

  build() {
    Column() {
      Text('Explore Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FF66')
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 24, bottom: 24 })

      TextInput({ placeholder: 'Search destination', text: this.query })
        .placeholderColor('#E0E0E0')
        .placeholderFont({ size: 13 })
        .fontColor('#E0E0E0')
        .fontSize(13)
        .caretColor('#00FF66')
        .borderWidth(1)
        .borderColor('#1F1F1F')
        .borderRadius(10)
        .backgroundColor('#0A0A0A')
        .width('100%')
        .height(56)
        .padding({ left: 12, right: 12 })
        .onChange((value: string) => {
          this.query = value;
        })

      Column() {
        ForEach(this.markers, (marker: MapMarker) => {
          Row() {
            Column() {
              Text(marker.name)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#E0E0E0')
              Text(marker.distance)
                .fontSize(13)
                .fontWeight(FontWeight.Normal)
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
              .borderRadius(6)
              .height(40)
              .padding({ left: 16, right: 16 })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .padding(12)
          .backgroundColor('#0A0A0A')
          .borderRadius(10)
          .margin({ bottom: 12 })
        })
      }
      .width('100%')
      .margin({ top: 4 })

      Blank()

      Button('Refresh Map')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .backgroundColor('#00FF66')
        .borderRadius(14)
        .width('100%')
        .height(48)
        .margin({ bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
    .padding({ left: 16, right: 16, top: 0, bottom: 0 })
    .alignItems(HorizontalAlign.Start)
  }
}