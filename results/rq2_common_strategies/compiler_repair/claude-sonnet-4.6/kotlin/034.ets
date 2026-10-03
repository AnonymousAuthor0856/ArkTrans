import { router } from '@kit.ArkUI';

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
      // Top Bar
      Row() {
        Text('Explore Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FF66')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#000000')

      // Content
      Column({ space: 16 }) {
        // Search TextField
        TextInput({ placeholder: 'Search destination', text: this.query })
          .placeholderColor('#E0E0E0')
          .placeholderFont({ size: 13 })
          .fontColor('#E0E0E0')
          .fontSize(13)
          .caretColor('#00FF66')
          .borderRadius(10)
          .borderWidth(1)
          .borderColor('#1F1F1F')
          .backgroundColor('#0A0A0A')
          .width('100%')
          .height(48)
          .onChange((value: string) => {
            this.query = value;
          })

        // Markers List
        Column({ space: 12 }) {
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

              Button('View')
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
                .backgroundColor('#00FF66')
                .borderRadius(6)
                .height(36)
                .padding({ left: 16, right: 16 })
            }
            .width('100%')
            .padding(12)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .backgroundColor('#0A0A0A')
            .borderRadius(10)
            .shadow({
              radius: 4,
              color: '#1F000000',
              offsetX: 0,
              offsetY: 2
            })
          })
        }
        .width('100%')

        // Spacer
        Row()
          .height(32)

        // Refresh Map Button
        Button('Refresh Map')
          .width('100%')
          .height(48)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .backgroundColor('#00FF66')
          .borderRadius(14)
      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
      .backgroundColor('#000000')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}