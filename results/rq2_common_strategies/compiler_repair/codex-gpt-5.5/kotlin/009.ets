class VideoColors {
  static primary: string = '#1E3A8A';
  static secondary: string = '#3B82F6';
  static background: string = '#0F172A';
  static surface: string = '#1E293B';
  static surfaceVariant: string = '#334155';
  static outline: string = '#475569';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onBackground: string = '#F8FAFC';
  static onSurface: string = '#E2E8F0';
}

@Entry
@Component
struct Index {
  @State title: string = 'Journey through the Skies';
  @State currentTime: number = 95;
  @State totalTime: number = 240;
  @State playing: boolean = false;
  @State fullscreen: boolean = false;

  private clamp(value: number, min: number, max: number): number {
    return Math.min(max, Math.max(min, value));
  }

  private formatTime(sec: number): string {
    let total: number = Math.max(0, Math.floor(sec));
    let minutes: number = Math.floor(total / 60);
    let seconds: number = total % 60;
    let suffix: string = seconds < 10 ? '0' + seconds.toString() : seconds.toString();
    return minutes.toString() + ':' + suffix;
  }

  private progressPercent(): number {
    if (this.totalTime <= 0) {
      return 0;
    }
    return this.currentTime / this.totalTime * 100;
  }

  @Builder
  ControlButton(label: string, action: () => void) {
    Button(label)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(VideoColors.onSurface)
      .backgroundColor(VideoColors.surfaceVariant)
      .borderRadius(12)
      .height(44)
      .width(88)
      .onClick(action)
  }

  @Builder
  Header() {
    if (!this.fullscreen) {
      Text('Video Player')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(VideoColors.onSurface)
        .lineHeight(22)
        .width('100%')
        .height(56)
        .textAlign(TextAlign.Center)
        .backgroundColor(VideoColors.background)
    }
  }

  build() {
    Column() {
      this.Header()

      Stack() {
        Text('Video Surface')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(VideoColors.onSurface)
          .lineHeight(22)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(VideoColors.surfaceVariant)
      .borderRadius(12)
      .alignContent(Alignment.Center)

      Column({ space: 12 }) {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(VideoColors.onSurface)
          .lineHeight(22)

        Slider({ value: this.progressPercent(), min: 0, max: 100, step: 1 })
          .selectedColor(VideoColors.primary)
          .trackColor(VideoColors.outline)
          .onChange((value: number) => {
            this.currentTime = value / 100 * this.totalTime;
          })

        Row() {
          Text(this.formatTime(this.currentTime))
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3E2E8F0')
            .lineHeight(16)
          Text(this.formatTime(this.totalTime))
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3E2E8F0')
            .lineHeight(16)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          this.ControlButton('-10s', () => {
            this.currentTime = this.clamp(this.currentTime - 10, 0, this.totalTime);
          })
          Button(this.playing ? 'II' : '>')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(VideoColors.onPrimary)
            .backgroundColor(VideoColors.primary)
            .borderRadius(72)
            .width(72)
            .height(72)
            .onClick(() => {
              this.playing = !this.playing;
            })
          this.ControlButton('+30s', () => {
            this.currentTime = this.clamp(this.currentTime + 30, 0, this.totalTime);
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)

        Row() {
          Text(this.fullscreen ? 'Exit Fullscreen' : 'Fullscreen')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.fullscreen ? VideoColors.onPrimary : VideoColors.onSurface)
            .lineHeight(20)
            .padding({ left: 12, right: 12, top: 7, bottom: 7 })
            .backgroundColor(this.fullscreen ? '#333B82F6' : VideoColors.surface)
            .border({ width: 1, color: VideoColors.outline, radius: 12 })
            .onClick(() => {
              this.fullscreen = !this.fullscreen;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(VideoColors.background)
  }
}
