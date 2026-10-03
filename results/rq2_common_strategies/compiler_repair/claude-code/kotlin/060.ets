@Entry
@Component
struct Index {
  @State active: string = 'Length'
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']

  build() {
    Column() {
      Text('Unit Converter')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .margin({ bottom: 14 })

      // MapArea
      Column() {
        Text('Unit Map Visualization')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
        Blank()
        Text('Active Unit: ' + this.active)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor('#1E293B')
      }
      .width('100%')
      .height(240)
      .backgroundColor('#E2E8F0')
      .border({ width: 1, color: '#CBD5E1', radius: 14 })
      .padding(14)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 14 })

      // MarkerBox list
      ForEach(this.markers, (item: string) => {
        Row() {
          Column() {
            Text(item)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1E293B')
            Text('Tap to convert')
              .fontSize(12)
              .fontWeight(FontWeight.Normal)
              .fontColor('#1E293B')
          }
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height(80)
        .backgroundColor(this.active === item ? 'rgba(56, 189, 248, 0.3)' : '#FFFFFF')
        .border({ width: 1, color: '#CBD5E1', radius: 10 })
        .padding(10)
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: 14 })
      }, (item: string) => item)

      // Button row
      Row() {
        ForEach(this.markers, (item: string) => {
          Button(item)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .backgroundColor(this.active === item ? '#2563EB' : '#E2E8F0')
            .fontColor(this.active === item ? '#FFFFFF' : '#1E293B')
            .borderRadius(10)
            .onClick(() => {
              this.active = item
            })
        }, (item: string) => item)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['rgba(56, 189, 248, 0.15)', 0.0], ['rgba(37, 99, 235, 0.15)', 1.0]]
    })
    .padding(14)
    .alignItems(HorizontalAlign.Center)
  }
}
