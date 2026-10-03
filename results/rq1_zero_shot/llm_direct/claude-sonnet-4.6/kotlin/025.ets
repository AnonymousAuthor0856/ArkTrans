import { router } from '@kit.ArkUI';

// App Tokens
const AppColors = {
  primary: '#FF00FFFF',
  secondary: '#FF00FF88',
  tertiary: '#FFBB86FC',
  background: '#FF0D0D0D',
  surface: '#FF1C1C1C',
  surfaceVariant: '#FF2E2E2E',
  outline: '#FF3F3F3F',
  success: '#FF00FFAA',
  warning: '#FFFFC107',
  error: '#FFFF1744',
  onPrimary: '#FF000000',
  onSecondary: '#FF000000',
  onTertiary: '#FF000000',
  onBackground: '#FFFFFFFF',
  onSurface: '#FFFFFFFF',
};

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
  @State currentColor: string = AppColors.primary;
  private canvasSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings);
  @State canvasWidth: number = 0;
  @State canvasHeight: number = 0;

  private randomInRange(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  private drawCanvas() {
    const ctx = this.canvasContext;
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    // Draw lines
    if (this.nodes.length > 1) {
      ctx.strokeStyle = this.currentColor;
      ctx.lineWidth = 6;
      for (let i = 1; i < this.nodes.length; i++) {
        ctx.beginPath();
        ctx.moveTo(this.nodes[i - 1].x, this.nodes[i - 1].y);
        ctx.lineTo(this.nodes[i].x, this.nodes[i].y);
        ctx.stroke();
      }
    }

    // Draw circles
    this.nodes.forEach((node: NodePoint) => {
      ctx.beginPath();
      ctx.fillStyle = this.currentColor;
      ctx.arc(node.x, node.y, 20, 0, Math.PI * 2);
      ctx.fill();
    });
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Neon Mind Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.background)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Canvas Area
      Stack({ alignContent: Alignment.BottomEnd }) {
        Canvas(this.canvasContext)
          .width('100%')
          .layoutWeight(1)
          .backgroundColor(AppColors.background)
          .onReady(() => {
            this.canvasWidth = this.canvasContext.width;
            this.canvasHeight = this.canvasContext.height;
            this.drawCanvas();
          })
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                const newNode: NodePoint = {
                  x: event.offsetX,
                  y: event.offsetY
                };
                this.nodes.push(newNode);
                this.drawCanvas();
              })
          )

        // FAB
        Button('+')
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(AppColors.secondary)
          .fontColor(AppColors.onSecondary)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 80, right: 16 })
          .onClick(() => {
            const newNode: NodePoint = {
              x: this.randomInRange(100, 600),
              y: this.randomInRange(200, 800)
            };
            this.nodes.push(newNode);
            this.drawCanvas();
          })
      }
      .layoutWeight(1)
      .width('100%')

      // Bottom Bar
      Row() {
        Button('Cyan')
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(8)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .onClick(() => {
            this.currentColor = AppColors.primary;
            this.drawCanvas();
          })

        Button('Green')
          .backgroundColor(AppColors.secondary)
          .fontColor(AppColors.onSecondary)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(8)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .onClick(() => {
            this.currentColor = AppColors.secondary;
            this.drawCanvas();
          })

        Button('Purple')
          .backgroundColor(AppColors.tertiary)
          .fontColor(AppColors.onTertiary)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(8)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .onClick(() => {
            this.currentColor = AppColors.tertiary;
            this.drawCanvas();
          })
      }
      .width('100%')
      .height(64)
      .backgroundColor(AppColors.surfaceVariant)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .padding(12)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}