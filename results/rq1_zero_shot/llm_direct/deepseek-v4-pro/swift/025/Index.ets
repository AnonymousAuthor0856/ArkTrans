// Hex Color Helper
function hexToColor(hex: number): string {
  const r = (hex >> 16) & 0xFF;
  const g = (hex >> 8) & 0xFF;
  const b = hex & 0xFF;
  return `rgb(${r}, ${g}, ${b})`;
}

// AppTokens
class AppTokens {
  static readonly Colors = {
    primary: hexToColor(0x00FFFF),
    secondary: hexToColor(0x00FF88),
    tertiary: hexToColor(0xBB86FC),
    background: hexToColor(0x0D0D0D),
    surface: hexToColor(0x1C1C1C),
    surfaceVariant: hexToColor(0x2E2E2E),
    outline: hexToColor(0x3F3F3F),
    success: hexToColor(0x00FFAA),
    warning: hexToColor(0xFFC107),
    error: hexToColor(0xFF1744),
    onPrimary: hexToColor(0x000000),
    onSecondary: hexToColor(0x000000),
    onTertiary: hexToColor(0x000000),
    onBackground: hexToColor(0xFFFFFF),
    onSurface: hexToColor(0xFFFFFF)
  };

  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Regular },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static readonly Elevation = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  };
}

// Node point interface
interface NodePoint {
  x: number;
  y: number;
}

// RootScreen Component
@Entry
@Component
struct RootScreen {
  @State private nodes: NodePoint[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ];
  @State private currentColor: string = AppTokens.Colors.primary;
  private canvasContext: CanvasRenderingContext2D | null = null;

  // Canvas drawing function
  private drawCanvas(context: CanvasRenderingContext2D, width: number, height: number) {
    // Clear canvas
    context.clearRect(0, 0, width, height);

    // Draw lines between nodes
    if (this.nodes.length > 1) {
      context.strokeStyle = this.currentColor;
      context.lineWidth = 6;
      context.lineCap = 'round';
      context.lineJoin = 'round';

      for (let i = 1; i < this.nodes.length; i++) {
        const start = this.nodes[i - 1];
        const end = this.nodes[i];
        context.beginPath();
        context.moveTo(start.x, start.y);
        context.lineTo(end.x, end.y);
        context.stroke();
      }
    }

    // Draw nodes
    context.fillStyle = this.currentColor;
    for (const node of this.nodes) {
      context.beginPath();
      context.arc(node.x, node.y, 20, 0, 2 * Math.PI);
      context.fill();
    }
  }

  // Handle touch/drag events
  private handleTouch(event: TouchEvent) {
    if (event.touches.length > 0) {
      const touch = event.touches[0];
      const x = touch.x;
      const y = touch.y;
      this.nodes.push({ x, y });
    }
  }

  // Handle mouse drag events
  private handleMouseDown(event: MouseEvent) {
    const x = event.x;
    const y = event.y;
    this.nodes.push({ x, y });
  }

  // Generate random node
  private addRandomNode() {
    const randomX = Math.floor(Math.random() * 501) + 100; // 100-600
    const randomY = Math.floor(Math.random() * 601) + 200; // 200-800
    this.nodes.push({ x: randomX, y: randomY });
  }

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Canvas for drawing
      Canvas(this.canvasContext)
        .width('100%')
        .height('100%')
        .onReady(() => {
          if (this.canvasContext) {
            this.drawCanvas(this.canvasContext, this.canvasContext.width, this.canvasContext.height);
          }
        })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down || event.type === TouchType.Move) {
            this.handleTouch(event);
            if (this.canvasContext) {
              this.drawCanvas(this.canvasContext, this.canvasContext.width, this.canvasContext.height);
            }
          }
        })
        .onMouse((event: MouseEvent) => {
          if (event.action === MouseAction.Press || event.action === MouseAction.Move) {
            this.handleMouseDown(event);
            if (this.canvasContext) {
              this.drawCanvas(this.canvasContext, this.canvasContext.width, this.canvasContext.height);
            }
          }
        })

      // Top Bar
      Column() {
        Text('Neon Mind Map')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.background)
        Blank()
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)

      // Bottom Bar
      Column() {
        Blank()
        Row({ space: AppTokens.Spacing.md }) {
          // Cyan Button
          Button('Cyan')
            .fontSize(AppTokens.Typography.body.fontSize)
            .fontWeight(AppTokens.Typography.body.fontWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({
              left: AppTokens.Spacing.lg,
              right: AppTokens.Spacing.lg,
              top: AppTokens.Spacing.sm,
              bottom: AppTokens.Spacing.sm
            })
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(15)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.primary;
              if (this.canvasContext) {
                this.drawCanvas(this.canvasContext, this.canvasContext.width, this.canvasContext.height);
              }
            })

          // Green Button
          Button('Green')
            .fontSize(AppTokens.Typography.body.fontSize)
            .fontWeight(AppTokens.Typography.body.fontWeight)
            .fontColor(AppTokens.Colors.onSecondary)
            .padding({
              left: AppTokens.Spacing.lg,
              right: AppTokens.Spacing.lg,
              top: AppTokens.Spacing.sm,
              bottom: AppTokens.Spacing.sm
            })
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(15)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.secondary;
              if (this.canvasContext) {
                this.drawCanvas(this.canvasContext, this.canvasContext.width, this.canvasContext.height);
              }
            })

          // Purple Button
          Button('Purple')
            .fontSize(AppTokens.Typography.body.fontSize)
            .fontWeight(AppTokens.Typography.body.fontWeight)
            .fontColor(AppTokens.Colors.onTertiary)
            .padding({
              left: AppTokens.Spacing.lg,
              right: AppTokens.Spacing.lg,
              top: AppTokens.Spacing.sm,
              bottom: AppTokens.Spacing.sm
            })
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(15)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.tertiary;
              if (this.canvasContext) {
                this.drawCanvas(this.canvasContext, this.canvasContext.width, this.canvasContext.height);
              }
            })
        }
        .padding(AppTokens.Spacing.md)
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .shadow({
          radius: AppTokens.Elevation.level1.radius,
          color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`,
          offsetY: AppTokens.Elevation.level1.dy
        })
      }
      .width('100%')
      .height('100%')

      // Floating Action Button
      Column() {
        Blank()
        Row() {
          Blank()
          Button('+')
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.onSecondary)
            .width(56)
            .height(56)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(28)
            .shadow({
              radius: AppTokens.Elevation.level2.radius,
              color: `rgba(0, 0, 0, ${AppTokens.Elevation.level2.opacity})`,
              offsetY: AppTokens.Elevation.level2.dy
            })
            .onClick(() => {
              this.addRandomNode();
              if (this.canvasContext) {
                this.drawCanvas(this.canvasContext, this.canvasContext.width, this.canvasContext.height);
              }
            })
            .margin({ right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}