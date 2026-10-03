class ZbColors {
  static readonly white: string = '#FFFFFFFF'
  static readonly textDark: string = '#FF2D2D2D'
  static readonly accentTeal: string = '#FF00897B'
  static readonly lightGray: string = '#FFF5F5F5'
  static readonly gray: string = '#FF808080'
  static readonly teal10: string = '#1A00897B'
  static readonly teal5: string = '#0D00897B'
  static readonly teal40: string = '#6600897B'
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
}

@Entry
@Component
struct Index {
  @State selectedPatternIndex: number = 0
  @State isPlaying: boolean = false
  @State scale: number = 0.8
  @State rotation: number = 0.0

  private patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4),
  ]

  get currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex]
  }

  toggleBreathing() {
    if (this.isPlaying) {
      this.stopBreathing()
    } else {
      this.startBreathing()
    }
  }

  startBreathing() {
    this.isPlaying = true
    animateTo({
      duration: 2000,
      iterations: -1,
      curve: Curve.EaseInOut,
      playMode: PlayMode.Alternate
    }, () => {
      this.scale = 1.2
    })
    animateTo({
      duration: 20000,
      iterations: -1,
      curve: Curve.Linear
    }, () => {
      this.rotation = 360
    })
  }

  stopBreathing() {
    this.isPlaying = false
    animateTo({ duration: 300 }, () => {
      this.scale = 0.8
      this.rotation = 0
    })
  }

  build() {
    Stack() {
      Column() {
        Blank().height(48)

        Row() {
          Text('ZenBreather')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(ZbColors.textDark)
          Blank()
          Text('⚙')
            .fontSize(24)
            .fontColor(ZbColors.gray)
        }
        .padding({ left: 24, right: 24 })

        Blank().height(60)

        Stack() {
          BreathVisualizer({ scale: this.scale, rotation: this.rotation })
            .width(280)
            .height(280)

          Column() {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(ZbColors.accentTeal)

            Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`)
              .fontSize(14)
              .fontColor(ZbColors.gray)
          }
        }

        Blank()

        Column() {
          Text('Select Rhythm')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(ZbColors.textDark)

          Row() {
            PatternCard({
              pName: this.patterns[0].name,
              isSelected: this.selectedPatternIndex === 0
            })
              .layoutWeight(1)
              .onClick(() => {
                this.selectedPatternIndex = 0
                this.stopBreathing()
              })

            PatternCard({
              pName: this.patterns[1].name,
              isSelected: this.selectedPatternIndex === 1
            })
              .layoutWeight(1)
              .onClick(() => {
                this.selectedPatternIndex = 1
                this.stopBreathing()
              })

            PatternCard({
              pName: this.patterns[2].name,
              isSelected: this.selectedPatternIndex === 2
            })
              .layoutWeight(1)
              .onClick(() => {
                this.selectedPatternIndex = 2
                this.stopBreathing()
              })
          }
          .margin({ top: 16 })
        }
        .padding({ left: 24, right: 24 })
        .alignItems(HorizontalAlign.Start)

        Blank().height(32)

        Row() {
          Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(ZbColors.white)

          if (!this.isPlaying) {
            Text('▶')
              .fontSize(20)
              .fontColor(ZbColors.white)
              .margin({ left: 8 })
          }
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(ZbColors.textDark)
        .borderRadius(32)
        .padding({ left: 32, right: 32, bottom: 32 })
        .onClick(() => {
          this.toggleBreathing()
        })
      }
    }
    .backgroundColor(ZbColors.white)
    .width('100%')
    .height('100%')
  }
}

@Component
struct BreathVisualizer {
  @Prop scale: number = 0.8
  @Prop rotation: number = 0.0
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Canvas(this.ctx)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawCanvas()
      })
      .onAreaChange(() => {
        this.drawCanvas()
      })
  }

  drawCanvas() {
    let w = this.ctx.width
    let h = this.ctx.height
    let cx = w / 2
    let cy = h / 2
    let r = Math.min(w, h) / 2
    let scaledR = r * this.scale

    this.ctx.clearRect(0, 0, w, h)
    this.ctx.save()
    this.ctx.translate(cx, cy)
    this.ctx.rotate(this.rotation * Math.PI / 180)

    this.ctx.fillStyle = ZbColors.teal10
    this.ctx.beginPath()
    this.ctx.arc(0, 0, scaledR, 0, Math.PI * 2)
    this.ctx.fill()

    this.ctx.strokeStyle = ZbColors.accentTeal
    this.ctx.lineWidth = 2
    this.ctx.beginPath()
    this.ctx.arc(0, 0, scaledR, 0, Math.PI * 2)
    this.ctx.stroke()

    let spokeLen = 70 * this.scale
    let dotOffset = 135 * this.scale
    for (let i = 0; i < 8; i++) {
      let angle = i * 45 * Math.PI / 180
      this.ctx.strokeStyle = ZbColors.teal40
      this.ctx.lineWidth = 2
      this.ctx.beginPath()
      this.ctx.moveTo(0, 0)
      this.ctx.lineTo(Math.cos(angle) * spokeLen, Math.sin(angle) * spokeLen)
      this.ctx.stroke()

      this.ctx.fillStyle = ZbColors.accentTeal
      this.ctx.beginPath()
      this.ctx.arc(Math.cos(angle) * dotOffset, Math.sin(angle) * dotOffset, 3 * this.scale, 0, Math.PI * 2)
      this.ctx.fill()
    }
    this.ctx.restore()
  }
}

@Component
struct PatternCard {
  @Prop pName: string = ''
  @Prop isSelected: boolean = false

  build() {
    Column() {
      if (this.isSelected) {
        Text('✓')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(ZbColors.accentTeal)
      }

      Text(this.pName)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isSelected ? ZbColors.accentTeal : ZbColors.textDark)
        .margin({ top: 4 })
    }
    .justifyContent(FlexAlign.Center)
    .width(100)
    .height(90)
    .backgroundColor(this.isSelected ? ZbColors.teal5 : ZbColors.lightGray)
    .borderRadius(20)
    .border({ width: this.isSelected ? 2 : 0, color: ZbColors.accentTeal })
    .margin({ right: 8 })
  }
}