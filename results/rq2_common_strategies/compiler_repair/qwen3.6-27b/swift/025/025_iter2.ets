import { BusinessError } from '@kit.BasicServicesKit';
import { canvas, CanvasRenderingContext2D } from '@kit.ArkGraphics';

// MARK: - Hex Color Helper
function hexToColor(hex: number): string {
  const r = (hex >> 16) & 0xFF;
  const g = (hex >> 8) & 0xFF;
  const b = hex & 0xFF;
  return `#${r.toString(16).padStart(2, '0')}${g.toString(16).padStart(2, '0')}${b.toString(16).padStart(2, '0')}`;
}

interface Point {
  x: number;
  y: number;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface ElevationToken {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface Colors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface Spacing {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface TypographyTokens {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ElevationMapping {
  level1: ElevationToken;
  level2: ElevationToken;
}

interface AppTokensConfig {
  Colors: Colors;
  TypographyTokens: TypographyTokens;
  Spacing: Spacing;
  ElevationMapping: ElevationMapping;
}

// MARK: - AppTokens
const AppTokens: AppTokensConfig = {
  Colors: {
    primary: hexToColor(0xFF00FFFF),
    secondary: hexToColor(0xFF00FF88),
    tertiary: hexToColor(0xFFBB86FC),
    background: hexToColor(0xFF0D0D0D),
    surface: hexToColor(0xFF1C1C1C),
    surfaceVariant: hexToColor(0xFF2E2E2E),
    outline: hexToColor(0xFF3F3F3F),
    success: hexToColor(0xFF00FFAA),
    warning: hexToColor(0xFFFFC107),
    error: hexToColor(0xFFFF1744),
    onPrimary: hexToColor(0xFF000000),
    onSecondary: hexToColor(0xFF000000),
    onTertiary: hexToColor(0xFF000000),
    onBackground: hexToColor(0xFFFFFFFF),
    onSurface: hexToColor(0xFFFFFFFF)
  },
  TypographyTokens: {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  },
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  },
  ElevationMapping: {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  }
};

@Entry
@Component
struct RootScreen {
  @State nodes: Point[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ];
  @State currentColor: string = AppTokens.Colors.primary;
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private context: CanvasRenderingContext2D | null = null;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background);

      // Canvas for drawing nodes and lines
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady((context: CanvasRenderingContext2D) => {
          this.context = context;
          this.canvasWidth = context.canvas.width;
          this.canvasHeight = context.canvas.height;
          this.drawCanvas(context);
        })
        .gesture(
          PanGesture()
            .onActionEnd((event: GestureEvent) => {
              if (event && event.offsetX !== undefined && event.offsetY !== undefined) {
                this.nodes.push({ x: event.offsetX, y: event.offsetY });
                this.refreshCanvas();
              }
            })
        )
        .hitTestBehavior(HitTestMode.Transparent);

      // Top Bar
      Column() {
        Text("Neon Mind Map")
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.background);
      }
      .position({ x: 0, y: 0 })
      .width('100%');

      // Bottom Bar
      Column() {
        Row() {
          Button("Cyan")
            .type(ButtonType.Normal)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .borderRadius(15)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.primary;
              this.refreshCanvas();
            });

          Button("Green")
            .type(ButtonType.Normal)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .borderRadius(15)
            .margin({ left: AppTokens.Spacing.md })
            .onClick(() => {
              this.currentColor = AppTokens.Colors.secondary;
              this.refreshCanvas();
            });

          Button("Purple")
            .type(ButtonType.Normal)
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontColor(AppTokens.Colors.onTertiary)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .borderRadius(15)
            .margin({ left: AppTokens.Spacing.md })
            .onClick(() => {
              this.currentColor = AppTokens.Colors.tertiary;
              this.refreshCanvas();
            });
        }
        .justifyContent(FlexAlign.Center)
        .padding(AppTokens.Spacing.md)
        .width('100%')
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .shadow({
          radius: AppTokens.ElevationMapping.level1.radius,
          color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy
        });
      }
      .alignItems(HorizontalAlign.Center)
      .position({ x: 0, y: this.canvasHeight - 100 }) // Approximate height adjustment
      .width('100%');

      // Floating Action Button
      Button("+")
        .type(ButtonType.Circle)
        .backgroundColor(AppTokens.Colors.secondary)
        .fontColor(AppTokens.Colors.onSecondary)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .width(56)
        .height(56)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
        .position({ x: this.canvasWidth - 80, y: this.canvasHeight - 160 })
        .onClick(() => {
          const randomX = Math.random() * 500 + 50;
          const randomY = Math.random() * 600 + 100;
          this.nodes.push({ x: randomX, y: randomY });
          this.refreshCanvas();
        });
    }
    .width('100%')
    .height('100%')
    .systemBarProperties({ statusBarColor: '#000000' });
  }

  drawCanvas(context: CanvasRenderingContext2D) {
    if (!context) return;

    // Clear canvas
    context.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    // Draw lines
    context.lineWidth = 6;
    context.strokeStyle = this.currentColor;
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

    // Draw nodes
    context.fillStyle = this.currentColor;
    for (const node of this.nodes) {
      context.beginPath();
      context.arc(node.x, node.y, 20, 0, 2 * Math.PI);
      context.fill();
    }
  }

  refreshCanvas() {
    if (this.context) {
      this.drawCanvas(this.context);
    }
  }
}