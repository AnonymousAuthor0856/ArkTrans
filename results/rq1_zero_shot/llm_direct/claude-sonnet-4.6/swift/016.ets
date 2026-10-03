import { router } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#FF00FFFF';
  static readonly secondary: string = '#FF9D00FF';
  static readonly tertiary: string = '#FF00FFA3';
  static readonly background: string = '#FF0B0B0D';
  static readonly surface: string = '#FF1A1A1D';
  static readonly surfaceVariant: string = '#FF2E2E33';
  static readonly outline: string = '#FF3F3F46';
  static readonly success: string = '#FF22C55E';
  static readonly warning: string = '#FFF59E0B';
  static readonly error: string = '#FFEF4444';
  static readonly onPrimary: string = '#FF000000';
  static readonly onSecondary: string = '#FFFFFFFF';
  static readonly onTertiary: string = '#FF000000';
  static readonly onBackground: string = '#FFE5E7EB';
  static readonly onSurface: string = '#FFE5E7EB';
  static readonly onSurfaceDim: string = '#B3E5E7EB';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly smallCornerRadius: number = 6;
  static readonly mediumCornerRadius: number = 10;
  static readonly largeCornerRadius: number = 14;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

@Entry
@Component
struct ContentView {
  @State private title: string = '';
  @State private recording: boolean = false;
  @State private seconds: number = 0;
  private timerInterval: number = -1;

  private startTimer(): void {
    this.stopTimer();
    this.timerInterval = setInterval(() => {
      this.seconds += 1;
    }, 1000);
  }

  private stopTimer(): void {
    if (this.timerInterval !== -1) {
      clearInterval(this.timerInterval);
      this.timerInterval = -1;
    }
  }

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Text('Neon Recorder')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
        .backgroundColor(AppColors.background)

      // Content Area
      Column({ space: AppSpacing.lg }) {
        // Recording Name Input
        Column({ space: AppSpacing.sm }) {
          Text('Recording name')
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurfaceDim)
            .width('100%')
            .textAlign(TextAlign.Start)

          TextInput({ placeholder: '', text: this.title })
            .fontSize(AppTypography.bodySize)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
            .padding(AppSpacing.md)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.mediumCornerRadius)
            .border({
              width: 1,
              color: this.title === '' ? AppColors.outline : AppColors.primary,
              radius: AppShapes.mediumCornerRadius
            })
            .caretColor(AppColors.primary)
            .width('100%')
            .onChange((value: string) => {
              this.title = value;
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)

        // Recording Status Card
        Stack() {
          Column()
            .width('100%')
            .height(200)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.largeCornerRadius)

          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? AppColors.primary : AppColors.onSurface)
        }
        .width('100%')
        .height(200)

        // Button Row
        Row({ space: AppSpacing.xl }) {
          Button(this.recording ? 'Stop' : 'Record')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .width(160)
            .height(52)
            .backgroundColor(this.recording ? AppColors.error : AppColors.primary)
            .borderRadius(AppShapes.largeCornerRadius)
            .onClick(() => {
              this.recording = !this.recording;
              if (this.recording) {
                this.seconds = 0;
                this.startTimer();
              } else {
                this.stopTimer();
              }
            })

          Button('Reset')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .width(120)
            .height(52)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.largeCornerRadius)
            .onClick(() => {
              this.seconds = 0;
              if (this.recording) {
                this.stopTimer();
                this.startTimer();
              }
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Blank()
          .height(AppSpacing.xxl)

        // Output Path
        Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurfaceDim)
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.background, 0.0],
          [AppColors.surfaceVariant, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}