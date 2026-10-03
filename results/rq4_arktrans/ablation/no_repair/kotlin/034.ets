interface Marker {
  name: string;
  distance: string;
}

@Entry
@Component
struct Index {
  @State query: string = ''
  private markers: Marker[] = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        TextInput({ placeholder: 'Search destination' })
          .width('100%')
          .height(48)
          .backgroundColor('#000000')
          .borderRadius(12)
          .border({ width: 1, color: '#333333' })
          .placeholderColor('#E0E0E0')
          .placeholderFont({ size: 16 })
          .onChange((value: string) => {
            this.query = value
          })

        Column({ space: 12 }) {
          ForEach(this.markers, (item: Marker) => {
            Column() {
              Row({ space: 0 }) {
                Column({ space: 4 }) {
                  Text(item.name)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#E0E0E0')
                  Text(item.distance)
                    .fontSize(14)
                    .fontColor('#CCCCCC')
                }
                Blank()
                Button() {
                  Text('View')
                    .fontSize(14)
                    .fontColor('#000000')
                }
                .backgroundColor('#00FF66')
                .borderRadius(8)
                .width(80)
                .height(40)
              }
              .alignItems(VerticalAlign.Center)
              .width('100%')
              .padding(12)
            }
            .backgroundColor('#0A0A0A')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
            .width('100%')
          }, (item: Marker) => item.name)
        }
        .width('100%')

        Blank().height(32)

        Button() {
          Text('Refresh Map')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .width('100%')
        .height(48)
        .backgroundColor('#00FF66')
        .borderRadius(24)
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#000000')

      Text('Explore Map')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FF66')
        .textAlign(TextAlign.Center)
        .position({ x: 0, y: 0 })
        .width('100%')
        .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
  }
}