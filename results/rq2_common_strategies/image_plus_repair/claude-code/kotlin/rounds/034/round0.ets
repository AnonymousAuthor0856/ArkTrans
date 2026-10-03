@Entry
@Component
struct ExploreMapPage {
  @State query: string = ''
  private markers: Array<{ name: string, distance: string }> = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' }
  ]

  build() {
    Column() {
      Text('Explore Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FF66')
        .margin({ top: 24, bottom: 24 })

      TextInput({ placeholder: 'Search destination' })
        .width('100%')
        .height(56)
        .backgroundColor('#000000')
        .fontColor('#E0E0E0')
        .placeholderColor('#999999')
        .fontSize(16)
        .borderRadius(10)
        .border({ width: 1, color: '#1F1F1F' })
        .padding({ left: 16, right: 16 })
        .margin({ bottom: 16 })
        .onChange((value: string) => {
          this.query = value
        })

      Column() {
        ForEach(this.markers, (item: { name: string, distance: string }) => {
          Row() {
            Column() {
              Text(item.name)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#E0E0E0')
              Text(item.distance)
                .fontSize(13)
                .fontColor('#CCCCCC')
                .margin({ top: 4 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Button('View')
              .width(90)
              .height(44)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .backgroundColor('#00FF66')
              .borderRadius(6)
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#0A0A0A')
          .borderRadius(10)
          .margin({ bottom: 12 })
          .alignItems(VerticalAlign.Center)
        }, (item: { name: string, distance: string }) => item.name)
      }
      .width('100%')
      .layoutWeight(1)

      Button('Refresh Map')
        .width('100%')
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .backgroundColor('#00FF66')
        .borderRadius(14)
        .margin({ top: 32, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
    .padding({ left: 16, right: 16 })
  }
}
