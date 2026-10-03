interface BreathingPattern {
  name: string
  inhale: number
  exhale: number
}

@Entry
@Component
struct Index {
  @State selectedPatternIndex: number = 0
  @State isPlaying: boolean = false
  private patterns: BreathingPattern[] = [
    { name: 'Relax', inhale: 4, exhale: 6 },
    { name: 'Balance', inhale: 5, exhale: 5 },
    { name: 'Focus', inhale: 4, exhale: 4 }
  ]

  build() {
    Column() {
      Blank().height(48)

      Row() {
        Text('ZenBreather')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(-1)
          .fontColor('#000000')
        Text('⚙').fontSize(24).fontColor('#888888')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(60)

      Stack({ alignContent: Alignment.Center }) {
        BreathVisualizer({
          isPlaying: this.isPlaying,
          durationSum: this.patterns[this.selectedPatternIndex].inhale + this.patterns[this.selectedPatternIndex].exhale
        })

        Column() {
          Text(this.isPlaying ? 'Breathe' : 'Ready')
            .fontSize(24)
            .fontColor('#00897B')
            .fontWeight(FontWeight.Medium)
          Text(this.patterns[this.selectedPatternIndex].inhale + 's In / ' + this.patterns[this.selectedPatternIndex].exhale + 's Out')
            .fontSize(14)
            .fontColor('#888888')
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280).height(280)

      Blank().layoutWeight(1)

      Text('Select Rhythm')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Blank().height(16)

      Row() {
        ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
          PatternCard({
            name: pattern.name,
            inhale: pattern.inhale,
            exhale: pattern.exhale,
            isSelected: index == this.selectedPatternIndex,
            onSelect: () => {
              this.selectedPatternIndex = index
              this.isPlaying = false
            }
          })
        }, (pattern: BreathingPattern) => pattern.name)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Blank().height(32)

      PlayPauseButton({ isPlaying: this.isPlaying, onToggle: () => { this.isPlaying = !this.isPlaying } })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24, bottom: 32 })
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct BreathVisualizer {
  @Prop isPlaying: boolean = false
  @Prop durationSum: number = 10
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .scale({ x: this.isPlaying ? 1.2 : 0.8, y: this.isPlaying ? 1.2 : 0.8 })
      .onReady(() => {
        this.context.clearRect(0, 0, 280, 280)
        const cx = 140
        const cy = 140
        const r = 140 / 2.5
        this.context.fillStyle = 'rgba(0, 137, 123, 0.1)'
        this.context.beginPath()
        this.context.arc(cx, cy, r, 0, Math.PI * 2)
        this.context.fill()
        this.context.strokeStyle = '#00897B'
        this.context.lineWidth = 4
        this.context.beginPath()
        this.context.arc(cx, cy, r, 0, Math.PI * 2)
        this.context.stroke()
        for (let i = 0; i < 8; i++) {
          const angle = i * 45 * Math.PI / 180
          const ex = cx + r * 0.7 * Math.cos(angle)
          const ey = cy + r * 0.7 * Math.sin(angle)
          this.context.strokeStyle = 'rgba(0, 137, 123, 0.4)'
          this.context.lineWidth = 2
          this.context.beginPath()
          this.context.moveTo(cx, cy)
          this.context.lineTo(ex, ey)
          this.context.stroke()
          this.context.fillStyle = '#00897B'
          this.context.beginPath()
          this.context.arc(ex, ey, 6, 0, Math.PI * 2)
          this.context.fill()
        }
      })
  }
}

@Component
struct PatternCard {
  @Prop name: string = ''
  @Prop inhale: number = 0
  @Prop exhale: number = 0
  @Prop isSelected: boolean = false
  onSelect: () => void = () => {}

  build() {
    Column() {
      if (this.isSelected) {
        Text('✓').fontSize(16).fontColor('#00897B')
        Blank().height(4)
      }
      Text(this.name)
        .fontWeight(FontWeight.Bold)
        .fontSize(14)
        .fontColor(this.isSelected ? '#00897B' : '#2D2D2D')
      Text(this.inhale + '-' + this.exhale)
        .fontSize(12)
        .fontColor('#888888')
    }
    .width(100).height(90)
    .padding(12)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.isSelected ? 'rgba(0, 137, 123, 0.05)' : '#F5F5F5')
    .borderRadius(20)
    .border({ width: 2, color: this.isSelected ? '#00897B' : '#00000000' })
    .onClick(() => { this.onSelect() })
  }
}

@Component
struct PlayPauseButton {
  @Prop isPlaying: boolean = false
  onToggle: () => void = () => {}

  build() {
    Button({ type: ButtonType.Normal }) {
      Row() {
        Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(1)
          .fontColor('#FFFFFF')
        if (!this.isPlaying) {
          Blank().width(8)
          Text('▶').fontSize(20).fontColor('#FFFFFF')
        }
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(64)
    .backgroundColor('#2D2D2D')
    .borderRadius(32)
    .onClick(() => { this.onToggle() })
  }
}
