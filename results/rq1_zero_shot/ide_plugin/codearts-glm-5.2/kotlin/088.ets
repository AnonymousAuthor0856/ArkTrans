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

class AppTokens {
  static readonly Colors = {
    pureWhite: '#FFFFFFFF',
    textDark: '#FF2D2D2D',
    accentTeal: '#FF00897B',
    accentTeal10: '#1A00897B',
    accentTeal40: '#6600897B',
    accentTeal05: '#0D00897B',
    lightGray: '#FFF5F5F5',
    gray: '#FF888888',
    white: '#FFFFFFFF',
    transparent: '#00000000'
  }
}

@Entry
@Component
struct MainScreen {
  @State selectedPatternIndex: number = 0
  @State isPlaying: boolean = false
  @State scale: number = 1
  @State rotation: number = 0
  private patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ]
  private scaleTimer: number = -1
  private rotationTimer: number = -1
  private scaleDirection: number = 1
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  get currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex]
  }

  aboutToDisappear() {
    clearInterval(this.scaleTimer)
    clearInterval(this.rotationTimer)
  }

  startAnimation() {
    clearInterval(this.scaleTimer)
    clearInterval(this.rotationTimer)
    this.scale = 0.8
    this.rotation = 0
    this.scaleDirection = 1
    const durationSum = this.currentPattern.totalDuration * 1000
    const interval = 40
    const scaleStep = interval / durationSum * 0.4
    const rotationStep = interval / 20000 * 360
    this.scaleTimer = setInterval(() => {
      this.scale += this.scaleDirection * scaleStep
      if (this.scale >= 1.2) {
        this.scale = 1.2
        this.scaleDirection = -1
      } else if (this.scale <= 0.8) {
        this.scale = 0.8
        this.scaleDirection = 1
      }
    }, interval)
    this.rotationTimer = setInterval(() => {
      this.rotation = (this.rotation + rotationStep) % 360
    }, interval)
  }

  stopAnimation() {
    clearInterval(this.scaleTimer)
    clearInterval(this.rotationTimer)
    this.scale = 1
    this.rotation = 0
  }

  togglePlay() {
    this.isPlaying = !this.isPlaying
    if (this.isPlaying) {
      this.startAnimation()
    } else {
      this.stopAnimation()
    }
  }

  selectPattern(index: number) {
    this.selectedPatternIndex = index
    this.isPlaying = false
    this.stopAnimation()
  }

  drawVisualizer() {
    const ctx = this.canvasContext
    const w = 280
    const h = 280
    const centerX = w / 2
    const centerY = h / 2
    const radius = Math.min(w, h) / 2.5

    ctx.clearRect(0, 0, w, h)

    ctx.fillStyle = AppTokens.Colors.accentTeal10
    ctx.beginPath()
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
    ctx.fill()

    ctx.strokeStyle = AppTokens.Colors.accentTeal
    ctx.lineWidth = 4
    ctx.beginPath()
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
    ctx.stroke()

    const petalCount = 8
    const angleStep = 360 / petalCount
    for (let i = 0; i < petalCount; i++) {
      const angle = i * angleStep
      const rad = angle * Math.PI / 180
      const endX = centerX + radius * 0.7 * Math.cos(rad)
      const endY = centerY + radius * 0.7 * Math.sin(rad)

      ctx.strokeStyle = AppTokens.Colors.accentTeal40
      ctx.lineWidth = 2
      ctx.lineCap = 'round'
      ctx.beginPath()
      ctx.moveTo(centerX, centerY)
      ctx.lineTo(endX, endY)
      ctx.stroke()

      ctx.fillStyle = AppTokens.Colors.accentTeal
      ctx.beginPath()
      ctx.arc(endX, endY, 6, 0, Math.PI * 2)
      ctx.fill()
    }
  }

  build() {
    Column() {
      Row() {
        Text('ZenBreather')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(-1)
        Blank()
        Text('⚙')
          .fontSize(24)
          .fontColor(AppTokens.Colors.gray)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48 })

      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.canvasContext)
          .width(280)
          .height(280)
          .scale({ x: this.isPlaying ? this.scale : 1, y: this.isPlaying ? this.scale : 1 })
          .rotate({ angle: this.isPlaying ? this.rotation : 0 })
          .onReady(() => {
            this.drawVisualizer()
          })

        Column() {
          Text(this.isPlaying ? 'Breathe' : 'Ready')
            .fontSize(24)
            .fontColor(AppTokens.Colors.accentTeal)
            .fontWeight(FontWeight.Medium)
          Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`)
            .fontSize(14)
            .fontColor(AppTokens.Colors.gray)
        }
      }
      .width(280)
      .height(280)
      .margin({ top: 60 })

      Blank()

      Column() {
        Text('Select Rhythm')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .width('100%')
        Row() {
          ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
            PatternCard({
              name: pattern.name,
              inhale: pattern.inhale,
              exhale: pattern.exhale,
              isSelected: index === this.selectedPatternIndex,
              onSelect: () => {
                this.selectPattern(index)
              }
            })
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 16 })
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 32 })

      Row() {
        Button(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.white)
          .backgroundColor(AppTokens.Colors.textDark)
          .height(64)
          .width('100%')
          .borderRadius(32)
          .onClick(() => this.togglePlay())
      }
      .width('100%')
      .padding({ left: 32, right: 32, bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.pureWhite)
    .alignItems(Alignment.Center)
  }
}

@Component
struct PatternCard {
  @Prop name: string
  @Prop inhale: number
  @Prop exhale: number
  @Prop isSelected: boolean
  onSelect: () => void = () => {}

  build() {
    Column() {
      if (this.isSelected) {
        Text('✓')
          .fontSize(16)
          .fontColor(AppTokens.Colors.accentTeal)
          .margin({ bottom: 4 })
      }
      Text(this.name)
        .fontWeight(FontWeight.Bold)
        .fontSize(14)
        .fontColor(this.isSelected ? AppTokens.Colors.accentTeal : AppTokens.Colors.textDark)
      Text(`${this.inhale}-${this.exhale}`)
        .fontSize(12)
        .fontColor(AppTokens.Colors.gray)
    }
    .width(100)
    .height(90)
    .borderRadius(20)
    .backgroundColor(this.isSelected ? AppTokens.Colors.accentTeal05 : AppTokens.Colors.lightGray)
    .border({ width: 2, color: this.isSelected ? AppTokens.Colors.accentTeal : AppTokens.Colors.transparent })
    .justifyContent(FlexAlign.Center)
    .onClick(() => this.onSelect())
  }
}