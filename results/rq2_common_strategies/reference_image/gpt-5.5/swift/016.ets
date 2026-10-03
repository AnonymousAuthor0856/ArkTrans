const AppColors: Record<string, string> = {
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
  onSurface: '#E5E7EB',
  onSurface70: '#B3E5E7EB'
}

const AppSpacing: Record<string, number> = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
}

const AppShapes: Record<string, number> = {
  smallCornerRadius: 6,
  mediumCornerRadius: 10,
  largeCornerRadius: 14
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
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')
        .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Column({ space: AppSpacing.sm }) {
          Text('Recording name')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface70)
            .width('100%')

          TextInput({ text: this.title })
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)
            .caretColor(AppColors.primary)
            .padding({
              left: AppSpacing.md,
              right: AppSpacing.md,
              top: AppSpacing.md,
              bottom: AppSpacing.md
            })
            .width('100%')
            .height(52)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.mediumCornerRadius)
            .border({
              width: 1,
              color: this.title.length === 0 ? AppColors.outline : AppColors.primary,
              radius: AppShapes.mediumCornerRadius
            })
            .onChange((value: string) => {
              this.title = value
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)

        Stack({ alignContent: Alignment.Center }) {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? AppColors.primary : AppColors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.largeCornerRadius)

        Row({ space: AppSpacing.xl }) {
          Button({ type: ButtonType.Normal }) {
            Text(this.recording ? 'Stop' : 'Record')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
          }
          .width(160)
          .height(52)
          .borderRadius(AppShapes.largeCornerRadius)
          .backgroundColor(this.recording ? AppColors.error : AppColors.primary)
          .stateEffect(false)
          .onClick(() => {
            this.recording = !this.recording
            if (this.recording) {
              this.seconds = 0
              this.startTimer()
            } else {
              this.stopTimer()
            }
          })

          Button({ type: ButtonType.Normal }) {
            Text('Reset')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
          }
          .width(120)
          .height(52)
          .borderRadius(AppShapes.largeCornerRadius)
          .backgroundColor(AppColors.secondary)
          .stateEffect(false)
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
          .height(AppSpacing.xxl)

        Text(`Output Path: /storage/recordings/${this.title.length === 0 ? 'untitled' : this.title}.mp3`)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface70)
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Stretch)
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
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}