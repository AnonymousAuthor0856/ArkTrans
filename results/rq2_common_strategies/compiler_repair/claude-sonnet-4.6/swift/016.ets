// AppTokens
class ColorsClass {
  primary: number = 0xFF00FFFF;
  secondary: number = 0xFF9D00FF;
  tertiary: number = 0xFF00FFA3;
  background: number = 0xFF0B0B0D;
  surface: number = 0xFF1A1A1D;
  surfaceVariant: number = 0xFF2E2E33;
  outline: number = 0xFF3F3F46;
  success: number = 0xFF22C55E;
  warning: number = 0xFFF59E0B;
  error: number = 0xFFEF4444;
  onPrimary: number = 0xFF000000;
  onSecondary: number = 0xFFFFFFFF;
  onTertiary: number = 0xFF000000;
  onBackground: number = 0xFFE5E7EB;
  onSurface: number = 0xFFE5E7EB;
}

class SpacingClass {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

class ShapesClass {
  smallCornerRadius: number = 6;
  mediumCornerRadius: number = 10;
  largeCornerRadius: number = 14;
}

const Colors = new ColorsClass();
const Spacing = new SpacingClass();
const Shapes = new ShapesClass();

@Entry
@Component
struct ContentView {
  @State title: string = '';
  @State recording: boolean = false;
  @State seconds: number = 0;
  private timerInterval: number = -1;

  startTimer() {
    this.stopTimer();
    this.timerInterval = setInterval(() => {
      this.seconds += 1;
    }, 1000);
  }

  stopTimer() {
    if (this.timerInterval !== -1) {
      clearInterval(this.timerInterval);
      this.timerInterval = -1;
    }
  }

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Text('Neon Recorder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.primary)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: Spacing.lg, bottom: Spacing.lg })
        .backgroundColor(Colors.background)

      // Content Area
      Column({ space: Spacing.lg }) {
        // Recording Name Input
        Column({ space: Spacing.sm }) {
          Text('Recording name')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(0xB3E5E7EB)
            .width('100%')
            .textAlign(TextAlign.Start)

          TextInput({ placeholder: '', text: this.title })
            .fontSize(14)
            .fontColor(Colors.onSurface)
            .fontWeight(FontWeight.Normal)
            .padding(Spacing.md)
            .backgroundColor(Colors.surface)
            .borderRadius(Shapes.mediumCornerRadius)
            .border({
              width: 1,
              color: this.title === '' ? Colors.outline : Colors.primary,
              radius: Shapes.mediumCornerRadius,
            })
            .caretColor(Colors.primary)
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
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(Shapes.largeCornerRadius)

          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? Colors.primary : Colors.onSurface)
        }
        .width('100%')
        .height(200)

        // Button Row
        Row({ space: Spacing.xl }) {
          Button(this.recording ? 'Stop' : 'Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onPrimary)
            .width(160)
            .height(52)
            .backgroundColor(this.recording ? Colors.error : Colors.primary)
            .borderRadius(Shapes.largeCornerRadius)
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
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSecondary)
            .width(120)
            .height(52)
            .backgroundColor(Colors.secondary)
            .borderRadius(Shapes.largeCornerRadius)
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

        // Spacer
        Column()
          .height(Spacing.xxl)

        // Output Path
        Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(0xB3E5E7EB)
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .padding(Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [Colors.background, 0.0],
          [Colors.surfaceVariant, 1.0],
        ],
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}