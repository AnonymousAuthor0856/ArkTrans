@Entry
@Component
struct Index {
  @State activeUnit: string = 'Length';
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
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
        Text('Active Unit: ' + this.activeUnit)
          .fontSize(12)
          .fontColor('#1E293B')
          .margin({ top: 10 })
      }
      .width('100%')
      .height(240)
      .backgroundColor('#E2E8F0')
      .borderRadius(14)
      .border({ width: 1, color: '#CBD5E1' })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding(14)
      .margin({ top: 14 })

      ForEach(this.markers, (item: string) => {
        Row() {
          Column() {
            Text(item)
              .fontSize(18)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#1E293B')
            Text('Tap to convert')
              .fontSize(12)
              .fontColor('#1E293B')
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height(80)
        .backgroundColor(this.activeUnit === item ? 'rgba(56, 189, 248, 0.3)' : '#FFFFFF')
        .borderRadius(10)
        .border({ width: 1, color: '#CBD5E1' })
        .padding(10)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 14 })
      })

      Row() {
        ForEach(this.markers, (item: string) => {
          Button(item)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .backgroundColor(this.activeUnit === item ? '#2563EB' : '#E2E8F0')
            .fontColor(this.activeUnit === item ? '#FFFFFF' : '#1E293B')
            .borderRadius(6)
            .onClick(() => {
              this.activeUnit = item;
            })
        })
      }
      .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['rgba(37, 99, 235, 0.15)', 0.0], ['rgba(56, 189, 248, 0.15)', 1.0]]
    })
  }
}
