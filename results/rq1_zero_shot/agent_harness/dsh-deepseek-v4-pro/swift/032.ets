// 032.ets - translated from 032.swift (Transfer Wizard)

// MARK: - AppTokens

const CLEAR: string = '#00000000';

class AppTokensColors {
  static readonly primary: string = '#FFA500';
  static readonly secondary: string = '#FFC300';
  static readonly tertiary: string = '#FFE066';
  static readonly background: string = '#FFFBF2';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFEED6';
  static readonly outline: string = '#F1C27D';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class AppTokensTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppTokensSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokensElevation {
  static readonly level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 };
  static readonly level2: ShadowSpec = { elevation: 6, radius: 8, dy: 4, opacity: 0.16 };
}

class AppTokens {
  static readonly Colors = AppTokensColors;
  static readonly TypographyTokens = AppTokensTypography;
  static readonly Spacing = AppTokensSpacing;
  static readonly ElevationMapping = AppTokensElevation;
}

// MARK: - RootScreen

@Component
struct RootScreen {
  @State markerX: number = 200;
  @State markerY: number = 400;
  @State progress: number = 0.4;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  progressPercent(): string {
    return (this.progress * 100).toString() + '%';
  }

  drawCanvas() {
    const w = this.ctx.width;
    const h = this.ctx.height;
    const cx = w / 2;
    const cy = h / 2;
    // 大背景圆
    this.ctx.fillStyle = AppTokens.Colors.surfaceVariant;
    this.ctx.beginPath();
    this.ctx.arc(cx, cy, 260, 0, Math.PI * 2);
    this.ctx.fill();
    // 标记圆
    this.ctx.fillStyle = AppTokens.Colors.primary;
    this.ctx.beginPath();
    this.ctx.arc(this.markerX, this.markerY, 20, 0, Math.PI * 2);
    this.ctx.fill();
  }

  build() {
    Stack() {
      // 背景渐变
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [['rgba(255,195,0,0.2)', 0.0], [AppTokens.Colors.background, 0.5], ['rgba(255,165,0,0.2)', 1.0]]
        })

      Column({ space: 0 }) {
        // 顶部栏
        Stack() {
          Column()
            .width('100%')
            .height(56)
            .backgroundColor(AppTokens.Colors.background)
          Text('Transfer Wizard')
            .fontSize(AppTokens.TypographyTokens.displaySize)
            .fontWeight(AppTokens.TypographyTokens.displayWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(56)

        // 主要内容区域
        Stack() {
          // Canvas 视图
          Canvas(this.ctx)
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.xl)
            .onReady(() => {
              this.drawCanvas();
            })

          // 底部内容区域
          Column({ space: AppTokens.Spacing.lg }) {
            Text('Transfer Progress')
              .fontSize(AppTokens.TypographyTokens.titleSize)
              .fontWeight(AppTokens.TypographyTokens.titleWeight)
              .fontColor(AppTokens.Colors.onSurface)

            // 线性进度条
            Stack({ alignContent: Alignment.Start }) {
              Row()
                .width('100%')
                .height(8)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(4)
              Row()
                .width(this.progressPercent())
                .height(8)
                .backgroundColor(AppTokens.Colors.primary)
                .borderRadius(4)
            }
            .width('80%')

            // 按钮行
            Row({ space: AppTokens.Spacing.md }) {
              Button() {
                Text('+')
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .width(64)
                  .height(64)
                  .textAlign(TextAlign.Center)
                  .backgroundColor(AppTokens.Colors.primary)
                  .fontColor(AppTokens.Colors.onPrimary)
                  .borderRadius(32)
              }
              .type(ButtonType.Normal)
              .backgroundColor(CLEAR)
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1.0);
                this.drawCanvas();
              })

              Button() {
                Text('-')
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .width(64)
                  .height(64)
                  .textAlign(TextAlign.Center)
                  .backgroundColor(AppTokens.Colors.secondary)
                  .fontColor(AppTokens.Colors.onSecondary)
                  .borderRadius(32)
              }
              .type(ButtonType.Normal)
              .backgroundColor(CLEAR)
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0.0);
                this.drawCanvas();
              })
            }
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.End)
          .padding({ bottom: AppTokens.Spacing.xxl })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - App Entry Point

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
