// Index.ets

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static Colors = {
    primary: '#00FFFF',
    secondary: '#9D00FF',
    tertiary: '#00FFA3',
    background: '#0B0B0D',
    surface: '#1A1A1D',
    surfaceVariant: '#2E2E33',
    outline: '#3F3F46',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#000000',
    onSecondary: '#FFFFFF',
    onTertiary: '#000000',
    onBackground: '#E5E7EB',
    onSurface: '#E5E7EB'
  };

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static Shapes = {
    small: 6,
    medium: 10,
    large: 14
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 } as ShadowSpec,
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.16 } as ShadowSpec
  };
}

@Entry
@Component
struct RootScreen {
  @State title: string = '';
  @State recording: boolean = false;
  @State seconds: number = 0;

  build() {
    Column() {
      // TopAppBar
      Row() {
        Text('Neon Recorder')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background);

      // Content
      Column() {
        // OutlinedTextField
        TextInput({ text: this.title, placeholder: 'Recording name' })
          .onChange((value: string) => {
            this.title = value;
          })
          .width('100%')
          .height(50)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderWidth(1)
          .borderColor(AppTokens.Colors.outline)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ bottom: AppTokens.Spacing.lg });

        // Card
        Column() {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(this.recording ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(200)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .margin({ bottom: AppTokens.Spacing.lg });

        // Buttons Row
        Row() {
          Button(this.recording ? 'Stop' : 'Record')
            .type(ButtonType.Capsule)
            .width(160)
            .height(52)
            .backgroundColor(this.recording ? AppTokens.Colors.error : AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .onClick(() => {
              this.recording = !this.recording;
              if (this.recording) {
                this.seconds = 0;
              }
            });

          Button('Reset')
            .type(ButtonType.Capsule)
            .width(120)
            .height(52)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .onClick(() => {
              this.seconds = 0;
            });
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ bottom: AppTokens.Spacing.xxl });

        // Output Path Text
        Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7);
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 1.0]]
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}