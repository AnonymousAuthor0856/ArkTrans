import { display } from '@kit.ArkUI';

interface NodePoint {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State nodes: NodePoint[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ];
  @State currentColor: string = '#00FFFF';
  @State currentColorName: string = 'Cyan';

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private colorPrimary: string = '#00FFFF';
  private colorSecondary: string = '#00FF88';
  private colorTertiary: string = '#BB86FC';
  private colorBackground: string = '#0D0D0D';
  private colorSurface: string = '#1C1C1C';
  private colorSurfaceVariant: string = '#2E2E2E';
  private colorOnPrimary: string = '#000000';
  private colorOnSecondary: string = '#000000';
  private colorOnTertiary: string = '#000000';
  private colorOnBackground: string = '#FFFFFF';

  private drawMindMap() {
    this.canvasContext.clearRect(0, 0, this.canvasContext.width, this.canvasContext.height);

    // Draw lines between nodes
    if (this.nodes.length > 1) {
      this.canvasContext.strokeStyle = this.currentColor;
      this.canvasContext.lineWidth = 6;
      this.canvasContext.shadowColor = this.currentColor;
      this.canvasContext.shadowBlur = 8;

      for (let i = 1; i < this.nodes.length; i++) {
        this.canvasContext.beginPath();
        this.canvasContext.moveTo(this.nodes[i - 1].x, this.nodes[i - 1].y);
        this.canvasContext.lineTo(this.nodes[i].x, this.nodes[i].y);
        this.canvasContext.stroke();
      }
    }

    // Draw circles at each node
    this.nodes.forEach((node: NodePoint) => {
      this.canvasContext.beginPath();
      this.canvasContext.arc(node.x, node.y, 20, 0, Math.PI * 2);
      this.canvasContext.fillStyle = this.currentColor;
      this.canvasContext.shadowColor = this.currentColor;
      this.canvasContext.shadowBlur = 12;
      this.canvasContext.fill();
    });
  }

  private addRandomNode() {
    const x = Math.floor(Math.random() * 500) + 100;
    const y = Math.floor(Math.random() * 600) + 200;
    this.nodes.push({ x, y });
    this.drawMindMap();
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Neon Mind Map')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colorPrimary)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 16, bottom: 16 })
      }
      .width('100%')
      .backgroundColor(this.colorBackground)
      .justifyContent(FlexAlign.Center)

      // Canvas Area
      Stack() {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .backgroundColor(this.colorBackground)
          .onReady(() => {
            this.drawMindMap();
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Move) {
              const touch = event.touches[0];
              this.nodes.push({ x: touch.x, y: touch.y });
              this.drawMindMap();
            }
          })

        // FAB Button
        Button('+')
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(this.colorSecondary)
          .fontColor(this.colorOnSecondary)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .position({ x: '80%', y: '85%' })
          .shadow({
            radius: 8,
            color: this.colorSecondary,
            offsetX: 0,
            offsetY: 4
          })
          .onClick(() => {
            this.addRandomNode();
          })
      }
      .width('100%')
      .layoutWeight(1)

      // Bottom Bar
      Row() {
        Button('Cyan')
          .backgroundColor(this.colorPrimary)
          .fontColor(this.colorOnPrimary)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(8)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .border({
            width: this.currentColorName === 'Cyan' ? 2 : 0,
            color: '#FFFFFF'
          })
          .onClick(() => {
            this.currentColor = this.colorPrimary;
            this.currentColorName = 'Cyan';
            this.drawMindMap();
          })

        Button('Green')
          .backgroundColor(this.colorSecondary)
          .fontColor(this.colorOnSecondary)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(8)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .border({
            width: this.currentColorName === 'Green' ? 2 : 0,
            color: '#FFFFFF'
          })
          .onClick(() => {
            this.currentColor = this.colorSecondary;
            this.currentColorName = 'Green';
            this.drawMindMap();
          })

        Button('Purple')
          .backgroundColor(this.colorTertiary)
          .fontColor(this.colorOnTertiary)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(8)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .border({
            width: this.currentColorName === 'Purple' ? 2 : 0,
            color: '#FFFFFF'
          })
          .onClick(() => {
            this.currentColor = this.colorTertiary;
            this.currentColorName = 'Purple';
            this.drawMindMap();
          })
      }
      .width('100%')
      .backgroundColor(this.colorSurfaceVariant)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .padding({ top: 12, bottom: 12, left: 8, right: 8 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorBackground)
  }
}