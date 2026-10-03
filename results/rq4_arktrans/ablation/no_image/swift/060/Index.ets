@Entry
@Component
struct Index {
  @State active: string = ''

  build() {
    Stack() {
      Column() {
        Text('Unit Converter').fontColor('#0F172A').fontSize(24)

        Column({ space: 8 }) {
          Text('Unit Map Visualization').fontColor('#1E293B').fontSize(18)
          Text(`Active Unit: ${this.active}`).fontColor('#1E293B').fontSize(14)
        }
        .padding(16)
        .borderRadius(16)
        .backgroundColor('#F1F5F9')
        .width('100%')
        .height(240)

        ForEach(['m', 'km', 'mi'], (unit: string) => {
          Column({ space: 4 }) {
            Text(unit).fontColor('#1E293B').fontSize(18)
            Text(`${unit} value`).fontColor('#1E293B').fontSize(14)
          }
          .alignItems(HorizontalAlign.Start)
          .padding(12)
          .borderRadius(8)
          .backgroundColor(this.active === unit ? '#C4B5FD' : '#FFFFFF')
          .border({ width: 1, color: '#CBD5E1', radius: 8 })
          .width('100%')
          .height(80)
        })

        Blank().height(8)

        Row({ space: 8 }) {
          ForEach(['m', 'km', 'mi'], (marker: string) => {
            Button() {
              Text(marker).fontColor(this.active === marker ? '#FFFFFF' : '#1E293B')
            }
            .onClick(() => {
              this.active = marker
            })
            .backgroundColor(this.active === marker ? '#8B5CF6' : '#E2E8F0')
            .borderRadius(8)
            .width(60)
            .height(40)
          })
        }
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}