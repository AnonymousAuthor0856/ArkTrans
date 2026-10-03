import { canvas } from '@kit.ArkGraphics';

interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct NeonMindMap {
  // State variables to hold the nodes (points) and the current drawing color
  @State nodes: Point[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ];
  @State currentColor: string = '#00FFFF'; // Cyan

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Neon Mind Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.currentColor)
          .margin({ top: 40 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)

      // Main Canvas Area
      Stack() {
        // Custom Drawing Component for lines and circles
        Canvas(this.context)
          .width('100%')
          .height('100%')
          .backgroundColor('#0D0D0D')
          .onReady(() => {
            this.drawCanvas();
          })
          .gesture(
            GestureGroup(GestureMode.Parallel,
              PanGesture().onActionUpdate((event?: GestureEvent) => {
                if (event) {
                  const offset: number = event.offsetX;
                  const offsetY: number = event.offsetY;
                  // Add a new node on pan gesture
                  this.nodes.push({ x: offset, y: offsetY });
                  this.drawCanvas();
                }
              }),
              TapGesture().onAction(() => {
                // Add a node on tap as well for better UX
                // Note: In a real app, you might want to distinguish between tap and drag start
              })
            )
          )

        // Floating Action Button (FAB)
        Column() {
          Text('+')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .width(60)
        .height(60)
        .borderRadius(30)
        .backgroundColor('#00FF88') // Green
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .position({ right: 20, bottom: 100 })
        .onClick(() => {
          // Add a random node when FAB is clicked
          const randomX = Math.random() * 300 + 50;
          const randomY = Math.random() * 500 + 100;
          this.nodes.push({ x: randomX, y: randomY });
          this.drawCanvas();
        })
      }
      .layoutWeight(1)
      .backgroundColor('#0D0D0D')

      // Bottom Bar with Color Selection Buttons
      Row() {
        this.ColorButton('Cyan', '#00FFFF')
        this.ColorButton('Green', '#00FF88')
        this.ColorButton('Purple', '#BB86FC')
      }
      .width('100%')
      .height(100)
      .backgroundColor('#2E2E2E')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0D0D0D')
  }

  private context: canvas.CanvasRenderingContext2D = null!;

  private drawCanvas(): void {
    if (!this.context) {
      return;
    }
    
    // Clear canvas
    this.context.clearRect(0, 0, 1000, 1000); // Assuming max size or use actual bounds

    // Draw connecting lines
    for (let i = 1; i < this.nodes.length; i++) {
      this.context.beginPath();
      this.context.moveTo(this.nodes[i - 1].x, this.nodes[i - 1].y);
      this.context.lineTo(this.nodes[i].x, this.nodes[i].y);
      this.context.lineWidth = 6;
      this.context.lineCap = 'round';
      this.context.strokeStyle = this.currentColor;
      this.context.stroke();
    }

    // Draw circles at each node
    for (const node of this.nodes) {
      this.context.beginPath();
      this.context.arc(node.x, node.y, 20, 0, Math.PI * 2, false);
      this.context.fillStyle = this.currentColor;
      this.context.fill();
    }
  }

  // Reusable component for color selection buttons
  @Builder
  ColorButton(label: string, color: string) {
    Button(label)
      .backgroundColor(color)
      .fontColor(Color.Black)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .borderRadius(20)
      .width(100)
      .height(40)
      .onClick(() => {
        this.currentColor = color;
        this.drawCanvas();
      })
  }
}