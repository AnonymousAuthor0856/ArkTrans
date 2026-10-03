// Translated from SwiftUI (Swift) to ArkTS (ArkUI)
// Source: ZenBreatherApp

@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    MainScreen()
  }
}

// MARK: - Models
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

  totalDuration(): number {
    return this.inhale + this.exhale
  }
}

// MARK: - Main Screen
@Component
struct MainScreen {
  @State selectedPatternIndex: number = 0
  @State isPlaying: boolean = false
  @State scale: number = 0.8
  @State rotation: number = 0

  patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ]

  currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex]
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Blank().height(48)

        Row() {
          Text('ZenBreather')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2D2D2D')
          Blank()
          Text('⚙')
            .fontSize(24)
            .fontColor('#808080')
        }
        .width('100%')
        .padding({ left: 24, right: 24 })

        Blank().height(60)

        Stack() {
          BreathVisualizer({ scale: this.scale, rotation: this.rotation })
            .width(280)
            .height(280)

          Column() {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#00897B')

            Text(this.currentPattern().inhale.toString() + 's In / ' + this.currentPattern().exhale.toString() + 's Out')
              .fontSize(14)
              .fontColor('#808080')
          }
        }

        Blank()

        Column({ space: 16 }) {
          Text('Select Rhythm')
            .fontSize(16)
            .fontWeight(FontWeight.Semibold)
            .fontColor('#2D2D2D')

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
              }
            }, (pattern: BreathingPattern) => pattern.id)
          }
          .width('100%')
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 24, right: 24 })

        Blank().height(32)

        Button() {
          Row({ space: 8 }) {
            Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
              .fontColor('#FFFFFF')

            if (!this.isPlaying) {
              Text('▶')
                .fontSize(20)
                .fontColor('#FFFFFF')
            }
          }
          .width('100%')
          .height(64)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .backgroundColor('#2D2D2D')
          .borderRadius(32)
        }
        .onClick(() => { this.toggleBreathing() })
        .width('100%')
        .margin({ left: 32, right: 32, bottom: 32 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  toggleBreathing() {
    if (this.isPlaying) {
      this.stopBreathing()
    } else {
      this.startBreathing()
    }
  }

  startBreathing() {
    this.isPlaying = true
    animateTo({ duration: this.currentPattern().inhale * 1000, curve: Curve.EaseInOut, iterations: -1, playMode: PlayMode.Alternate }, () => {
      this.scale = 1.2
    })
    animateTo({ duration: 20000, curve: Curve.Linear, iterations: -1 }, () => {
      this.rotation = 360
    })
  }

  stopBreathing() {
    this.isPlaying = false
    animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
      this.scale = 0.8
      this.rotation = 0
    })
  }
}

// MARK: - Components

@Component
struct BreathVisualizer {
  scale: number = 1
  rotation: number = 0

  build() {
    Stack() {
      Circle()
        .fill('#00897B')
        .opacity(0.1)
        .width('100%')
        .height('100%')
        .scale({ x: this.scale, y: this.scale })

      Circle()
        .fill('#00000000')
        .width('100%')
        .height('100%')
        .border({ width: 2, color: '#00897B' })
        .scale({ x: this.scale, y: this.scale })

      ForEach([0, 1, 2, 3, 4, 5, 6, 7], (i: number) => {
        Stack() {
          Column()
            .width(140)
            .height(2)
            .backgroundColor('#00897B')
            .opacity(0.4)
            .offset({ x: 70 })

          Circle()
            .fill('#00897B')
            .width(6)
            .height(6)
            .offset({ x: 135 })
        }
        .rotate({ angle: i * 45 })
        .scale({ x: this.scale, y: this.scale })
      }, (i: number) => i.toString())
    }
    .rotate({ angle: this.rotation })
  }
}

@Component
struct PatternCard {
  pattern: BreathingPattern = new BreathingPattern('', 0, 0)
  isSelected: boolean = false
  onClick: () => void = () => {}

  build() {
    Button() {
      Stack() {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(this.isSelected ? '#0D00897B' : '#F5F5F5')
          .borderRadius(20)
          .border({ width: 2, color: this.isSelected ? '#00897B' : '#00000000' })

        Column({ space: 4 }) {
          if (this.isSelected) {
            Text('✓')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#00897B')
          }

          Text(this.pattern.name)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isSelected ? '#00897B' : '#2D2D2D')

          if (!this.isSelected) {
            Text(' ')
              .fontSize(16)
          }
        }
      }
      .width(100)
      .height(90)
    }
    .onClick(() => { this.onClick() })
  }
}
