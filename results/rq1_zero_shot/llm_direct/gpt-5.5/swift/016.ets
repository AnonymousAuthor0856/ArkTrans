class AppTokens {
  static readonly Colors = {
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
  }

  static readonly TypographyTokens = {
    displaySize: 28,
    displayWeight: FontWeight.Bold,
    titleSize: 18,
    titleWeight: FontWeight.Medium,
    bodySize: 14,
    bodyWeight: FontWeight.Regular,
    labelSize: 12,
    labelWeight: FontWeight.Medium
  }

  static readonly Shapes = {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 14
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }
}

@Entry
@Component
struct ContentView {
  @State private title: string = ''
  @State private recording: boolean = false
  @State private seconds: number = 0

  private timerId: number = -1

  private startTimer(): void {
    this.stopTimer()
    this.timerId = setInterval(() => {
      this.seconds += 1
    }, 1000)
  }

  private stopTimer(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
      this.timerId = -1
    }
  }

  aboutToDisappear(): void {
    this.stopTimer()
  }

  build() {
    Column({ space: 0 }) {
      Text('Neon Recorder')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(AppTokens.TypographyTokens.displayWeight)
        .fontColor(AppTokens.Colors.primary)
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.lg }) {
        Column({ space: AppTokens.Spacing.sm }) {
          Text('Recording name')
            .fontSize(AppTokens.TypographyTokens.labelSize)
            .fontWeight(AppTokens.TypographyTokens.labelWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .opacity(0.7)
            .width('100%')
            .textAlign(TextAlign.Start)

          TextInput({ text: this.title })
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontWeight(AppTokens.TypographyTokens.bodyWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .caretColor(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.mediumCornerRadius)
            .border({
              width: 1,
              color: this.title.length === 0 ? AppTokens.Colors.outline : AppTokens.Colors.primary
            })
            .padding(AppTokens.Spacing.md)
            .height(48)
            .width('100%')
            .onChange((value: string) => {
              this.title = value
            })
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')

        Stack() {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(this.recording ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.largeCornerRadius)

        Row({ space: AppTokens.Spacing.xl }) {
          Button({ type: ButtonType.Normal, stateEffect: false }) {
            Text(this.recording ? 'Stop' : 'Record')
              .fontSize(AppTokens.TypographyTokens.titleSize)
              .fontWeight(AppTokens.TypographyTokens.titleWeight)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width(160)
          .height(52)
          .backgroundColor(this.recording ? AppTokens.Colors.error : AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
          .onClick(() => {
            this.recording = !this.recording
            if (this.recording) {
              this.seconds = 0
              this.startTimer()
            } else {
              this.stopTimer()
            }
          })

          Button({ type: ButtonType.Normal, stateEffect: false }) {
            Text('Reset')
              .fontSize(AppTokens.TypographyTokens.titleSize)
              .fontWeight(AppTokens.TypographyTokens.titleWeight)
              .fontColor(AppTokens.Colors.onSecondary)
          }
          .width(120)
          .height(52)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.largeCornerRadius)
          .onClick(() => {
            this.seconds = 0
            if (this.recording) {
              this.stopTimer()
              this.startTimer()
            }
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Blank()
          .height(AppTokens.Spacing.xxl)

        Text(`Output Path: /storage/recordings/${this.title.length === 0 ? 'untitled' : this.title}.mp3`)
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(AppTokens.TypographyTokens.bodyWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7)
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.background, 0.0],
          [AppTokens.Colors.surfaceVariant, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}