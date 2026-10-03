@Entry
@Component
struct ZenBreatherPage {
  @State selectedPatternIndex: number = 0
  @State isPlaying: boolean = false
  private patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ]

  build() {
    Column() {
      Column() {
        // Header
        Row() {
          Text('ZenBreather')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2D2D2D')
            .letterSpacing(-1)
          Image($r('sys.media.ohos_ic_public_settings'))
            .width(24)
            .height(24)
            .fillColor(Color.Gray)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Visualizer Section
        Stack({ alignContent: Alignment.Center }) {
          BreathVisualizer({
            isPlaying: this.isPlaying,
            durationSum: this.patterns[this.selectedPatternIndex].totalDuration
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

      // Pattern Selection
      Column() {
        Text('Select Rhythm')
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#2D2D2D')
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
      .padding({ left: 24, right: 24 })
      .margin({ top: 0 })

      Blank()

      // Bottom Control Bar
      Row() {
        PlayPauseButton({
          isPlaying: this.isPlaying,
          onClick: () => {
            this.isPlaying = !this.isPlaying
          }
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
  @State scale: number = 1.0
  @State rotation: number = 0
  private readonly petalCount: number = 8

  aboutToAppear() {
    this.startAnimations()
  }

  aboutToUpdate() {
    this.startAnimations()
  }

  startAnimations() {
    if (this.isPlaying) {
      // Scale animation - simulates lungs expanding/contracting
      animateTo({
        duration: this.durationSum * 1000,
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
      animateTo({
        duration: 500,
        curve: Curve.EaseInOut
      }, () => {
        this.scale = 1.0
        this.rotation = 0
      })
    }
  }

  build() {
    Canvas()
      .width('100%')
      .height('100%')
      .scale({ x: this.isPlaying ? this.scale : 1, y: this.isPlaying ? this.scale : 1 })
      .rotate({ angle: this.isPlaying ? this.rotation : 0 })
      .onReady((ctx: CanvasRenderingContext2D) => {
        this.drawVisualizer(ctx)
      })
  }

  drawVisualizer(ctx: CanvasRenderingContext2D) {
    const width = ctx.canvas.width
    const height = ctx.canvas.height
    const centerX = width / 2
    const centerY = height / 2
    const radius = Math.min(width, height) / 2.5

    // Outer circle fill (light teal)
    ctx.beginPath()
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
    ctx.fillStyle = 'rgba(0, 137, 123, 0.1)'
    ctx.fill()

    // Outer circle stroke
    ctx.beginPath()
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
    ctx.strokeStyle = '#00897B'
    ctx.lineWidth = 4
    ctx.stroke()

    // Petals
    const angleStep = (Math.PI * 2) / this.petalCount

    for (let i = 0; i < this.petalCount; i++) {
      const angle = i * angleStep
      const endX = centerX + radius * 0.7 * Math.cos(angle)
      const endY = centerY + radius * 0.7 * Math.sin(angle)

      // Petal line
      ctx.beginPath()
      ctx.moveTo(centerX, centerY)
      ctx.lineTo(endX, endY)
      ctx.strokeStyle = 'rgba(0, 137, 123, 0.4)'
      ctx.lineWidth = 2
      ctx.lineCap = 'round'
      ctx.stroke()

      // Dot at end of petal
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
        Image($r('sys.media.ohos_ic_public_selected'))
          .width(16)
          .height(16)
          .fillColor('#00897B')
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
      this.onClick()
    })
  }
}

@Component
struct PlayPauseButton {
  @Link isPlaying: boolean
  @Link onClick: () => void

  build() {
    Row() {
      Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .letterSpacing(1)
      if (!this.isPlaying) {
        Image($r('sys.media.ohos_ic_public_play'))
          .width(20)
          .height(20)
          .fillColor(Color.White)
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
      this.onClick()
    })
  }
}
