const PureWhite: ResourceColor = '#FFFFFF'
const TextDark: ResourceColor = '#2D2D2D'
const AccentTeal: ResourceColor = '#00897B'
const LightGray: ResourceColor = '#F5F5F5'

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
struct MainScreen {
  @State selectedPatternIndex: number = 0
  @State isPlaying: boolean = false

  private patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ]

  build() {
    Column() {
      Blank()
        .height(48)

      Row() {
        Text('ZenBreather')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextDark)
          .letterSpacing(-1)

        Text('⚙')
          .fontSize(24)
          .fontColor('#808080')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(60)

      Stack({ alignContent: Alignment.Center }) {
        BreathVisualizer({
          isPlaying: this.isPlaying,
          durationSum: this.patterns[this.selectedPatternIndex].totalDuration
        })

        Column() {
          Text(this.isPlaying ? 'Breathe' : 'Ready')
            .fontSize(24)
            .fontColor(AccentTeal)
            .fontWeight(FontWeight.Medium)

          Text(`${this.patterns[this.selectedPatternIndex].inhale}s In / ${this.patterns[this.selectedPatternIndex].exhale}s Out`)
            .fontSize(14)
            .fontColor('#808080')
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
        .fontWeight(FontWeight.SemiBold)
        .fontColor(TextDark)

      Blank()
        .height(16)

      Row() {
        ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
          PatternCard({
            pattern: pattern,
            isSelected: index === this.selectedPatternIndex,
            onSelect: () => {
              this.selectedPatternIndex = index
              this.isPlaying = false
            }
          })
        }, (pattern: BreathingPattern) => pattern.name)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Blank()
        .height(32)

      PlayPauseButton({
        isPlaying: this.isPlaying,
        onClick: () => {
          this.isPlaying = !this.isPlaying
        }
      })
        .margin({ bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .backgroundColor(PureWhite)
  }
}

@Component
struct BreathVisualizer {
  @Prop @Watch('onPlayingChanged') isPlaying: boolean
  @Prop @Watch('onPlayingChanged') durationSum: number

  @State private scaleValue: number = 1
  @State private rotationValue: number = 0

  private canvasContext: CanvasRenderingContext2D =
    new CanvasRenderingContext2D(new RenderingContextSettings(true))

  aboutToAppear() {
    if (this.isPlaying) {
      this.startAnimation()
    }
  }

  private onPlayingChanged() {
    if (this.isPlaying) {
      this.startAnimation()
    } else {
      animateTo({
        duration: 200,
        curve: Curve.EaseOut
      }, () => {
        this.scaleValue = 1
        this.rotationValue = 0
      })
    }
  }

  private startAnimation() {
    this.scaleValue = 0.8
    this.rotationValue = 0

    animateTo({
      duration: this.durationSum * 1000,
      curve: Curve.FastOutSlowIn,
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

  private drawBreathShape() {
    const width = this.canvasContext.width
    const height = this.canvasContext.height
    const centerX = width / 2
    const centerY = height / 2
    const radius = Math.min(width, height) / 2.5

    this.canvasContext.clearRect(0, 0, width, height)

    this.canvasContext.beginPath()
    this.canvasContext.fillStyle = 'rgba(0, 137, 123, 0.1)'
    this.canvasContext.arc(centerX, centerY, radius, 0, Math.PI * 2)
    this.canvasContext.fill()

    this.canvasContext.beginPath()
    this.canvasContext.strokeStyle = '#00897B'
    this.canvasContext.lineWidth = 4
    this.canvasContext.arc(centerX, centerY, radius, 0, Math.PI * 2)
    this.canvasContext.stroke()

    const petalCount = 8
    const angleStep = 360 / petalCount

    for (let i = 0; i < petalCount; i++) {
      const angle = i * angleStep
      const rad = angle * Math.PI / 180
      const endX = centerX + radius * 0.7 * Math.cos(rad)
      const endY = centerY + radius * 0.7 * Math.sin(rad)

      this.canvasContext.beginPath()
      this.canvasContext.strokeStyle = 'rgba(0, 137, 123, 0.4)'
      this.canvasContext.lineWidth = 2
      this.canvasContext.lineCap = 'round'
      this.canvasContext.moveTo(centerX, centerY)
      this.canvasContext.lineTo(endX, endY)
      this.canvasContext.stroke()

      this.canvasContext.beginPath()
      this.canvasContext.fillStyle = '#00897B'
      this.canvasContext.arc(endX, endY, 6, 0, Math.PI * 2)
      this.canvasContext.fill()
    }
  }

  build() {
    Canvas(this.canvasContext)
      .width('100%')
      .height('100%')
      .scale({
        x: this.isPlaying ? this.scaleValue : 1,
        y: this.isPlaying ? this.scaleValue : 1,
        centerX: '50%',
        centerY: '50%'
      })
      .rotate({
        angle: this.isPlaying ? this.rotationValue : 0,
        centerX: '50%',
        centerY: '50%'
      })
      .onReady(() => {
        this.drawBreathShape()
      })
  }
}

@Component
struct PatternCard {
  pattern: BreathingPattern
  isSelected: boolean
  onSelect: () => void = () => {}

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column() {
        if (this.isSelected) {
          Text('✓')
            .fontSize(16)
            .fontColor(AccentTeal)
            .fontWeight(FontWeight.Bold)

          Blank()
            .height(4)
        }

        Text(this.pattern.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isSelected ? AccentTeal : TextDark)

        Text(`${this.pattern.inhale}-${this.pattern.exhale}`)
          .fontSize(12)
          .fontColor('#808080')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(100)
    .height(90)
    .padding(12)
    .borderRadius(20)
    .backgroundColor(this.isSelected ? 'rgba(0, 137, 123, 0.05)' : LightGray)
    .border({
      width: 2,
      color: this.isSelected ? AccentTeal : Color.Transparent,
      radius: 20
    })
    .onClick(() => {
      this.onSelect()
    })
  }
}

@Component
struct PlayPauseButton {
  isPlaying: boolean
  onClick: () => void = () => {}

  build() {
    Button({ type: ButtonType.Normal }) {
      Row() {
        Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .letterSpacing(1)

        if (!this.isPlaying) {
          Blank()
            .width(8)

          Text('▶')
            .fontSize(20)
            .fontColor(Color.White)
        }
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(64)
    .borderRadius(32)
    .backgroundColor(TextDark)
    .stateEffect(false)
    .onClick(() => {
      this.onClick()
    })
  }
}