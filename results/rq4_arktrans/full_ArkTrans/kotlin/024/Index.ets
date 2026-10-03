@Entry
@Component
struct Index {
  @State Clear: string = '0'
  @State Red: string = '0'
  @State Yellow: string = '0'
  @State Green: string = '0'
  @State RetroWhiteboard: string = '0'

  build() {
    Stack() {
      // === Scaffold ===
      Stack({ alignContent: Alignment.Top }) {
        // === Box (Canvas Container) ===
        Stack({ alignContent: Alignment.Center }) {
          Canvas().width('100%').height('100%')
        }.width('100%').height('100%').padding(16).backgroundColor('#FFFCF2')

        // === CenterAlignedTopAppBar ===
        Column() {
          Text('Retro Whiteboard')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E1E1E')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 40, bottom: 20 })

        // === Surface (Bottom Bar) ===
        Column() {
          Row({ space: 20 }) {
            Button('Red')
              .backgroundColor('#EF476F')
              .fontColor('#FFFFFF')
              .borderRadius(8)
              .width('30%')
              .height(50)
            
            Button('Yellow')
              .backgroundColor('#FFD166')
              .fontColor('#1E1E1E')
              .borderRadius(8)
              .width('30%')
              .height(50)
              
            Button('Green')
              .backgroundColor('#06D6A0')
              .fontColor('#1E1E1E')
              .borderRadius(8)
              .width('30%')
              .height(50)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .position({ x: 0, y: -100 }) // Adjusted to sit at bottom relative to stack flow if needed, but usually absolute positioning is better for overlays. 
                                     // However, following the skeleton structure which nests it in a Top-aligned stack, we use position or margin.
                                     // To match screenshot exactly where it's at the very bottom:
        .margin({ top: '100%' }) // Push to bottom
        .translate({ y: -60 })   // Pull up slightly to overlap content area like a floating bar
        .shadow({ radius: 4, color: '#1A000000' })
        .backgroundColor('#FFFFFF')
        .padding(12)

        // === FloatingActionButton ===
        Button('Clear')
          .type(ButtonType.Circle)
          .backgroundColor('#FFD166')
          .fontColor('#1E1E1E')
          .width(80)
          .height(80)
          .shadow({ radius: 8, color: '#33000000', offsetX: 0, offsetY: 4 })
          .position({ x: '100%', y: '100%' })
          .translate({ x: -60, y: -140 }) // Positioning based on the "bottom right" visual from screenshot
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}