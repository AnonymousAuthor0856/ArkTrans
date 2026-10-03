class Theme {
  static pureWhite: string = '#FFFFFF'
  static textDark: string = '#2D2D2D'
  static accentTeal: string = '#00897B'
  static accentTeal10: string = 'rgba(0, 137, 123, 0.10)'
  static accentTeal05: string = 'rgba(0, 137, 123, 0.05)'
  static accentTeal40: string = 'rgba(0, 137, 123, 0.40)'
  static lightGray: string = '#F5F5F5'
  static textGray: string = '#8E8E93'
}

class BreathingPattern {
  name: string
  inhale: number
  exhale: number

  constructor(name: string, inhale: number, exhale: number) {
    this.name = name
    this.inhale = inhale
    this.exhale = exhale
  }

  get totalDuration(): number {
    return this.inhale + this.exhale
  }
}

@Component
struct BreathVisualizer {
  scaleValue: number = 0.8
  rotationValue: number = 0

  private spokeAngles: number[] = [0, 45, 90, 135, 180, 225, 270, 315]

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle({ width: 280, height: 280 })
        .fill(Theme.accentTeal10)
        .stroke(Theme.accentTeal)
        .strokeWidth(2)

      ForEach(this.spokeAngles, (angle: number) => {
        Stack({ alignContent: Alignment.Center }) {
          Rect({ width: 140, height: 2 })
            .fill(Theme.accentTeal40)
            .translate({ x: 70, y: 0 })

          Circle({ width: 6, height: 6 })
            .fill(Theme.accentTeal)
            .translate({ x: 135, y: 0 })
        }
        .width(280)
        .height(280)
        .rotate({ angle: angle })
      }, (angle: number) => angle.toString())
    }
    .width(280)
    .height(280)
    .scale({ x: this.scaleValue, y: this.scaleValue })
    .rotate({ angle: this.rotationValue })
  }
}

@Component
struct PatternCard {
  name: string = ''
  isSelected: boolean = false
  onClickAction: () => void = () => {
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column({ space: 4 }) {
        if (this.isSelected) {
          Text('✓')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Theme.accentTeal)
            .lineHeight(28)
        }

        Text(this.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isSelected ? Theme.accentTeal : Theme.textDark)

        if (!this.isSelected) {
          Text(' ')
            .fontSize(16)
            .lineHeight(16)
        }
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(100)
    .height(90)
    .backgroundColor(this.isSelected ? Theme.accentTeal05 : Theme.lightGray)
    .borderRadius(20)
    .border({
      width: this.isSelected ? 2 : 0,
      color: this.isSelected ? Theme.accentTeal : Color.Transparent
    })
    .onClick(() => {
      this.onClickAction()
    })
  }
}

@Entry
@Component
struct Index {
  @State private selectedPatternIndex: number = 0
  @State private isPlaying: boolean = false
  @State private scaleValue: number = 0.8
  @State private rotationValue: number = 0

  private patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ]

  get currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex]
  }

  private selectPattern(index: number): void {
    this.selectedPatternIndex = index
    this.stopBreathing()
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

    animateTo({
      duration: this.currentPattern.inhale * 1000,
      curve: Curve.EaseInOut,
      iterations: -1,
      playMode: PlayMode.Alternate
    }, () => {
      this.scaleValue = 1.2
    })

    animateTo({
      duration: 20000,
      curve: Curve.Linear,
      iterations: -1,
      playMode: PlayMode.Normal
    }, () => {
      this.rotationValue = 360
    })
  }

  private stopBreathing(): void {
    this.isPlaying = false

    animateTo({
      duration: 300,
      curve: Curve.EaseInOut
    }, () => {
      this.scaleValue = 0.8
      this.rotationValue = 0
    })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        Blank()
          .height(48)

        Row() {
          Text('ZenBreather')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Theme.textDark)

          Blank()

          Text('⚙')
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor(Theme.textGray)
        }
        .width('100%')
        .height(40)
        .padding({ left: 24, right: 24 })

        Blank()
          .height(60)

        Stack({ alignContent: Alignment.Center }) {
          BreathVisualizer({
            scaleValue: this.scaleValue,
            rotationValue: this.rotationValue
          })

          Column({ space: 2 }) {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(Theme.accentTeal)

            Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`)
              .fontSize(14)
              .fontColor(Theme.textGray)
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(280)
        .height(280)

        Blank()
          .layoutWeight(1)

        Column({ space: 16 }) {
          Text('Select Rhythm')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Theme.textDark)

          Row() {
            PatternCard({
              name: this.patterns[0].name,
              isSelected: this.selectedPatternIndex === 0,
              onClickAction: () => {
                this.selectPattern(0)
              }
            })

            PatternCard({
              name: this.patterns[1].name,
              isSelected: this.selectedPatternIndex === 1,
              onClickAction: () => {
                this.selectPattern(1)
              }
            })

            PatternCard({
              name: this.patterns[2].name,
              isSelected: this.selectedPatternIndex === 2,
              onClickAction: () => {
                this.selectPattern(2)
              }
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 24, right: 24 })

        Blank()
          .height(32)

        Column() {
          Row({ space: 8 }) {
            Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .letterSpacing(1)

            if (!this.isPlaying) {
              Text('▶')
                .fontSize(26)
                .fontColor(Color.White)
            }
          }
          .width('100%')
          .height(64)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(Theme.textDark)
          .borderRadius(32)
          .onClick(() => {
            this.toggleBreathing()
          })
        }
        .width('100%')
        .padding({ left: 32, right: 32, bottom: 32 })
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Theme.pureWhite)
  }
}