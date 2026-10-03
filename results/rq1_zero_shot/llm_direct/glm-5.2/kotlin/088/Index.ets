// index.ets
interface BreathingPattern {
  name: string;
  inhale: number;
  exhale: number;
  totalDuration: number;
}

const PATTERNS: BreathingPattern[] = [
  { name: "Relax", inhale: 4, exhale: 6, totalDuration: 10 },
  { name: "Balance", inhale: 5, exhale: 5, totalDuration: 10 },
  { name: "Focus", inhale: 4, exhale: 4, totalDuration: 8 }
];

@Entry
@Component
struct Index {
  @State selectedPatternIndex: number = 0;
  @State isPlaying: boolean = false;
  @State scale: number = 1.0;
  @State rotation: number = 0;

  // Animation references
  scaleAnimId: number = -1;
  rotationAnimId: number = -1;

  get currentPattern(): BreathingPattern {
    return PATTERNS[this.selectedPatternIndex];
  }

  aboutToDisappear() {
    this.stopAnimations();
  }

  stopAnimations() {
    if (this.scaleAnimId !== -1) {
      animatorUtils.stopAnimator(this.scaleAnimId);
      this.scaleAnimId = -1;
    }
    if (this.rotationAnimId !== -1) {
      animatorUtils.stopAnimator(this.rotationAnimId);
      this.rotationAnimId = -1;
    }
  }

  togglePlaying() {
    this.isPlaying = !this.isPlaying;
    if (this.isPlaying) {
      this.startAnimations();
    } else {
      this.stopAnimations();
      // Reset visual state
      this.scale = 1.0;
      this.rotation = 0;
    }
  }

  startAnimations() {
    this.stopAnimations();

    // Scale Animation
    const scaleAnimator = animatorUtils.createAnimator({
      duration: this.currentPattern.totalDuration * 1000,
      easing: "ease-in-out",
      delay: 0,
      fill: "forwards",
      iterations: -1,
      begin: 0.8,
      end: 1.2
    });
    scaleAnimator.onframe = (progress: number) => {
      // Reverse mode simulation
      const reverseProgress = progress > 0.5 ? (1.0 - progress) * 2 : progress * 2;
      this.scale = 0.8 + (1.2 - 0.8) * reverseProgress;
    };
    scaleAnimator.play();
    this.scaleAnimId = scaleAnimator.id;

    // Rotation Animation
    const rotationAnimator = animatorUtils.createAnimator({
      duration: 20000,
      easing: "linear",
      delay: 0,
      fill: "forwards",
      iterations: -1,
      begin: 0,
      end: 360
    });
    rotationAnimator.onframe = (progress: number) => {
      this.rotation = 360 * progress;
    };
    rotationAnimator.play();
    this.rotationAnimId = rotationAnimator.id;
  }

  selectPattern(index: number) {
    this.selectedPatternIndex = index;
    this.stopAnimations();
    this.isPlaying = false;
    this.scale = 1.0;
    this.rotation = 0;
  }

  build() {
    Column() {
      // Main Content Area
      Column() {
        // Header
        Row() {
          Text("ZenBreather")
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2D2D2D')
            .layoutWeight(1)

          Image($r('sys.media.ohos_ic_public_settings'))
            .width(24)
            .height(24)
            .fillColor('#888888')
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 48 })

        // Visualizer Section
        Stack() {
          // Canvas Visualizer
          Canvas() {
            this.drawBreathVisualizer();
          }
          .width(280)
          .height(280)
          .scale({
            x: this.isPlaying ? this.scale : 1.0,
            y: this.isPlaying ? this.scale : 1.0,
            centerX: '50%',
            centerY: '50%'
          })
          .rotate({
            z: this.isPlaying ? this.rotation : 0,
            centerX: '50%',
            centerY: '50%'
          })

          // Center Text
          Column() {
            Text(this.isPlaying ? "Breathe" : "Ready")
              .fontSize(24)
              .fontColor('#00897B')
              .fontWeight(FontWeight.Medium)
            Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`)
              .fontSize(14)
              .fontColor('#888888')
              .margin({ top: 4 })
          }
        }
        .width(280)
        .height(280)
        .margin({ top: 60 })

        // Spacer
        Blank().layoutWeight(1)

        // Pattern Selection
        Text("Select Rhythm")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2D2D2D')
          .width('100%')
          .padding({ left: 24, right: 24 })

        Row() {
          ForEach(PATTERNS, (pattern: BreathingPattern, index: number) => {
            this.PatternCard(pattern, index)
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 24, right: 24, top: 16 })

      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      // Bottom Control Bar
      Row() {
        Button(this.isPlaying ? "STOP SESSION" : "START BREATHING")
          .type(ButtonType.Normal)
          .backgroundColor('#2D2D2D')
          .fontColor('#FFFFFF')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .height(64)
          .borderRadius(32)
          .onClick(() => this.togglePlaying())
      }
      .width('100%')
      .padding({ left: 32, right: 32, bottom: 32, top: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  PatternCard(pattern: BreathingPattern, index: number) {
    Column() {
      if (index === this.selectedPatternIndex) {
        Text("✓")
          .fontSize(16)
          .fontColor('#00897B')
          .margin({ bottom: 4 })
      }
      Text(pattern.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(index === this.selectedPatternIndex ? '#00897B' : '#2D2D2D')
      Text(`${pattern.inhale}-${pattern.exhale}`)
        .fontSize(12)
        .fontColor('#888888')
        .margin({ top: 2 })
    }
    .width(100)
    .height(90)
    .borderRadius(20)
    .backgroundColor(index === this.selectedPatternIndex ? 'rgba(0, 137, 123, 0.05)' : '#F5F5F5')
    .border({
      width: 2,
      color: index === this.selectedPatternIndex ? '#00897B' : 'transparent',
      radius: 20
    })
    .justifyContent(FlexAlign.Center)
    .onClick(() => this.selectPattern(index))
  }

  drawBreathVisualizer() {
    const ctx = this.getCanvasContext();
    if (!ctx) return;

    const width = 280;
    const height = 280;
    const center = { x: width / 2, y: height / 2 };
    const radius = Math.min(width, height) / 2.5;

    // Clear canvas
    ctx.clearRect(0, 0, width, height);

    // Draw outer filled circle
    ctx.fillStyle = 'rgba(0, 137, 123, 0.1)';
    ctx.beginPath();
    ctx.arc(center.x, center.y, radius, 0, 2 * Math.PI);
    ctx.fill();

    // Draw outer stroked circle
    ctx.strokeStyle = '#00897B';
    ctx.lineWidth = 4;
    ctx.beginPath();
    ctx.arc(center.x, center.y, radius, 0, 2 * Math.PI);
    ctx.stroke();

    // Draw petals
    const petalCount = 8;
    const angleStep = 360 / petalCount;

    for (let i = 0; i < petalCount; i++) {
      const angle = i * angleStep;
      const rad = (angle * Math.PI) / 180;
      const endX = center.x + radius * 0.7 * Math.cos(rad);
      const endY = center.y + radius * 0.7 * Math.sin(rad);

      // Draw line
      ctx.strokeStyle = 'rgba(0, 137, 123, 0.4)';
      ctx.lineWidth = 2;
      ctx.lineCap = 'round';
      ctx.beginPath();
      ctx.moveTo(center.x, center.y);
      ctx.lineTo(endX, endY);
      ctx.stroke();

      // Draw dot at end
      ctx.fillStyle = '#00897B';
      ctx.beginPath();
      ctx.arc(endX, endY, 6, 0, 2 * Math.PI);
      ctx.fill();
    }
  }
}