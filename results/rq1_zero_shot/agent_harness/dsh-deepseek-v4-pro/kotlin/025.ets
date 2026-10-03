const Colors = {
  primary: '#00FFFF',
  secondary: '#00FF88',
  tertiary: '#BB86FC',
  background: '#0D0D0D',
  surface: '#1C1C1C',
  surfaceVariant: '#2E2E2E',
  outline: '#3F3F3F',
  success: '#00FFAA',
  warning: '#FFC107',
  error: '#FF1744',
  onPrimary: '#000000',
  onSecondary: '#000000',
  onTertiary: '#000000',
  onBackground: '#FFFFFF',
  onSurface: '#FFFFFF'
};

const Spacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
};

interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct Index {
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true));
  @State nodes: Point[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ];
  @State currentColor: string = Colors.primary;

  drawMindMap() {
    const ctx = this.context;
    ctx.clearRect(0, 0, ctx.width, ctx.height);
    ctx.strokeStyle = this.currentColor;
    ctx.lineWidth = 6;
    for (let i = 1; i < this.nodes.length; i++) {
      ctx.beginPath();
      ctx.moveTo(this.nodes[i - 1].x, this.nodes[i - 1].y);
      ctx.lineTo(this.nodes[i].x, this.nodes[i].y);
      ctx.stroke();
    }
    ctx.fillStyle = this.currentColor;
    for (const n of this.nodes) {
      ctx.beginPath();
      ctx.arc(n.x, n.y, 20, 0, 2 * Math.PI);
      ctx.fill();
    }
  }

  build() {
    Column() {
      Row() {
        Text('Neon Mind Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Colors.background)

      Stack() {
        Canvas(this.context)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawMindMap();
          })
          .onTouch((event: TouchEvent) => {
            if (event.touches.length > 0) {
              this.nodes.push({ x: event.touches[0].x, y: event.touches[0].y });
              this.drawMindMap();
            }
          })
        Button('+')
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(Colors.secondary)
          .fontColor(Colors.onSecondary)
          .fontSize(18)
          .onClick(() => {
            this.nodes.push({ x: Math.floor(Math.random() * 501) + 100, y: Math.floor(Math.random() * 601) + 200 });
            this.drawMindMap();
          })
          .position({ right: 16, bottom: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(Colors.background)

      Row() {
        Button('Cyan')
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .onClick(() => {
            this.currentColor = Colors.primary;
          })
        Button('Green')
          .backgroundColor(Colors.secondary)
          .fontColor(Colors.onSecondary)
          .onClick(() => {
            this.currentColor = Colors.secondary;
          })
        Button('Purple')
          .backgroundColor(Colors.tertiary)
          .fontColor(Colors.onTertiary)
          .onClick(() => {
            this.currentColor = Colors.tertiary;
          })
      }
      .width('100%')
      .padding(Spacing.md)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.surfaceVariant)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
