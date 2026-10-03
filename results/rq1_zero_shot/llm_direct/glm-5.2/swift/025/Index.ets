// AppTokens.ets
export class AppTokens {
  static Colors = {
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
    onSurface: '#FFFFFFFF'
  };

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  };
}

// RootScreen.ets
import { AppTokens } from './AppTokens';

interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State private nodes: Point[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ];
  @State private currentColor: string = AppTokens.Colors.primary;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

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
        .onReady(() => {
          this.drawCanvas();
        })
        .gesture(
          // PanGesture with distance 0 to mimic DragGesture(minimumDistance: 0)
          PanGesture({ distance: 0 })
            .onActionStart((event: GestureEvent) => {
              this.nodes.push({ x: event.fingerList[0].localX, y: event.fingerList[0].localY });
              this.drawCanvas();
            })
            .onActionUpdate((event: GestureEvent) => {
              this.nodes.push({ x: event.fingerList[0].localX, y: event.fingerList[0].localY });
              this.drawCanvas();
            })
        )
        // Also handle touch to ensure immediate response on tap without move
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down) {
            this.nodes.push({ x: event.touches[0].x, y: event.touches[0].y });
            this.drawCanvas();
          }
        });

      // Top Bar
      Column() {
        Text('Neon Mind Map')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .width('100%')
          .backgroundColor(AppTokens.Colors.background)
          .textAlign(TextAlign.Center);
      }
      .width('100%');

      // Bottom Bar
      Column() {
        Blank(); // Push to bottom

        Row({ space: AppTokens.Spacing.md }) {
          // Cyan Button
          Button('Cyan') {
            this.currentColor = AppTokens.Colors.primary;
          }
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(15);

          // Green Button
          Button('Green') {
            this.currentColor = AppTokens.Colors.secondary;
          }
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSecondary)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(15);

          // Purple Button
          Button('Purple') {
            this.currentColor = AppTokens.Colors.tertiary;
          }
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onTertiary)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(15);
        }
        .padding(AppTokens.Spacing.md)
        .width('100%')
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .shadow({
          radius: AppTokens.ElevationMapping.level1.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy
        });
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End);

      // Floating Action Button
      Column() {
        Blank(); // Push to bottom

        Row() {
          Blank(); // Push to right
          Button('+') {
            const randomX = Math.random() * 500 + 100;
            const randomY = Math.random() * 600 + 200;
            this.nodes.push({ x: randomX, y: randomY });
            this.drawCanvas();
          }
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
          .padding(0); // Remove default button padding
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg);
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }

  private drawCanvas() {
    const ctx = this.context;
    // Clear canvas
    const width = ctx.canvas.width;
    const height = ctx.canvas.height;
    ctx.clearRect(0, 0, width, height);

    // Draw lines
    ctx.lineWidth = 6;
    ctx.strokeStyle = this.currentColor;
    ctx.beginPath();
    for (let i = 1; i < this.nodes.length; i++) {
      const start = this.nodes[i - 1];
      const end = this.nodes[i];
      ctx.moveTo(start.x, start.y);
      ctx.lineTo(end.x, end.y);
    }
    ctx.stroke();

    // Draw nodes
    ctx.fillStyle = this.currentColor;
    for (const node of this.nodes) {
      ctx.beginPath();
      ctx.arc(node.x, node.y, 20, 0, Math.PI * 2);
      ctx.fill();
    }
  }
}