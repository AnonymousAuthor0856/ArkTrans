@Entry
@Component
struct RootScreen {
  @State active: string = 'Length'
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']

  build() {
    Column() {
      Text('Unit Converter')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')

      // MapArea
      Column() {
        Text('Unit Map Visualization')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')
        Text(`Active Unit: ${this.active}`)
          .fontSize(12)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(240)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#E2E8F0')
      .borderRadius(14)
      .border({ width: 1, color: '#CBD5E1' })
      .padding(14)

      // MarkerBoxes
      ForEach(this.markers, (marker: string) => {
        Column() {
          Text(marker)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')
          Text('Tap to convert')
            .fontSize(12)
            .fontColor('#0F172A')
        }
        .width('100%')
        .height(80)
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
        .padding(10)
        .backgroundColor(this.active === marker ? 'rgba(37, 99, 235, 0.3)' : '#FFFFFF')
        .borderRadius(10)
        .border({ width: 1, color: '#CBD5E1' })
      }, (item: string) => item)

      Blank().height(10)

      // Buttons Row
      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        ForEach(this.markers, (marker: string) => {
          Button() {
            Text(marker)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.active === marker ? '#FFFFFF' : '#0F172A')
          }
          .type(ButtonType.Normal)
          .backgroundColor(this.active === marker ? '#2563EB' : '#E2E8F0')
          .borderRadius(6)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .onClick(() => {
            this.active = marker
          })
        }, (item: string) => item)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .linearGradient({
      angle: 90,
      colors: [['#38BDF8', 0], ['#2563EB', 1]]
    })
  }
}