interface ColorTokens {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onSecondary: ResourceColor;
  onTertiary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
}

@Entry
@Component
struct Index {
  @State title: string = '';
  @State recording: boolean = false;
  @State seconds: number = 0;
  private timerId: number = -1;

  private readonly Colors: ColorTokens = {
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

  aboutToAppear(): void {
    this.startTimer();
  }

  aboutToDisappear(): void {
    this.stopTimer();
  }

  startTimer(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
    }
    this.timerId = setInterval(() => {
      if (this.recording) {
        this.seconds++;
      }
    }, 1000);
  }

  stopTimer(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  build() {
    Column() {
      Text('Neon Recorder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.Colors.primary)
        .margin({ top: 48, bottom: 24 } as Margin)

      TextInput({ placeholder: 'Recording name', text: this.title })
        .width('100%')
        .height(56)
        .backgroundColor(this.Colors.background)
        .fontColor(this.Colors.onSurface)
        .placeholderColor(this.Colors.onSurface)
        .placeholderFont({ size: 18, weight: FontWeight.Normal } as Font)
        .borderRadius(14)
        .border({ width: 1, color: this.Colors.outline } as BorderOptions)
        .padding({ left: 16, right: 16 } as Padding)
        .margin({ bottom: 16 } as Margin)
        .onChange((value: string) => {
          this.title = value;
        })

      Column() {
        Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.recording ? this.Colors.primary : this.Colors.onSurface)
      }
      .width('100%')
      .height(200)
      .backgroundColor(this.Colors.surfaceVariant)
      .borderRadius(14)
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 16 } as Margin)

      Row() {
        Button(this.recording ? 'Stop' : 'Record')
          .width(160)
          .height(52)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.Colors.onPrimary)
          .backgroundColor(this.recording ? this.Colors.error : this.Colors.primary)
          .borderRadius(14)
          .onClick(() => {
            this.recording = !this.recording;
            if (this.recording) {
              this.seconds = 0;
            }
          })

        Button('Reset')
          .width(120)
          .height(52)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.Colors.onSecondary)
          .backgroundColor(this.Colors.secondary)
          .borderRadius(14)
          .onClick(() => {
            this.seconds = 0;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ bottom: 32 } as Margin)

      Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
        .fontSize(14)
        .fontColor(this.Colors.onSurface)
        .opacity(0.7)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16 } as Padding)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[this.Colors.surfaceVariant, 0.0], [this.Colors.background, 1.0]]
    } as LinearGradientOptions)
  }
}
