// Name: 026MindMapen
// UI Type: Productivity
// Style Theme: Dark Neon
// Lang: en
// Baseline Size: 720x1280

class ColorTokens {
  primary: string = '#00FFFF';
  secondary: string = '#00FF88';
  tertiary: string = '#BB86FC';
  background: string = '#0D0D0D';
  surface: string = '#1C1C1C';
  surfaceVariant: string = '#2E2E2E';
  outline: string = '#3F3F3F';
  success: string = '#00FFAA';
  warning: string = '#FFC107';
  error: string = '#FF1744';
  onPrimary: string = '#000000';
  onSecondary: string = '#000000';
  onTertiary: string = '#000000';
  onBackground: string = '#FFFFFF';
  onSurface: string = '#FFFFFF';
}

class TypographySpec {
  fontSize: number = 0;
  fontWeight: FontWeight = FontWeight.Normal;
}

class TypographyTokens {
  display: TypographySpec = new TypographySpec();
  title: TypographySpec = new TypographySpec();
  body: TypographySpec = new TypographySpec();
  label: TypographySpec = new TypographySpec();
}

class SpacingTokens {
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
}

class AppTokens {
  static readonly Colors: ColorTokens = new ColorTokens();

  static readonly Typography: TypographyTokens = (() => {
    const t = new TypographyTokens();
    t.display.fontSize = 28;
    t.display.fontWeight = FontWeight.Bold;
    t.title.fontSize = 18;
    t.title.fontWeight = FontWeight.Medium;
    t.body.fontSize = 14;
    t.body.fontWeight = FontWeight.Normal;
    t.label.fontSize = 12;
    t.label.fontWeight = FontWeight.Medium;
    return t;
  })();

  static readonly Spacing: SpacingTokens = new SpacingTokens();
}

class NodePoint {
  x: number = 0;
  y: number = 0;

  constructor(x: number = 0, y: number = 0) {
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct MindMapApp {
  @State nodes: NodePoint[] = [
    new NodePoint(200, 400),
    new NodePoint(500, 700),
    new NodePoint(350, 250),
  ];
  @State currentColor: string = AppTokens.Colors.primary;
  @State canvasReady: boolean = false;
  private nodeRadius: number = 20;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToUpdate(): void {
    if (this.canvasReady) {
      this.drawMindMap();
    }
  }

  build() {
    Column() {
      Row() {
        Text('Neon Mind Map')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Stack({ alignContent: Alignment.BottomEnd }) {
        Canvas(this.ctx)
          .width('100%')
          .height('100%')
          .backgroundColor(AppTokens.Colors.background)
          .onReady(() => {
            this.canvasReady = true;
            this.drawMindMap();
          })
          .gesture(
            PanGesture()
              .onActionStart((event: GestureEvent) => {
                this.nodes.push(new NodePoint(
                  event.fingerList[0].localX,
                  event.fingerList[0].localY
                ));
              })
              .onActionUpdate((event: GestureEvent) => {
                this.nodes.push(new NodePoint(
                  event.fingerList[0].localX,
                  event.fingerList[0].localY
                ));
              })
          )

        Button('+')
          .width(56)
          .height(56)
          .borderRadius(28)
          .fontSize(24)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .margin({ right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .shadow({
            radius: 8,
            color: AppTokens.Colors.secondary + '80',
            offsetY: 4,
          })
          .onClick(() => {
            const randX: number = 100 + Math.random() * 500;
            const randY: number = 200 + Math.random() * 600;
            this.nodes.push(new NodePoint(randX, randY));
          })
      }
      .width('100%')
      .layoutWeight(1)

      Row() {
        Button('Cyan')
          .layoutWeight(1)
          .height(40)
          .margin({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .onClick(() => {
            this.currentColor = AppTokens.Colors.primary;
          })

        Button('Green')
          .layoutWeight(1)
          .height(40)
          .margin({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .onClick(() => {
            this.currentColor = AppTokens.Colors.secondary;
          })

        Button('Purple')
          .layoutWeight(1)
          .height(40)
          .margin({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontColor(AppTokens.Colors.onTertiary)
          .backgroundColor(AppTokens.Colors.tertiary)
          .onClick(() => {
            this.currentColor = AppTokens.Colors.tertiary;
          })
      }
      .width('100%')
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private drawMindMap(): void {
    const ctx: CanvasRenderingContext2D = this.ctx;

    ctx.clearRect(0, 0, 1000, 1600);

    if (this.nodes.length > 1) {
      ctx.strokeStyle = this.currentColor;
      ctx.lineWidth = 6;
      ctx.lineCap = 'round';
      ctx.shadowColor = this.currentColor;
      ctx.shadowBlur = 10;

      ctx.beginPath();
      ctx.moveTo(this.nodes[0].x, this.nodes[0].y);
      for (let i: number = 1; i < this.nodes.length; i++) {
        ctx.lineTo(this.nodes[i].x, this.nodes[i].y);
      }
      ctx.stroke();
    }

    ctx.shadowBlur = 15;
    ctx.shadowColor = this.currentColor;
    ctx.fillStyle = this.currentColor;

    for (let i: number = 0; i < this.nodes.length; i++) {
      ctx.beginPath();
      ctx.arc(this.nodes[i].x, this.nodes[i].y, this.nodeRadius, 0, Math.PI * 2);
      ctx.fill();
    }

    ctx.shadowBlur = 0;
  }
}
