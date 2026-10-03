// MARK: - Color Extension for Hex Initialization
function toHexByte(value: number): string {
  const s: string = value.toString(16).toUpperCase();
  return s.length === 1 ? '0' + s : s;
}

function hexColor(hex: number): string {
  const red: number = (hex >> 16) & 0xFF;
  const green: number = (hex >> 8) & 0xFF;
  const blue: number = hex & 0xFF;
  const alphaRaw: number = (hex >> 24) & 0xFF;
  const alpha: number = (alphaRaw === 0 && hex <= 0xFFFFFF) ? 0xFF : alphaRaw;
  return '#' + toHexByte(alpha) + toHexByte(red) + toHexByte(green) + toHexByte(blue);
}

// MARK: - AppTokens
interface ColorsMap {
  readonly primary: string;
  readonly secondary: string;
  readonly tertiary: string;
  readonly background: string;
  readonly surface: string;
  readonly surfaceVariant: string;
  readonly outline: string;
  readonly success: string;
  readonly warning: string;
  readonly error: string;
  readonly onPrimary: string;
  readonly onSecondary: string;
  readonly onTertiary: string;
  readonly onBackground: string;
  readonly onSurface: string;
}

class FontToken {
  size: number = 0;
  weight: FontWeight = FontWeight.Regular;

  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

interface TypographyMap {
  readonly display: FontToken;
  readonly title: FontToken;
  readonly body: FontToken;
  readonly label: FontToken;
}

interface ShapesMap {
  readonly smallCornerRadius: number;
  readonly mediumCornerRadius: number;
  readonly largeCornerRadius: number;
}

interface SpacingMap {
  readonly xs: number;
  readonly sm: number;
  readonly md: number;
  readonly lg: number;
  readonly xl: number;
  readonly xxl: number;
}

class AppTokens {
  static readonly Colors: ColorsMap = {
    primary: hexColor(0xFF00FFFF),
    secondary: hexColor(0xFF9D00FF),
    tertiary: hexColor(0xFF00FFA3),
    background: hexColor(0xFF0B0B0D),
    surface: hexColor(0xFF1A1A1D),
    surfaceVariant: hexColor(0xFF2E2E33),
    outline: hexColor(0xFF3F3F46),
    success: hexColor(0xFF22C55E),
    warning: hexColor(0xFFF59E0B),
    error: hexColor(0xFFEF4444),
    onPrimary: hexColor(0xFF000000),
    onSecondary: hexColor(0xFFFFFFFF),
    onTertiary: hexColor(0xFF000000),
    onBackground: hexColor(0xFFE5E7EB),
    onSurface: hexColor(0xFFE5E7EB)
  };
  static readonly TypographyTokens: TypographyMap = {
    display: new FontToken(28, FontWeight.Bold),
    title: new FontToken(18, FontWeight.Medium),
    body: new FontToken(14, FontWeight.Regular),
    label: new FontToken(12, FontWeight.Medium)
  };
  static readonly Shapes: ShapesMap = {
    smallCornerRadius: 6.0,
    mediumCornerRadius: 10.0,
    largeCornerRadius: 14.0
  };
  static readonly Spacing: SpacingMap = {
    xs: 4.0,
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 24.0,
    xxl: 32.0
  };
}

// MARK: - RootScreen
@Component
struct ContentView {
  @State title: string = '';
  @State recording: boolean = false;
  @State seconds: number = 0;
  private timerId: number = -1;

  build() {
    Column({ space: 0 }) {
      // 顶部栏
      Text('Neon Recorder')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.primary)
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .width('100%')
        .backgroundColor(AppTokens.Colors.background)

      // 内容区域
      Column({ space: AppTokens.Spacing.lg }) {
        // 录音名称输入框
        Column({ space: AppTokens.Spacing.sm }) {
          Text('Recording name')
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .opacity(0.7)

          TextInput({ placeholder: '', text: this.title })
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
            .border({
              width: 1,
              color: this.title.length === 0 ? AppTokens.Colors.outline : AppTokens.Colors.primary
            })
            .caretColor(AppTokens.Colors.primary)
            .onChange((value: string) => {
              this.title = value;
            })
        }
        .alignItems(HorizontalAlign.Start)

        // 录音状态卡片
        Stack() {
          Rect()
            .fill(AppTokens.Colors.surfaceVariant)
            .radius(AppTokens.Shapes.largeCornerRadius)
            .width('100%')
            .height('100%')
          Text(this.recording ? 'Recording... ' + this.seconds + 's' : 'Press Record')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(this.recording ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(200)

        // 按钮行
        Row({ space: AppTokens.Spacing.xl }) {
          Button() {
            Text(this.recording ? 'Stop' : 'Record')
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .type(ButtonType.Normal)
          .width(160)
          .height(52)
          .backgroundColor(this.recording ? AppTokens.Colors.error : AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
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
            Text('Reset')
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
          }
          .type(ButtonType.Normal)
          .width(120)
          .height(52)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
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

        Text('Output Path: /storage/recordings/' + (this.title.length === 0 ? 'untitled' : this.title) + '.mp3')
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7)
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    // iOS: .ignoresSafeArea(.keyboard, edges: .bottom) — not applicable in ArkUI
    // iOS: .ignoresSafeArea(.all, edges: .all) — not applicable in ArkUI
    // iOS: .statusBar(hidden: true) — configured via window/ability settings in ArkUI
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
}

// MARK: - App Entry Point
@Entry
@Component
struct NeonRecorderApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
    // iOS: .preferredColorScheme(.dark) — ArkUI defaults to the system theme
  }
}
