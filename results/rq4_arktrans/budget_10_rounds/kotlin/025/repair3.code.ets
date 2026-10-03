@Entry
@Component
struct Index {
  @State nodes: Array<Point> = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Canvas Area ===
      Stack({ alignContent: Alignment.Center }) {
        Canvas()
          .width('100%')
          .height('100%')
          .onReady((context: CanvasRenderingContext2D) => {
            const color = '#00FFFF'
            
            context.beginPath()
            context.strokeStyle = color
            context.lineWidth = 4
            
            if (this.nodes.length > 1) {
              context.moveTo(this.nodes[0].x, this.nodes[0].y)
              for (let i = 1; i < this.nodes.length; i++) {
                context.lineTo(this.nodes[i].x, this.nodes[i].y)
              }
            }
            context.stroke()

            for (const node of this.nodes) {
              context.beginPath()
              context.arc(node.x, node.y, 16, 0, Math.PI * 2)
              context.fillStyle = color
              context.fill()
            }
          })
      }.width('100%').height('100%').backgroundColor('#0D0D0D')

      // === Top App Bar ===
      Column() {
        Text('Neon Mind Map')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FFFF')
          .textAlign(TextAlign.Center)
          .margin({ top: 40, bottom: 20 })
      }.width('100%')

      // === Bottom Control Panel ===
      Column() {
        Row({ space: 12 }) {
          Button('Cyan')
            .backgroundColor('#00FFFF')
            .fontColor('#000000')
            .borderRadius(999)
            .height(56)
            .layoutWeight(1)
          
          Button('Green')
            .backgroundColor('#00FF88')
            .fontColor('#000000')
            .borderRadius(999)
            .height(56)
            .layoutWeight(1)
          
          Button('Purple')
            .backgroundColor('#B388FF')
            .fontColor('#000000')
            .borderRadius(999)
            .height(56)
            .layoutWeight(1)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      }
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#2E2E2E')
      .shadow({ radius: 4, color: '#1A000000', offsetY: -4 })
      .position({ x: 0, y: '100%' })
      .translate({ y: -100 }) // Adjust to sit at bottom visually
      .width('100%')

      // === Floating Action Button ===
      Button('+')
        .type(ButtonType.Circle)
        .backgroundColor('#00FF88')
        .fontColor('#000000')
        .fontSize(32)
        .width(72)
        .height(72)
        .position({ x: '100%', y: '100%' })
        .translate({ x: -60, y: -160 })
    }
    .width('100%')
    .height('100%')
  }
}

interface Point {
  x: number
  y: number
}