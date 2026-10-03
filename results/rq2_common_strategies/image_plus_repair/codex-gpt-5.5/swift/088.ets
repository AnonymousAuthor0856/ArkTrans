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

class ZenTheme {
  static readonly pureWhite: string = '#FFFFFF'
  static readonly textDark: string = '#2D2D2D'
  static readonly accentTeal: string = '#00897B'
  static readonly accentTealSoft: string = '#1A00897B'
  static readonly accentTealLine: string = '#6600897B'
  static readonly lightGray: string = '#F5F5F5'
  static readonly textGray: string = '#8E8E93'
  static readonly clear: string = '#00000000'
}

@Entry
@Component
struct MainScreen {
  @State private selectedPatternIndex: number = 0
  @State private isPlaying: boolean = false
  @State private scaleValue: number = 0.8
  @State private rotationValue: number = 0

  private patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ]
  private timerId: number = -1
  private startedAt: number = 0

  private currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex]
  }

  private easeInOut(progress: number): number {
    return 0.5 - Math.cos(progress * Math.PI) / 2
  }

  private toggleBreathing(): void {
    if (this.isPlaying) {
      this.stopBreathing()
    } else {
      this.startBreathing()
    }
  }

  private startBreathing(): void {
    this.stopTimer()
    this.isPlaying = true
    this.startedAt = Date.now()
    this.timerId = setInterval(() => {
      const current: BreathingPattern = this.currentPattern()
      const elapsedSeconds: number = (Date.now() - this.startedAt) / 1000
      const cycleSeconds: number = current.totalDuration()
      const cyclePosition: number = elapsedSeconds % cycleSeconds

      if (cyclePosition <= current.inhale) {
        const progress: number = this.easeInOut(cyclePosition / current.inhale)
        this.scaleValue = 0.8 + progress * 0.4
      } else {
        const progress: number = this.easeInOut((cyclePosition - current.inhale) / current.exhale)
        this.scaleValue = 1.2 - progress * 0.4
      }

      this.rotationValue = (elapsedSeconds / 20 * 360) % 360
    }, 50)
  }

  private stopBreathing(): void {
    this.isPlaying = false
    this.stopTimer()
    animateTo({ duration: 250, curve: Curve.EaseOut }, () => {
      this.scaleValue = 0.8
      this.rotationValue = 0
    })
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
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Blank()
          .height(48)

        Row() {
          Text('ZenBreather')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(ZenTheme.textDark)

          Blank()

          Text('\u2699')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(ZenTheme.textGray)
        }
        .width('100%')
        .height(48)
        .padding({ left: 24, right: 24 })

        Blank()
          .height(60)

        Stack({ alignContent: Alignment.Center }) {
          BreathVisualizer({
            scaleValue: this.scaleValue,
            rotationValue: this.rotationValue
          })

          Column() {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(ZenTheme.accentTeal)

            Text(`${this.currentPattern().inhale}s In / ${this.currentPattern().exhale}s Out`)
              .fontSize(14)
              .fontColor(ZenTheme.textGray)
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(280)
        .height(280)

        Blank()

        Column({ space: 16 }) {
          Text('Select Rhythm')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(ZenTheme.textDark)

          Row() {
            ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
              PatternCard({
                pattern: pattern,
                isSelected: index === this.selectedPatternIndex,
                cardClick: () => {
                  this.selectedPatternIndex = index
                  this.stopBreathing()
                }
              })
            }, (pattern: BreathingPattern) => pattern.name)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 24, right: 24 })

        Blank()
          .height(32)

        Row({ space: 8 }) {
          Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(ZenTheme.pureWhite)
            .letterSpacing(1)

          if (!this.isPlaying) {
            Text('\u25B6')
              .fontSize(24)
              .fontColor(ZenTheme.pureWhite)
              .padding({ left: 4 })
          }
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(ZenTheme.textDark)
        .borderRadius(32)
        .onClick(() => {
          this.toggleBreathing()
        })
        .margin({ left: 32, right: 32 })

        Blank()
          .height(32)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ZenTheme.pureWhite)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ZenTheme.pureWhite)
  }
}

@Component
struct BreathVisualizer {
  @Prop scaleValue: number = 0.8
  @Prop rotationValue: number = 0

  private spokes: number[] = [0, 1, 2, 3, 4, 5, 6, 7]

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(280)
        .height(280)
        .fill(ZenTheme.accentTealSoft)
        .scale({ x: this.scaleValue, y: this.scaleValue })

      Circle()
        .width(280)
        .height(280)
        .fill(ZenTheme.clear)
        .stroke(ZenTheme.accentTeal)
        .strokeWidth(2)
        .scale({ x: this.scaleValue, y: this.scaleValue })

      ForEach(this.spokes, (spoke: number) => {
        Divider()
          .width(140)
          .height(2)
          .backgroundColor(ZenTheme.accentTealLine)
          .offset({ x: 70, y: 0 })
          .rotate({ angle: spoke * 45 })
          .scale({ x: this.scaleValue, y: this.scaleValue })

        Circle()
          .width(6)
          .height(6)
          .fill(ZenTheme.accentTeal)
          .offset({ x: 135, y: 0 })
          .rotate({ angle: spoke * 45 })
          .scale({ x: this.scaleValue, y: this.scaleValue })
      }, (spoke: number) => spoke.toString())
    }
    .width(280)
    .height(280)
    .rotate({ angle: this.rotationValue })
  }
}

@Component
struct PatternCard {
  pattern: BreathingPattern = new BreathingPattern('', 0, 0)
  isSelected: boolean = false
  cardClick: () => void = () => {
  }

  build() {
    Column({ space: 4 }) {
      if (this.isSelected) {
        Text('\u2713')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(ZenTheme.accentTeal)
          .height(28)
      } else {
        Blank()
          .height(28)
      }

      Text(this.pattern.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isSelected ? ZenTheme.accentTeal : ZenTheme.textDark)
    }
    .width(100)
    .height(90)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.isSelected ? '#0D00897B' : ZenTheme.lightGray)
    .borderRadius(20)
    .border({
      width: this.isSelected ? 2 : 0,
      color: this.isSelected ? ZenTheme.accentTeal : ZenTheme.clear
    })
    .onClick(() => {
      this.cardClick()
    })
  }
}
