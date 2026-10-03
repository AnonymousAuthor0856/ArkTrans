@Entry
@Component
struct ZenBreatherApp {
  @State selectedPatternIndex: number = 0
  @State isPlaying: boolean = false
  @State scaleValue: number = 0.8
  @State rotation: number = 0

  private patterns: BreathingPattern[] = [
    { name: 'Relax', inhale: 4, exhale: 6 },
    { name: 'Balance', inhale: 5, exhale: 5 },
    { name: 'Focus', inhale: 4, exhale: 4 }
  ]

  get currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex]
  }

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Bottom }
    // children: 1
    Stack({ alignContent: Alignment.Bottom }) {
      // === Column ===
      // modifier: { width: '100%', height: '100%', backgroundColor: '#FFFFFF' }
      // children: 7
      Column() {
        // === Blank ===
        // modifier: { height: 48 }
        Blank().height(48)

        // === Row ===
        // modifier: { width: '100%', padding: { left: 24, right: 24 } }
        // children: 2
        Row() {
          // === Text ===
          // props: { text: 'ZenBreather' }
          // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, fontColor: '#2D2D2D' }
          Text('ZenBreather').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#2D2D2D')
          
          // === Blank ===
          Blank()
          
          // === Image ===
          // modifier: { width: 24, height: 24, fontColor: '#9E9E9E' }
          Image($r('app.media.startIcon')).width(24).height(24).fillColor('#9E9E9E')
        }.width('100%').padding({ left: 24, right: 24 })

        // === Blank ===
        // modifier: { height: 60 }
        Blank().height(60)

        // === Stack ===
        // props: { alignContent: Alignment.Center }
        // modifier: { width: 280, height: 280 }
        // children: 2
        Stack({ alignContent: Alignment.Center }) {
          // === BreathVisualizer ===
          // props: { scale: this.scaleValue, rotation: this.rotation }
          BreathVisualizer({ scale: this.scaleValue, rotation: this.rotation })

          // === Column ===
          // modifier: { space: 4 }
          // children: 2
          Column({ space: 4 }) {
            // === Text ===
            // props: { text: this.isPlaying ? 'Breathe' : 'Ready' }
            // modifier: { fontSize: 24, fontWeight: FontWeight.Medium, fontColor: '#00897B' }
            Text(this.isPlaying ? 'Breathe' : 'Ready').fontSize(24).fontWeight(FontWeight.Medium).fontColor('#00897B')
            
            // === Text ===
            // props: { text: `${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out` }
            // modifier: { fontSize: 14, fontColor: '#9E9E9E' }
            Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`).fontSize(14).fontColor('#9E9E9E')
          }
        }.width(280).height(280)

        // === Blank ===
        // modifier: { layoutWeight: 1 }
        Blank().layoutWeight(1)

        // === Column ===
        // props: { space: 16, alignment: HorizontalAlign.Start }
        // modifier: { width: '100%', padding: { left: 24, right: 24 } }
        // children: 2
        Column({ space: 16 }) {
          // === Text ===
          // props: { text: 'Select Rhythm' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.SemiBold, fontColor: '#2D2D2D' }
          Text('Select Rhythm').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#2D2D2D')

          // === Flex ===
          // props: { justifyContent: FlexAlign.SpaceBetween }
          // modifier: { width: '100%' }
          // children: 3
          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            // === PatternCard ===
            // props: { pattern: this.patterns[0], isSelected: this.selectedPatternIndex === 0, onClick: () => { this.selectedPatternIndex = 0; this.stopBreathing(); } }
            PatternCard({ pattern: this.patterns[0], isSelected: this.selectedPatternIndex === 0, onClick: () => { this.selectedPatternIndex = 0; this.stopBreathing(); } })
            
            // === PatternCard ===
            // props: { pattern: this.patterns[1], isSelected: this.selectedPatternIndex === 1, onClick: () => { this.selectedPatternIndex = 1; this.stopBreathing(); } }
            PatternCard({ pattern: this.patterns[1], isSelected: this.selectedPatternIndex === 1, onClick: () => { this.selectedPatternIndex = 1; this.stopBreathing(); } })
            
            // === PatternCard ===
            // props: { pattern: this.patterns[2], isSelected: this.selectedPatternIndex === 2, onClick: () => { this.selectedPatternIndex = 2; this.stopBreathing(); } }
            PatternCard({ pattern: this.patterns[2], isSelected: this.selectedPatternIndex === 2, onClick: () => { this.selectedPatternIndex = 2; this.stopBreathing(); } })
          }.width('100%')
        }.width('100%').padding({ left: 24, right: 24 }).alignItems(HorizontalAlign.Start)

        // === Blank ===
        // modifier: { height: 32 }
        Blank().height(32)

        // === Button ===
        // modifier: { width: '100%', height: 64, backgroundColor: '#2D2D2D', borderRadius: 32, margin: { left: 32, right: 32, bottom: 32 } }
        // children: 1
        Button() {
          // === Row ===
          // props: { space: 8, verticalAlignment: VerticalAlign.Center }
          // modifier: { width: '100%', justifyContent: FlexAlign.Center }
          // children: 2
          Row({ space: 8 }) {
            // === Text ===
            // props: { text: this.isPlaying ? 'STOP SESSION' : 'START BREATHING' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, fontColor: '#FFFFFF', letterSpacing: 1 }
            Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#FFFFFF').letterSpacing(1)
            
            if (!this.isPlaying) {
              // === Image ===
              // modifier: { width: 20, height: 20, fontColor: '#FFFFFF' }
              Image($r('app.media.startIcon')).width(20).height(20).fillColor('#FFFFFF')
            }
          }.width('100%').justifyContent(FlexAlign.Center).verticalCenter()
        }
        .onClick(() => {
          this.toggleBreathing()
        })
        .width('100%')
        .height(64)
        .backgroundColor('#2D2D2D')
        .borderRadius(32)
        .margin({ left: 32, right: 32, bottom: 32 })
      }.width('100%').height('100%').backgroundColor('#FFFFFF')
    }.width('100%').height('100%')
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
    
    // Animate Scale
    animateTo({
      duration: this.currentPattern.inhale * 1000,
      curve: Curve.EaseInOut,
      iterations: -1,
      playMode: PlayMode.Alternate
    }, () => {
      this.scaleValue = 1.2
    })

    // Animate Rotation
    animateTo({
      duration: 20000,
      curve: Curve.Linear,
      iterations: -1,
      playMode: PlayMode.Normal
    }, () => {
      this.rotation = 360
    })
  }

  stopBreathing() {
    this.isPlaying = false
    
    animateTo({
      duration: 300,
      curve: Curve.EaseOut
    }, () => {
      this.scaleValue = 0.8
      this.rotation = 0
    })
  }
}

// MARK: - Components

interface BreathingPattern {
  name: string
  inhale: number
  exhale: number
}

@Component
struct BreathVisualizer {
  @Prop scale: number
  @Prop rotation: number

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Center }
    // modifier: { transform: { rotate: { angle: this.rotation } }, scaleEffect: { x: this.scale, y: this.scale } }
    // children: 10
    Stack({ alignContent: Alignment.Center }) {
      // === Circle ===
      // modifier: { width: 280, height: 280, fill: '#00897B', opacity: 0.1 }
      Circle().width(280).height(280).fill('#00897B').opacity(0.1)

      // === Circle ===
      // modifier: { width: 280, height: 280, stroke: '#00897B', strokeWidth: 2 }
      Circle().width(280).height(280).stroke('#00897B').strokeWidth(2)

      // === ForEach ===
      // props: { data: [0, 1, 2, 3, 4, 5, 6, 7] }
      ForEach([0, 1, 2, 3, 4, 5, 6, 7], (i: number) => {
        // === Stack ===
        // props: { alignContent: Alignment.Center }
        // modifier: { transform: { rotate: { angle: i * 45 } } }
        // children: 2
        Stack({ alignContent: Alignment.Center }) {
          // === Rectangle ===
          // modifier: { width: 140, height: 2, fill: '#00897B', opacity: 0.4, translate: { x: 70 } }
          Rect().width(140).height(2).fill('#00897B').opacity(0.4).translate({ x: 70 })
          
          // === Circle ===
          // modifier: { width: 6, height: 6, fill: '#00897B', translate: { x: 135 } }
          Circle().width(6).height(6).fill('#00897B').translate({ x: 135 })
        }.transform({ rotate: { angle: i * 45 } })
      })
    }
    .transform({ rotate: { angle: this.rotation } })
    .scale({ x: this.scale, y: this.scale })
  }
}

@Component
struct PatternCard {
  @Prop pattern: BreathingPattern
  @Prop isSelected: boolean
  @Prop onClick: () => void

  build() {
    // === Button ===
    // modifier: { width: 100, height: 90, borderRadius: 20, backgroundColor: this.isSelected ? '#F0FAF8' : '#F5F5F5', border: { width: this.isSelected ? 2 : 0, color: this.isSelected ? '#00897B' : '#FFFFFF', radius: 20 } }
    // children: 1
    Button() {
      // === Column ===
      // props: { space: 4, horizontalAlignment: HorizontalAlign.Center }
      // modifier: { width: '100%', height: '100%', justifyContent: FlexAlign.Center }
      // children: 2
      Column({ space: 4 }) {
        if (this.isSelected) {
          // === Text ===
          // props: { text: '✓' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, fontColor: '#00897B' }
          Text('✓').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#00897B')
        }

        // === Text ===
        // props: { text: this.pattern.name }
        // modifier: { fontSize: 14, fontWeight: FontWeight.Bold, fontColor: this.isSelected ? '#00897B' : '#2D2D2D' }
        Text(this.pattern.name).fontSize(14).fontWeight(FontWeight.Bold).fontColor(this.isSelected ? '#00897B' : '#2D2D2D')
      }.width('100%').height('100%').justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
    }
    .onClick(() => {
      this.onClick()
    })
    .width(100)
    .height(90)
    .borderRadius(20)
    .backgroundColor(this.isSelected ? '#F0FAF8' : '#F5F5F5')
    .border({ width: this.isSelected ? 2 : 0, color: this.isSelected ? '#00897B' : '#FFFFFF', radius: 20 })
  }
}