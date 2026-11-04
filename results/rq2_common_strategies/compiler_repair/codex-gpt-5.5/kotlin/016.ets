class RecorderColors {
  static primary: string = '#00FFFF';
  static secondary: string = '#9D00FF';
  static tertiary: string = '#00FFA3';
  static background: string = '#0B0B0D';
  static surface: string = '#1A1A1D';
  static surfaceVariant: string = '#2E2E33';
  static outline: string = '#3F3F46';
  static error: string = '#EF4444';
  static onPrimary: string = '#000000';
  static onSecondary: string = '#FFFFFF';
  static onSurface: string = '#E5E7EB';
}

@Entry
@Component
struct Index {
  @State title: string = '';
  @State recording: boolean = false;
  @State seconds: number = 0;

  private outputName(): string {
    return this.title.trim().length === 0 ? 'untitled' : this.title;
  }

  build() {
    Column() {
      Text('Neon Recorder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(RecorderColors.primary)
        .lineHeight(34)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor(RecorderColors.background)

      Column({ space: 16 }) {
        TextInput({ text: this.title, placeholder: 'Recording name' })
          .fontSize(16)
          .fontColor(RecorderColors.onSurface)
          .placeholderColor(RecorderColors.onSurface)
          .caretColor(RecorderColors.primary)
          .height(54)
          .width('100%')
          .backgroundColor(RecorderColors.surface)
          .border({ width: 1, color: RecorderColors.outline, radius: 10 })
          .onChange((value: string) => {
            this.title = value;
          })

        Stack() {
          Text(this.recording ? 'Recording... ' + this.seconds.toString() + 's' : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? RecorderColors.primary : RecorderColors.onSurface)
            .lineHeight(24)
        }
        .width('100%')
        .height(200)
        .backgroundColor(RecorderColors.surfaceVariant)
        .borderRadius(14)
        .alignContent(Alignment.Center)

        Row() {
          Button(this.recording ? 'Stop' : 'Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(RecorderColors.onPrimary)
            .backgroundColor(this.recording ? RecorderColors.error : RecorderColors.primary)
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
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(RecorderColors.onSecondary)
            .backgroundColor(RecorderColors.secondary)
            .borderRadius(14)
            .height(52)
            .width(120)
            .onClick(() => {
              this.seconds = 0;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Blank().height(32)

        Text('Output Path: /storage/recordings/' + this.outputName() + '.mp3')
          .fontSize(14)
          .fontColor('#B3E5E7EB')
          .lineHeight(20)
          .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(RecorderColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RecorderColors.background)
  }
}
