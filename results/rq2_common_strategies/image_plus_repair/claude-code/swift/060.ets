@Entry
@Component
struct UnitConverterPage {
  @State active: string = 'Length';
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];

  build() {
    Column() {
      Text('Unit Converter')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')

      Column() {
        Text('Unit Map Visualization')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
        Text('Active Unit: ' + this.active)
          .fontSize(12)
          .fontWeight(FontWeight.Regular)
          .fontColor('#1E293B')
          .margin({ top: 10 })
      }
      .width('100%')
      .height(240)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#E2E8F0')
      .borderRadius(14)
      .border({ width: 1, color: '#CBD5E1' })
      .padding(14)
      .margin({ top: 14 })

      ForEach(this.markers, (marker: string) => {
        Column() {
          Text(marker)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')
          Text('Tap to convert')
            .fontSize(12)
            .fontWeight(FontWeight.Regular)
            .fontColor('#1E293B')
            .margin({ top: 4 })
        }
        .width('100%')
        .height(80)
        .padding(10)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Start)
        .backgroundColor(this.active === marker ? 'rgba(56, 189, 248, 0.3)' : '#FFFFFF')
        .borderRadius(10)
        .border({ width: 1, color: '#CBD5E1' })
        .margin({ top: 14 })
      }, (marker: string) => marker)

      Blank()
        .height(10)
        .margin({ top: 14 })

      Row() {
        ForEach(this.markers, (marker: string) => {
          Button(marker)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .backgroundColor(this.active === marker ? '#2563EB' : '#E2E8F0')
            .fontColor(this.active === marker ? '#FFFFFF' : '#1E293B')
            .borderRadius(6)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .onClick(() => {
              this.active = marker;
            })
            .layoutWeight(1)
        }, (marker: string) => marker)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: 14 })
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['rgba(56, 189, 248, 0.15)', 0.0], ['rgba(37, 99, 235, 0.15)', 1.0]]
    })
  }
}
