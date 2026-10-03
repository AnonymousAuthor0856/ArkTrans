// MARK: - Hex Color Helper
function hexToColor(hex: number): string {
  const r = (hex >> 16) & 0xFF;
  const g = (hex >> 8) & 0xFF;
  const b = hex & 0xFF;
  return `rgb(${r}, ${g}, ${b})`;
}

// MARK: - AppTokens
interface IColors {
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

interface ITypography {
  size: number;
  weight: FontWeight;
}

interface ITypographyTokens {
  display: ITypography;
  title: ITypography;
  body: ITypography;
  label: ITypography;
}

interface ISpacing {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface IShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface IElevationMapping {
  level1: IShadowSpec;
  level2: IShadowSpec;
}

class AppTokens {
  static Colors: IColors = {
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
    onSurface: hexToColor(0xFFFFFF),
  }

  static TypographyTokens: ITypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }

  static Spacing: ISpacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  }

  static ElevationMapping: IElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  }
}

// MARK: - Point Interface
interface Point {
  x: number;
  y: number;
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State private nodes: Point[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ];
  @State private currentColor: string = AppTokens.Colors.primary;
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Canvas for drawing nodes and lines
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.canvasWidth = this.context.width;
          this.canvasHeight = this.context.height;
          this.drawCanvas();
        })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.nodes.push({ x: event.fingerList[0].localX, y: event.fingerList[0].localY });
              this.nodes = [...this.nodes];
              this.drawCanvas();
            })
        )

      // Top Bar
      Column() {
        Text("Neon Mind Map")
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .width('100%')
          .backgroundColor(AppTokens.Colors.background)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Start)

      // Bottom Bar
      Column() {
        Row({ space: AppTokens.Spacing.md }) {
          // Cyan Button
          Button("Cyan")
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(15)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.primary;
              this.drawCanvas();
            })

          // Green Button
          Button("Green")
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(15)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.secondary;
              this.drawCanvas();
            })

          // Purple Button
          Button("Purple")
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onTertiary)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(15)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.tertiary;
              this.drawCanvas();
            })
        }
        .padding(AppTokens.Spacing.md)
        .width('100%')
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .shadow({
          radius: AppTokens.ElevationMapping.level1.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)

      // Floating Action Button (FAB)
      Column() {
        Row() {
          Button('+')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .width(56)
            .height(56)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(28) // Circle
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
              offsetX: 0,
              offsetY: AppTokens.ElevationMapping.level2.dy
            })
            .onClick(() => {
              const randomX = 100 + Math.random() * 500;
              const randomY = 200 + Math.random() * 600;
              this.nodes.push({ x: randomX, y: randomY });
              this.nodes = [...this.nodes];
              this.drawCanvas();
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .justifyContent(FlexAlign.End)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
  }

  // Helper method to draw on Canvas
  private drawCanvas() {
    if (this.canvasWidth === 0 || this.canvasHeight === 0) {
      return;
    }
    // Clear canvas before redraw
    this.context.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    // Draw lines
    for (let i = 1; i < this.nodes.length; i++) {
      const start = this.nodes[i - 1];
      const end = this.nodes[i];
      this.context.beginPath();
      this.context.moveTo(start.x, start.y);
      this.context.lineTo(end.x, end.y);
      this.context.lineWidth = 6;
      this.context.strokeStyle = this.currentColor;
      this.context.stroke();
    }

    // Draw nodes
    for (const node of this.nodes) {
      this.context.beginPath();
      this.context.arc(node.x, node.y, 20, 0, Math.PI * 2);
      this.context.fillStyle = this.currentColor;
      this.context.fill();
    }
  }
}