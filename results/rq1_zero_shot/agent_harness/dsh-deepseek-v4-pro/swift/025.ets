// AppTokens
class AppColors {
  static readonly primary: string = '#00FFFF';
  static readonly secondary: string = '#00FF88';
  static readonly tertiary: string = '#BB86FC';
  static readonly background: string = '#0D0D0D';
  static readonly surface: string = '#1C1C1C';
  static readonly surfaceVariant: string = '#2E2E2E';
  static readonly outline: string = '#3F3F3F';
  static readonly success: string = '#00FFAA';
  static readonly warning: string = '#FFC107';
  static readonly error: string = '#FF1744';
  static readonly onPrimary: string = '#000000';
  static readonly onSecondary: string = '#000000';
  static readonly onTertiary: string = '#000000';
  static readonly onBackground: string = '#FFFFFF';
  static readonly onSurface: string = '#FFFFFF';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class AppShadows {
  static readonly level1Color: string = '#1F000000';
  static readonly level1Radius: number = 4;
  static readonly level1Dy: number = 2;
  static readonly level2Color: string = '#2E000000';
  static readonly level2Radius: number = 8;
  static readonly level2Dy: number = 4;
}

interface Point {
  x: number;
  y: number;
}

@Component
struct RootScreen {
  @State nodes: Point[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ];
  @State currentColor: string = AppColors.primary;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    this.ctx.clearRect(0, 0, this.ctx.width, this.ctx.height);
    // 绘制连线
    this.ctx.strokeStyle = this.currentColor;
    this.ctx.lineWidth = 6;
    for (let i = 1; i < this.nodes.length; i++) {
      const start = this.nodes[i - 1];
      const end = this.nodes[i];
      this.ctx.beginPath();
      this.ctx.moveTo(start.x, start.y);
      this.ctx.lineTo(end.x, end.y);
      this.ctx.stroke();
    }
    // 绘制节点
    this.ctx.fillStyle = this.currentColor;
    for (let i = 0; i < this.nodes.length; i++) {
      const n = this.nodes[i];
      this.ctx.beginPath();
      this.ctx.arc(n.x, n.y, 20, 0, 2 * Math.PI);
      this.ctx.fill();
    }
  }

  build() {
    Stack() {
      // Canvas 用于绘制节点和连线
      Canvas(this.ctx)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawCanvas();
        })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down || event.type === TouchType.Move) {
            this.nodes.push({ x: event.touches[0].x, y: event.touches[0].y });
            this.drawCanvas();
          }
        })

      // 顶部栏 (Top Bar)
      Column() {
        Text('Neon Mind Map')
          .fontSize(AppTypography.displaySize)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.primary)
          .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.background)
        Blank()
      }
      .width('100%')
      .height('100%')

      // 底部栏 (Bottom Bar)
      Column() {
        Blank()
        Row() {
          Button({ type: ButtonType.Normal }) {
            Text('Cyan')
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.onPrimary)
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
          }
          .backgroundColor(AppColors.primary)
          .borderRadius(15)
          .onClick(() => {
            this.currentColor = AppColors.primary;
          })

          Button({ type: ButtonType.Normal }) {
            Text('Green')
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.onSecondary)
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
          }
          .backgroundColor(AppColors.secondary)
          .borderRadius(15)
          .onClick(() => {
            this.currentColor = AppColors.secondary;
          })

          Button({ type: ButtonType.Normal }) {
            Text('Purple')
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.onTertiary)
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
          }
          .backgroundColor(AppColors.tertiary)
          .borderRadius(15)
          .onClick(() => {
            this.currentColor = AppColors.tertiary;
          })
        }
        .space(AppSpacing.md)
        .padding(AppSpacing.md)
        .width('100%')
        .backgroundColor(AppColors.surfaceVariant)
        .shadow({ radius: AppShadows.level1Radius, color: AppShadows.level1Color, offsetX: 0, offsetY: AppShadows.level1Dy })
      }
      .width('100%')
      .height('100%')

      // 浮动操作按钮 (Floating Action Button)
      Column() {
        Blank()
        Row() {
          Blank()
          Button({ type: ButtonType.Normal }) {
            Text('+')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
              .fontColor(AppColors.onSecondary)
          }
          .width(56)
          .height(56)
          .backgroundColor(AppColors.secondary)
          .borderRadius(28)
          .shadow({ radius: AppShadows.level2Radius, color: AppShadows.level2Color, offsetX: 0, offsetY: AppShadows.level2Dy })
          .onClick(() => {
            const randomX = 100 + Math.random() * 500;
            const randomY = 200 + Math.random() * 600;
            this.nodes.push({ x: randomX, y: randomY });
            this.drawCanvas();
          })
          .padding(AppSpacing.lg)
        }
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
