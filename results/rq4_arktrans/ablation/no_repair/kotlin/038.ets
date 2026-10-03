@Entry
@Component
struct Index {
  @State scanning: boolean = false

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        // Surface Card
        Column() {
          // Canvas Area
          Stack({ alignContent: Alignment.Center }) {
            // Background Circle (Scanning area)
            Circle().width('70%').height('70%').fill('#E0F2FE')
            
            // Markers
            Circle().width(16).height(16).fill('#06B6D4').position({ x: '30%', y: '30%' })
            Circle().width(16).height(16).fill('#06B6D4').position({ x: '50%', y: '50%' })
            Circle().width(16).height(16).fill('#06B6D4').position({ x: '80%', y: '80%' })
          }.width('100%').height('100%').padding(20)
        }
        .width('100%')
        .height(400)
        .backgroundColor('#FFFFFF')
        .borderRadius(32)
        .shadow({ radius: 12, color: '#1A000000', offsetX: 0, offsetY: 4 })

        // Controls Row
        Row({ space: 0 }) {
          Text('Scanning Active')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')
          
          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .width(52)
            .height(32)
            .selectedColor('#06B6D4')
            .onChange((isOn: boolean) => {
              this.scanning = isOn
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Add Marker Button
        Button() {
          Text('Add Marker')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .width('100%')
        .height(48)
        .backgroundColor('#06B6D4')
        .borderRadius(16)
        .onClick(() => {
          // Action placeholder
        })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#BAE6FD', 0], ['#FFFFFF', 0.5], ['#BAE6FD', 1]]
      })

      // Top App Bar
      Column() {
        Text('Invoice Scanner')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(80)
      .justifyContent(FlexAlign.End)
      .padding({ bottom: 16 })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#F0F9FF', 0], ['#F0F9FF', 1]]
      })
    }
    .width('100%')
    .height('100%')
  }
}