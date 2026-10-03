const PURE_WHITE: string = '#FFFFFF'
const TEXT_DARK: string = '#2D2D2D'
const ACCENT_TEAL: string = '#00897B'
const LIGHT_GRAY: string = '#F5F5F5'
const MUTED_GRAY: string = '#888888'
const SELECTED_BG: string = '#F2FBFA'

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

  private currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex]
  }

  build() {
    Column() {
      Blank()
        .height(48)

      Row() {
        Text('ZenBreather')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_DARK)
          .letterSpacing(-1)

        Text('⚙')
          .fontSize(32)
          .fontColor(MUTED_GRAY)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(60)

      Stack({ alignContent: Alignment.Center }) {
        BreathVisualizer({
          isPlaying: this.isPlaying,
          durationSum: this.currentPattern().totalDuration
        })

        Column() {
          Text(this.isPlaying ? 'Breathe' : 'Ready')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(ACCENT_TEAL)

          Text(`${this.currentPattern().inhale}s In / ${this.currentPattern().exhale}s Out`)
            .fontSize(14)
            .fontColor(MUTED_GRAY)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)

      Blank()
        .layoutWeight(1)

      Text('Select Rhythm')
        .width('100%')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT_DARK)

      Blank()
        .height(16)

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
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(32)

      PlayPauseButton({
        isPlaying: this.isPlaying,
        onClick: () => {
          this.isPlaying = !this.isPlaying
        }
      })
      .margin({ left: 16, right: 16 })

      Blank()
        .height(32)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .backgroundColor(PURE_WHITE)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct BreathVisualizer {
  @Prop @Watch('onAnimationInputChanged') isPlaying: boolean = false
  @Prop @Watch('onAnimationInputChanged') durationSum: number = 10

  @State private scaleValue: number = 1
  @State private rotationValue: number = 0

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private breathTimer: number = -1
  private rotationTimer: number = -1
  private breathExpanded: boolean = false

  aboutToAppear(): void {
    if (this.isPlaying) {
      this.startAnimation()
    }
  }

  aboutToDisappear(): void {
    this.clearTimers()
  }

  private onAnimationInputChanged(): void {
    if (this.isPlaying) {
      this.startAnimation()
    } else {
      this.stopAnimation()
    }
  }

  private clearTimers(): void {
    if (this.breathTimer !== -1) {
      clearInterval(this.breathTimer)
      this.breathTimer = -1
    }

    if (this.rotationTimer !== -1) {
      clearInterval(this.rotationTimer)
      this.rotationTimer = -1
    }
  }

  private startAnimation(): void {
    this.clearTimers()
    this.scaleValue = 0.8
    this.rotationValue = 0
    this.breathExpanded = true

    animateTo({
      duration: this.durationSum * 1000,
      curve: Curve.FastOutSlowIn
    }, () => {
      this.scaleValue = 1.2
    })

    this.breathTimer = setInterval(() => {
      this.animateBreathStep()
    }, this.durationSum * 1000)

    this.rotationTimer = setInterval(() => {
      animateTo({
        duration: 1000,
        curve: Curve.Linear
      }, () => {
        this.rotationValue += 18
      })
    }, 1000)
  }

  private animateBreathStep(): void {
    this.breathExpanded = !this.breathExpanded
    animateTo({
      duration: this.durationSum * 1000,
      curve: Curve.FastOutSlowIn
    }, () => {
      this.scaleValue = this.breathExpanded ? 1.2 : 0.8
    })
  }

  private stopAnimation(): void {
    this.clearTimers()
    animateTo({
      duration: 200,
      curve: Curve.EaseOut
    }, () => {
      this.scaleValue = 1
      this.rotationValue = 0
    })
  }

  private drawVisualizer(): void {
    const width: number = 280
    const height: number = 280
    const centerX: number = width / 2
    const centerY: number = height / 2
    const radius: number = width / 2.5

    this.context.clearRect(0, 0, width, height)

    this.context.beginPath()
    this.context.fillStyle = 'rgba(0, 137, 123, 0.10)'
    this.context.arc(centerX, centerY, radius, 0, Math.PI * 2)
    this.context.fill()

    this.context.beginPath()
    this.context.strokeStyle = ACCENT_TEAL
    this.context.lineWidth = 4
    this.context.arc(centerX, centerY, radius, 0, Math.PI * 2)
    this.context.stroke()

    const petalCount: number = 8
    const angleStep: number = 360 / petalCount

    for (let i = 0; i < petalCount; i++) {
      const angle: number = i * angleStep
      const rad: number = Math.PI * angle / 180
      const endX: number = centerX + radius * 0.7 * Math.cos(rad)
      const endY: number = centerY + radius * 0.7 * Math.sin(rad)

      this.context.beginPath()
      this.context.strokeStyle = 'rgba(0, 137, 123, 0.40)'
      this.context.lineWidth = 2
      this.context.lineCap = 'round'
      this.context.moveTo(centerX, centerY)
      this.context.lineTo(endX, endY)
      this.context.stroke()

      this.context.beginPath()
      this.context.fillStyle = ACCENT_TEAL
      this.context.arc(endX, endY, 6, 0, Math.PI * 2)
      this.context.fill()
    }
  }

  build() {
    Canvas(this.context)
      .width(280)
      .height(280)
      .scale({
        x: this.isPlaying ? this.scaleValue : 1,
        y: this.isPlaying ? this.scaleValue : 1
      })
      .rotate({
        z: 1,
        angle: this.isPlaying ? this.rotationValue : 0
      })
      .onReady(() => {
        this.drawVisualizer()
      })
  }
}

@Component
struct PatternCard {
  @Prop pattern: BreathingPattern = new BreathingPattern('', 0, 0)
  @Prop isSelected: boolean = false

  onClick: () => void = () => {
  }

  build() {
    Column() {
      if (this.isSelected) {
        Text('✓')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(ACCENT_TEAL)

        Blank()
          .height(4)
      }

      Text(this.pattern.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isSelected ? ACCENT_TEAL : TEXT_DARK)

      Text(`${this.pattern.inhale}-${this.pattern.exhale}`)
        .fontSize(12)
        .fontColor(MUTED_GRAY)
        .margin({ top: 4 })
    }
    .width(100)
    .height(90)
    .padding(12)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.isSelected ? SELECTED_BG : LIGHT_GRAY)
    .borderRadius(20)
    .border({
      width: 2,
      color: this.isSelected ? ACCENT_TEAL : 'rgba(0, 0, 0, 0)',
      radius: 20
    })
    .onClick(() => {
      this.onClick()
    })
  }
}

@Component
struct PlayPauseButton {
  @Prop isPlaying: boolean = false

  onClick: () => void = () => {
  }

  build() {
    Button({ type: ButtonType.Capsule, stateEffect: true }) {
      Row() {
        Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(PURE_WHITE)
          .letterSpacing(1)

        if (!this.isPlaying) {
          Blank()
            .width(8)

          Text('▶')
            .fontSize(20)
            .fontColor(PURE_WHITE)
        }
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .height(64)
    .width('100%')
    .backgroundColor(TEXT_DARK)
    .borderRadius(32)
    .onClick(() => {
      this.onClick()
    })
  }
}