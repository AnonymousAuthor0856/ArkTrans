@Entry
@Component
struct Index {
  @State powerOn: boolean = false
  @State syncProgress: number = 0.3

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 24 }) {
        // Surface Card
        Column() {
          Stack({ alignContent: Alignment.TopStart }) {
            // Canvas Background (Simulated with Shape)
            Column() {
              Row() {
                Circle().width('100%').height('100%')
              }.width('100%').height('100%').backgroundColor('#FFEBC8')
            }.width('100%').height('100%')

            // Power Indicator Dot
            Circle()
              .width(32)
              .height(32)
              .margin({ top: 16, left: 16 })
              .backgroundColor(this.powerOn ? '#4CAF50' : '#FF7A00')
          }
          .width('100%')
          .height('100%')
          .padding(16)
        }
        .width(280)
        .height(280)
        .borderRadius(32)
        .shadow({ radius: 10, color: '#1A000000', offsetY: 4 })
        .backgroundColor('#FFF8E7')

        // Status Text
        Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.powerOn ? '#4CAF50' : '#D32F2F')

        // Buttons Row
        Row({ space: 24 }) {
          // On/Off Button
          Button() {
            Text(this.powerOn ? 'Off' : 'On')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
          }
          .width(80)
          .height(80)
          .borderRadius(40)
          .backgroundColor('#FF7A00')
          .onClick(() => {
            this.powerOn = !this.powerOn
          })

          // Reset Button
          Button() {
            Text('Reset')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1E1E1E')
          }
          .width(80)
          .height(80)
          .borderRadius(40)
          .backgroundColor('#FFC107')
          .onClick(() => {
            this.syncProgress = 0.3
          })
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')

        // Progress Bar
        Progress({ value: this.syncProgress, total: 1.0, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color('#FF7A00')
          .trackColor('#FFEBC8')
          .borderRadius(3)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFF8E7')

      // Top App Bar
      Column() {
        Text('Retro Remote Control')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#FFF8E7')
    }
    .width('100%')
    .height('100%')
  }
}