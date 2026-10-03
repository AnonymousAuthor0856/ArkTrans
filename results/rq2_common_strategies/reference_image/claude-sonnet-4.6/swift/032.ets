// Transfer Wizard — ArkTS (ArkUI declarative) conversion of the SwiftUI screen.

// MARK: - Design tokens

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
  // 20% alpha variants used by the vertical background gradient
  static readonly secondary20: string = '#33FFC300';
  static readonly primary20: string = '#33FFA500';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
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
  @State private markerX: number = 200;
  @State private markerY: number = 400;
  @State private progress: number = 0.4;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  // Custom drawing: big surfaceVariant circle (r = 260) + primary marker circle (r = 20)
  private drawScene(): void {
    const w: number = this.context.width;
    const h: number = this.context.height;
    const centerX: number = w / 2;
    const centerY: number = h / 2;

    this.context.clearRect(0, 0, w, h);

    this.context.fillStyle = AppColors.surfaceVariant;
    this.context.beginPath();
    this.context.arc(centerX, centerY, 260, 0, Math.PI * 2);
    this.context.closePath();
    this.context.fill();

    this.context.fillStyle = AppColors.primary;
    this.context.beginPath();
    this.context.arc(this.markerX, this.markerY, 20, 0, Math.PI * 2);
    this.context.closePath();
    this.context.fill();
  }

  // Capsule-shaped linear progress indicator, 8vp high, 80% of the parent width
  @Builder
  TransferProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Column()
        .width('100%')
        .height(8)
        .borderRadius(4)
        .backgroundColor(AppColors.surfaceVariant)

      Column()
        .width(`${Math.round(this.progress * 100)}%`)
        .height(8)
        .borderRadius(4)
        .backgroundColor(AppColors.primary)
    }
    .width('80%')
    .height(8)
  }

  @Builder
  CircularStepButton(label: string, background: string, foreground: string, step: number) {
    Button(label, { type: ButtonType.Circle, stateEffect: true })
      .width(64)
      .height(64)
      .backgroundColor(background)
      .fontColor(foreground)
      .fontSize(24)
      .fontWeight(FontWeight.Bold)
      .onClick(() => {
        const next: number = this.progress + step;
        this.progress = Math.min(Math.max(next, 0), 1);
      })
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background gradient: secondary 20% -> background -> primary 20%
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            [AppColors.secondary20, 0.0],
            [AppColors.background, 0.5],
            [AppColors.primary20, 1.0]
          ]
        })

      Column() {
        // Center-aligned top app bar
        Stack() {
          Row()
            .width('100%')
            .height(56)
            .backgroundColor(AppColors.background)

          Text('Transfer Wizard')
            .fontSize(AppTypography.displaySize)
            .fontWeight(AppTypography.displayWeight)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(56)

        // Main content area
        Stack({ alignContent: Alignment.Center }) {
          // Canvas fills the area with 24vp padding, same as the SwiftUI Canvas
          Column() {
            Canvas(this.context)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawScene();
              })
          }
          .width('100%')
          .height('100%')
          .padding(AppSpacing.xl)

          // Bottom-aligned controls
          Column({ space: AppSpacing.lg }) {
            Text('Transfer Progress')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
              .fontColor(AppColors.onSurface)

            this.TransferProgressBar()

            Row({ space: AppSpacing.md }) {
              this.CircularStepButton('+', AppColors.primary, AppColors.onPrimary, 0.1)
              this.CircularStepButton('-', AppColors.secondary, AppColors.onSecondary, -0.1)
            }
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.End)
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
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}