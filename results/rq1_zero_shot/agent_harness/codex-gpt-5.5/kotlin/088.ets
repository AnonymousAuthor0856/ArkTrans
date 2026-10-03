class BreathingPattern {
  name: string;
  inhale: number;
  exhale: number;

  constructor(name: string, inhale: number, exhale: number) {
    this.name = name;
    this.inhale = inhale;
    this.exhale = exhale;
  }

  totalDuration(): number {
    return this.inhale + this.exhale;
  }
}

@Entry
@Component
struct MainActivity {
  @State selectedPatternIndex: number = 0;
  @State playing: boolean = false;

  private patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ];

  @Builder
  BreathVisualizer(pattern: BreathingPattern) {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(this.playing ? 270 : 250)
        .height(this.playing ? 270 : 250)
        .fill('#1A00897B')
      Circle()
        .width(230)
        .height(230)
        .fill(Color.Transparent)
        .stroke('#00897B')
        .strokeWidth(4)
      ForEach([0, 1, 2, 3, 4, 5, 6, 7], (i: number) => {
        Circle()
          .width(12)
          .height(12)
          .fill('#00897B')
          .position({ x: `${50 + 34 * Math.cos(i * Math.PI / 4)}%`, y: `${50 + 34 * Math.sin(i * Math.PI / 4)}%` })
      })
      Column() {
        Text(this.playing ? 'Breathe' : 'Ready')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#00897B')
        Text(`${pattern.inhale}s In / ${pattern.exhale}s Out`)
          .fontSize(14)
          .fontColor('#808080')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(280)
    .height(280)
  }

  @Builder
  PatternCard(pattern: BreathingPattern, index: number) {
    Column() {
      if (this.selectedPatternIndex === index) {
        Text('✓')
          .fontSize(16)
          .fontColor('#00897B')
          .margin({ bottom: 4 })
      }
      Text(pattern.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.selectedPatternIndex === index ? '#00897B' : '#2D2D2D')
      Text(`${pattern.inhale}-${pattern.exhale}`)
        .fontSize(12)
        .fontColor('#808080')
    }
    .width(100)
    .height(90)
    .padding(12)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.selectedPatternIndex === index ? '#0D00897B' : '#F5F5F5')
    .borderRadius(20)
    .border({ width: 2, color: this.selectedPatternIndex === index ? '#00897B' : Color.Transparent })
    .onClick(() => {
      this.selectedPatternIndex = index;
      this.playing = false;
    })
  }

  @Builder
  PlayPauseButton() {
    Button(this.playing ? 'STOP SESSION' : 'START BREATHING  ▶')
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .fontColor('#FFFFFF')
      .width('100%')
      .height(64)
      .backgroundColor('#2D2D2D')
      .borderRadius(32)
      .onClick(() => {
        this.playing = !this.playing;
      })
  }

  build() {
    Column() {
      Column() {
        Blank().height(48)
        Row() {
          Text('ZenBreather')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2D2D2D')
            .layoutWeight(1)
          Text('⚙')
            .fontSize(24)
            .fontColor('#808080')
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Blank().height(60)
        this.BreathVisualizer(this.patterns[this.selectedPatternIndex])

        Blank().layoutWeight(1)
        Text('Select Rhythm')
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#2D2D2D')
          .width('100%')
        Blank().height(16)
        Row() {
          ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
            this.PatternCard(pattern, index)
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        Blank().height(32)
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 24, right: 24 })
      .alignItems(HorizontalAlign.Center)

      Row() {
        this.PlayPauseButton()
      }
      .width('100%')
      .padding(32)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
