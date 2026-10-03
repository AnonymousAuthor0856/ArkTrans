interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State nodes: Point[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ];
  @State currentColor: string = '#00FFFF';

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // === Column (Main Content) ===
      // props: { space: 16 }
      // modifier: { width: '100%', height: '100%' }
      // children: 2
      Column() {
        // === Text (Title) ===
        // props: { text: 'Neon Mind Map' }
        // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#00FFFF', margin: 16 }
        Text('Neon Mind Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FFFF')
          .margin(16)

        // === CustomPainter (Canvas) ===
        // props: { points: this.nodes, color: this.currentColor }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 0
        CustomPainter({ points: this.nodes, color: this.currentColor })
          .width('100%')
          .layoutWeight(1)
      }

      // === Button (FAB) ===
      // modifier: { width: 56, height: 56, backgroundColor: '#00FF88', fontColor: '#000000', borderRadius: 28, shadow: { radius: 6, color: '#3F000000' }, margin: 24 }
      // children: 1
      Button() {
        // === Text ===
        // props: { text: '+' }
        // modifier: { fontSize: 24, fontWeight: FontWeight.Medium }
        Text('+').fontSize(24).fontWeight(FontWeight.Medium)
      }
      .width(56)
      .height(56)
      .backgroundColor('#00FF88')
      .fontColor('#000000')
      .borderRadius(28)
      .shadow({ radius: 6, color: '#3F000000' })
      .margin(24)
      .onClick(() => {
        const randomX = Math.floor(Math.random() * 500) + 100;
        const randomY = Math.floor(Math.random() * 600) + 200;
        this.nodes.push({ x: randomX, y: randomY });
      })

      // === Row (Bottom Bar) ===
      // props: { space: 12 }
      // modifier: { width: '100%', padding: 16, backgroundColor: '#2E2E2E', alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceEvenly }
      // children: 3
      Row({ space: 12 }) {
        // === Button ===
        // modifier: { backgroundColor: '#00FFFF', fontColor: '#000000', borderRadius: 999 }
        // children: 1
        Button() {
          // === Text ===
          // props: { text: 'Cyan' }
          Text('Cyan')
        }
        .backgroundColor('#00FFFF')
        .fontColor('#000000')
        .borderRadius(999)
        .onClick(() => { this.currentColor = '#00FFFF' })

        // === Button ===
        // modifier: { backgroundColor: '#00FF88', fontColor: '#000000', borderRadius: 999 }
        // children: 1
        Button() {
          // === Text ===
          // props: { text: 'Green' }
          Text('Green')
        }
        .backgroundColor('#00FF88')
        .fontColor('#000000')
        .borderRadius(999)
        .onClick(() => { this.currentColor = '#00FF88' })

        // === Button ===
        // modifier: { backgroundColor: '#BB86FC', fontColor: '#000000', borderRadius: 999 }
        // children: 1
        Button() {
          // === Text ===
          // props: { text: 'Purple' }
          Text('Purple')
        }
        .backgroundColor('#BB86FC')
        .fontColor('#000000')
        .borderRadius(999)
        .onClick(() => { this.currentColor = '#BB86FC' })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#2E2E2E')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0D0D0D')
  }
}

// Helper component to simulate Canvas drawing in ArkTS UI tree
@Component
struct CustomPainter {
  private points: Point[] = [];
  private color: string = '';

  aboutToAppear() {
    // In a real scenario, we might use a custom Painter or Image generated from canvas, 
    // but for strict UI tree compliance without external libs, we construct the lines/circles manually.
  }

  build() {
    Stack() {
      // Draw Lines
      ForEach(this.points.slice(1), (point: Point, index: number) => {
        let prevPoint = this.points[index - 1];
        let dx = point.x - prevPoint.x;
        let dy = point.y - prevPoint.y;
        let length = Math.sqrt(dx * dx + dy * dy);
        let angle = Math.atan2(dy, dx) * 180 / Math.PI;

        // Line representation using a rotated rectangle
        RectComponent()
          .width(length)
          .height(6)
          .backgroundColor(this.color)
          .position({ x: prevPoint.x, y: prevPoint.y })
          .rotate({ angle: angle })
          .translate({ x: length / 2, y: 0 }) // Adjust anchor point
      })

      // Draw Circles
      ForEach(this.points, (point: Point) => {
        Circle()
          .width(40)
          .height(40)
          .fill(this.color)
          .position({ x: point.x - 20, y: point.y - 20 })
      })
    }
    .width('100%')
    .height('100%')
  }
}

// Simple helper for the line rotation logic if needed, though handled inline above
@Component
struct RectComponent {
  build() {
    Rectangle().fill(Color.Transparent)
  }
}