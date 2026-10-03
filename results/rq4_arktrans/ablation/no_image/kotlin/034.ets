@Entry
@Component
struct Index {
  @State query: string = ''
  @State markers: Marker[] = [
    { name: 'Location A', distance: '1.2 km' },
    { name: 'Location B', distance: '3.5 km' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        TextInput({ placeholder: 'Search destination' })
          .width('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .padding(12)
          .onChange((value: string) => {
            this.query = value
          })

        Column({ space: 12 }) {
          ForEach(this.markers, (item: Marker) => {
            Column() {
              Row({ space: 0 }) {
                Column({ space: 4 }) {
                  Text(item.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#E0E0E0')
                  Text(item.distance)
                    .fontSize(14)
                    .fontColor('#CCCCCC')
                }
                Blank()
                Button('View')
                  .backgroundColor('#6750A4')
                  .borderRadius(8)
                  .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                  .onClick(() => {
                    // Handle view click
                  })
              }
              .alignItems(VerticalAlign.Center)
              .width('100%')
              .padding(12)
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
            .width('100%')
          })
        }
        .width('100%')

        Blank().height(32)

        Button('Refresh Map')
          .width('100%')
          .height(48)
          .backgroundColor('#6750A4')
          .borderRadius(24)
          .onClick(() => {
            // Handle refresh click
          })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#000000')

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
    }
    .width('100%')
    .height('100%')
  }
}

interface Marker {
  name: string
  distance: string
}