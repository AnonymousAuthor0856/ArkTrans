interface MapMarker {
  name: string;
  distance: string;
}

@Entry
@Component
struct ExploreMap {
  @State query: string = '';

  private readonly markers: MapMarker[] = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' }
  ];

  build() {
    Column() {
      Text('Explore Map')
        .fontSize(54)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FF66')
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 34, bottom: 80 });

      TextInput({ placeholder: 'Search destination', text: this.query })
        .width('100%')
        .height(112)
        .fontSize(32)
        .fontColor('#E0E0E0')
        .placeholderColor('#D8D8D8')
        .backgroundColor('#000000')
        .border({
          width: 2,
          color: '#1F1F1F',
          radius: 20
        })
        .padding({ left: 30, right: 30 })
        .onChange((value: string) => {
          this.query = value;
        });

      Column() {
        ForEach(this.markers, (marker: MapMarker) => {
          Row() {
            Column() {
              Text(marker.name)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor('#E0E0E0')
                .width('100%')
                .textAlign(TextAlign.Start);

              Text(marker.distance)
                .fontSize(27)
                .fontColor('#CCCCCC')
                .width('100%')
                .textAlign(TextAlign.Start)
                .margin({ top: 2 });
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1);

            Button('View')
              .width(144)
              .height(80)
              .fontSize(22)
              .fontColor('#000000')
              .backgroundColor('#00FF66')
              .borderRadius(14)
              .margin({ left: 20 });
          }
          .width('100%')
          .height(144)
          .padding({ left: 24, right: 24 })
          .backgroundColor('#0A0A0A')
          .borderRadius(20)
          .margin({ bottom: 24 });
        }, (marker: MapMarker) => marker.name);
      }
      .width('100%')
      .margin({ top: 32 });

      Blank()
        .layoutWeight(1);

      Button('Refresh Map')
        .width('100%')
        .height(96)
        .fontSize(32)
        .fontColor('#000000')
        .backgroundColor('#00FF66')
        .borderRadius(28)
        .margin({ bottom: 0 });
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32, top: 0, bottom: 0 })
    .backgroundColor('#000000')
    .justifyContent(FlexAlign.Start);
  }
}
