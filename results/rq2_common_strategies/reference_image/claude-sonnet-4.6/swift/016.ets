/**
 * Index.ets — Neon Recorder (ArkTS / ArkUI)
 * ArkTS/ArkUI conversion of the SwiftUI NeonRecorderApp.
 */

import { window } from '@kit.ArkUI';

// MARK: - AppTokens

class AppColors {
  static readonly primary: string = '#00FFFF';        // 0xFF00FFFF
  static readonly secondary: string = '#9D00FF';      // 0xFF9D00FF
  static readonly tertiary: string = '#00FFA3';       // 0xFF00FFA3
  static readonly background: string = '#0B0B0D';     // 0xFF0B0B0D
  static readonly surface: string = '#1A1A1D';        // 0xFF1A1A1D
  static readonly surfaceVariant: string = '#2E2E33'; // 0xFF2E2E33
  static readonly outline: string = '#3F3F46';        // 0xFF3F3F46
  static readonly success: string = '#22C55E';        // 0xFF22C55E
  static readonly warning: string = '#F59E0B';        // 0xFFF59E0B
  static readonly error: string = '#EF4444';          // 0xFFEF4444
  static readonly onPrimary: string = '#000000';      // 0xFF000000
  static readonly onSecondary: string = '#FFFFFF';    // 0xFFFFFFFF
  static readonly onTertiary: string = '#000000';     // 0xFF000000
  static readonly onBackground: string = '#E5E7EB';   // 0xFFE5E7EB
  static readonly onSurface: string = '#E5E7EB';      // 0xFFE5E7EB
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

// MARK: - RootScreen

@Entry
@Component
struct ContentView {
  @State title: string = '';
  @State recording: boolean = false;
  @State seconds: number = 0;

  private timerId: number = -1;

  async aboutToAppear(): Promise<void> {
    // Equivalent of .statusBar(hidden: true) + dark colour scheme
    try {
      const win: window.Window = await window.getLastWindow(getContext(this));
      await win.setWindowLayoutFullScreen(true);
      await win.setWindowSystemBarEnable([]);
    } catch (err) {
      // window APIs unavailable (e.g. previewer) — safe to ignore
    }
  }

  aboutToDisappear(): void {
    this.stopTimer();
  }

  // MARK: - Timer Functions

  private startTimer(): void {
    this.stopTimer();
    this.timerId = setInterval(() => {
      this.seconds += 1;
    }, 1000);
  }

  private stopTimer(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  build() {
    Column() {
      // 顶部栏
      Text('Neon Recorder')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
        .backgroundColor(AppColors.background)

      // 内容区域
      Column({ space: AppSpacing.lg }) {
        // 录音名称输入框
        Column({ space: AppSpacing.sm }) {
          Text('Recording name')
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .opacity(0.7)
            .width('100%')
            .textAlign(TextAlign.Start)

          TextInput({ text: this.title, placeholder: '' })
            .type(InputType.Normal)
            .fontSize(AppTypography.bodySize)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)
            .caretColor(AppColors.primary)
            .placeholderColor(AppColors.onSurface)
            .padding(AppSpacing.md)
            .width('100%')
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.mediumCornerRadius)
            .border({
              width: 1,
              color: this.title.length === 0 ? AppColors.outline : AppColors.primary
            })
            .onChange((value: string) => {
              this.title = value;
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)

        // 录音状态卡片
        Stack() {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? AppColors.primary : AppColors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.largeCornerRadius)

        // 按钮行
        Row({ space: AppSpacing.xl }) {
          Button() {
            Text(this.recording ? 'Stop' : 'Record')
              .fontSize(AppTypography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
          }
          .type(ButtonType.Normal)
          .width(160)
          .height(52)
          .borderRadius(AppShapes.largeCornerRadius)
          .backgroundColor(this.recording ? AppColors.error : AppColors.primary)
          .onClick(() => {
            if (!this.recording) {
              this.recording = true;
              this.seconds = 0;
              this.startTimer();
            } else {
              this.recording = false;
              this.stopTimer();
            }
          })

          Button() {
            Text('Reset')
              .fontSize(AppTypography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
          }
          .type(ButtonType.Normal)
          .width(120)
          .height(52)
          .borderRadius(AppShapes.largeCornerRadius)
          .backgroundColor(AppColors.secondary)
          .onClick(() => {
            this.seconds = 0;
            if (this.recording) {
              this.startTimer();
            }
          })
        }

        // Spacer().frame(height: AppSpacing.xxl)
        Row() {
        }
        .width('100%')
        .height(AppSpacing.xxl)

        Text('Output Path: /storage/recordings/' +
          (this.title.length === 0 ? 'untitled' : this.title) + '.mp3')
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .opacity(0.7)
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [[AppColors.background, 0.0], [AppColors.surfaceVariant, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea()
  }
}