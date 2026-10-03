@Entry
@Component
struct Index {
  @State markerPosition: number = 200

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        Text('Favorite Spots Map')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ top: 40, bottom: 20 })

        Stack({ alignContent: Alignment.Center }) {
          // Background Radial Gradient Simulation
          Circle().width('90%').height('90%').fill('#E0F2FE').opacity(0.5)
          Circle().width('60%').height('60%').fill('#BAE6FD').opacity(0.6)
          
          // Marker
          Row() {
            Circle().width(24).height(24).fill('#60A5FA')
          }
          .border({ width: 2, color: '#93C5FD' })
          .backgroundColor('#FFFFFF')
          .borderRadius(20)
        }
        .width('100%')
        .height(400)
        .borderRadius(32)
        .border({ width: 1, color: '#D1D5DB' })
        .backgroundColor('#F9FAFB')

        Text(`Spot Coordinates: (${this.markerPosition}, 400)`)
          .fontSize(16)
          .fontColor('#111827')
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ top: 12 })

        Button('Save Marker')
          .type(ButtonType.Capsule)
          .backgroundColor('#60A5FA')
          .fontColor('#FFFFFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .height(48)
          .margin({ top: 12, left: 16, right: 16 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16 })
      .backgroundColor('#F9FAFB')
    }.width('100%').height('100%')
  }
}