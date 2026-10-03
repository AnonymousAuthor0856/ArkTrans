// entry/src/main/ets/pages/Index.ets

import { common } from '@kit.AbilityKit';
import { drawing } from '@kit.ArkGraphics2D';

@Entry
@Component
struct RetroFilterSearch {
  @State query: string = ''
  @State knobOffset: drawing.Point = new drawing.Point(160, 120)
  
  // Mock data for results
  private results: ResultItem[] = [
    { id: 1, title: 'Result 1' },
    { id: 2, title: 'Result 2' },
    { id: 3, title: 'Result 3' },
    { id: 4, title: 'Result 4' }
  ]

  build() {
    Column() {
      // Title
      Text('Retro Filter Search')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3E2723')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ top: 16, bottom: 12 })

      // Search Field
      TextInput({ placeholder: 'Search products' })
        .type(InputType.Normal)
        .backgroundColor(Color.White)
        .borderRadius(10)
        .height(50)
        .placeholderColor('#BDBDBD')
        .placeholderFont({ size: 16 })
        .textAlign(TextAlign.Start)
        .onChange((value: string) => {
          this.query = value
        })
        .margin({ bottom: 12 })

      // Filter Chips Row
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
        Button('Popular')
          .backgroundColor('#FFD166')
          .fontColor('#3E2723')
          .borderRadius(6)
          .height(36)
          .margin({ right: 8, bottom: 8 })
        
        Button('New')
          .backgroundColor('#FFD166')
          .fontColor('#3E2723')
          .borderRadius(6)
          .height(36)
          .margin({ right: 8, bottom: 8 })
        
        Button('Discount')
          .backgroundColor('#FFD166')
          .fontColor('#3E2723')
          .borderRadius(6)
          .height(36)
          .margin({ right: 8, bottom: 8 })
          
        Button('Premium')
          .backgroundColor('#FFD166')
          .fontColor('#3E2723')
          .borderRadius(6)
          .height(36)
          .margin({ bottom: 8 })
      }
      .width('100%')
      .margin({ bottom: 12 })

      // Canvas Area (Retro Filter Visualization)
      Stack() {
        // Background container
        Rect()
          .width('100%')
          .height(180)
          .fill(Color.White)
          .borderRadius(14)
        
        // Inner content area
        Column() {
          // Simulated canvas content
          Row() {
            // Gradient circle simulation using a simple colored circle for simplicity in ArkTS without complex shaders
            Circle()
              .width(160)
              .height(160)
              .fill(new drawing.RadialGradient([
                { offset: 0, color: '#FFD166' },
                { offset: 1, color: '#FF7B00' }
              ], { c: new drawing.Point(80, 80), r: 80 }))
            
            // Knob
            Circle()
              .width(32)
              .height(32)
              .fill('#FF7B00')
              .position({ x: this.knobOffset.x - 16, y: this.knobOffset.y - 16 })
              .onTouch((event: TouchEvent) => {
                if (event.type === TouchType.Move) {
                  const touchObj = event.touches[0]
                  this.knobOffset = new drawing.Point(touchObj.localX, touchObj.localY)
                }
              })
          }
          .width('90%')
          .height('90%')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .backgroundColor('#FFF0C1')
        }
        .width('100%')
        .height('100%')
        .padding(16)
      }
      .width('100%')
      .height(180)
      .margin({ bottom: 16 })

      // Results Grid
      GridContainer() {
        ForEach(this.results, (item: ResultItem) => {
          GridItem() {
            Column() {
              // Placeholder Image Box
              Rect()
                .width('80%')
                .height(120)
                .fill('#FFF0C1')
                .borderRadius(10)
              
              Text(item.title)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#3E2723')
                .margin({ top: 12, bottom: 12 })
              
              Button('Add')
                .width('80%')
                .backgroundColor('#FF7B00')
                .fontColor(Color.White)
                .borderRadius(10)
                .height(40)
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .backgroundColor(Color.White)
            .borderRadius(14)
            .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: 4 })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .gridItemLayout({ width: '100%', height: 'auto' })
      .gap({ row: 16, column: 16 })
      .width('100%')
      .height(400) // Fixed height for grid to show scroll effect if needed
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFF6E5')
  }
}

interface ResultItem {
  id: number
  title: string
}