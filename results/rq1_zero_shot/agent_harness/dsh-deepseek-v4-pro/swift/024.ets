// AppTokens
class AppColors {
  static readonly primary: string = '#EF476F';
  static readonly secondary: string = '#FFD166';
  static readonly tertiary: string = '#06D6A0';
  static readonly background: string = '#FFFCF2';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F7EDE2';
  static readonly outline: string = '#E5D4B1';
  static readonly success: string = '#06D6A0';
  static readonly warning: string = '#FFA600';
  static readonly error: string = '#D62828';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class AppTypography {
  static readonly displaySize: number = 26;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class AppShadows {
  static readonly level1Color: string = '#1F000000';
  static readonly level1Radius: number = 2;
  static readonly level1Dy: number = 2;
  static readonly level2Color: string = '#29000000';
  static readonly level2Radius: number = 8;
  static readonly level2Dy: number = 4;
}

interface Point {
  x: number;
  y: number;
}

@Component
struct RootScreen {
  @State points: Point[] = [];
  @State currentColor: string = AppColors.primary;

  buttonHeight: number = 44;
  fabSize: number = 56;
  circleRadius: number = 10;
  topBarActualHeight: number = 30 + 2 * AppSpacing.md;
  bottomBarActualHeight: number = 44 + 2 * AppSpacing.md;
  fabBottomMargin: number = AppSpacing.xl;
  canvasBottomPadding: number = Math.max(44 + 2 * AppSpacing.md, 56 + AppSpacing.xl);

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    this.ctx.clearRect(0, 0, this.ctx.width, this.ctx.height);
    this.ctx.fillStyle = this.currentColor;
    for (let i = 0; i < this.points.length; i++) {
      const p = this.points[i];
      this.ctx.beginPath();
      this.ctx.arc(p.x, p.y, this.circleRadius, 0, 2 * Math.PI);
      this.ctx.fill();
    }
  }

  build() {
    Stack() {
      // 绘制画布区域
      Canvas(this.ctx)
        .width('100%')
        .height('100%')
        .padding({ top: this.topBarActualHeight, bottom: this.canvasBottomPadding })
        .onReady(() => {
          this.drawCanvas();
        })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down || event.type === TouchType.Move) {
            this.points.push({ x: event.touches[0].x, y: event.touches[0].y });
            this.drawCanvas();
          }
        })

      // 顶部栏
      Column() {
        Text('Retro Whiteboard')
          .fontSize(AppTypography.displaySize)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.onSurface)
          .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.background)
        Blank()
      }
      .width('100%')
      .height('100%')

      // 底部颜色选择栏
      Column() {
        Blank()
        Row() {
          Button({ type: ButtonType.Normal }) {
            Text('Red')
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.onPrimary)
          }
          .layoutWeight(1)
          .height(this.buttonHeight)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small)
          .onClick(() => {
            this.currentColor = AppColors.primary;
          })

          Blank().width(AppSpacing.md)

          Button({ type: ButtonType.Normal }) {
            Text('Yellow')
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.onSecondary)
          }
          .layoutWeight(1)
          .height(this.buttonHeight)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppShapes.small)
          .onClick(() => {
            this.currentColor = AppColors.secondary;
          })

          Blank().width(AppSpacing.md)

          Button({ type: ButtonType.Normal }) {
            Text('Green')
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.onTertiary)
          }
          .layoutWeight(1)
          .height(this.buttonHeight)
          .backgroundColor(AppColors.tertiary)
          .borderRadius(AppShapes.small)
          .onClick(() => {
            this.currentColor = AppColors.tertiary;
          })
        }
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface)
        .shadow({ radius: AppShadows.level1Radius, color: AppShadows.level1Color, offsetX: 0, offsetY: AppShadows.level1Dy })
      }
      .width('100%')
      .height('100%')

      // 浮动操作按钮 (FAB) - 清除画布
      Column() {
        Blank()
        Row() {
          Blank()
          Button({ type: ButtonType.Normal }) {
            Text('Clear')
              .fontSize(AppTypography.labelSize)
              .fontWeight(AppTypography.labelWeight)
              .fontColor(AppColors.onSecondary)
          }
          .width(this.fabSize)
          .height(this.fabSize)
          .backgroundColor(AppColors.secondary)
          .borderRadius(this.fabSize / 2)
          .shadow({ radius: AppShadows.level1Radius, color: AppShadows.level1Color, offsetX: 0, offsetY: AppShadows.level1Dy })
          .onClick(() => {
            this.points = [];
            this.drawCanvas();
          })
          .padding({ right: AppSpacing.xl, bottom: this.fabBottomMargin })
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
