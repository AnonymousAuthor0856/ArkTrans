@Entry
@Component
struct NeonMindMap {
  // State variables to hold the nodes (points) and the current drawing color
  @State nodes: Point[] = [
    new Point(200, 400),
    new Point(500, 700),
    new Point(350, 250)
  ];
  @State currentColor: Color = '#00FFFF'; // Cyan

  // Helper class to represent a point with x and y coordinates
  class Point {
    x: number;
    y: number;
    constructor(x: number, y: number) {
      this.x = x;
      this.y = y;
    }
  }

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
        Drawing((canvas: Canvas, rect: Rect) => {
          // Draw connecting lines
          for (let i = 1; i < this.nodes.length; i++) {
            canvas.beginPath();
            canvas.moveTo(this.nodes[i - 1].x, this.nodes[i - 1].y);
            canvas.lineTo(this.nodes[i].x, this.nodes[i].y);
            canvas.lineWidth = 6;
            canvas.lineCap = LineCap.Round;
            canvas.strokeColor = this.currentColor;
            canvas.stroke();
          }

          // Draw circles at each node
          for (const node of this.nodes) {
            canvas.beginPath();
            canvas.arc(node.x, node.y, 20, 0, Math.PI * 2, false);
            canvas.fillColor = this.currentColor;
            canvas.fill();
          }
        })
        .width('100%')
        .height('100%')
        .backgroundColor('#0D0D0D')
        .gesture(
          GestureGroup(GestureMode.Parallel,
            PanGesture().onActionUpdate((event?: GestureEvent) => {
              if (event) {
                const offset: Offset = event.offsetX;
                const offsetY: Offset = event.offsetY;
                // Add a new node on pan gesture
                this.nodes.push(new Point(offset, offsetY));
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
          this.nodes.push(new Point(randomX, randomY));
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

  // Reusable component for color selection buttons
  @Builder
  ColorButton(label: string, color: Color) {
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
      })
  }
}