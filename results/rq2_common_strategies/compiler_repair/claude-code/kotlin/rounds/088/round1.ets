@Entry
@Component
struct ZenBreatherPage {
  @State selectedPatternIndex: number = 0
  @State isPlaying: boolean = false
  @State currentDurationSum: number = 10
  private patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ]

  aboutToAppear(): void {
    this.currentDurationSum = this.patterns[this.selectedPatternIndex].totalDuration
  }

  build() {
    Column() {
      Column() {
        Row() {
          Text('ZenBreather')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2D2D2D')
            .letterSpacing(-1)
          Text('⚙')
            .fontSize(24)
            .fontColor(Color.Gray)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Stack({ alignContent: Alignment.Center }) {
          BreathVisualizer({
            isPlaying: $isPlaying,
            durationSum: $currentDurationSum
          })
          Column() {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontSize(24)
              .fontColor('#00897B')
              .fontWeight(FontWeight.Medium)
            Text(`${this.patterns[this.selectedPatternIndex].inhale}s In / ${this.patterns[this.selectedPatternIndex].exhale}s Out`)
              .fontSize(14)
              .fontColor(Color.Gray)
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(280)
        .height(280)
        .margin({ top: 60 })
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48 })

      Column() {
        Text('Select Rhythm')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2D2D2D')
          .width('100%')

        Row() {
          ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
            PatternCard({
              pattern: pattern,
              isSelected: index === this.selectedPatternIndex,
              onCardClick: () => {
                this.selectedPatternIndex = index
                this.isPlaying = false
                this.currentDurationSum = pattern.totalDuration
              }
            })
          }, (pattern: BreathingPattern) => pattern.name)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 16 })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })

      Blank()

      Row() {
        PlayPauseButton({
          isPlaying: $isPlaying
        })
      }
      .width('100%')
      .padding(32)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
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
  @Link durationSum: number
  @State breathScale: number = 1.0
  @State rotation: number = 0
  @State canvasWidth: number = 280
  @State canvasHeight: number = 280
  private readonly petalCount: number = 8
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: DrawingRenderingContext = new DrawingRenderingContext(this.settings)

  aboutToAppear(): void {
    this.startAnimations()
  }

  aboutToUpdate(): void {
    this.startAnimations()
  }

  startAnimations(): void {
    if (this.isPlaying) {
      animateTo({
        duration: this.durationSum * 1000,
        curve: Curve.FastOutSlowIn,
        iterations: -1,
        playMode: PlayMode.Alternate
      }, () => {
        this.breathScale = 1.2
      })

      animateTo({
        duration: 20000,
        curve: Curve.Linear,
        iterations: -1,
        playMode: PlayMode.Normal
      }, () => {
        this.rotation = 360
      })
    } else {
      animateTo({
        duration: 500,
        curve: Curve.EaseInOut
      }, () => {
        this.breathScale = 1.0
        this.rotation = 0
      })
    }
  }

  build() {
    Canvas(this.ctx)
      .width('100%')
      .height('100%')
      .scale({ x: this.isPlaying ? this.breathScale : 1, y: this.isPlaying ? this.breathScale : 1 })
      .rotate({ angle: this.isPlaying ? this.rotation : 0 })
      .onReady(() => {
        this.drawVisualizer()
      })
      .onAreaChange((oldArea: Area, newArea: Area) => {
        this.canvasWidth = newArea.width as number
        this.canvasHeight = newArea.height as number
        this.drawVisualizer()
      })
  }

  drawVisualizer(): void {
    const width: number = this.canvasWidth
    const height: number = this.canvasHeight
    const centerX: number = width / 2
    const centerY: number = height / 2
    const radius: number = Math.min(width, height) / 2.5

    this.ctx.beginPath()
    this.ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
    this.ctx.fillStyle = 'rgba(0, 137, 123, 0.1)'
    this.ctx.fill()

    this.ctx.beginPath()
    this.ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
    this.ctx.strokeStyle = '#00897B'
    this.ctx.lineWidth = 4
    this.ctx.stroke()

    const angleStep: number = (Math.PI * 2) / this.petalCount

    for (let i: number = 0; i < this.petalCount; i++) {
      const angle: number = i * angleStep
      const endX: number = centerX + radius * 0.7 * Math.cos(angle)
      const endY: number = centerY + radius * 0.7 * Math.sin(angle)

      this.ctx.beginPath()
      this.ctx.moveTo(centerX, centerY)
      this.ctx.lineTo(endX, endY)
      this.ctx.strokeStyle = 'rgba(0, 137, 123, 0.4)'
      this.ctx.lineWidth = 2
      this.ctx.lineCap = 'round'
      this.ctx.stroke()

      this.ctx.beginPath()
      this.ctx.arc(endX, endY, 6, 0, Math.PI * 2)
      this.ctx.fillStyle = '#00897B'
      this.ctx.fill()
    }
  }
}

@Component
struct PatternCard {
  pattern: BreathingPattern = new BreathingPattern('', 0, 0)
  isSelected: boolean = false
  onCardClick: () => void = () => {}

  build() {
    Column() {
      if (this.isSelected) {
        Text('✓')
          .fontSize(16)
          .fontColor('#00897B')
          .margin({ bottom: 4 })
      }
      Text(this.pattern.name)
        .fontWeight(FontWeight.Bold)
        .fontSize(14)
        .fontColor(this.isSelected ? '#00897B' : '#2D2D2D')
      Text(`${this.pattern.inhale}-${this.pattern.exhale}`)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .width(100)
    .height(90)
    .borderRadius(20)
    .backgroundColor(this.isSelected ? 'rgba(0, 137, 123, 0.05)' : '#F5F5F5')
    .border({
      width: 2,
      color: this.isSelected ? '#00897B' : Color.Transparent,
      radius: 20
    })
    .padding(12)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.onCardClick()
    })
  }
}

@Component
struct PlayPauseButton {
  @Link isPlaying: boolean

  build() {
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
    .height(64)
    .borderRadius(32)
    .backgroundColor('#2D2D2D')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.isPlaying = !this.isPlaying
    })
  }
}
