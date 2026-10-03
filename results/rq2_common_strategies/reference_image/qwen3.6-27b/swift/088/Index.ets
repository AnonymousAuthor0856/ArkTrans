import { web_webview } from '@kit.ArkWeb'

@Entry
@Component
struct ZenBreatherApp {
  @State selectedPatternIndex: number = 0
  @State isPlaying: boolean = false
  @State scale: number = 0.8
  @State rotation: number = 0.0
  
  private patterns: BreathingPattern[] = [
    { name: "Relax", inhale: 4, exhale: 6 },
    { name: "Balance", inhale: 5, exhale: 5 },
    { name: "Focus", inhale: 4, exhale: 4 }
  ]
  
  get currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex]
  }
  
  build() {
    Column() {
      // Header
      Row() {
        Text("ZenBreather")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2D2D2D')
        
        Image($r('app.media.ic_settings'))
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      
      Spacer().height(60)
      
      // Visualizer
      BreathVisualizer({
        scale: this.scale,
        rotation: this.rotation,
        isPlaying: this.isPlaying,
        pattern: this.currentPattern
      })
      .width(280)
      .height(280)
      
      Spacer()
      
      // Pattern Selection
      Column({ space: 16 }) {
        Text("Select Rhythm")
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#2D2D2D')
          .alignSelf(ItemAlign.Start)
        
        Row({ space: 12 }) {
          ForEach(this.patterns.map((p, i) => ({ ...p, index: i })), (pattern: any) => {
            PatternCard({
              pattern: pattern,
              isSelected: pattern.index === this.selectedPatternIndex,
              onClick: () => {
                this.selectedPatternIndex = pattern.index
                this.stopBreathing()
              }
            })
          })
        }
      }
      .padding({ left: 24, right: 24 })
      
      Spacer().height(32)
      
      // Control Button
      Button() {
        Row() {
          Text(this.isPlaying ? "STOP SESSION" : "START BREATHING")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
          
          if (!this.isPlaying) {
            Image($r('app.media.ic_play'))
              .width(20)
              .height(20)
              .margin({ left: 8 })
          }
        }
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(64)
      .backgroundColor('#2D2D2D')
      .borderRadius(32)
      .onClick(() => {
        this.toggleBreathing()
      })
      .margin({ left: 32, right: 32, bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
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
    
    // Scale animation
    animateTo({
      duration: this.currentPattern.inhale * 1000,
      curve: Curve.EaseInOut,
      iterations: -1,
      playMode: PlayMode.Normal
    }, () => {
      this.scale = 1.2
    })
    
    // Rotation animation
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
      this.scale = 0.8
      this.rotation = 0
    })
  }
}

interface BreathingPattern {
  name: string
  inhale: number
  exhale: number
}

@Component
struct BreathVisualizer {
  scale: number
  rotation: number
  isPlaying: boolean
  pattern: BreathingPattern
  
  build() {
    Stack() {
      // Outer faint ring
      Circle()
        .fill('#00897B').opacity(0.1)
        .scale({ x: this.scale, y: this.scale })
      
      // Stroke ring
      Circle()
        .stroke('#00897B', { width: 2 })
        .scale({ x: this.scale, y: this.scale })
      
      // Petals / Spokes
      ForEach(Array.from({ length: 8 }), (_, i) => {
        Column() {
          Rectangle()
            .fill('#00897B').opacity(0.4)
            .width(140)
            .height(2)
            .offset({ x: 70 })
          
          Circle()
            .fill('#00897B')
            .width(6)
            .height(6)
            .offset({ x: 135 })
        }
        .rotate({ angle: i * 45 })
        .scale({ x: this.scale, y: this.scale })
      })
      
      // Center text
      Column() {
        Text(this.isPlaying ? "Breathe" : "Ready")
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#00897B')
        
        Text(`${this.pattern.inhale}s In / ${this.pattern.exhale}s Out`)
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
      }
    }
    .width(280)
    .height(280)
    .rotate({ angle: this.rotation })
  }
}

@Component
struct PatternCard {
  pattern: BreathingPattern & { index: number }
  isSelected: boolean
  onClick: () => void
  
  build() {
    Button() {
      Column({ space: 4 }) {
        if (this.isSelected) {
          Image($r('app.media.ic_check'))
            .width(16)
            .height(16)
            .fillColor('#00897B')
        }
        
        Text(this.pattern.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isSelected ? '#00897B' : '#2D2D2D')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width(100)
    .height(90)
    .backgroundColor(this.isSelected ? '#00897B'.withOpacity(0.05) : '#F5F5F5')
    .borderRadius(20)
    .border({
      width: this.isSelected ? 2 : 0,
      color: this.isSelected ? '#00897B' : Color.Transparent
    })
    .onClick(this.onClick)
  }
}