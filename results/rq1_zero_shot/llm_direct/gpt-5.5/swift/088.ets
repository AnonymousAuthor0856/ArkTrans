class Theme {
  static readonly pureWhite: string = '#FFFFFF'
  static readonly textDark: string = '#2D2D2D'
  static readonly accentTeal: string = '#00897B'
  static readonly accentTeal10: string = 'rgba(0, 137, 123, 0.10)'
  static readonly accentTeal05: string = 'rgba(0, 137, 123, 0.05)'
  static readonly accentTeal40: string = 'rgba(0, 137, 123, 0.40)'
  static readonly lightGray: string = '#F5F5F5'
  static readonly textGray: string = '#808080'
}

class BreathingPattern {
  id: string
  name: string
  inhale: number
  exhale: number

  constructor(name: string, inhale: number, exhale: number) {
    this.id = name
    this.name = name
    this.inhale = inhale
    this.exhale = exhale
  }

  get totalDuration(): number {
    return this.inhale + this.exhale
  }
}

@Entry
@Component
struct MainScreen {
  @State private selectedPatternIndex: number = 0
  @State private isPlaying: boolean = false
  @State private scaleValue: number = 0.8
  @State private rotation: number = 0

  private timerId: number = -1
  private startTime: number = 0

  private patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ]

  get currentPattern(): BreathingPattern {
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
    this.clearTimer()
    this.isPlaying = true
    this.startTime = Date.now()

    this.timerId = setInterval(() => {
      this.updateBreathingAnimation()
    }, 50)

    this.updateBreathingAnimation()
  }

  private stopBreathing(): void {
    this.isPlaying = false
    this.clearTimer()

    animateTo({
      duration: 300,
      curve: Curve.EaseInOut
    }, () => {
      this.scaleValue = 0.8
      this.rotation = 0
    })
  }

  private clearTimer(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
      this.timerId = -1
    }
  }

  private updateBreathingAnimation(): void {
    if (!this.isPlaying) {
      return
    }

    const now: number = Date.now()
    const elapsed: number = now - this.startTime

    const inhaleMs: number = this.currentPattern.inhale * 1000
    const exhaleMs: number = this.currentPattern.exhale * 1000
    const cycleMs: number = inhaleMs + exhaleMs
    const phase: number = elapsed % cycleMs

    let nextScale: number = 0.8

    if (phase < inhaleMs) {
      const t: number = phase / inhaleMs
      const smooth: number = 0.5 - 0.5 * Math.cos(Math.PI * t)
      nextScale = 0.8 + 0.4 * smooth
    } else {
      const t: number = (phase - inhaleMs) / exhaleMs
      const smooth: number = 0.5 - 0.5 * Math.cos(Math.PI * t)
      nextScale = 1.2 - 0.4 * smooth
    }

    this.scaleValue = nextScale
    this.rotation = elapsed / 20000 * 360
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
            .fontColor(Theme.textDark)

          Blank()
            .layoutWeight(1)

          Text('⚙')
            .fontSize(24)
            .fontColor(Theme.textGray)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })

        Blank()
          .height(60)

        Stack() {
          BreathVisualizer({
            scaleValue: this.scaleValue,
            rotation: this.rotation
          })
            .width(280)
            .height(280)

          Column() {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(Theme.accentTeal)

            Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`)
              .fontSize(14)
              .fontColor(Theme.textGray)
          }
        }
        .width(280)
        .height(280)

        Blank()
          .layoutWeight(1)

        Column({ space: 16 }) {
          Text('Select Rhythm')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Theme.textDark)

          Row() {
            ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
              PatternCard({
                pattern: pattern,
                isSelected: index === this.selectedPatternIndex,
                onClick: () => {
                  this.selectedPatternIndex = index
                  this.stopBreathing()
                }
              })

              if (index < this.patterns.length - 1) {
                Blank()
                  .layoutWeight(1)
              }
            }, (pattern: BreathingPattern) => pattern.id)
          }
          .width('100%')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 24, right: 24 })

        Blank()
          .height(32)

        Button({ type: ButtonType.Normal }) {
          Row({ space: 8 }) {
            Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .letterSpacing(1)

            if (!this.isPlaying) {
              Text('▶')
                .fontSize(20)
                .fontColor(Color.White)
            }
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')
          .height(64)
        }
        .width('100%')
        .height(64)
        .backgroundColor(Theme.textDark)
        .borderRadius(32)
        .padding(0)
        .onClick(() => {
          this.toggleBreathing()
        })
        .margin({ left: 32, right: 32, bottom: 32 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Theme.pureWhite)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Theme.pureWhite)
    .onDisAppear(() => {
      this.clearTimer()
    })
  }
}

@Component
struct BreathVisualizer {
  @Prop scaleValue: number
  @Prop rotation: number

  private spokes: number[] = [0, 1, 2, 3, 4, 5, 6, 7]

  build() {
    Stack() {
      Circle()
        .width(280)
        .height(280)
        .fill(Theme.accentTeal10)
        .scale({ x: this.scaleValue, y: this.scaleValue })

      Circle()
        .width(280)
        .height(280)
        .fill(Color.Transparent)
        .stroke(Theme.accentTeal)
        .strokeWidth(2)
        .scale({ x: this.scaleValue, y: this.scaleValue })

      ForEach(this.spokes, (item: number) => {
        Rect()
          .width(140)
          .height(2)
          .fill(Theme.accentTeal40)
          .offset({ x: 70 })
          .rotate({ angle: item * 45 })
          .scale({ x: this.scaleValue, y: this.scaleValue })

        Circle()
          .width(6)
          .height(6)
          .fill(Theme.accentTeal)
          .offset({ x: 135 })
          .rotate({ angle: item * 45 })
          .scale({ x: this.scaleValue, y: this.scaleValue })
      }, (item: number) => item.toString())
    }
    .width(280)
    .height(280)
    .rotate({ angle: this.rotation })
  }
}

@Component
struct PatternCard {
  @Prop pattern: BreathingPattern
  @Prop isSelected: boolean

  onClick: () => void = () => {
  }

  build() {
    Button({ type: ButtonType.Normal }) {
      Stack() {
        Column()
          .width(100)
          .height(90)
          .backgroundColor(this.isSelected ? Theme.accentTeal05 : Theme.lightGray)
          .borderRadius(20)
          .border({
            width: this.isSelected ? 2 : 0,
            color: this.isSelected ? Theme.accentTeal : Color.Transparent
          })

        Column({ space: 4 }) {
          if (this.isSelected) {
            Text('✓')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Theme.accentTeal)
          }

          Text(this.pattern.name)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isSelected ? Theme.accentTeal : Theme.textDark)

          if (!this.isSelected) {
            Text(' ')
              .fontSize(16)
          }
        }
        .justifyContent(FlexAlign.Center)
      }
      .width(100)
      .height(90)
    }
    .width(100)
    .height(90)
    .backgroundColor(Color.Transparent)
    .borderRadius(20)
    .padding(0)
    .stateEffect(false)
    .onClick(() => {
      this.onClick()
    })
  }
}