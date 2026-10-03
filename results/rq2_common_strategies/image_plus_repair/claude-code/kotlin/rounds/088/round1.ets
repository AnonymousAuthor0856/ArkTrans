@Entry
@Component
struct ZenBreatherPage {
  @State selectedPatternIndex: number = 0
  @State isPlaying: boolean = false
  private patterns: BreathingPattern[] = [
    new BreathingPattern("Relax", 4, 6),
    new BreathingPattern("Balance", 5, 5),
    new BreathingPattern("Focus", 4, 4)
  ]

  build() {
    Column() {
      // Header
      Row() {
        Text("ZenBreather")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF2D2D2D')
          .letterSpacing(-1)
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 48, left: 24, right: 24 })

      // Visualizer Section
      Stack({ alignContent: Alignment.Center }) {
        BreathVisualizer({
          isPlaying: $isPlaying,
          durationSum: this.patterns[this.selectedPatternIndex].totalDuration
        })

        Column() {
          Text(this.isPlaying ? "Breathe" : "Ready")
            .fontSize(24)
            .fontColor('#FF00897B')
            .fontWeight(FontWeight.Medium)
          Text(`${this.patterns[this.selectedPatternIndex].inhale}s In / ${this.patterns[this.selectedPatternIndex].exhale}s Out`)
            .fontSize(14)
            .fontColor(Color.Gray)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)
      .margin({ top: 60 })

      // Pattern Selection
      Column() {
        Text("Select Rhythm")
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#FF2D2D2D')
          .width('100%')

        Row() {
          ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
            PatternCard({
              pattern: pattern,
              isSelected: index === this.selectedPatternIndex,
              onClick: () => {
                this.selectedPatternIndex = index
                this.isPlaying = false
              }
            })
          }, (pattern: BreathingPattern) => pattern.name)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 16 })
      }
      .width('100%')
      .margin({ top: 32, left: 24, right: 24 })

      // Play/Pause Button
      Button() {
        Row() {
          Text(this.isPlaying ? "STOP SESSION" : "START BREATHING")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .letterSpacing(1)
          if (!this.isPlaying) {
            Blank()
              .width(8)
            Image($r('sys.media.ohos_ic_public_play'))
              .width(20)
              .height(20)
              .fillColor(Color.White)
          }
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('85%')
      .height(64)
      .backgroundColor('#FF2D2D2D')
      .borderRadius(32)
      .margin({ top: 32, bottom: 32 })
      .onClick(() => {
        this.isPlaying = !this.isPlaying
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.Start)
  }
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
  @Link isPlaying: boolean
  @State scaleVal: number = 1.0
  @State rotateVal: number = 0
  private durationSum: number = 10
  private readonly petalCount: number = 8

  aboutToAppear(): void {
    if (this.isPlaying) {
      this.startAnimations()
    }
  }

  aboutToUpdate(): void {
    if (this.isPlaying && this.scaleVal === 1.0 && this.rotateVal === 0) {
      this.startAnimations()
    }
  }

  startAnimations(): void {
    // Scale animation (inhale/exhale)
    animateTo({
      duration: this.durationSum * 500,
      curve: Curve.FastOutSlowIn,
      iterations: -1,
      playMode: PlayMode.Alternate
    }, () => {
      this.scaleVal = 1.2
    })

    // Rotation animation
    animateTo({
      duration: 20000,
      curve: Curve.Linear,
      iterations: -1,
      playMode: PlayMode.Normal
    }, () => {
      this.rotateVal = 360
    })
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Outer filled circle (light teal background)
      Circle({ width: 224, height: 224 })
        .fill('rgba(0, 137, 123, 0.1)')
        .stroke('#FF00897B')
        .strokeWidth(4)

      // Petals - 8 lines from center with dots at ends
      ForEach(Array.from({ length: this.petalCount }, (_, i) => i), (i: number) => {
        Stack({ alignContent: Alignment.Center }) {
          Line()
            .width(1)
            .height(78.4)
            .startPoint([0.5, 78.4])
            .endPoint([0.5, 0])
            .stroke('rgba(0, 137, 123, 0.4)')
            .strokeWidth(2)
            .margin({ bottom: 0 })

          Circle({ width: 12, height: 12 })
            .fill('#FF00897B')
            .margin({ bottom: 0 })
            .translate({ y: -6 })
        }
        .width(224)
        .height(224)
        .rotate({ angle: i * 45, centerX: '50%', centerY: '50%' })
      }, (i: number) => i.toString())
    }
    .width('100%')
    .height('100%')
    .scale({ x: this.isPlaying ? this.scaleVal : 1.0, y: this.isPlaying ? this.scaleVal : 1.0, centerX: '50%', centerY: '50%' })
    .rotate({ angle: this.isPlaying ? this.rotateVal : 0, centerX: '50%', centerY: '50%' })
    .onClick(() => {})
  }
}

@Component
struct PatternCard {
  pattern: BreathingPattern = new BreathingPattern("", 0, 0)
  isSelected: boolean = false
  onClick: () => void = () => {}

  build() {
    Column() {
      if (this.isSelected) {
        Image($r('sys.media.ohos_ic_public_check'))
          .width(16)
          .height(16)
          .fillColor('#FF00897B')
        Blank()
          .height(4)
      }
      Text(this.pattern.name)
        .fontWeight(FontWeight.Bold)
        .fontSize(14)
        .fontColor(this.isSelected ? '#FF00897B' : '#FF2D2D2D')
      Text(`${this.pattern.inhale}-${this.pattern.exhale}`)
        .fontSize(12)
        .fontColor(Color.Gray)
        .margin({ top: 2 })
    }
    .width(100)
    .height(90)
    .borderRadius(20)
    .backgroundColor(this.isSelected ? 'rgba(0, 137, 123, 0.05)' : '#FFF5F5F5')
    .border({
      width: 2,
      color: this.isSelected ? '#FF00897B' : Color.Transparent
    })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(12)
    .onClick(() => {
      this.onClick()
    })
  }
}
