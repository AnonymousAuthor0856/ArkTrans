import { webview } from '@kit.ArkWeb'

@Entry
@Component
struct ZenBreatherApp {
  @State selectedPatternIndex: number = 0
  @State isPlaying: boolean = false
  @State scaleValue: number = 0.8
  @State rotation: number = 0.0
  private timerId: number = -1

  // Theme Colors
  private readonly pureWhite: string = '#FFFFFF'
  private readonly textDark: string = '#2D2D2D'
  private readonly accentTeal: string = '#00897B'
  private readonly lightGray: string = '#F5F5F5'
  private readonly textGray: string = '#9E9E9E'

  // Data Models
  patterns: BreathingPattern[] = [
    { name: "Relax", inhale: 4, exhale: 6 },
    { name: "Balance", inhale: 5, exhale: 5 },
    { name: "Focus", inhale: 4, exhale: 4 }
  ]

  get currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex]
  }

  aboutToAppear() {
    // Initialize animation loop if needed, though we use ArkUI animations primarily
  }

  build() {
    Column() {
      // Header
      Row() {
        Text("ZenBreather")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textDark)
        Blank()
        Image($r('app.media.ic_settings')) // Placeholder for gear icon
          .width(24)
          .height(24)
          .fillColor(this.textGray)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .margin({ top: 48 })

      Column().height(60)

      // Visualizer Area
      Stack() {
        BreathVisualizer({
          scaleValue: this.scaleValue,
          rotation: this.rotation,
          color: this.accentTeal
        }).width(280).height(280)

        Column() {
          Text(this.isPlaying ? "Breathe" : "Ready")
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.accentTeal)
          
          Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`)
            .fontSize(14)
            .fontColor(this.textGray)
            .margin({ top: 4 })
        }
      }

      Column()

      // Pattern Selection
      Column({ space: 16 }) {
        Text("Select Rhythm")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.textDark)
          .alignSelf(ItemAlign.Start)

        Row({ space: 12 }) {
          ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
            PatternCard({
              pattern: pattern,
              isSelected: index === this.selectedPatternIndex,
              onClick: () => {
                this.selectedPatternIndex = index
                this.stopBreathing()
              },
              accentColor: this.accentTeal,
              grayColor: this.lightGray,
              darkColor: this.textDark
            })
          })
        }
      }
      .width('100%')
      .padding({ left: 24, right: 24 })

      Column().height(32)

      // Control Button
      Button() {
        Row() {
          Text(this.isPlaying ? "STOP SESSION" : "START BREATHING")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
            .fontColor('#FFFFFF')
          
          if (!this.isPlaying) {
            Image($r('app.media.ic_play')) // Placeholder for play icon
              .width(20)
              .height(20)
              .fillColor('#FFFFFF')
              .margin({ left: 8 })
          }
        }
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(64)
      .backgroundColor(this.textDark)
      .borderRadius(32)
      .onClick(() => {
        this.toggleBreathing()
      })
      .margin({ left: 32, right: 32, bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pureWhite)
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
    
    // Scale Animation (Inhale/Exhale)
    animateTo({
      duration: this.currentPattern.inhale * 1000,
      curve: Curve.EaseInOut,
      iterations: -1, // Repeat forever
      playMode: PlayMode.Alternate
    }, () => {
      this.scaleValue = 1.2
    })

    // Rotation Animation
    animateTo({
      duration: 20000,
      curve: Curve.Linear,
      iterations: -1,
      playMode: PlayMode.Normal
    }, () => {
      this.rotation = 360
    })
  }

  stopBreathing() {
    this.isPlaying = false
    // Reset animations
    animateTo({
      duration: 300,
      curve: Curve.EaseOut
    }, () => {
      this.scaleValue = 0.8
      this.rotation = 0
    })
  }
}

interface BreathingPattern {
  name: string;
  inhale: number;
  exhale: number;
}

// MARK: - Components

@Component
struct BreathVisualizer {
  @Prop scaleValue: number
  @Prop rotation: number
  @Prop color: string

  build() {
    Stack() {
      // Outer faint ring
      Circle()
        .fill(new Color(this.color).withOpacity(0.1))
        .scale({ x: this.scaleValue, y: this.scaleValue })

      // Stroke ring
      Circle()
        .stroke(new Color(this.color), { width: 2 })
        .scale({ x: this.scaleValue, y: this.scaleValue })

      // Petals / Spokes
      ForEach([0, 1, 2, 3, 4, 5, 6, 7], (i: number) => {
        Column() {
          // Line
          Rect()
            .fill(new Color(this.color).withOpacity(0.4))
            .width(140)
            .height(2)
            .offset({ x: 70 }) // Start from center

          // Dot at end
          Circle()
            .fill(new Color(this.color))
            .width(6)
            .height(6)
            .offset({ x: 135 })
        }
        .rotate({ angle: i * 45 })
        .scale({ x: this.scaleValue, y: this.scaleValue })
      })
    }
    .rotate({ angle: this.rotation })
  }
}

@Component
struct PatternCard {
  @Prop pattern: BreathingPattern
  @Prop isSelected: boolean
  @Prop onClick: () => void
  @Prop accentColor: string
  @Prop grayColor: string
  @Prop darkColor: string

  build() {
    Button() {
      Column({ space: 4 }) {
        if (this.isSelected) {
          Image($r('app.media.ic_check')) // Placeholder for checkmark
            .width(16)
            .height(16)
            .fillColor(this.accentColor)
        }

        Text(this.pattern.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isSelected ? this.accentColor : this.darkColor)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(100)
    .height(90)
    .backgroundColor(this.isSelected ? new Color(this.accentColor).withOpacity(0.05) : new Color(this.grayColor))
    .borderRadius(20)
    .border({
      width: this.isSelected ? 2 : 0,
      color: this.isSelected ? this.accentColor : Color.Transparent
    })
    .onClick(() => {
      this.onClick()
    })
  }
}