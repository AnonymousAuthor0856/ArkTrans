@Entry
@Component
struct UnitConverterApp {
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']
  @State active: string = 'Length'

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F8FAFC')

      // Main content
      Column({ space: 14 }) {
        Text('Unit Converter')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#0F172A')
          .width('100%')
          .textAlign(TextAlign.Center)

        // MapArea equivalent
        Column({ space: 10 }) {
          Text('Unit Map Visualization')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#1E293B')
          Text('Active Unit: ' + this.active)
            .fontSize(12)
            .foregroundColor('#1E293B')
        }
        .width('100%')
        .height(240)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#E2E8F0')
        .borderRadius(14)
        .border({ width: 1, color: '#CBD5E1', radius: 14 })
        .margin({ left: 14, right: 14 })

        // MarkerBox for each unit
        ForEach(this.markers, (unit: string) => {
          Stack({ alignContent: Alignment.Start }) {
            Column({ space: 0 }) {
              Text(unit)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#1E293B')
              Text('Tap to convert')
                .fontSize(12)
                .foregroundColor('#1E293B')
            }
            .padding(10)
            .width('100%')
            .height(80)
            .backgroundColor(this.active === unit ? '#38BDF8' : '#FFFFFF')
            .borderRadius(10)
            .border({ width: 1, color: '#CBD5E1', radius: 10 })
          }
          .width('100%')
          .onClick(() => {
            this.active = unit
          })
        })

        Blank().height(10)

        // Unit selection buttons
        Row({ space: 10 }) {
          ForEach(this.markers, (unit: string) => {
            Button() {
              Text(unit)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .foregroundColor(this.active === unit ? '#FFFFFF' : '#1E293B')
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                .textAlign(TextAlign.Center)
            }
            .backgroundColor(this.active === unit ? '#2563EB' : '#E2E8F0')
            .borderRadius(6)
            .onClick(() => {
              this.active = unit
            })
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height('100%')
      .padding(14)
      .backgroundColor('#F8FAFC')
    }
    .width('100%')
    .height('100%')
  }
}