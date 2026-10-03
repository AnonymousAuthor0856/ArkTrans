@Entry
@Component
struct Index {
  @State currentSpending: string = '0'
  @State spending: number = 0
  @State syncProgress: number = 0.3
  @State adjustSpending: string = '0'
  @State fontSize: number = 24
  @State reset: string = '0'
  @State billCalendar: string = '0'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        // Surface Card
        Column() {
          Column({ space: 0 }) {
            Text('Current Spending')
              .fontSize(16)
              .fontColor('#06B6D4')
            
            Text(`$${this.spending} / $${1000}`)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0F172A')

            Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
              .width('100%')
              .height(8)
              .color('#06B6D4')
              .backgroundColor('#E0F2FE')
          }
          .width('100%')
          .height('100%')
          .padding(16)
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
        .width('100%')
        .height(160)

        Text('Adjust Spending')
          .fontSize(16)
          .fontColor('#0F172A')

        Slider({ value: this.spending, min: 0, max: 2000 })
          .width('100%')
          .onChange((value: number) => {
            this.spending = value
          })

        Button() {
          Text('Reset')
            .fontSize(16)
            .fontColor('#FFFFFF')
        }
        .type(ButtonType.Capsule)
        .backgroundColor('#06B6D4')
        .width('100%')
        .height(48)
        .onClick(() => {
          this.spending = 0
        })
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#06B6D4', 0.3], ['#F0F9FF', 0.5], ['#06B6D4', 0.2]]
      })

      // Top App Bar Simulation (Placed at top via Stack alignment or separate column if needed, 
      // but skeleton puts it as sibling in Stack with Alignment.Top, so it overlays or sits above.
      // Given the structure, it seems to be a header. In ArkTS Stack, order matters for z-index.
      // The skeleton has Scaffold content then TopAppBar. Usually TopAppBar is on top.
      // We will place it here.
      
      Row() {
        Text('Bill Calendar')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F0F9FF')
      .position({ x: 0, y: 0 })

    }.width('100%').height('100%')
  }
}