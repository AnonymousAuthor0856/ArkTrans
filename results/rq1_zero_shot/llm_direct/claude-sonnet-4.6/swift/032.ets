import { display } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
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

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State markerX: number = 200;
  @State markerY: number = 400;
  @State progress: number = 0.4;
  @State canvasWidth: number = 0;
  @State canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    const ctx = this.canvasContext;
    const w = this.canvasWidth;
    const h = this.canvasHeight;
    if (w === 0 || h === 0) return;

    ctx.clearRect(0, 0, w, h);

    const centerX = w / 2;
    const centerY = h / 2;

    // Draw large background circle
    ctx.beginPath();
    ctx.arc(centerX, centerY, 260, 0, Math.PI * 2);
    ctx.fillStyle = AppColors.surfaceVariant;
    ctx.fill();

    // Draw marker circle
    ctx.beginPath();
    ctx.arc(this.markerX, this.markerY, 20, 0, Math.PI * 2);
    ctx.fillStyle = AppColors.primary;
    ctx.fill();
  }

  build() {
    Stack() {
      // Background gradient
      Column() {
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#33FFC300', 0.0],
          ['#FFFBF2', 0.5],
          ['#33FFA500', 1.0]
        ]
      })

      Column() {
        // Top App Bar
        Stack() {
          Row() {
          }
          .width('100%')
          .height(56)
          .backgroundColor(AppColors.background)

          Text('Transfer Wizard')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(56)
        .alignContent(Alignment.Center)

        // Main content area
        Stack({ alignContent: Alignment.Bottom }) {
          // Canvas
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .padding(AppSpacing.xl)
            .onReady(() => {
              this.canvasWidth = this.canvasContext.width;
              this.canvasHeight = this.canvasContext.height;
              this.drawCanvas();
            })
            .onAreaChange((_oldVal, newVal) => {
              this.canvasWidth = newVal.width as number;
              this.canvasHeight = newVal.height as number;
              this.drawCanvas();
            })

          // Bottom content: progress + buttons
          Column({ space: AppSpacing.lg }) {
            Text('Transfer Progress')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)

            // Custom progress bar
            Stack({ alignContent: Alignment.Start }) {
              // Track
              Row() {
              }
              .width('100%')
              .height(8)
              .borderRadius(4)
              .backgroundColor(AppColors.surfaceVariant)

              // Progress fill
              Row() {
              }
              .width(`${this.progress * 100}%`)
              .height(8)
              .borderRadius(4)
              .backgroundColor(AppColors.primary)
            }
            .width('80%')
            .height(8)

            // Buttons row
            Row({ space: AppSpacing.md }) {
              // "+" button
              Button('+')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .width(64)
                .height(64)
                .borderRadius(32)
                .backgroundColor(AppColors.primary)
                .fontColor(AppColors.onPrimary)
                .onClick(() => {
                  this.progress = Math.min(this.progress + 0.1, 1.0);
                  this.drawCanvas();
                })

              // "-" button
              Button('-')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .width(64)
                .height(64)
                .borderRadius(32)
                .backgroundColor(AppColors.secondary)
                .fontColor(AppColors.onSecondary)
                .onClick(() => {
                  this.progress = Math.max(this.progress - 0.1, 0.0);
                  this.drawCanvas();
                })
            }
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .padding({ bottom: AppSpacing.xxl })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}