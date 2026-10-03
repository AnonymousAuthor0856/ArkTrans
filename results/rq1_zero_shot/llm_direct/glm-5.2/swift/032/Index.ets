// MARK: - AppTokens
// Encapsulates all design tokens for the application for centralized management and modification.
class AppTokens {
  static readonly Colors = {
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
    onSurface: '#1E1E1E',
  };

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };

  // ShadowSpec and ElevationMapping are not used in the current UI but kept for future expansion
  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.16 },
  };
}

// MARK: - CustomLinearProgressViewStyle
// Custom component to exactly match the Compose LinearProgressIndicator's color and height.
@Component
struct CustomLinearProgressView {
  @Prop progressColor: string;
  @Prop trackColor: string;
  @Prop height: number;
  @Prop progress: number;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Column()
        .width('100%')
        .height(this.height)
        .backgroundColor(this.trackColor)
        .borderRadius(this.height / 2)

      // Progress
      Column()
        .width(`${(this.progress * 100).toFixed(2)}%`)
        .height(this.height)
        .backgroundColor(this.progressColor)
        .borderRadius(this.height / 2)
    }
    .width('100%')
    .height(this.height)
  }
}

// MARK: - RootScreen
// The main UI view of the application, corresponding to Kotlin's RootScreen Composable.
@Entry
@Component
struct RootScreen {
  // @State variables correspond to Kotlin's mutableStateOf, used for managing UI state.
  // The initial value of markerPosition (200, 400) is mapped directly to a Point,
  // assuming they are points in the Canvas internal coordinate system.
  @State private markerPosition: Point = { x: 200, y: 400 };
  @State private progress: number = 0.4;

  build() {
    // Top-level Stack simulates Scaffold's content area and handles background gradient.
    Stack() {
      // Background gradient, corresponding to Kotlin's Brush.verticalGradient
      Column() {
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 180,
            colors: [
              [AppTokens.Colors.secondary, 0.0], // Opacity approximated by color hex or ignored if solid
              [AppTokens.Colors.background, 0.5],
              [AppTokens.Colors.primary, 1.0],
            ],
          })
      }
      .width('100%')
      .height('100%')
      .position({ x: 0, y: 0 })

      // Column simulates Scaffold's structure: Top bar + Main content area
      Column() {
        // Top bar, corresponding to Kotlin's CenterAlignedTopAppBar
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width('100%')
            .height(56) // Standard AppBar height
            .backgroundColor(AppTokens.Colors.background)

          Text("Transfer Wizard")
            .fontSize(AppTokens.TypographyTokens.display.size)
            .fontWeight(AppTokens.TypographyTokens.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(56)

        // Main content area
        Stack({ alignContent: Alignment.Center }) {
          // Canvas view for custom drawing of circles
          Canvas(this)
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.xl)
            .onReady((context: RenderingContext) => {
              const canvas = context.canvas;
              const width = context.width;
              const height = context.height;
              const center: Point = { x: width / 2, y: height / 2 };

              // Draw large background circle
              const bgPaint = new Paint();
              bgPaint.color = AppTokens.Colors.surfaceVariant;
              bgPaint.style = PaintStyle.Fill;
              canvas.drawCircle(center.x, center.y, 260, bgPaint);

              // Draw marker circle
              const markerPaint = new Paint();
              markerPaint.color = AppTokens.Colors.primary;
              markerPaint.style = PaintStyle.Fill;
              canvas.drawCircle(this.markerPosition.x, this.markerPosition.y, 20, markerPaint);
            })

          // Bottom content area (Transfer Progress, Progress bar, Buttons)
          Column({ space: AppTokens.Spacing.lg }) {
            Text("Transfer Progress")
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onSurface)

            // Linear progress bar using custom component
            CustomLinearProgressView({
              progressColor: AppTokens.Colors.primary,
              trackColor: AppTokens.Colors.surfaceVariant,
              height: 8,
              progress: this.progress
            })
              .width('80%') // Width fills 80%

            // Button row, corresponding to Kotlin's Row
            Row({ space: AppTokens.Spacing.md }) {
              // "+" button
              Button({ type: ButtonType.Normal }) {
                Text("+")
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppTokens.Colors.onPrimary)
              }
              .width(64)
              .height(64)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(32) // Circle shape
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1.0);
              })

              // "-" button
              Button({ type: ButtonType.Normal }) {
                Text("-")
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppTokens.Colors.onSecondary)
              }
              .width(64)
              .height(64)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(32) // Circle shape
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0.0);
              })
            }
          }
          .width('100%')
          .height('100%')
          .padding({ bottom: AppTokens.Spacing.xxl })
          .justifyContent(FlexAlign.End) // Align to bottom
        }
        .layoutWeight(1) // Fill remaining space
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}