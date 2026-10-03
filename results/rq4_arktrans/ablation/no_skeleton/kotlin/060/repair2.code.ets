@Entry
@Component
struct UnitConverter {
  @State active: string = 'Length'
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']

  build() {
    // === Column (Root) ===
    // props: { space: 14, horizontalAlignment: HorizontalAlign.Center }
    // modifier: { width: '100%', height: '100%', padding: 14, backgroundColor: '#F8FAFC' }
    // children: 5
    Column({ space: 14 }) {
      // === Text ===
      // props: { text: 'Unit Converter' }
      // modifier: { fontSize: 24, fontWeight: FontWeight.Bold, color: '#0F172A' }
      Text('Unit Converter')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')

      // === Column (MapArea) ===
      // props: { horizontalAlignment: HorizontalAlign.Center, verticalAlignment: VerticalAlign.Center }
      // modifier: { width: '100%', height: 240, borderRadius: 14, backgroundColor: '#E2E8F0', borderColor: '#CBD5E1', borderWidth: 1, padding: 14 }
      // children: 2
      Column() {
        // === Text ===
        // props: { text: 'Unit Map Visualization' }
        // modifier: { fontSize: 18, fontWeight: FontWeight.SemiBold, color: '#1E293B' }
        Text('Unit Map Visualization')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')

        // === Text ===
        // props: { text: 'Active Unit: Length' }
        // modifier: { fontSize: 12, fontWeight: FontWeight.Normal, color: '#1E293B', margin: { top: 10 } }
        Text(`Active Unit: ${this.active}`)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor('#1E293B')
          .margin({ top: 10 })
      }
      .width('100%')
      .height(240)
      .borderRadius(14)
      .backgroundColor('#E2E8F0')
      .border({ width: 1, color: '#CBD5E1' })
      .padding(14)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      // === ForEach (Markers) ===
      // children: 4
      ForEach(this.markers, (unit: string) => {
        // === Column (MarkerBox) ===
        // props: { space: 6, verticalAlignment: VerticalAlign.Top }
        // modifier: { width: '100%', height: 80, borderRadius: 10, backgroundColor: (active == unit ? '#88D4F5' : '#FFF'), borderColor: '#CBD5E1', borderWidth: 1, padding: 10 }
        // children: 2
        Column({ space: 6 }) {
          // === Text ===
          // props: { text: unit }
          // modifier: { fontSize: 18, fontWeight: FontWeight.SemiBold, color: '#1E293B' }
          Text(unit)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')

          // === Text ===
          // props: { text: 'Tap to convert' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Normal, color: '#1E293B' }
          Text('Tap to convert')
            .fontSize(12)
            .fontWeight(FontWeight.Normal)
            .fontColor('#1E293B')
        }
        .width('100%')
        .height(80)
        .borderRadius(10)
        .backgroundColor(this.active === unit ? '#88D4F5' : '#FFF')
        .border({ width: 1, color: '#CBD5E1' })
        .padding(10)
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
      }, (item: string) => item)

      // === Row (Buttons) ===
      // props: { space: 10, justifyContent: FlexAlign.Start }
      // modifier: { width: '100%' }
      // children: 4
      Row({ space: 10 }) {
        ForEach(this.markers, (unit: string) => {
          // === Button ===
          // props: { type: ButtonType.Capsule }
          // modifier: { width: 'auto', height: 36, borderRadius: 18, backgroundColor: (active == unit ? '#2563EB' : '#E2E8F0'), fontColor: (active == unit ? '#FFF' : '#1E293B') }
          // children: 1
          Button(unit)
            .type(ButtonType.Capsule)
            .width('auto')
            .height(36)
            .borderRadius(18)
            .backgroundColor(this.active === unit ? '#2563EB' : '#E2E8F0')
            .fontColor(this.active === unit ? '#FFF' : '#1E293B')
            .onClick(() => {
              this.active = unit
            })
        }, (item: string) => item)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
    .padding(14)
    .backgroundColor('#F8FAFC')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }
}