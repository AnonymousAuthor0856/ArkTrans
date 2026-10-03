// AppTokens - Colors
const ColorPrimary: number = 0xFF00FFFF;
const ColorSecondary: number = 0xFF00FF88;
const ColorTertiary: number = 0xFFBB86FC;
const ColorBackground: number = 0xFF0D0D0D;
const ColorSurface: number = 0xFF1C1C1C;
const ColorSurfaceVariant: number = 0xFF2E2E2E;
const ColorOutline: number = 0xFF3F3F3F;
const ColorSuccess: number = 0xFF00FFAA;
const ColorWarning: number = 0xFFFFC107;
const ColorError: number = 0xFFFF1744;
const ColorOnPrimary: number = 0xFF000000;
const ColorOnSecondary: number = 0xFF000000;
const ColorOnTertiary: number = 0xFF000000;
const ColorOnBackground: number = 0xFFFFFFFF;
const ColorOnSurface: number = 0xFFFFFFFF;

// AppTokens - Spacing
const SpacingSm: number = 8;
const SpacingMd: number = 12;
const SpacingLg: number = 16;
const SpacingXl: number = 24;

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
  @State currentColor: number = ColorPrimary;
  private canvasSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings);

  colorToRgb(color: number): string {
    const r = (color >> 16) & 0xFF;
    const g = (color >> 8) & 0xFF;
    const b = color & 0xFF;
    return `rgb(${r},${g},${b})`;
  }

  drawCanvas() {
    const ctx = this.canvasContext;
    ctx.clearRect(0, 0, ctx.width, ctx.height);

    // Draw lines
    if (this.nodes.length > 1) {
      ctx.strokeStyle = this.colorToRgb(this.currentColor);
      ctx.lineWidth = 6;
      for (let i = 1; i < this.nodes.length; i++) {
        const start: NodePoint = this.nodes[i - 1];
        const end: NodePoint = this.nodes[i];
        ctx.beginPath();
        ctx.moveTo(start.x, start.y);
        ctx.lineTo(end.x, end.y);
        ctx.stroke();
      }
    }

    // Draw nodes
    ctx.fillStyle = this.colorToRgb(this.currentColor);
    for (const node of this.nodes) {
      ctx.beginPath();
      ctx.arc(node.x, node.y, 20, 0, Math.PI * 2);
      ctx.fill();
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(ColorBackground)

      // Canvas for drawing
      Canvas(this.canvasContext)
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Transparent)
        .onReady(() => {
          this.drawCanvas();
        })
        .gesture(
          PanGesture({ fingers: 1, distance: 0 })
            .onActionStart((event: GestureEvent) => {
              const newNode: NodePoint = { x: event.offsetX, y: event.offsetY } as NodePoint;
              this.nodes.push(newNode);
              this.drawCanvas();
            })
            .onActionUpdate((event: GestureEvent) => {
              const newNode: NodePoint = { x: event.offsetX, y: event.offsetY } as NodePoint;
              this.nodes.push(newNode);
              this.drawCanvas();
            })
        )

      // Top Bar
      Column() {
        Text('Neon Mind Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(ColorPrimary)
          .padding({ top: SpacingLg, bottom: SpacingLg })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(ColorBackground)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      // Bottom Bar
      Column() {
        Blank()
        Row({ space: SpacingMd }) {
          // Cyan Button
          Button('Cyan')
            .fontSize(14)
            .fontColor(ColorOnPrimary)
            .backgroundColor(ColorPrimary)
            .borderRadius(15)
            .padding({ left: SpacingLg, right: SpacingLg, top: SpacingSm, bottom: SpacingSm })
            .onClick(() => {
              this.currentColor = ColorPrimary;
              this.drawCanvas();
            })

          // Green Button
          Button('Green')
            .fontSize(14)
            .fontColor(ColorOnSecondary)
            .backgroundColor(ColorSecondary)
            .borderRadius(15)
            .padding({ left: SpacingLg, right: SpacingLg, top: SpacingSm, bottom: SpacingSm })
            .onClick(() => {
              this.currentColor = ColorSecondary;
              this.drawCanvas();
            })

          // Purple Button
          Button('Purple')
            .fontSize(14)
            .fontColor(ColorOnTertiary)
            .backgroundColor(ColorTertiary)
            .borderRadius(15)
            .padding({ left: SpacingLg, right: SpacingLg, top: SpacingSm, bottom: SpacingSm })
            .onClick(() => {
              this.currentColor = ColorTertiary;
              this.drawCanvas();
            })
        }
        .padding(SpacingMd)
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor(ColorSurfaceVariant)
        .shadow({
          radius: 4,
          color: '#1F000000',
          offsetX: 0,
          offsetY: 2
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)

      // FAB
      Column() {
        Blank()
        Row() {
          Blank()
          Button('+')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColorOnSecondary)
            .width(56)
            .height(56)
            .backgroundColor(ColorSecondary)
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
              const newNode: NodePoint = { x: randomX, y: randomY } as NodePoint;
              this.nodes.push(newNode);
              this.drawCanvas();
            })
            .margin({ right: SpacingLg, bottom: 80 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
  }
}