@Entry
@Component
struct RootScreen {
  @State query: string = ""
  private markers: MapMarker[] = [
    { name: "Central Plaza", distance: "1.2 km" },
    { name: "Museum District", distance: "3.4 km" },
    { name: "Tech Park", distance: "5.6 km" },
    { name: "Old Town Gate", distance: "7.8 km" }
  ]

  build() {
    Stack() {
      // Background color for entire screen
      Column() {}
        .width('100%')
        .height('100%')
        .backgroundColor('#FF000000')

      Column({ space: 0 }) {
        // Top Bar
        Text('Explore Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#FF00FF66')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 24, bottom: 24 })
          .backgroundColor('#FF000000')

        // Main content
        Column({ space: 16 }) {
          // Search TextInput
          TextInput({ placeholder: 'Search destination', text: this.query })
            .width('100%')
            .height(44)
            .fontSize(13)
            .fontWeight(FontWeight.Regular)
            .foregroundColor('#FFE0E0E0')
            .caretColor('#FF00FF66')
            .padding({ left: 12, right: 12, top: 12, bottom: 12 })
            .backgroundColor('#FF111111')
            .borderRadius(10)
            .border({ width: 1, color: '#FF1F1F1F' })
            .onChange((value: string) => {
              this.query = value
            })

          // Markers List
          List({ space: 12 }) {
            ForEach(this.markers, (marker: MapMarker) => {
              ListItem() {
                Row({ space: 0 }) {
                  Column({ space: 0 }) {
                    Text(marker.name)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .foregroundColor('#FFE0E0E0')
                    Text(marker.distance)
                      .fontSize(13)
                      .fontWeight(FontWeight.Regular)
                      .foregroundColor('#FFCCCCCC')
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank().layoutWeight(1)

                  Button() {
                    Text('View')
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .foregroundColor('#FF000000')
                      .padding({ left: 12, right: 12, top: 4, bottom: 4 })
                  }
                  .backgroundColor('#FF00FF66')
                  .borderRadius(6)
                  .onClick(() => {
                    // Handle view action
                  })
                }
                .width('100%')
                .padding(12)
                .backgroundColor('#FF0A0A0A')
                .borderRadius(10)
                .shadow({ radius: 4, color: 'rgba(0,0,0,0.12)', offsetX: 0, offsetY: 2 })
              }
            })
          }
          .width('100%')
          .layoutWeight(1)

          // Refresh Map Button
          Button() {
            Text('Refresh Map')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FF000000')
          }
          .width('100%')
          .height(48)
          .backgroundColor('#FF00FF66')
          .borderRadius(14)
          .onClick(() => {
            // Handle refresh action
          })
        }
        .width('100%')
        .height('100%')
        .padding(16)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

interface MapMarker {
  name: string
  distance: string
}