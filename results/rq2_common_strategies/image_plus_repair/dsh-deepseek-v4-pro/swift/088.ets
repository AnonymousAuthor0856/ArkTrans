// Translated from SwiftUI (088.swift) to ArkTS (HarmonyOS ArkUI)

@Entry
@Component
struct ZenBreatherApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ContentView {
  build() {
    // .preferredColorScheme(.light) and .statusBarHidden(true) are SwiftUI
    // window-level preferences; HarmonyOS handles these through system settings.
    Column() {
      MainScreen()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Constants & Theme
class AppTheme {
  static readonly pureWhite: ResourceColor = Color.White
  static readonly textDark: ResourceColor = '#2D2D2D' // #2D2D2D
  static readonly accentTeal: ResourceColor = '#00897B' // #00897B
  static readonly lightGray: ResourceColor = '#F5F5F5' // #F5F5F5
  static readonly textGray: ResourceColor = Color.Gray
}

class BreathingPattern {
  static nextId: number = 0
  id: string = ''
  name: string = ''
  inhale: number = 0
  exhale: number = 0

  constructor(name: string, inhale: number, exhale: number) {
    this.id = 'pattern-' + BreathingPattern.nextId
    BreathingPattern.nextId++
    this.name = name
    this.inhale = inhale
    this.exhale = exhale
  }

  get totalDuration(): number {
    return this.inhale + this.exhale
  }
}

// MARK: - Main Screen
@Component
struct MainScreen {
  @State selectedPatternIndex: number = 0
  @State isPlaying: boolean = false
  @State scaleValue: number = 0.8
  @State rotation: number = 0.0
  @State timerId: number = -1

  patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ]

  currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex]
  }

  aboutToAppear(): void {
    // Animation timer (replaces Timer.publish(every: 0.05).autoconnect())
    this.timerId = setInterval(() => {
      if (this.isPlaying) {
        animateTo({
          duration: this.currentPattern().totalDuration * 1000,
          curve: Curve.EaseInOut
        }, () => {
          // Simple continuous rotation simulation
          this.rotation += 1

          // Simulating breath cycle for scale (0.8 to 1.2) roughly based on timer tick
          // Note: In production, use exact time-based interpolation.
          // Here we rely on ArkUI animation system triggered by state changes if we used .repeatForever,
          // but manual state update gives more control to stop instantly.
          // For simplicity in this single-file layout migration:
        })
      }
    }, 50)
  }

  aboutToDisappear(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
      this.timerId = -1
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        Blank()
          .height(48)

        // Header
        Row() {
          Text('ZenBreather')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTheme.textDark)
          Blank()
          Image($r('sys.symbol.gearshape_fill'))
            .width(24)
            .height(24)
            .fillColor(AppTheme.textGray)
        }
        .width('100%')
        .margin({ left: 24, right: 24 })

        Blank()
          .height(60)

        // Visualizer
        Stack() {
          BreathVisualizer({ scaleValue: this.scaleValue, rotation: this.rotation })
            .width(280)
            .height(280)

          Column({ space: 0 }) {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTheme.accentTeal)

            Text(`${this.currentPattern().inhale}s In / ${this.currentPattern().exhale}s Out`)
              .fontSize(14)
              .fontColor(AppTheme.textGray)
          }
        }

        Blank()

        // Pattern Selection
        Column({ space: 16 }) {
          Text('Select Rhythm')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTheme.textDark)

          Row({ space: 0 }) {
            ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
              PatternCard({
                pattern: pattern,
                isSelected: index === this.selectedPatternIndex,
                onSelect: () => {
                  this.selectedPatternIndex = index
                  this.stopBreathing()
                }
              })
            }, (pattern: BreathingPattern) => pattern.id)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 24, right: 24 })

        Blank()
          .height(32)

        // Control Button
        Button() {
          Row({ space: 8 }) {
            Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
              .fontColor(Color.White)

            if (!this.isPlaying) {
              Image($r('sys.symbol.play_fill'))
                .width(20)
                .height(20)
                .fillColor(Color.White)
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .type(ButtonType.Normal)
        .width('100%')
        .height(64)
        .backgroundColor(AppTheme.textDark)
        .borderRadius(32)
        .onClick(() => {
          this.toggleBreathing()
        })
        .margin({ left: 32, right: 32, bottom: 32 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.pureWhite)
  }

  toggleBreathing(): void {
    if (this.isPlaying) {
      this.stopBreathing()
    } else {
      this.startBreathing()
    }
  }

  startBreathing(): void {
    this.isPlaying = true
    animateTo({
      duration: this.currentPattern().inhale * 1000,
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
      this.rotation = 360
    })
  }

  stopBreathing(): void {
    this.isPlaying = false
    animateTo({
      duration: 350,
      curve: Curve.Ease
    }, () => {
      this.scaleValue = 0.8
      this.rotation = 0
    })
  }
}

// MARK: - Components

@Component
struct BreathVisualizer {
  @Prop scaleValue: number = 0.8
  @Prop rotation: number = 0.0
  spokeIndices: number[] = [0, 1, 2, 3, 4, 5, 6, 7]

  build() {
    Stack() {
      // Outer faint ring
      Circle()
        .width('100%')
        .height('100%')
        .fill(AppTheme.accentTeal)
        .opacity(0.1)
        .scale({ x: this.scaleValue, y: this.scaleValue })

      // Stroke ring
      Circle()
        .width('100%')
        .height('100%')
        .fillOpacity(0)
        .stroke(AppTheme.accentTeal)
        .strokeWidth(2) // Thin stroke as per design
        .scale({ x: this.scaleValue, y: this.scaleValue })

      // Petals / Spokes
      ForEach(this.spokeIndices, (i: number) => {
        Rect()
          .width(140)
          .height(2) // Length matches radius roughly
          .fill(AppTheme.accentTeal)
          .opacity(0.4)
          .offset({ x: 70, y: 0 }) // Offset to start from center
          .rotate({ angle: i * 45 })
          .scale({ x: this.scaleValue, y: this.scaleValue })
      }, (i: number) => 'spoke-' + i)

      // Dots at ends
      ForEach(this.spokeIndices, (i: number) => {
        Circle()
          .width(6)
          .height(6)
          .fill(AppTheme.accentTeal)
          .offset({ x: 135, y: 0 }) // Position at end of spoke
          .rotate({ angle: i * 45 })
          .scale({ x: this.scaleValue, y: this.scaleValue })
      }, (i: number) => 'dot-' + i)
    }
    .width('100%')
    .height('100%')
    .rotate({ angle: this.rotation })
  }
}

@Component
struct PatternCard {
  pattern: BreathingPattern = new BreathingPattern('', 0, 0)
  @Prop isSelected: boolean = false
  onSelect: () => void = () => {}

  build() {
    Button() {
      Stack() {
        // Background fill (5% teal when selected, light gray otherwise)
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(this.isSelected ? AppTheme.accentTeal : AppTheme.lightGray)
          .opacity(this.isSelected ? 0.05 : 1)
          .borderRadius(20)

        // Border stroke
        Column()
          .width('100%')
          .height('100%')
          .border({
            width: 2,
            color: this.isSelected ? AppTheme.accentTeal : Color.Transparent,
            radius: 20
          })

        // Content
        Column({ space: 4 }) {
          if (this.isSelected) {
            Image($r('sys.symbol.checkmark'))
              .width(16)
              .height(16)
              .fillColor(AppTheme.accentTeal)
          }

          Text(this.pattern.name)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isSelected ? AppTheme.accentTeal : AppTheme.textDark)

          // Show details only if not selected (or based on design preference, here keeping
          // consistent with image which shows just name when selected sometimes, but text
          // underneath always useful)
          // The Android code hides checkmark if not selected, shows name/details always.
          // Image shows "Ready" state has checkmark on first item.
          if (!this.isSelected) {
            Text(' ') // Placeholder to keep height consistent if needed
              .fontSize(16)
          }
        }
      }
      .width(100)
      .height(90)
    }
    .type(ButtonType.Normal)
    .onClick(() => {
      this.onSelect()
    })
  }
}
