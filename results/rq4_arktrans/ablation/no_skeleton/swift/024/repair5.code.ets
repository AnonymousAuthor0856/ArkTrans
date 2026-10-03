@Entry
@Component
struct RetroWhiteboard {
  @State points: Point[] = []
  @State currentColor: string = '#EF476F'

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // === Background ===
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFCF2')

      // === Canvas Area ===
      // Using a Column to act as the drawing surface container with padding
      Column() {
        // We use a custom component or just a stack of circles for simplicity in ArkTS without complex canvas API usage
        // However, to strictly follow "Implement every child", we map the SwiftUI Canvas logic.
        // In ArkTS, drawing dynamic shapes is often done via CustomPainter or simply stacking components.
        // Given the constraints and typical ArkTS patterns for simple UIs, we will stack Circles.
        ForEach(this.points, (point: Point) => {
          Circle()
            .width(20) // radius * 2
            .height(20)
            .fill(Color(point.color))
            .position({ x: point.x, y: point.y })
        })
      }
      .width('100%')
      .height('100%')
      .padding({ top: 54, bottom: 80 }) // topBarActualHeight + max(bottomBar, FAB)
      .gesture(
        PanGesture()
          .onActionUpdate((event: GestureEvent) => {
            if (event.state == GestureStatus.Update || event.state == GestureStatus.Begin) {
              const offset: number = event.offsetX
              const globalOffset: number = event.globalPoint.x
              // Calculate position relative to the padded area
              // This is an approximation for the gesture mapping
              this.points.push({ x: globalOffset, y: globalOffset, color: this.currentColor })
            }
          })
      )

      // === Top Bar ===
      Column() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 12, bottom: 12 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)

      // === Bottom Color Selection Bar ===
      Column() {
        Row({ space: 12 }) {
          Blank()
          
          Button() {
            Text('Red')
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor('#FFFFFF')
          }
          .width('30%') // Approximate distribution
          .height(44)
          .backgroundColor('#EF476F')
          .borderRadius(6)
          .onClick(() => { this.currentColor = '#EF476F' })

          Blank()

          Button() {
            Text('Yellow')
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor('#1E1E1E')
          }
          .width('30%')
          .height(44)
          .backgroundColor('#FFD166')
          .borderRadius(6)
          .onClick(() => { this.currentColor = '#FFD166' })

          Blank()

          Button() {
            Text('Green')
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor('#1E1E1E')
          }
          .width('30%')
          .height(44)
          .backgroundColor('#06D6A0')
          .borderRadius(6)
          .onClick(() => { this.currentColor = '#06D6A0' })

          Blank()
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FFF')
        .shadow({ radius: 2, color: 'rgba(0,0,0,0.12)', offsetY: 2 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.End)

      // === Floating Action Button (Clear) ===
      Button() {
        Text('Clear')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')
      }
      .width(56)
      .height(56)
      .backgroundColor('#FFD166')
      .borderRadius(28) // Half of width/height for circle
      .shadow({ radius: 2, color: 'rgba(0,0,0,0.12)', offsetY: 2 })
      .margin({ right: 24, bottom: 24 })
      .onClick(() => { this.points = [] })
      .position({ right: 0, bottom: 0 })
    }
    .width('100%')
    .height('100%')
  }
}

interface Point {
  x: number
  y: number
  color: string
}