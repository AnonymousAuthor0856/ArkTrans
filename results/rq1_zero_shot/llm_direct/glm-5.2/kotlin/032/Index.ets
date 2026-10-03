// 033TransferWizarden - Finance - Warm Gradient - en - 720x1280

// 1. Design Tokens
class AppColors {
  primary: string = '#FFA500';
  secondary: string = '#FFC300';
  tertiary: string = '#FFE066';
  background: string = '#FFFBF2';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#FFEED6';
  outline: string = '#F1C27D';
  success: string = '#22C55E';
  warning: string = '#F59E0B';
  error: string = '#EF4444';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#1E1E1E';
  onTertiary: string = '#1E1E1E';
  onBackground: string = '#1E1E1E';
  onSurface: string = '#1E1E1E';
}

class AppTypography {
  display: TextStyle = { size: '28fp', weight: FontWeight.Bold };
  title: TextStyle = { size: '18fp', weight: FontWeight.Medium };
  body: TextStyle = { size: '14fp', weight: FontWeight.Normal };
  label: TextStyle = { size: '12fp', weight: FontWeight.Medium };
}

class AppSpacing {
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

class AppTokens {
  static readonly Colors: AppColors = new AppColors();
  static readonly Typography: AppTypography = new AppTypography();
  static readonly Spacing: AppSpacing = new AppSpacing();
}

// 2. State Management
@Observed
class RootScreenState {
  markerX: number = 200;
  markerY: number = 400;
  progress: number = 0.4;

  increaseProgress(): void {
    this.progress = Math.min(1.0, this.progress + 0.1);
  }

  decreaseProgress(): void {
    this.progress = Math.max(0.0, this.progress - 0.1);
  }
}

// 3. Root Screen Component
@Entry
@Component
struct RootScreen {
  @State state: RootScreenState = new RootScreenState();

  build(): void {
    Stack() {
      // Background Gradient
      Column() {
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 180,
            colors: [
              [AppTokens.Colors.secondary, 0.2],
              [AppTokens.Colors.background, 1.0],
              [AppTokens.Colors.primary, 0.2]
            ]
          });
      }
      .width('100%')
      .height('100%');

      // Canvas Content
      Column() {
        // Canvas equivalent using Stack and shapes
        Stack() {
          // Outer Circle
          Circle()
            .width(520)
            .height(520)
            .fillColor(AppTokens.Colors.surfaceVariant);

          // Marker Circle
          Circle()
            .width(40)
            .height(40)
            .fillColor(AppTokens.Colors.primary)
            .markAnchor({
              x: this.state.markerX - 20,
              y: this.state.markerY - 20
            });
        }
        .width('100%')
        .height('100%')
        .padding(AppTokens.Spacing.xl);
      }
      .width('100%')
      .height('100%');

      // Bottom Controls
      Column() {
        Text('Transfer Progress')
          .fontSize(AppTokens.Typography.title.size)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ bottom: AppTokens.Spacing.lg });

        // Linear Progress Indicator
        Row() {
          // Track
          Column()
            .width('100%')
            .height(8)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(4);

          // Progress
          Column()
            .width(`${this.state.progress * 100}%`)
            .height(8)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(4)
            .markAnchor({ x: 0, y: 0 });
        }
        .width('80%')
        .height(8)
        .margin({ bottom: AppTokens.Spacing.lg });

        // Buttons Row
        Row() {
          Button('+')
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .onClick(() => {
              this.state.increaseProgress();
            });

          Button('-')
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .margin({ left: AppTokens.Spacing.md })
            .onClick(() => {
              this.state.decreaseProgress();
            });
        }
      }
      .width('100%')
      .padding({ bottom: AppTokens.Spacing.xxl })
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.End);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}