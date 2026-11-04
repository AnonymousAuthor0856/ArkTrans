class BreathingPattern {
  name: string
  inhale: number
  exhale: number

  constructor(name: string, inhale: number, exhale: number) {
    this.name = name
    this.inhale = inhale
    this.exhale = exhale
  }
}

@Entry
@Component
struct Index {
  @State selectedPatternIndex: number = 0
  @State isPlaying: boolean = false
  @State breathScale: number = 0.8
  @State rotation: number = 0

  private readonly textDark: string = '#2D2D2D'
  private readonly accentTeal: string = '#00897B'
  private readonly lightGray: string = '#F5F5F5'
  private readonly textGray: string = '#808080'
  private readonly patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ]

  private currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex]
  }

  private toggleBreathing(): void {
    if (this.isPlaying) {
      this.stopBreathing()
    } else {
      this.startBreathing()
    }
  }

  private startBreathing(): void {
    this.isPlaying = true
    this.breathScale = 1.2
    this.rotation = 360
  }

  private stopBreathing(): void {
    this.isPlaying = false
    this.breathScale = 0.8
    this.rotation = 0
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Blank().height(48)
        this.Header()
        Blank().height(60)
        this.VisualizerSection()
        Blank()
        this.PatternSelection()
        Blank().height(32)
        this.ControlButton()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  Header() {
    Row() {
      Text('ZenBreather')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textDark)
      Blank()
      Text('⚙')
        .fontSize(24)
        .fontColor(this.textGray)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }

  @Builder
  VisualizerSection() {
    Stack() {
      this.BreathVisualizer()
      Column() {
        Text(this.isPlaying ? 'Breathe' : 'Ready')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accentTeal)
        Text(this.currentPattern().inhale.toString() + 's In / ' + this.currentPattern().exhale.toString() + 's Out')
          .fontSize(14)
          .fontColor(this.textGray)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(280)
    .height(280)
  }

  @Builder
  BreathVisualizer() {
    Stack() {
      Circle()
        .width(224 * this.breathScale)
        .height(224 * this.breathScale)
        .fill('#1A00897B')
      Circle()
        .width(224 * this.breathScale)
        .height(224 * this.breathScale)
        .fill(Color.Transparent)
        .stroke(this.accentTeal)
        .strokeWidth(2)
      ForEach([0, 1, 2, 3, 4, 5, 6, 7], (item: number) => {
        Stack() {
          Rect()
            .width(140 * this.breathScale)
            .height(2)
            .fill('#6600897B')
            .offset({ x: 70 * this.breathScale })
          Circle()
            .width(6)
            .height(6)
            .fill(this.accentTeal)
            .offset({ x: 135 * this.breathScale })
        }
        .width(280)
        .height(280)
        .rotate({ angle: item * 45 + this.rotation })
      }, (item: number) => item.toString())
    }
    .width(280)
    .height(280)
  }

  @Builder
  PatternSelection() {
    Column() {
      Text('Select Rhythm')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textDark)
        .width('100%')
        .margin({ bottom: 16 })
      Row() {
        ForEach(this.patterns, (pattern: BreathingPattern, index?: number) => {
          this.PatternCard(pattern, index === undefined ? 0 : index)
        }, (pattern: BreathingPattern) => pattern.name)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  PatternCard(pattern: BreathingPattern, index: number) {
    Button() {
      Stack() {
        Column() {
          if (index === this.selectedPatternIndex) {
            Text('✓')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.accentTeal)
          }
          Text(pattern.name)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(index === this.selectedPatternIndex ? this.accentTeal : this.textDark)
          if (index !== this.selectedPatternIndex) {
            Text(' ')
              .fontSize(16)
          }
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }
      .width(100)
      .height(90)
    }
    .width(100)
    .height(90)
    .borderRadius(20)
    .backgroundColor(index === this.selectedPatternIndex ? '#0D00897B' : this.lightGray)
    .border({ width: index === this.selectedPatternIndex ? 2 : 0, color: this.accentTeal })
    .onClick(() => {
      this.selectedPatternIndex = index
      this.stopBreathing()
    })
  }

  @Builder
  ControlButton() {
    Button() {
      Row() {
        Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .letterSpacing(1)
        if (!this.isPlaying) {
          Text('▶')
            .fontSize(20)
            .fontColor(Color.White)
            .margin({ left: 8 })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .height(64)
    .width('100%')
    .borderRadius(32)
    .backgroundColor(this.textDark)
    .margin({ left: 32, right: 32, bottom: 32 })
    .onClick(() => {
      this.toggleBreathing()
    })
  }
}