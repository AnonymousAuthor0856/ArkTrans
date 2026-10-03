import { webview } from '@kit.ArkWeb'

// Interfaces for data structures
interface BreathingPattern {
  name: string
  inhale: number
  exhale: number
}

@Entry
@Component
struct ZenBreatherApp {
  @State isPlaying: boolean = false
  @State selectedPatternIndex: number = 0
  @State scaleValue: number = 1.0 // For visualizer scaling
  
  // Patterns Data
  private patterns: BreathingPattern[] = [
    { name: 'Relax', inhale: 4, exhale: 6 },
    { name: 'Balance', inhale: 5, exhale: 5 },
    { name: 'Focus', inhale: 4, exhale: 4 }
  ]

  build() {
    Column() {
      // === Header Section ===
      Row() {
        Text('ZenBreather')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(-1)
          .fontColor('#2D2D2D')
        
        Blank()
        
        // Settings Icon (Using a generic image resource as per rules)
        Image($r('app.media.startIcon')) 
          .width(24)
          .height(24)
          .fillColor('#808080') // Gray tint simulation
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48 })

      Spacer()
        .height('60vp')

      // === Visualizer Section ===
      Stack({ alignContent: Alignment.Center }) {
        // The Animated Circle Background
        this.BreathVisualizerComponent()

        // Center Text
        Column() {
          Text(this.isPlaying ? "Breathe" : "Ready")
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#00897B') // AccentTeal
          
          Text(`${this.patterns[this.selectedPatternIndex].inhale}s In / ${this.patterns[this.selectedPatternIndex].exhale}s Out`)
            .fontSize(14)
            .fontColor('#808080') // Gray
        }
      }
      .width(280)
      .height(280)

      Blank()

      // === Pattern Selection Section ===
      Text('Select Rhythm')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2D2D2D')
        .width('100%')
        .margin({ bottom: 16 })

      Row({ space: 12 }) {
        ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
          this.PatternCard(pattern, index === this.selectedPatternIndex, () => {
            this.selectedPatternIndex = index
            this.isPlaying = false
            this.scaleValue = 1.0 // Reset scale
          })
        })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      
      Spacer()
        .height('32vp')

      // === Bottom Control Bar ===
      Button() {
        Row() {
          Text(this.isPlaying ? "STOP SESSION" : "START BREATHING")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
            .fontColor(Color.White)
          
          if (!this.isPlaying) {
            Spacer()
              .width('8vp')
            // Play Icon Simulation
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .fillColor(Color.White)
          }
        }
      }
      .width('100%')
      .height(64)
      .backgroundColor('#2D2D2D')
      .borderRadius(32)
      .onClick(() => {
        this.isPlaying = !this.isPlaying
        if (this.isPlaying) {
          this.animateScale()
        } else {
          this.scaleValue = 1.0
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .padding({ left: 24, right: 24 })
  }

  // Helper to animate the scale value manually since ArkTS animations are property-based
  private animateScale(): void {
    let durationSum = this.patterns[this.selectedPatternIndex].inhale + this.patterns[this.selectedPatternIndex].exhale
    let totalMs = durationSum * 1000
    
    // Simple loop logic to simulate infinite repeatable tween
    // Note: In a real complex app, we might use AnimationProperty, but here we toggle state or use a simple transition
    // To mimic the "breathing" expansion/contraction continuously:
    
    // We will use a recursive timeout approach to keep it simple and compilable without external animation libraries
    let expanding = true
    
    const runAnimation = () => {
      if (!this.isPlaying) return;

      // Calculate target based on direction
      // Compose code: 0.8f <-> 1.2f
      let target = expanding ? 1.2 : 0.8
      
      // Animate using ArkUI's built-in animateTo
      animateTo({
        duration: (durationSum / 2) * 1000, // Half cycle time
        curve: Curve.EaseInOut
      }, () => {
        this.scaleValue = target
      }).then(() => {
        if (this.isPlaying) {
          expanding = !expanding
          runAnimation()
        }
      })
    }
    
    runAnimation()
  }

  @Builder
  BreathVisualizerComponent() {
    // Simulating the Canvas with Shapes for better performance and simpler code structure in ArkTS
    // Outer Ring
    Circle()
      .width(280)
      .height(280)
      .fill('#00897B') // AccentTeal
      .opacity(0.1)
    
    // Stroke Ring
    Circle()
      .width(280)
      .height(280)
      .fill('transparent')
      .stroke('#00897B')
      .strokeWidth(4)

    // Petals/Rays (Simulated with Lines)
    // We need 8 petals. 
    // Since we can't easily draw lines radiating from center in a declarative way without Canvas,
    // we will use rotated Lines centered in the stack.
    
    ForEach([0, 1, 2, 3, 4, 5, 6, 7], (index: number) => {
      Line()
        .width(100) // Approx radius length
        .height(2)
        .stroke('#00897B')
        .strokeOpacity(0.4)
        .lineCapStyle(LineCapStyle.Round)
        .rotate({ angle: index * 45 })
        
      // Dot at the end of the line
      Circle()
        .width(6)
        .height(6)
        .fill('#00897B')
        .position({ x: 0, y: -50 }) // Offset to match line end
        .rotate({ angle: index * 45 })
    })
  }

  @Builder
  PatternCard(pattern: BreathingPattern, isSelected: boolean, onClick: () => void) {
    Column() {
      if (isSelected) {
        // Checkmark Icon
        Image($r('app.media.startIcon')) // Reusing icon as checkmark placeholder
          .width(16)
          .height(16)
          .fillColor('#00897B')
          .margin({ bottom: 4 })
      }
      
      Text(pattern.name)
        .fontWeight(FontWeight.Bold)
        .fontSize(14)
        .fontColor(isSelected ? '#00897B' : '#2D2D2D')
      
      Text(`${pattern.inhale}-${pattern.exhale}`)
        .fontSize(12)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width(100)
    .height(90)
    .borderRadius(20)
    .backgroundColor(isSelected ? '#F0FAF9' : '#F5F5F5') // Light teal bg vs LightGray
    .border({ width: isSelected ? 2 : 0, color: '#00897B', radius: 20 })
    .onClick(onClick)
  }
}