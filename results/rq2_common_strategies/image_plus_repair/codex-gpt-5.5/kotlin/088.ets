const PURE_WHITE: string = '#FFFFFF'
const TEXT_DARK: string = '#2D2D2D'
const ACCENT_TEAL: string = '#00897B'
const LIGHT_GRAY: string = '#F5F5F5'
const MUTED_GRAY: string = '#8A8A8A'

interface BreathingPattern {
  name: string
  inhale: number
  exhale: number
}

@Entry
@Component
struct Index {
  @State private selectedPatternIndex: number = 0
  @State private isPlaying: boolean = false
  @State private phase: number = 0

  private readonly patterns: BreathingPattern[] = [
    { name: 'Relax', inhale: 4, exhale: 6 },
    { name: 'Balance', inhale: 5, exhale: 5 },
    { name: 'Focus', inhale: 4, exhale: 4 }
  ]

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D()
  private timerId: number = -1

  aboutToAppear(): void {
    this.timerId = setInterval(() => {
      if (this.isPlaying) {
        this.phase = (this.phase + 0.018) % 1
        this.drawVisualizer()
      }
    }, 30)
  }

  aboutToDisappear(): void {
    if (this.timerId >= 0) {
      clearInterval(this.timerId)
      this.timerId = -1
    }
  }

  private get currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex]
  }

  private selectPattern(index: number): void {
    this.selectedPatternIndex = index
    this.isPlaying = false
    this.phase = 0
    this.drawVisualizer()
  }

  private togglePlaying(): void {
    this.isPlaying = !this.isPlaying
    if (!this.isPlaying) {
      this.phase = 0
    }
    this.drawVisualizer()
  }

  private drawVisualizer(): void {
    const ctx = this.canvasContext
    const width: number = 360
    const height: number = 360
    const centerX: number = width / 2
    const centerY: number = height / 2
    const breathingScale: number = this.isPlaying
      ? 0.94 + 0.11 * Math.sin(this.phase * 2 * Math.PI)
      : 1
    const radius: number = 145 * breathingScale

    ctx.clearRect(0, 0, width, height)

    ctx.beginPath()
    ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI)
    ctx.fillStyle = '#E4F2F1'
    ctx.fill()

    ctx.beginPath()
    ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI)
    ctx.strokeStyle = ACCENT_TEAL
    ctx.lineWidth = 4
    ctx.stroke()

    for (let i = 0; i < 8; i++) {
      const angle: number = (i * Math.PI) / 4
      const endX: number = centerX + radius * 0.7 * Math.cos(angle)
      const endY: number = centerY + radius * 0.7 * Math.sin(angle)

      ctx.beginPath()
      ctx.moveTo(centerX, centerY)
      ctx.lineTo(endX, endY)
      ctx.strokeStyle = '#76C5BE'
      ctx.lineWidth = 2
      ctx.stroke()

      ctx.beginPath()
      ctx.arc(endX, endY, 6, 0, 2 * Math.PI)
      ctx.fillStyle = ACCENT_TEAL
      ctx.fill()
    }
  }

  @Builder
  private patternCard(pattern: BreathingPattern, index: number) {
    Column({ space: 4 }) {
      if (index === this.selectedPatternIndex) {
        Text('✓')
          .fontSize(21)
          .fontColor(ACCENT_TEAL)
          .height(24)
      } else {
        Blank().height(24)
      }
      Text(pattern.name)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(index === this.selectedPatternIndex ? ACCENT_TEAL : TEXT_DARK)
      Text(`${pattern.inhale}-${pattern.exhale}`)
        .fontSize(14)
        .fontColor(MUTED_GRAY)
    }
    .width('31%')
    .height(102)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(index === this.selectedPatternIndex ? '#F1F9F8' : LIGHT_GRAY)
    .border({
      width: index === this.selectedPatternIndex ? 3 : 0,
      color: ACCENT_TEAL,
      radius: 24
    })
    .borderRadius(24)
    .onClick(() => this.selectPattern(index))
  }

  build() {
    Column() {
      Row() {
        Text('ZenBreather')
          .fontSize(38)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_DARK)
          .letterSpacing(-1.2)

        Text('⚙')
          .fontSize(37)
          .fontColor('#8B8B8B')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(72)

      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.canvasContext)
          .width(360)
          .height(360)
          .onReady(() => {
            this.drawVisualizer()
          })

        Column({ space: 5 }) {
          Text(this.isPlaying ? 'Breathe' : 'Ready')
            .fontSize(47)
            .fontWeight(FontWeight.Medium)
            .fontColor(ACCENT_TEAL)
          Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`)
            .fontSize(27)
            .fontColor(MUTED_GRAY)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(360)
      .height(360)

      Blank()
        .layoutWeight(1)

      Text('Select Rhythm')
        .width('100%')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT_DARK)
        .margin({ bottom: 28 })

      Row({ space: 12 }) {
        ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
          this.patternCard(pattern, index)
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Blank().height(66)

      Button() {
        Row({ space: 18 }) {
          Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(PURE_WHITE)
            .letterSpacing(1.2)
          if (!this.isPlaying) {
            Text('▶')
              .fontSize(25)
              .fontColor(PURE_WHITE)
          }
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(128)
      .backgroundColor(TEXT_DARK)
      .borderRadius(64)
      .onClick(() => this.togglePlaying())
    }
    .width('100%')
    .height('100%')
    .padding({ left: 48, right: 48, top: 70, bottom: 64 })
    .backgroundColor(PURE_WHITE)
  }
}
