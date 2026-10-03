@Entry
@Component
struct Index {
  @State query: string = ''
  @State isSearchFieldFocused: boolean = false

  // Data model for the list items
  private markers: Array<MarkerItem> = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' }
  ]

  build() {
    Stack() {
      Column() {
        // Header Text
        Text('Explore Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FF66')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 12, bottom: 12 })

        // Main Content Container
        Column() {
          // Search Input Field
          TextInput({ placeholder: 'Search destination' })
            .type(InputType.Normal)
            .text(this.query)
            .onChange((value: string) => {
              this.query = value
            })
            .backgroundColor('#111111')
            .borderRadius(16)
            .padding(12)
            .width('100%')
            .height(48)
            .fontColor('#E0E0E0')
            .placeholderColor('#666666')
            .border({
              width: 1,
              color: this.isSearchFieldFocused ? '#00FF66' : '#1F1F1F',
              radius: 16
            })
            .onFocus(() => {
              this.isSearchFieldFocused = true
            })
            .onBlur(() => {
              this.isSearchFieldFocused = false
            })

          // List of Markers
          Column({ space: 12 }) {
            ForEach(this.markers, (marker: MarkerItem) => {
              Row() {
                // Left side: Name and Distance
                Column() {
                  Text(marker.name)
                    .fontColor('#FFFFFF')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                  
                  Text(marker.distance)
                    .fontColor('#999999')
                    .fontSize(14)
                    .margin({ top: 4 })
                }

                Blank()

                // Right side: View Button
                Button('View')
                  .backgroundColor('#00FF66')
                  .fontColor('#000000')
                  .fontWeight(FontWeight.Bold)
                  .borderRadius(8)
                  .width(60)
                  .height(32)
                  .onClick(() => {
                    console.info(`View ${marker.name} Tapped`)
                  })
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .backgroundColor('#0A0A0A')
              .borderRadius(16)
              .padding({ left: 16, right: 16, top: 12, bottom: 12 })
              .shadow({ radius: 8, color: '#00000033', offsetY: 4 })
            }, (item: MarkerItem) => item.name)
          }
          .width('100%')
          .layoutWeight(1) // Take up remaining space

          Blank()

          // Bottom Refresh Button
          Button('Refresh Map')
            .width('100%')
            .height(56)
            .backgroundColor('#00FF66')
            .fontColor('#000000')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .borderRadius(28)
            .onClick(() => {
              console.info('Refresh Map Tapped')
            })
        }
        .padding(16)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#000000')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}

interface MarkerItem {
  name: string;
  distance: string;
}