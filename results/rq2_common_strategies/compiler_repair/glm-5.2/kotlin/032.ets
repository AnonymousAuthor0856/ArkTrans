// Index.ets
const NAME: string = "033TransferWizarden";
const UI_TYPE: string = "Finance";
const STYLE_THEME: string = "Warm Gradient";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  primary: ResourceColor = 0xFFFFA500;
  secondary: ResourceColor = 0xFFFFC300;
  tertiary: ResourceColor = 0xFFFFE066;
  background: ResourceColor = 0xFFFFFBF2;
  surface: ResourceColor = 0xFFFFFFFF;
  surfaceVariant: ResourceColor = 0xFFFFEED6;
  outline: ResourceColor = 0xFFF1C27D;
  success: ResourceColor = 0xFF22C55E;
  warning: ResourceColor = 0xFFF59E0B;
  error: ResourceColor = 0xFFEF4444;
  onPrimary: ResourceColor = 0xFFFFFFFF;
  onSecondary: ResourceColor = 0xFF1E1E1E;
  onTertiary: ResourceColor = 0xFF1E1E1E;
  onBackground: ResourceColor = 0xFF1E1E1E;
  onSurface: ResourceColor = 0xFF1E1E1E;
}

class AppSpacing {
  sm: Length = 8;
  md: Length = 12;
  lg: Length = 16;
  xl: Length = 24;
  xxl: Length = 32;
}

class AppTokens {
  static Colors: AppColors = new AppColors();
  static Spacing: AppSpacing = new AppSpacing();
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.4;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Transfer Wizard")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background);

      // Content Area
      Stack({ alignContent: Alignment.Center }) {
        // Background Gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 180,
            colors: [
              [AppTokens.Colors.secondary as number, 0.2],
              [AppTokens.Colors.background as number, 0.5],
              [AppTokens.Colors.primary as number, 0.2]
            ]
          });

        // Canvas Drawing
        Canvas(this)
          .width('100%')
          .height('100%')
          .onReady((context: CanvasRenderingContext2D) => {
            const w = context.width;
            const h = context.height;
            const centerX = w / 2;
            const centerY = h / 2;

            // Draw large circle
            context.beginPath();
            context.arc(centerX, centerY, 130, 0, Math.PI * 2);
            context.fillStyle = '#FFEED6';
            context.fill();

            // Draw marker circle
            context.beginPath();
            context.arc(200, 400, 20, 0, Math.PI * 2);
            context.fillStyle = '#FFA500';
            context.fill();
          })
          .padding(AppTokens.Spacing.xl);

        // Bottom Controls
        Column({ space: AppTokens.Spacing.lg }) {
          Text("Transfer Progress")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface);

          // Linear Progress Indicator
          Row()
            .width('80%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .clip(true)
            .overlay() {
              Row()
                .width(`${this.progress * 100}%`)
                .height(8)
                .borderRadius(4)
                .backgroundColor(AppTokens.Colors.primary)
            };

          // Buttons Row
          Row({ space: AppTokens.Spacing.md }) {
            Button("+")
              .width(48)
              .height(48)
              .borderRadius(24)
              .backgroundColor(AppTokens.Colors.primary)
              .fontColor(AppTokens.Colors.onPrimary)
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1.0);
              });

            Button("-")
              .width(48)
              .height(48)
              .borderRadius(24)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0.0);
              });
          }
        }
        .width('100%')
        .padding({ bottom: AppTokens.Spacing.xxl })
        .align(Alignment.Bottom);
      }
      .layoutWeight(1)
      .width('100%');
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}