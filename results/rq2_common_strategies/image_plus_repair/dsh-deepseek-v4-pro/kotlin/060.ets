@Entry
@Component
struct RootScreen {
  @State active: string = 'Length'
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']

  @Builder
  MarkerBox(unit: string, value: string, isActive: boolean) {
    Column() {
      Text(unit)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
      Text(value)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor('#1E293B')
    }
    .width('100%')
    .height(80)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(isActive ? '#4D38BDF8' : '#FFFFFF')
    .borderRadius(10)
    .border({ width: 1, color: '#CBD5E1' })
    .padding(10)
  }

  @Builder
  MapArea(selected: string) {
    Column() {
      Text('Unit Map Visualization')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
      Blank().height(10)
      Text('Active Unit: ' + selected)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor('#1E293B')
    }
    .width('100%')
    .height(240)
    .backgroundColor('#E2E8F0')
    .borderRadius(14)
    .border({ width: 1, color: '#CBD5E1' })
    .padding(14)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column({ space: 14 }) {
      Text('Unit Converter')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')

      this.MapArea(this.active)

      ForEach(this.markers, (item: string) => {
        this.MarkerBox(item, 'Tap to convert', this.active === item)
      }, (item: string) => item)

      Blank().height(10)

      Row({ space: 10 }) {
        ForEach(this.markers, (item: string) => {
          Button() {
            Text(item)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.active === item ? '#FFFFFF' : '#1E293B')
          }
          .backgroundColor(this.active === item ? '#2563EB' : '#E2E8F0')
          .onClick(() => {
            this.active = item
          })
        }, (item: string) => item)
      }
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#2638BDF8', 0], ['#262563EB', 1]]
    })
    .padding(14)
    .alignItems(HorizontalAlign.Center)
  }
}
