// Name: 026MindMapen
// UI Type: Productivity
// Style Theme: Dark Neon
// Lang: en
// Baseline Size: 720x1280

import prompt from '@ohos.promptAction';

class AppTokens {
  static readonly Colors = {
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
    onSurface: '#FFFFFF',
  };

  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  };
}

interface NodePoint {
  x: number;
  y: number;
}

@Entry
@Component
struct MindMapApp {
  @State nodes: NodePoint[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 },
  ];
  @State currentColor: string = AppTokens.Colors.primary;
  private nodeRadius: number = 20;

  build() {
    Stack() {
      // Background
      Column() {
        // Top Bar
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

        // Canvas Area
        Stack() {
          Canvas(this.getCanvasSettings())
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawMindMap();
            })
            .gesture(
              PanGesture()
                .onActionStart((event: GestureEvent) => {
                  const localX = event.fingerList[0].localX;
                  const localY = event.fingerList[0].localY;
                  this.nodes.push({ x: localX, y: localY });
                })
                .onActionUpdate((event: GestureEvent) => {
                  const localX = event.fingerList[0].localX;
                  const localY = event.fingerList[0].localY;
                  this.nodes.push({ x: localX, y: localY });
                })
            )
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // Floating Action Button
      Column() {
        Blank()
        Row() {
          Blank()
          Button('+')
            .width(56)
            .height(56)
            .borderRadius(28)
            .fontSize(24)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .margin({ right: AppTokens.Spacing.lg, bottom: 100 })
            .shadow({
              radius: 8,
              color: AppTokens.Colors.secondary + '80',
              offsetY: 4,
            })
            .onClick(() => {
              const randX = 100 + Math.random() * 500;
              const randY = 200 + Math.random() * 600;
              this.nodes.push({ x: randX, y: randY });
            })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      Column() {
        Blank()
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
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  getCanvasSettings() {
    return this.ctx;
  }

  private drawMindMap(): void {
    const ctx = this.ctx;

    ctx.clearRect(0, 0, 1000, 1600);

    // Draw lines between consecutive nodes
    if (this.nodes.length > 1) {
      ctx.strokeStyle = this.currentColor;
      ctx.lineWidth = 6;
      ctx.lineCap = 'round';
      ctx.shadowColor = this.currentColor;
      ctx.shadowBlur = 10;

      ctx.beginPath();
      ctx.moveTo(this.nodes[0].x, this.nodes[0].y);
      for (let i = 1; i < this.nodes.length; i++) {
        ctx.lineTo(this.nodes[i].x, this.nodes[i].y);
      }
      ctx.stroke();
    }

    // Draw node circles
    ctx.shadowBlur = 15;
    ctx.shadowColor = this.currentColor;
    ctx.fillStyle = this.currentColor;

    for (let i = 0; i < this.nodes.length; i++) {
      ctx.beginPath();
      ctx.arc(this.nodes[i].x, this.nodes[i].y, this.nodeRadius, 0, Math.PI * 2);
      ctx.fill();
    }

    ctx.shadowBlur = 0;
  }
}
