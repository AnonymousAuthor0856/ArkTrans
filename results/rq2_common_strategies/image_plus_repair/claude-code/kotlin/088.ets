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
        Text("⚙")
          .fontSize(24)
          .fontColor(Color.Gray)
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
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF2D2D2D')
          .width('100%')

        Row() {
          ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
            PatternCard({
              pattern: pattern,
              isSelected: index === this.selectedPatternIndex,
              onCardClick: () => {
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
            Text("▶")
              .fontSize(20)
              .fontColor(Color.White)
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
  private settings: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  aboutToAppear(): void {
    if (this.isPlaying) {
      this.startAnimations()
    }
  }

  aboutToUpdate(): void {
    if (this.isPlaying && this.scaleVal === 1.0 && this.rotateVal === 0) {
      this.startAnimations()
    }
    if (!this.isPlaying) {
      this.scaleVal = 1.0
      this.rotateVal = 0
    }
  }

  startAnimations(): void {
    animateTo({
      duration: this.durationSum * 500,
      curve: Curve.FastOutSlowIn,
      iterations: -1,
      playMode: PlayMode.Alternate
    }, () => {
      this.scaleVal = 1.2
    })

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
    Canvas(this.settings)
      .width('100%')
      .height('100%')
      .scale({
        x: this.isPlaying ? this.scaleVal : 1.0,
        y: this.isPlaying ? this.scaleVal : 1.0,
        centerX: '50%',
        centerY: '50%'
      })
      .rotate({
        angle: this.isPlaying ? this.rotateVal : 0,
        centerX: '50%',
        centerY: '50%'
      })
      .onReady(() => {
        this.drawVisualizer()
      })
  }

  drawVisualizer(): void {
    const ctx = this.settings
    const w = 280
    const h = 280
    const cx = w / 2
    const cy = h / 2
    const r = Math.min(w, h) / 2.5

    ctx.clearRect(0, 0, w, h)

    // Outer filled circle (light teal)
    ctx.beginPath()
    ctx.arc(cx, cy, r, 0, Math.PI * 2)
    ctx.fillStyle = 'rgba(0, 137, 123, 0.1)'
    ctx.fill()

    // Outer ring
    ctx.beginPath()
    ctx.arc(cx, cy, r, 0, Math.PI * 2)
    ctx.strokeStyle = '#00897B'
    ctx.lineWidth = 4
    ctx.stroke()

    // 8 petals with dots
    const petalCount = 8
    const angleStep = (Math.PI * 2) / petalCount
    for (let i = 0; i < petalCount; i++) {
      const angle = i * angleStep - Math.PI / 2
      const ex = cx + r * 0.7 * Math.cos(angle)
      const ey = cy + r * 0.7 * Math.sin(angle)

      ctx.beginPath()
      ctx.moveTo(cx, cy)
      ctx.lineTo(ex, ey)
      ctx.strokeStyle = 'rgba(0, 137, 123, 0.4)'
      ctx.lineWidth = 2
      ctx.lineCap = 'round'
      ctx.stroke()

      ctx.beginPath()
      ctx.arc(ex, ey, 6, 0, Math.PI * 2)
      ctx.fillStyle = '#00897B'
      ctx.fill()
    }
  }
}

@Component
struct PatternCard {
  pattern: BreathingPattern = new BreathingPattern("", 0, 0)
  isSelected: boolean = false
  onCardClick: () => void = () => {}

  build() {
    Column() {
      if (this.isSelected) {
        Text("✓")
          .fontSize(16)
          .fontColor('#FF00897B')
          .fontWeight(FontWeight.Bold)
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
      this.onCardClick()
    })
  }
}
