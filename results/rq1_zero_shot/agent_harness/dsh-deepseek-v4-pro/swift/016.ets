// Translated from SwiftUI to ArkTS (ArkUI declarative syntax)

// MARK: - AppTokens
class AppTokens {
  static readonly Colors = {
    primary: "#00FFFF",
    secondary: "#9D00FF",
    tertiary: "#00FFA3",
    background: "#0B0B0D",
    surface: "#1A1A1D",
    surfaceVariant: "#2E2E33",
    outline: "#3F3F46",
    success: "#22C55E",
    warning: "#F59E0B",
    error: "#EF4444",
    onPrimary: "#000000",
    onSecondary: "#FFFFFF",
    onTertiary: "#000000",
    onBackground: "#E5E7EB",
    onSurface: "#E5E7EB",
  };

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };
}

@Component
struct ContentView {
  @State title: string = "";
  @State recording: boolean = false;
  @State seconds: number = 0;
  private timerId: number = -1;

  build() {
    Column({ space: 0 }) {
      // 顶部栏
      Text("Neon Recorder")
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.primary)
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .width("100%")
        .backgroundColor(AppTokens.Colors.background)

      // 内容区域
      Column({ space: AppTokens.Spacing.lg }) {
        // 录音名称输入框
        Column({ space: AppTokens.Spacing.sm }) {
          Text("Recording name")
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .opacity(0.7)

          TextInput({ placeholder: "", text: this.title })
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.medium)
            .border({
              width: 1,
              color: this.title.length == 0 ? AppTokens.Colors.outline : AppTokens.Colors.primary
            })
            .onChange((value: string) => {
              this.title = value;
            })
        }
        .alignItems(HorizontalAlign.Start)

        // 录音状态卡片
        Stack() {
          Rect()
            .width("100%")
            .height(200)
            .fill(AppTokens.Colors.surfaceVariant)
            .radius(AppTokens.Shapes.large)

          Text(this.recording ? "Recording... " + this.seconds.toString() + "s" : "Press Record")
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(this.recording ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
        }
        .width("100%")
        .height(200)

        // 按钮行
        Row({ space: AppTokens.Spacing.xl }) {
          Button() {
            Text(this.recording ? "Stop" : "Record")
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
              .width(160)
              .height(52)
          }
          .width(160)
          .height(52)
          .backgroundColor(this.recording ? AppTokens.Colors.error : AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {
            this.recording = !this.recording;
            if (this.recording) {
              this.seconds = 0;
              this.startTimer();
            } else {
              this.stopTimer();
            }
          })

          Button() {
            Text("Reset")
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .width(120)
              .height(52)
          }
          .width(120)
          .height(52)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {
            this.seconds = 0;
            if (this.recording) {
              this.stopTimer();
              this.startTimer();
            }
          })
        }

        Blank()
          .height(AppTokens.Spacing.xxl)

        Text("Output Path: /storage/recordings/" + (this.title.length == 0 ? "untitled" : this.title) + ".mp3")
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7)
          .width("100%")
          .textAlign(TextAlign.Start)
      }
      .padding(AppTokens.Spacing.lg)
      .width("100%")
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 1.0]]
      })
    }
    .width("100%")
    .height("100%")
    .backgroundColor(AppTokens.Colors.background)
  }

  // MARK: - Timer Functions
  private startTimer() {
    this.stopTimer();
    this.timerId = setInterval(() => {
      this.seconds += 1;
    }, 1000);
  }

  private stopTimer() {
    if (this.timerId != -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }
}

@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}
