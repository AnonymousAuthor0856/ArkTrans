@Entry
@Component
struct Index {
  @State scanning: boolean = false

  build() {
    Stack() {
      Column() {
        Text('Invoice Scanner')
          .backgroundColor('#FFF0F9FF')
          .padding({ top: 12, bottom: 12 })
          .width('100%')
          .fontColor('#0F172A')
          .fontSize(28)

        Column() {
          // SurfaceView equivalent
          Column() {
            // BoxView equivalent
            Column() {
              // Canvas equivalent - using a simple colored box to represent the canvas area
              Column() {
                Text('Canvas Area')
                  .fontSize(14)
                  .fontColor('#9CA3AF')
              }
              .width('100%')
              .height('100%')
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            }
            .width('100%')
            .height('100%')
            .padding(8)
          }
          .width('100%')
          .height(400)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })

          Row() {
            Text('Scanning Active')
              .fontColor('#0F172A')
              .fontSize(18)
            
            Blank()
            
            Toggle({ type: ToggleType.Switch, isOn: this.scanning })
              .onChange((isOn: boolean) => {
                this.scanning = isOn
              })
          }
          .width('100%')
          .margin({ top: 16 })

          Button() {
            Text('Add Marker')
              .fontColor('#FFFFFF')
          }
          .backgroundColor('#3B82F6')
          .width('100%')
          .height(48)
          .borderRadius(8)
          .margin({ top: 16 })
          .onClick(() => {
            // Simulate adding a marker
            console.info('Marker added')
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#E0F2FE', 0], ['#BAE6FD', 1]]
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}