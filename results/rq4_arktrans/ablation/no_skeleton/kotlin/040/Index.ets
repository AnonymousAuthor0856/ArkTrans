@Entry
@Component
struct RetroFilterSearch {
  @State query: string = ''
  @State knobX: number = 160
  @State knobY: number = 120

  build() {
    Column() {
      // Header
      Text('Retro Filter Search')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3E2723')
        .margin({ bottom: 12 })

      // Search Field
      TextInput({ placeholder: 'Search products' })
        .type(InputType.Normal)
        .width('100%')
        .height(48)
        .backgroundColor('#FFF')
        .borderRadius(10)
        .placeholderColor('#A0A0A0')
        .border({ width: 1, color: '#E0C080' })
        .onChange((value: string) => { this.query = value })
        .margin({ bottom: 12 })

      // Chips Row
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
        Button('Popular').backgroundColor('#FFD166').fontColor('#3E2723').borderRadius(6).height(36).margin({ right: 8 })
        Button('New').backgroundColor('#FFD166').fontColor('#3E2723').borderRadius(6).height(36).margin({ right: 8 })
        Button('Discount').backgroundColor('#FFD166').fontColor('#3E2723').borderRadius(6).height(36).margin({ right: 8 })
        Button('Premium').backgroundColor('#FFD166').fontColor('#3E2723').borderRadius(6).height(36)
      }
      .width('100%')
      .margin({ bottom: 12 })

      // Canvas Area (Simulated with Stack for ArkTS compatibility)
      Stack() {
        // Background Surface
        Rect().fill('#FFF').width('100%').height(180).borderRadius(14)
        
        // Inner Content Container
        Column() {
          // Light Yellow Background
          Rect().fill('#FFF0C1').width('90%').height('90%').borderRadius(0)
          
          // Gradient Circle (Center)
          Stack() {
            Circle().width(160).height(160).fill(Color.Orange) // Simplified gradient representation
          }.position({ x: '50%', y: '50%' }).translate({ x: -80, y: -80 })

          // Draggable Knob
          Stack() {
            Circle().width(32).height(32).fill('#FF7B00')
          }
          .position({ x: this.knobX, y: this.knobY })
          .translate({ x: -16, y: -16 })
          .gesture(
            PanGesture()
              .onActionUpdate((event?: GestureEvent) => {
                if (event) {
                  this.knobX += event.offsetX
                  this.knobY += event.offsetY
                }
              })
          )
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height(180)
      .margin({ bottom: 12 })

      // Grid List
      Grid() {
        ForEach([1, 2, 3, 4], (index: number) => {
          GridItem() {
            Column() {
              // Placeholder Image Box
              Rect()
                .width('80%')
                .height(120)
                .fill('#FFF0C1')
                .borderRadius(10)
                .margin({ bottom: 8 })

              // Title
              Text(`Result ${index}`)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#3E2723')
                .margin({ bottom: 8 })

              // Add Button
              Button('Add')
                .width('100%')
                .backgroundColor('#FF7B00')
                .fontColor('#FFF')
                .borderRadius(10)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFF')
            .borderRadius(14)
            .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFF6E5')
  }
}