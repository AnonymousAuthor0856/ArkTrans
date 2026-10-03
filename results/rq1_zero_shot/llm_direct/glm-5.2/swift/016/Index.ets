// AppTokens.ets
export class AppColors {
  static readonly primary: ResourceColor = '#FF00FFFF';
  static readonly secondary: ResourceColor = '#FF9D00FF';
  static readonly tertiary: ResourceColor = '#FF00FFA3';
  static readonly background: ResourceColor = '#FF0B0B0D';
  static readonly surface: ResourceColor = '#FF1A1A1D';
  static readonly surfaceVariant: ResourceColor = '#FF2E2E33';
  static readonly outline: ResourceColor = '#FF3F3F46';
  static readonly success: ResourceColor = '#FF22C55E';
  static readonly warning: ResourceColor = '#FFF59E0B';
  static readonly error: ResourceColor = '#FFEF4444';
  static readonly onPrimary: ResourceColor = '#FF000000';
  static readonly onSecondary: ResourceColor = '#FFFFFFFF';
  static readonly onTertiary: ResourceColor = '#FF000000';
  static readonly onBackground: ResourceColor = '#FFE5E7EB';
  static readonly onSurface: ResourceColor = '#FFE5E7EB';
}

export class AppTypography {
  static readonly display: Font = { size: 28, weight: FontWeight.Bold };
  static readonly title: Font = { size: 18, weight: FontWeight.Medium };
  static readonly body: Font = { size: 14, weight: FontWeight.Normal };
  static readonly label: Font = { size: 12, weight: FontWeight.Medium };
}

export class AppShapes {
  static readonly small: number = 6.0;
  static readonly medium: number = 10.0;
  static readonly large: number = 14.0;
}

export class AppSpacing {
  static readonly xs: number = 4.0;
  static readonly sm: number = 8.0;
  static readonly md: number = 12.0;
  static readonly lg: number = 16.0;
  static readonly xl: number = 24.0;
  static readonly xxl: number = 32.0;
}

// ContentView.ets
import { AppColors, AppTypography, AppShapes, AppSpacing } from './AppTokens';

@Entry
@Component
struct ContentView {
  @State title: string = '';
  @State recording: boolean = false;
  @State seconds: number = 0;
  private intervalId: number = -1;

  private startTimer() {
    this.stopTimer();
    this.intervalId = setInterval(() => {
      this.seconds += 1;
    }, 1000);
  }

  private stopTimer() {
    if (this.intervalId !== -1) {
      clearInterval(this.intervalId);
      this.intervalId = -1;
    }
  }

  aboutToDisappear() {
    this.stopTimer();
  }

  build() {
    Column() {
      // 顶部栏
      Text('Neon Recorder')
        .font(AppTypography.display)
        .fontColor(AppColors.primary)
        .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
        .width('100%')
        .backgroundColor(AppColors.background)
        .textAlign(TextAlign.Center);

      // 内容区域
      Column() {
        // 录音名称输入框
        Column() {
          Text('Recording name')
            .font(AppTypography.label)
            .fontColor(AppColors.onSurface)
            .opacity(0.7)
            .margin({ bottom: AppSpacing.sm });

          TextInput({ text: this.title, placeholder: '' })
            .onChange((value: string) => {
              this.title = value;
            })
            .font(AppTypography.body)
            .fontColor(AppColors.onSurface)
            .padding(AppSpacing.md)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.medium)
            .border({
              width: 1,
              color: this.title === '' ? AppColors.outline : AppColors.primary
            });
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%');

        // 录音状态卡片
        Stack() {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .font(AppTypography.title)
            .fontColor(this.recording ? AppColors.primary : AppColors.onSurface);
        }
        .width('100%')
        .height(200)
        .borderRadius(AppShapes.large)
        .backgroundColor(AppColors.surfaceVariant);

        // 按钮行
        Row({ space: AppSpacing.xl }) {
          Button(this.recording ? 'Stop' : 'Record')
            .font(AppTypography.title)
            .fontColor(AppColors.onPrimary)
            .width(160)
            .height(52)
            .borderRadius(AppShapes.large)
            .backgroundColor(this.recording ? AppColors.error : AppColors.primary)
            .onClick(() => {
              this.recording = !this.recording;
              if (this.recording) {
                this.seconds = 0;
                this.startTimer();
              } else {
                this.stopTimer();
              }
            });

          Button('Reset')
            .font(AppTypography.title)
            .fontColor(AppColors.onSecondary)
            .width(120)
            .height(52)
            .borderRadius(AppShapes.large)
            .backgroundColor(AppColors.secondary)
            .onClick(() => {
              this.seconds = 0;
              if (this.recording) {
                this.stopTimer();
                this.startTimer();
              }
            });
        }
        .width('100%')
        .justifyContent(FlexAlign.Center);

        Blank().height(AppSpacing.xxl);

        Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
          .font(AppTypography.body)
          .fontColor(AppColors.onSurface)
          .opacity(0.7)
          .width('100%')
          .textAlign(TextAlign.Start);
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.background, 0.0],
          [AppColors.surfaceVariant, 1.0]
        ]
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}