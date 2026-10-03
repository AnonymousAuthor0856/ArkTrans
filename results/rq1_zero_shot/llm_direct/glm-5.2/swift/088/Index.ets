// ZenBreatherApp.ets
import { animateTo, Curves } from '@kit.ArkUI';

interface BreathingPattern {
  name: string;
  inhale: number;
  exhale: number;
}

@Entry
@Component
struct ZenBreatherApp {
  @State selectedPatternIndex: number = 0;
  @State isPlaying: boolean = false;
  @State scale: number = 0.8;
  @State rotation: number = 0;
  @State phase: number = 0; // 0: Ready, 1: Inhale, 2: Exhale
  private timerId: number = -1;
  private cycleStartTime: number = 0;

  patterns: BreathingPattern[] = [
    { name: "Relax", inhale: 4, exhale: 6 },
    { name: "Balance", inhale: 5, exhale: 5 },
    { name: "Focus", inhale: 4, exhale: 4 }
  ];

  get currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex];
  }

  get statusText(): string {
    if (!this.isPlaying) return "Ready";
    if (this.phase === 1) return "Breathe In";
    return "Breathe Out";
  }

  aboutToDisappear() {
    this.stopTimer();
  }

  stopTimer() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  toggleBreathing() {
    if (this.isPlaying) {
      this.stopBreathing();
    } else {
      this.startBreathing();
    }
  }

  startBreathing() {
    this.isPlaying = true;
    this.phase = 1;
    this.cycleStartTime = new Date().getTime();

    // Animate to full scale (Inhale)
    animateTo({
      duration: this.currentPattern.inhale * 1000,
      curve: Curves.EaseInOut,
      onFinish: () => {
        if (!this.isPlaying) return;
        this.phase = 2;
        // Animate back to normal scale (Exhale)
        animateTo({
          duration: this.currentPattern.exhale * 1000,
          curve: Curves.EaseInOut,
          onFinish: () => {
            if (this.isPlaying) {
              this.startBreathing(); // Loop
            }
          }
        }, () => {
          this.scale = 0.8;
        });
      }
    }, () => {
      this.scale = 1.2;
    });

    // Continuous rotation
    animateTo({
      duration: 20000, // 20 seconds for full rotation
      curve: Curves.Linear,
      iterations: -1 // Infinite
    }, () => {
      this.rotation = 360;
    });

    // Timer to update phase text precisely
    this.stopTimer();
    this.timerId = setInterval(() => {
      if (!this.isPlaying) return;
      const elapsed = (new Date().getTime() - this.cycleStartTime) / 1000;
      if (elapsed < this.currentPattern.inhale) {
        this.phase = 1;
      } else if (elapsed < this.currentPattern.inhale + this.currentPattern.exhale) {
        this.phase = 2;
      } else {
        this.cycleStartTime = new Date().getTime(); // Reset cycle
        this.phase = 1;
      }
    }, 100);
  }

  stopBreathing() {
    this.isPlaying = false;
    this.phase = 0;
    this.stopTimer();
    
    animateTo({ duration: 300, curve: Curves.EaseOut }, () => {
      this.scale = 0.8;
      this.rotation = 0;
    });
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Header
        Row() {
          Text("ZenBreather")
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2D2D2D')
          Blank()
          Text("⚙")
            .fontSize(24)
            .fontColor(Color.Gray)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .margin({ top: 48 })

        // Visualizer
        Stack() {
          this.BreathVisualizer(this.scale, this.rotation)
            .width(280)
            .height(280)

          Column() {
            Text(this.statusText)
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#00897B')
            Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`)
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ top: 4 })
          }
        }
        .layoutWeight(1)
        .width('100%')

        // Pattern Selection
        Column({ space: 16 }) {
          Text("Select Rhythm")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2D2D2D')
            .alignSelf(ItemAlign.Start)

          Row({ space: 12 }) {
            ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
              PatternCard({
                pattern: pattern,
                isSelected: index === this.selectedPatternIndex,
                onClick: () => {
                  this.selectedPatternIndex = index;
                  this.stopBreathing();
                }
              })
            })
          }
          .width('100%')
        }
        .padding({ left: 24, right: 24 })
        .margin({ bottom: 32 })

        // Control Button
        Button() {
          Row({ space: 8 }) {
            Text(this.isPlaying ? "STOP SESSION" : "START BREATHING")
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
            if (!this.isPlaying) {
              Text("▶")
                .fontSize(16)
            }
          }
          .width('100%')
          .height(64)
          .justifyContent(FlexAlign.Center)
        }
        .backgroundColor('#2D2D2D')
        .fontColor(Color.White)
        .borderRadius(32)
        .margin({ left: 32, right: 32, bottom: 32 })
        .onClick(() => this.toggleBreathing())
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  BreathVisualizer(scale: number, rotation: number) {
    Stack() {
      // Outer faint ring
      Circle()
        .width('100%')
        .height('100%')
        .fill('#1A00897B') // 10% opacity
        .scale({ x: scale, y: scale })

      // Stroke ring
      Circle()
        .width('100%')
        .height('100%')
        .fill(Color.Transparent)
        .stroke('#00897B')
        .strokeWidth(2)
        .scale({ x: scale, y: scale })

      // Petals / Spokes
      ForEach([0, 1, 2, 3, 4, 5, 6, 7], (i: number) => {
        // Spoke Line
        Row()
          .width(140)
          .height(2)
          .backgroundColor('#6600897B') // 40% opacity
          .position({ x: 0, y: 139 }) // Center vertically
          .scale({ x: scale, y: scale, centerX: 0, centerY: 0 })
          .rotate({ angle: i * 45 })

        // End Dot
        Circle()
          .width(6)
          .height(6)
          .fill('#00897B')
          .position({ x: 137, y: 137 }) // Center dot initially
          .scale({ x: scale, y: scale, centerX: 0, centerY: 0 })
          .rotate({ angle: i * 45 })
      })
    }
    .width(280)
    .height(280)
    .rotate({ angle: rotation })
  }
}

@Component
struct PatternCard {
  pattern: BreathingPattern;
  isSelected: boolean;
  onClick: () => void;

  build() {
    Button() {
      Stack() {
        // Background & Border
        Column()
          .width('100%')
          .height('100%')
          .borderRadius(20)
          .backgroundColor(this.isSelected ? '#0D00897B' : '#F5F5F5') // 5% opacity vs Light Gray
          .border({ width: 2, color: this.isSelected ? '#00897B' : Color.Transparent, radius: 20 })

        // Content
        Column({ space: 4 }) {
          if (this.isSelected) {
            Text("✓")
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#00897B')
          }
          Text(this.pattern.name)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isSelected ? '#00897B' : '#2D2D2D')
        }
        .justifyContent(FlexAlign.Center)
      }
      .width(100)
      .height(90)
    }
    .type(ButtonType.Capsule)
    .backgroundColor(Color.Transparent)
    .onClick(this.onClick)
  }
}