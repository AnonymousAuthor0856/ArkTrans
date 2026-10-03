@Entry
@Component
struct Index {
  @State active: string = 'Length'

  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']

  build() {
    Stack() {
      Column({ space: 14 }) {
        Text('Unit Converter')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .textAlign(TextAlign.Center)

        // MapArea
        Column({ space: 0 }) {
          Text('Unit Map Visualization')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')
            .textAlign(TextAlign.Center)

          Blank().height(16)

          Text(`Active Unit: ${this.active}`)
            .fontSize(16)
            .fontColor('#1E293B')
            .textAlign(TextAlign.Center)
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height(240)
        .backgroundColor('#E2E8F0')
        .borderRadius(16)
        .border({ width: 1, color: '#CBD5E1', radius: 16 })
        .padding(14)

        // ForEach Markers
        ForEach(this.markers, (it: string) => {
          const isActive = this.active === it
          
          Row({ space: 0 }) {
            Column({ space: 4 }) {
              Text(it)
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1E293B')
              
              Text('Tap to convert')
                .fontSize(16)
                .fontColor('#1E293B')
            }
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Start)
            .layoutWeight(1)
          }
          .width('100%')
          .height(80)
          .backgroundColor(isActive ? '#A5D8FF' : '#FFFFFF')
          .borderRadius(16)
          .border({ width: 1, color: '#CBD5E1', radius: 16 })
          .padding(10)
          .onClick(() => {
            this.active = it
          })
        }, (it: string) => it)

        Blank().height(16)

        // Bottom Buttons Row
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
          ForEach(this.markers, (it: string) => {
            Button(it)
              .type(ButtonType.Capsule)
              .backgroundColor(this.active === it ? '#3B82F6' : '#E2E8F0')
              .fontColor(this.active === it ? '#FFFFFF' : '#1E293B')
              .margin({ right: 10, bottom: 10 })
              .onClick(() => {
                this.active = it
              })
          }, (it: string) => it)
        }
        .width('100%')
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#DBEAFE', 0], ['#BFDBFE', 1]]
      })
      .padding(14)
    }
    .width('100%')
    .height('100%')
  }
}