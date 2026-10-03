// Index.ets

interface AppColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface AppTypography {
  display: FontInfo;
  title: FontInfo;
  body: FontInfo;
  label: FontInfo;
}

interface AppShapes {
  smallCornerRadius: number;
  mediumCornerRadius: number;
  largeCornerRadius: number;
}

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface FontInfo {
  size: number;
  weight: FontWeight;
}

class AppTokens {
  static Colors: AppColors = {
    primary: '#FF00FFFF',
    secondary: '#FF9D00FF',
    tertiary: '#FF00FFA3',
    background: '#FF0B0B0D',
    surface: '#FF1A1A1D',
    surfaceVariant: '#FF2E2E33',
    outline: '#FF3F3F46',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FF000000',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF000000',
    onBackground: '#FFE5E7EB',
    onSurface: '#FFE5E7EB'
  };

  static TypographyTokens: AppTypography = {
    display: { size: 28, weight: FontWeight.Bold } as FontInfo,
    title: { size: 18, weight: FontWeight.Medium } as FontInfo,
    body: { size: 14, weight: FontWeight.Regular } as FontInfo,
    label: { size: 12, weight: FontWeight.Medium } as FontInfo
  };

  static Shapes: AppShapes = {
    smallCornerRadius: 6.0,
    mediumCornerRadius: 10.0,
    largeCornerRadius: 14.0
  };

  static Spacing: AppSpacing = {
    xs: 4.0,
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 24.0,
    xxl: 32.0
  };
}

@Entry
@Component
struct ContentView {
  @State title: string = '';
  @State recording: boolean = false;
  @State seconds: number = 0;
  private timerId: number = -1;

  private startTimer() {
    this.stopTimer();
    this.timerId = setInterval(() => {
      this.seconds += 1;
    }, 1000);
  }

  private stopTimer() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  aboutToDisappear() {
    this.stopTimer();
  }

  build() {
    Column() {
      // 顶部栏
      Text('Neon Recorder')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.primary)
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .width('100%')
        .backgroundColor(AppTokens.Colors.background)
        .textAlign(TextAlign.Center);

      // 内容区域
      Column() {
        // 录音名称输入框
        Column() {
          Text('Recording name')
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .opacity(0.7)
            .margin({ bottom: AppTokens.Spacing.sm });

          TextInput({ text: this.title, placeholder: '' })
            .onChange((value: string) => {
              this.title = value;
            })
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
            .border({ width: 1, color: this.title === '' ? AppTokens.Colors.outline : AppTokens.Colors.primary })
            .caretColor(AppTokens.Colors.primary);
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%');

        // 录音状态卡片
        Stack() {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(this.recording ? AppTokens.Colors.primary : AppTokens.Colors.onSurface);
        }
        .width('100%')
        .height(200)
        .margin({ top: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.largeCornerRadius);

        // 按钮行
        Row() {
          Button(this.recording ? 'Stop' : 'Record')
            .onClick(() => {
              this.recording = !this.recording;
              if (this.recording) {
                this.seconds = 0;
                this.startTimer();
              } else {
                this.stopTimer();
              }
            })
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width(160)
            .height(52)
            .backgroundColor(this.recording ? AppTokens.Colors.error : AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.largeCornerRadius);

          Button('Reset')
            .onClick(() => {
              this.seconds = 0;
              if (this.recording) {
                this.stopTimer();
                this.startTimer();
              }
            })
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .width(120)
            .height(52)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.largeCornerRadius);
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: AppTokens.Spacing.xl });

        // 底部路径文本
        Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: AppTokens.Spacing.xxl });
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 1.0]]
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]);
  }
}