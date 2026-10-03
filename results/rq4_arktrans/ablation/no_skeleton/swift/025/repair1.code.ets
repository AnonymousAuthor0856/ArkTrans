@Entry
@Component
struct RootScreen {
  @State nodes: Point[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ]
  @State currentColor: string = '#00FFFF'

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#0D0D0D')

      // Canvas for drawing lines and nodes
      Canvas(this)
        .width('100%')
        .height('100%')
        .onDraw((context: CanvasRenderingContext2D, size: Size) => {
          // Draw lines
          for (let i = 1; i < this.nodes.length; i++) {
            const start = this.nodes[i - 1]
            const end = this.nodes[i]
            context.beginPath()
            context.moveTo(start.x, start.y)
            context.lineTo(end.x, end.y)
            context.strokeStyle = this.currentColor
            context.lineWidth = 6
            context.stroke()
          }

          // Draw nodes
          for (const node of this.nodes) {
            context.beginPath()
            context.arc(node.x, node.y, 20, 0, Math.PI * 2)
            context.fillStyle = this.currentColor
            context.fill()
          }
        })
        .gesture(
          PanGesture()
            .onActionEnd((event?: GestureEvent) => {
              if (event) {
                this.nodes.push({ x: event.localX, y: event.localY })
              }
            })
        )

      // Top Bar
      Column() {
        Text('Neon Mind Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FFFF')
          .padding({ top: 16, bottom: 16 })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor('#0D0D0D')
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .width('100%')

      // Bottom Bar
      Column() {
        Row({ space: 12 }) {
          Button() {
            Text('Cyan')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor('#000000')
          }
          .backgroundColor('#00FFFF')
          .borderRadius(15)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })

          Button() {
            Text('Green')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor('#000000')
          }
          .backgroundColor('#00FF88')
          .borderRadius(15)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .onClick(() => {
            this.currentColor = '#00FF88'
          })

          Button() {
            Text('Purple')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor('#000000')
          }
          .backgroundColor('#BB86FC')
          .borderRadius(15)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .onClick(() => {
            this.currentColor = '#BB86FC'
          })
        }
        .padding(12)
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#2E2E2E')
        .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.12)', offsetY: 2 })
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.End)
      .width('100%')
      .height('100%')

      // Floating Action Button
      Button() {
        Text('+')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .width(56)
      .height(56)
      .backgroundColor('#00FF88')
      .borderRadius(28)
      .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.18)', offsetY: 4 })
      .margin(16)
      .position({ right: 0, bottom: 0 })
      .onClick(() => {
        const randomX = Math.random() * 500 + 50
        const randomY = Math.random() * 600 + 100
        this.nodes.push({ x: randomX, y: randomY })
      })
    }
    .width('100%')
    .height('100%')
  }
}

interface Point {
  x: number
  y: number
}