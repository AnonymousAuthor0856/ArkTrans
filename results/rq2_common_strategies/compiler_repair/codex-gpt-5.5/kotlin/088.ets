class BreathingPattern {
  name: string
  inhale: number
  exhale: number

  constructor(name: string, inhale: number, exhale: number) {
    this.name = name
    this.inhale = inhale
    this.exhale = exhale
  }

  totalDuration(): number {
    return this.inhale + this.exhale
  }
}

@Entry
@Component
struct Index {
  @State selectedPatternIndex: number = 0
  @State isPlaying: boolean = false

  private patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Text('ZenBreather')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2D2D2D')
          Text('⚙')
            .fontSize(24)
            .fontColor(Color.Gray)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 48 })

        Stack() {
          this.BreathVisualizer()
          Column() {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontSize(24)
              .fontColor('#00897B')
              .fontWeight(FontWeight.Medium)
            Text(this.patterns[this.selectedPatternIndex].inhale.toString() + 's In / ' + this.patterns[this.selectedPatternIndex].exhale.toString() + 's Out')
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(280)
        .height(280)
        .margin({ top: 60 })

        Blank()

        Text('Select Rhythm')
          .width('100%')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2D2D2D')
          .margin({ bottom: 16 })

        Row() {
          ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
            this.PatternCard(pattern, index)
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: 112 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })
      .alignItems(HorizontalAlign.Center)

      this.PlayPauseButton()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  BreathVisualizer() {
    Stack() {
      Circle()
        .width(250)
        .height(250)
        .fill('rgba(0,137,123,0.1)')
      Circle()
        .width(250)
        .height(250)
        .fill(Color.Transparent)
        .stroke('#00897B')
        .strokeWidth(4)
      ForEach([0, 1, 2, 3, 4, 5, 6, 7], (item: number) => {
        Stack() {
          Rect()
            .width(2)
            .height(86)
            .fill('rgba(0,137,123,0.4)')
            .margin({ top: 44 })
          Circle()
            .width(12)
            .height(12)
            .fill('#00897B')
            .margin({ top: 36 })
        }
        .width(250)
        .height(250)
        .rotate({ angle: item * 45 })
      })
    }
    .width(280)
    .height(280)
    .scale({ x: this.isPlaying ? 1.08 : 1, y: this.isPlaying ? 1.08 : 1 })
  }

  @Builder
  PatternCard(pattern: BreathingPattern, index: number) {
    Column() {
      if (this.selectedPatternIndex === index) {
        Text('✓')
          .fontSize(16)
          .fontColor('#00897B')
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 4 })
      }
      Text(pattern.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.selectedPatternIndex === index ? '#00897B' : '#2D2D2D')
      Text(pattern.inhale.toString() + '-' + pattern.exhale.toString())
        .fontSize(12)
        .fontColor(Color.Gray)
        .margin({ top: 4 })
    }
    .width(100)
    .height(90)
    .padding(12)
    .border({ width: 2, color: this.selectedPatternIndex === index ? '#00897B' : Color.Transparent, radius: 20 })
    .backgroundColor(this.selectedPatternIndex === index ? 'rgba(0,137,123,0.05)' : '#F5F5F5')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.selectedPatternIndex = index
      this.isPlaying = false
    })
  }

  @Builder
  PlayPauseButton() {
    Button() {
      Row() {
        Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
        if (!this.isPlaying) {
          Text('▶')
            .fontSize(20)
            .fontColor(Color.White)
            .margin({ left: 8 })
        }
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .height(64)
    .width('100%')
    .borderRadius(32)
    .backgroundColor('#2D2D2D')
    .margin({ left: 32, right: 32, bottom: 32 })
    .onClick(() => {
      this.isPlaying = !this.isPlaying
    })
  }
}
