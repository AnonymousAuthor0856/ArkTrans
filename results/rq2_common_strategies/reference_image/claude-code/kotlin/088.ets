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
          isPlaying: this.isPlaying,
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
  @Link durationSum: number
  @State scale: number = 1.0
  @State rotation: number = 0.0
  private accentTeal: string = '#FF00897B'

  aboutToAppear(): void {
    this.startAnimations()
  }

  aboutToUpdate(): void {
    this.startAnimations()
  }

  startAnimations(): void {
    if (this.isPlaying) {
      // Scale animation (inhale/exhale)
      animateTo({
        duration: this.durationSum * 500,
        curve: Curve.FastOutSlowIn,
        iterations: -1,
        playMode: PlayMode.Alternate,
        onFinish: () => {}
      }, () => {
        this.scale = 1.2
      })

      // Rotation animation
      animateTo({
        duration: 20000,
        curve: Curve.Linear,
        iterations: -1,
        playMode: PlayMode.Normal,
        onFinish: () => {}
      }, () => {
        this.rotation = 360
      })
    } else {
      this.scale = 1.0
      this.rotation = 0.0
    }
  }

  build() {
    Canvas(this.canvasSettings)
      .width('100%')
      .height('100%')
      .scale({ x: this.scale, y: this.scale, centerX: '50%', centerY: '50%' })
      .rotate({ angle: this.rotation, centerX: '50%', centerY: '50%' })
      .onReady(() => {
        this.drawBreathVisualizer()
      })
  }

  private canvasSettings: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  drawBreathVisualizer(): void {
    const ctx = this.canvasSettings
    const width = 280
    const height = 280
    const centerX = width / 2
    const centerY = height / 2
    const radius = Math.min(width, height) / 2.5

    ctx.clearRect(0, 0, width, height)

    // Outer filled circle (light teal)
    ctx.beginPath()
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
    ctx.fillStyle = 'rgba(0, 137, 123, 0.1)'
    ctx.fill()

    // Outer ring
    ctx.beginPath()
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
    ctx.strokeStyle = '#00897B'
    ctx.lineWidth = 4
    ctx.stroke()

    // Petals (8 lines from center)
    const petalCount = 8
    const angleStep = (Math.PI * 2) / petalCount

    for (let i = 0; i < petalCount; i++) {
      const angle = i * angleStep - Math.PI / 2
      const endX = centerX + radius * 0.7 * Math.cos(angle)
      const endY = centerY + radius * 0.7 * Math.sin(angle)

      // Line from center
      ctx.beginPath()
      ctx.moveTo(centerX, centerY)
      ctx.lineTo(endX, endY)
      ctx.strokeStyle = 'rgba(0, 137, 123, 0.4)'
      ctx.lineWidth = 2
      ctx.lineCap = 'round'
      ctx.stroke()

      // Dot at end
      ctx.beginPath()
      ctx.arc(endX, endY, 6, 0, Math.PI * 2)
      ctx.fillStyle = '#00897B'
      ctx.fill()
    }
  }
}

@Component
struct PatternCard {
  @Link pattern: BreathingPattern
  @Link isSelected: boolean
  @Link onClick: () => void

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
