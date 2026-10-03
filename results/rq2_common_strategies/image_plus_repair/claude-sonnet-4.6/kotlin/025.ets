import { drawing } from '@kit.ArkGraphics2D';

interface NodePoint {
  x: number;
  y: number;
}

const COLOR_CYAN: string = '#00FFFF';
const COLOR_GREEN: string = '#00FF88';
const COLOR_PURPLE: string = '#BB86FC';
const COLOR_BG: string = '#0D0D0D';
const COLOR_SURFACE_VARIANT: string = '#2E2E2E';
const COLOR_ON_PRIMARY: string = '#000000';

@Entry
@Component
struct RootScreen {
  @State nodes: NodePoint[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ];
  @State currentColor: string = COLOR_CYAN;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private drawCanvas() {
    this.context.clearRect(0, 0, this.context.width, this.context.height);
    if (this.nodes.length > 1) {
      for (let i = 1; i < this.nodes.length; i++) {
        this.context.beginPath();
        this.context.strokeStyle = this.currentColor;
        this.context.lineWidth = 3;
        this.context.moveTo(this.nodes[i - 1].x, this.nodes[i - 1].y);
        this.context.lineTo(this.nodes[i].x, this.nodes[i].y);
        this.context.stroke();
      }
    }
    for (let node of this.nodes) {
      this.context.beginPath();
      this.context.fillStyle = this.currentColor;
      this.context.arc(node.x, node.y, 20, 0, Math.PI * 2);
      this.context.fill();
    }
  }

  private addRandomNode() {
    const x = Math.random() * 500 + 100;
    const y = Math.random() * 600 + 200;
    this.nodes.push({ x: x, y: y });
    this.drawCanvas();
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Neon Mind Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_CYAN)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(COLOR_BG)

      // Canvas Area
      Stack({ alignContent: Alignment.BottomEnd }) {
        Canvas(this.context)
          .width('100%')
          .layoutWeight(1)
          .backgroundColor(COLOR_BG)
          .onReady(() => {
            this.drawCanvas();
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Move || event.type === TouchType.Down) {
              const touch = event.touches[0];
              this.nodes.push({ x: touch.x, y: touch.y });
              this.drawCanvas();
            }
          })

        // FAB
        Button('+')
          .width(60)
          .height(60)
          .borderRadius(30)
          .backgroundColor(COLOR_GREEN)
          .fontColor(COLOR_ON_PRIMARY)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 16, right: 16 })
          .onClick(() => {
            this.addRandomNode();
          })
      }
      .layoutWeight(1)
      .width('100%')

      // Bottom Bar
      Row() {
        Button('Cyan')
          .backgroundColor(COLOR_CYAN)
          .fontColor(COLOR_ON_PRIMARY)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(20)
          .height(44)
          .layoutWeight(1)
          .margin({ left: 8, right: 4 })
          .onClick(() => {
            this.currentColor = COLOR_CYAN;
            this.drawCanvas();
          })
        Button('Green')
          .backgroundColor(COLOR_GREEN)
          .fontColor(COLOR_ON_PRIMARY)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(20)
          .height(44)
          .layoutWeight(1)
          .margin({ left: 4, right: 4 })
          .onClick(() => {
            this.currentColor = COLOR_GREEN;
            this.drawCanvas();
          })
        Button('Purple')
          .backgroundColor(COLOR_PURPLE)
          .fontColor(COLOR_ON_PRIMARY)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(20)
          .height(44)
          .layoutWeight(1)
          .margin({ left: 4, right: 8 })
          .onClick(() => {
            this.currentColor = COLOR_PURPLE;
            this.drawCanvas();
          })
      }
      .width('100%')
      .height(72)
      .backgroundColor(COLOR_SURFACE_VARIANT)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .padding({ top: 12, bottom: 12 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BG)
  }
}