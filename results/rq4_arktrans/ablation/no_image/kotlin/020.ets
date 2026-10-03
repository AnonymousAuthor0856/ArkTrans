@Entry
@Component
struct Index {
  @State powerOn: boolean = false

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 24 }) {
        // Surface
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Canvas().width('100%').height('100%')
          }.width('100%').height('100%').padding(16)
        }
        .width(280)
        .height(280)
        .borderRadius(16)
        .backgroundColor('#FFEBC8')
        .shadow({ radius: 4, color: '#1A000000' })

        // Text Power Status
        Text(this.powerOn ? "Power: ON" : "Power: OFF")
          .fontSize(16)
          .fontColor(this.powerOn ? '#4CAF50' : '#F44336')

        // Row Buttons
        Row({ space: 0 }) {
          Button() {
            Text(this.powerOn ? "Off" : "On").fontSize(16)
          }
          .width(80)
          .height(80)
          .borderRadius(40)
          .backgroundColor('#FF7A00')
          .onClick(() => {
            this.powerOn = !this.powerOn
          })

          Button() {
            Text("Reset").fontSize(16)
          }
          .width(80)
          .height(80)
          .borderRadius(40)
          .backgroundColor('#FFB74D')
          .onClick(() => {
            // Reset logic placeholder
          })
        }.justifyContent(FlexAlign.SpaceEvenly).width('100%')

        // Progress Indicator
        Progress({ value: 0.3, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color('#FF7A00')
          .trackColor('#FFEBC8')
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFF8E7')

      // Top App Bar (Overlay or separate structure in Compose, here placed in Stack)
      // Note: In ArkTS, a true CenterAlignedTopAppBar is often a custom component or Row.
      // Given the skeleton structure, it's inside the Stack.
      Row() {
        Text('Retro Remote Control')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFF8E7')
    }
    .width('100%')
    .height('100%')
  }
}