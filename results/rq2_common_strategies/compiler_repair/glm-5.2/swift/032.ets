// AppTokens: Encapsulates design tokens for centralized management.
class AppTokens {
  static readonly Colors: Record<string, string> = {
    primary: '#FFA500',
    secondary: '#FFC300',
    tertiary: '#FFE066',
    background: '#FFFBF2',
    surface: '#FFFFFF',
    surfaceVariant: '#FFEED6',
    outline: '#F1C27D',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  }

  static readonly Typography: Record<string, Record<string, number | FontWeight>> = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Spacing: Record<string, number> = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }
}

// Entry Component
@Entry
@Component
struct RootScreen {
  // State variables corresponding to Kotlin's mutableStateOf
  @State markerPositionX: number = 200;
  @State markerPositionY: number = 400;
  @State progress: number = 0.4;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Stack() {
      // Background Gradient
      Column() {
        // Top App Bar
        Stack() {
          Text("Transfer Wizard")
            .fontSize(AppTokens.Typography.display.size as number)
            .fontWeight(AppTokens.Typography.display.weight as FontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(56)
        .backgroundColor(AppTokens.Colors.background)

        // Main Content Area
        Stack() {
          // Canvas View
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.xl)
            .onReady(() => {
              this.drawCanvas();
            })

          // Bottom Content Area
          Column({ space: AppTokens.Spacing.lg }) {
            Text("Transfer Progress")
              .fontSize(AppTokens.Typography.title.size as number)
              .fontWeight(AppTokens.Typography.title.weight as FontWeight)
              .fontColor(AppTokens.Colors.onSurface)

            // Linear Progress Bar
            Stack({ alignContent: Alignment.Start }) {
              // Track
              Column()
                .width('100%')
                .height(8)
                .borderRadius(4)
                .backgroundColor(AppTokens.Colors.surfaceVariant)

              // Progress Fill
              Column()
                .width(`${this.progress * 100}%`)
                .height(8)
                .borderRadius(4)
                .backgroundColor(AppTokens.Colors.primary)
            }
            .width('80%')
            .height(8)

            // Button Row
            Row({ space: AppTokens.Spacing.md }) {
              // "+" Button
              Button({ type: ButtonType.Circle }) {
                Text("+")
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppTokens.Colors.onPrimary)
              }
              .width(64)
              .height(64)
              .backgroundColor(AppTokens.Colors.primary)
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1.0);
              })

              // "-" Button
              Button({ type: ButtonType.Circle }) {
                Text("-")
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppTokens.Colors.onSecondary)
              }
              .width(64)
              .height(64)
              .backgroundColor(AppTokens.Colors.secondary)
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0.0);
              })
            }
          }
          .width('100%')
          .height('100%')
          .padding({ bottom: AppTokens.Spacing.xxl })
          .justifyContent(FlexAlign.End)
          .alignItems(HorizontalAlign.Center)
        }
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [AppTokens.Colors.secondary, 0.2],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.primary, 0.2]
      ]
    })
  }

  // Custom drawing logic for Canvas
  private drawCanvas() {
    const width: number = this.context.canvas.width;
    const height: number = this.context.canvas.height;
    const centerX: number = width / 2;
    const centerY: number = height / 2;

    // Draw large background circle
    this.context.fillStyle = AppTokens.Colors.surfaceVariant;
    this.context.beginPath();
    this.context.arc(centerX, centerY, 260, 0, Math.PI * 2);
    this.context.fill();

    // Draw marker circle
    this.context.fillStyle = AppTokens.Colors.primary;
    this.context.beginPath();
    this.context.arc(this.markerPositionX, this.markerPositionY, 20, 0, Math.PI * 2);
    this.context.fill();
  }
}