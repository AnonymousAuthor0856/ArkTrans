interface MindNode {
  x: number
  y: number
}

@Entry
@Component
struct MainPage {
  @State private nodes: MindNode[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ]
  @State private currentColor: string = '#00FFFF'
  @State private canvasWidth: number = 750
  @State private canvasHeight: number = 1334

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  private drawMindMap(): void {
    const context = this.canvasContext
    context.clearRect(0, 0, this.canvasWidth, this.canvasHeight)
    context.lineWidth = 6
    context.strokeStyle = this.currentColor
    context.fillStyle = this.currentColor

    for (let index = 1; index < this.nodes.length; index++) {
      const start = this.nodes[index - 1]
      const end = this.nodes[index]
      context.beginPath()
      context.moveTo(start.x, start.y)
      context.lineTo(end.x, end.y)
      context.stroke()
    }

    for (const node of this.nodes) {
      context.beginPath()
      context.arc(node.x, node.y, 40, 0, Math.PI * 2)
      context.fill()
    }
  }

  private appendNode(x: number, y: number): void {
    this.nodes = [...this.nodes, { x: x, y: y }]
    this.drawMindMap()
  }

  private addRandomNode(): void {
    const x = 100 + Math.random() * 500
    const y = 200 + Math.random() * 600
    this.appendNode(x, y)
  }

  private setColor(color: string): void {
    this.currentColor = color
    this.drawMindMap()
  }

  build() {
    Stack() {
      Canvas(this.canvasContext)
        .width('100%')
        .height('100%')
        .backgroundColor('#0D0D0D')
        .onAreaChange((oldValue: Area, newValue: Area) => {
          this.canvasWidth = Number(newValue.width)
          this.canvasHeight = Number(newValue.height)
          this.drawMindMap()
        })
        .onReady(() => {
          this.drawMindMap()
        })
        .onTouch((event: TouchEvent) => {
          if (event.touches.length > 0) {
            const touch = event.touches[0]
            if (touch.type === TouchType.Down || touch.type === TouchType.Move) {
              this.appendNode(touch.x, touch.y)
            }
          }
        })

      Column() {
        Text('Neon Mind Map')
          .fontSize(56)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FFFF')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 35, bottom: 24 })
          .backgroundColor('#0D0D0D')

        Blank()
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)

      Column() {
        Blank()

        Row() {
          Button('Cyan')
            .fontSize(28)
            .fontColor('#000000')
            .backgroundColor('#00FFFF')
            .borderRadius(32)
            .padding({ left: 30, right: 30 })
            .height(64)
            .onClick(() => this.setColor('#00FFFF'))

          Button('Green')
            .fontSize(28)
            .fontColor('#000000')
            .backgroundColor('#00FF88')
            .borderRadius(32)
            .padding({ left: 30, right: 30 })
            .height(64)
            .margin({ left: 24 })
            .onClick(() => this.setColor('#00FF88'))

          Button('Purple')
            .fontSize(28)
            .fontColor('#000000')
            .backgroundColor('#BB86FC')
            .borderRadius(32)
            .padding({ left: 30, right: 30 })
            .height(64)
            .margin({ left: 24 })
            .onClick(() => this.setColor('#BB86FC'))
        }
        .width('100%')
        .height(114)
        .padding(12)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#2E2E2E')
      }
      .width('100%')
      .height('100%')

      Button('+')
        .fontSize(36)
        .fontColor('#000000')
        .backgroundColor('#00FF88')
        .width(112)
        .height(112)
        .borderRadius(56)
        .position({ right: 32, bottom: 32 })
        .onClick(() => this.addRandomNode())
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0D0D0D')
  }
}
