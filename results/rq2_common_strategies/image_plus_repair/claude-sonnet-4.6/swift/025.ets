interface NodePoint {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State nodes: NodePoint[] = [
    { x: 200, y: 400 } as NodePoint,
    { x: 500, y: 700 } as NodePoint,
    { x: 350, y: 250 } as NodePoint
  ];
  @State currentColor: string = '#00FFFF';

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    const ctx = this.canvasContext;
    ctx.clearRect(0, 0, ctx.width, ctx.height);

    // Draw lines
    for (let i = 1; i < this.nodes.length; i++) {
      const start: NodePoint = this.nodes[i - 1];
      const end: NodePoint = this.nodes[i];
      ctx.beginPath();
      ctx.moveTo(start.x, start.y);
      ctx.lineTo(end.x, end.y);
      ctx.strokeStyle = this.currentColor;
      ctx.lineWidth = 6;
      ctx.stroke();
    }

    // Draw nodes
    for (const node of this.nodes) {
      ctx.beginPath();
      ctx.arc(node.x, node.y, 20, 0, Math.PI * 2);
      ctx.fillStyle = this.currentColor;
      ctx.fill();
    }
  }

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#0D0D0D')

      // Canvas layer
      Canvas(this.canvasContext)
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Transparent)
        .onReady(() => {
          this.drawCanvas();
        })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Move || event.type === TouchType.Down) {
            const touch = event.touches[0];
            const newNode: NodePoint = { x: touch.x, y: touch.y };
            this.nodes.push(newNode);
            this.drawCanvas();
          }
        })

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
        Blank()
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)

      // Bottom Bar with FAB
      Column() {
        Blank()
        Stack() {
          // Bottom bar
          Row({ space: 12 }) {
            // Cyan button
            Button('Cyan')
              .fontSize(14)
              .fontColor('#000000')
              .fontWeight(FontWeight.Normal)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .backgroundColor('#00FFFF')
              .borderRadius(15)
              .onClick(() => {
                this.currentColor = '#00FFFF';
                this.drawCanvas();
              })

            // Green button
            Button('Green')
              .fontSize(14)
              .fontColor('#000000')
              .fontWeight(FontWeight.Normal)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .backgroundColor('#00FF88')
              .borderRadius(15)
              .onClick(() => {
                this.currentColor = '#00FF88';
                this.drawCanvas();
              })

            // Purple button
            Button('Purple')
              .fontSize(14)
              .fontColor('#000000')
              .fontWeight(FontWeight.Normal)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .backgroundColor('#BB86FC')
              .borderRadius(15)
              .onClick(() => {
                this.currentColor = '#BB86FC';
                this.drawCanvas();
              })
          }
          .padding(12)
          .width('100%')
          .backgroundColor('#2E2E2E')
          .shadow({
            radius: 8,
            color: '#1F000000',
            offsetX: 0,
            offsetY: 4
          })

          // FAB
          Row() {
            Blank()
            Button('+')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .width(56)
              .height(56)
              .backgroundColor('#00FF88')
              .borderRadius(28)
              .shadow({
                radius: 8,
                color: '#2E000000',
                offsetX: 0,
                offsetY: 4
              })
              .onClick(() => {
                const randomX: number = Math.random() * 500 + 100;
                const randomY: number = Math.random() * 600 + 200;
                const newNode: NodePoint = { x: randomX, y: randomY };
                this.nodes.push(newNode);
                this.drawCanvas();
              })
              .margin({ right: 16, bottom: 8 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Bottom)
          .padding({ bottom: 70 })
        }
        .width('100%')
        .alignContent(Alignment.Bottom)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.TopStart)
  }
}