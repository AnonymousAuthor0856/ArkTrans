// AppTokens
class Colors {
  static primary: string = '#FFA500';
  static secondary: string = '#FFC300';
  static tertiary: string = '#FFE066';
  static background: string = '#FFFBF2';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#FFEED6';
  static outline: string = '#F1C27D';
  static success: string = '#22C55E';
  static warning: string = '#F59E0B';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#1E1E1E';
  static onTertiary: string = '#1E1E1E';
  static onBackground: string = '#1E1E1E';
  static onSurface: string = '#1E1E1E';
}

class Spacing {
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 32;
}

@Entry
@Component
struct RootScreen {
  @State private progress: number = 0.4;
  @State private markerX: number = 200;
  @State private markerY: number = 400;
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    const ctx = this.canvasContext;
    const w = this.canvasWidth;
    const h = this.canvasHeight;
    if (w === 0 || h === 0) return;

    ctx.clearRect(0, 0, w, h);

    const cx = w / 2;
    const cy = h / 2;

    // Draw large background circle
    ctx.beginPath();
    ctx.arc(cx, cy, 260, 0, Math.PI * 2);
    ctx.fillStyle = Colors.surfaceVariant;
    ctx.fill();

    // Draw marker circle
    ctx.beginPath();
    ctx.arc(this.markerX, this.markerY, 20, 0, Math.PI * 2);
    ctx.fillStyle = Colors.primary;
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
          .backgroundColor(Colors.background)

          Text('Transfer Wizard')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
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
            .padding(Spacing.xl)
            .onReady(() => {
              this.canvasWidth = this.canvasContext.width;
              this.canvasHeight = this.canvasContext.height;
              this.drawCanvas();
            })
            .onAreaChange((_oldVal: Area, newVal: Area) => {
              this.canvasWidth = newVal.width as number;
              this.canvasHeight = newVal.height as number;
              this.drawCanvas();
            })

          // Bottom controls
          Column({ space: Spacing.lg }) {
            Text('Transfer Progress')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)

            // Custom progress bar
            Stack({ alignContent: Alignment.Start }) {
              // Track
              Row() {
              }
              .width('100%')
              .height(8)
              .borderRadius(4)
              .backgroundColor(Colors.surfaceVariant)

              // Progress fill
              Row() {
              }
              .width(`${this.progress * 100}%`)
              .height(8)
              .borderRadius(4)
              .backgroundColor(Colors.primary)
            }
            .width('80%')
            .height(8)

            // Buttons row
            Row({ space: Spacing.md }) {
              // "+" button
              Button('+')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .width(64)
                .height(64)
                .borderRadius(32)
                .backgroundColor(Colors.primary)
                .fontColor(Colors.onPrimary)
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
                .backgroundColor(Colors.secondary)
                .fontColor(Colors.onSecondary)
                .onClick(() => {
                  this.progress = Math.max(this.progress - 0.1, 0.0);
                  this.drawCanvas();
                })
            }
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .padding({ bottom: Spacing.xxl })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}