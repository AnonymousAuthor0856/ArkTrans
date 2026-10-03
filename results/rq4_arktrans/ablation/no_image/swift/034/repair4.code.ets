@Entry
@Component
struct Index {
  @State query: string = ''
  @State isSearchFieldFocused: boolean = false
  private markers: Marker[] = [
    { name: 'Location A', distance: '1.2 km' },
    { name: 'Location B', distance: '3.5 km' }
  ]

  build() {
    Stack() {
      Column({ space: 0 }) {
        Text('Explore Map')
          .backgroundColor('#000000')
          .padding({ top: 12, bottom: 12 })
          .width('100%')
          .fontColor('#00FF66')
          .fontSize(28)

        Column({ space: 12 }) {
          TextInput({ placeholder: 'Search destination' })
            .width('100%')
            .borderRadius(8)
            .backgroundColor('#111111')
            .padding(8)
            .textColor(Color.Gray)
            .fontSize(13)
            .focused(this.isSearchFieldFocused)
            .onChange((value: string) => {
              this.query = value
            })

          Column({ space: 8 }) {
            ForEach(this.markers, (marker: Marker) => {
              Row() {
                Column({ space: 0 }) {
                  Text(marker.name)
                    .fontColor('#FFFFFF')
                    .fontSize(16)
                  Text(marker.distance)
                    .fontColor('#999999')
                    .fontSize(14)
                }
                Blank()
                Button('View')
                  .onClick(() => {
                    console.log(`View ${marker.name} Tapped`)
                  })
                  .backgroundColor('#00FF66')
                  .borderRadius(4)
                  .padding(8)
              }
              .width('100%')
              .shadow({ radius: 4, color: '#1F000000' })
              .borderRadius(8)
              .backgroundColor('#1A1A1A')
              .padding(12)
            })
          }.width('100%')

          Blank()

          Button('Refresh Map')
            .onClick(() => {
              console.log('Refresh Map Tapped')
            })
            .backgroundColor('#00FF66')
            .borderRadius(8)
            .padding(12)
            .width('100%')
        }.padding(12)
      }
    }.width('100%').height('100%')
  }
}

interface Marker {
  name: string;
  distance: string;
}