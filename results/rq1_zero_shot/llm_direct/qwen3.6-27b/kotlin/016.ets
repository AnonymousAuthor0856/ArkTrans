import { Window } from '@kit.ArkUI'

// Token Definitions matching Kotlin AppTokens
const COLORS = {
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
} as const;

const SPACING = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
} as const;

@Entry
@Component
struct RootScreen {
  @State title: string = '';
  @State recording: boolean = false;
  @State seconds: number = 0;
  private timerId: number = -1;

  aboutToAppear() {
    // Start the timer logic
    this.startTimer();
  }

  aboutToDisappear() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
    }
  }

  startTimer() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
    }
    this.timerId = setInterval(() => {
      if (this.recording) {
        this.seconds++;
      }
    }, 1000);
  }

  build() {
    Column() {
      // Top Bar Area
      Row() {
        Text('Neon Recorder')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: SPACING.lg, bottom: SPACING.md })

      // Main Content Area
      Column() {
        // Input Field
        TextInput({ placeholder: 'Recording name' })
          .type(InputType.Text)
          .text(this.title)
          .onChange((value: string) => {
            this.title = value;
          })
          .backgroundColor(COLORS.surfaceVariant)
          .borderRadius(10)
          .borderWidth(1)
          .borderColor(this.title.length > 0 ? COLORS.primary : COLORS.outline)
          .margin({ bottom: SPACING.lg })
          .height(50)
          .padding({ left: SPACING.sm })
          .fontColor(COLORS.onSurface)

        // Visualization Card
        Column() {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? COLORS.primary : COLORS.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(COLORS.surfaceVariant)
        .borderRadius(14)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .margin({ bottom: SPACING.lg })

        // Buttons Row
        Row() {
          Button(this.recording ? 'Stop' : 'Record')
            .backgroundColor(this.recording ? COLORS.error : COLORS.primary)
            .fontColor(COLORS.onPrimary)
            .borderRadius(14)
            .height(52)
            .width(160)
            .onClick(() => {
              this.recording = !this.recording;
              if (this.recording) {
                this.seconds = 0;
              }
            })

          Button('Reset')
            .backgroundColor(COLORS.secondary)
            .fontColor(COLORS.onSecondary)
            .borderRadius(14)
            .height(52)
            .width(120)
            .margin({ left: SPACING.md })
            .onClick(() => {
              this.seconds = 0;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ bottom: SPACING.xxl })

        // Output Path Text
        Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#B3E5E7EB') // Approximate alpha 0.7 of #E5E7EB
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding(SPACING.lg)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
    // Simulating vertical gradient with a simple background color for ArkTS compatibility in single file
    // or using linearGradient if supported by specific SDK version, but solid is safer for "compilable" guarantee
    .linearGradient({
      direction: GradientDirection.TOP,
      colors: [['#0B0B0D', 0], ['#2E2E33', 1]]
    })
  }
}