// Index.ets
interface BreathingPattern {
  name: string;
  inhale: number;
  exhale: number;
  totalDuration: number;
}

@Entry
@Component
struct MainScreen {
  @State selectedPatternIndex: number = 0;
  @State isPlaying: boolean = false;
  @State scale: number = 1.0;
  @State rotation: number = 0;
  private intervalId: number = -1;
  private patterns: BreathingPattern[] = [
    { name: 'Relax', inhale: 4, exhale: 6, totalDuration: 10 },
    { name: 'Balance', inhale: 5, exhale: 5, totalDuration: 10 },
    { name: 'Focus', inhale: 4, exhale: 4, totalDuration: 8 }
  ];

  get currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex];
  }

  togglePlaying() {
    this.isPlaying = !this.isPlaying;
    if (this.isPlaying) {
      this.startAnimation();
    } else {
      this.stopAnimation();
    }
  }

  startAnimation() {
    this.stopAnimation();
    const duration = this.currentPattern.totalDuration * 1000;
    const startTime = Date.now();
    this.intervalId = setInterval(() => {
      const elapsed = Date.now() - startTime;
      const progress = (elapsed % duration) / duration;
      // Smooth scale animation using sine wave
      this.scale = 0.8 + 0.4 * (0.5 - 0.5 * Math.cos(progress * 2 * Math.PI));
      // Continuous rotation
      this.rotation = (elapsed / 20000) * 360 % 360;
    }, 16);
  }

  stopAnimation() {
    if (this.intervalId !== -1) {
      clearInterval(this.intervalId);
      this.intervalId = -1;
    }
    this.scale = 1.0;
    this.rotation = 0;
  }

  selectPattern(index: number) {
    this.selectedPatternIndex = index;
    this.isPlaying = false;
    this.stopAnimation();
  }

  build() {
    Column() {
      // Header
      Row() {
        Text('ZenBreather')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(-1)
        Blank()
        Text('⚙')
          .fontSize(24)
          .fontColor('#9E9E9E')
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48 })

      // Visualizer Section
      Stack({ alignContent: Alignment.Center }) {
        // Canvas for drawing shapes
        Canvas(this)
          .width('100%')
          .height(280)
          .scale({ x: this.scale, y: this.scale })
          .rotate({ angle: this.rotation })
          .onReady((context: CanvasRenderingContext2D) => {
            this.drawVisualizer(context);
          })

        // Text inside the circle
        Column() {
          Text(this.isPlaying ? 'Breathe' : 'Ready')
            .fontSize(24)
            .fontColor('#00897B')
            .fontWeight(FontWeight.Medium)
          Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`)
            .fontSize(14)
            .fontColor('#9E9E9E')
        }
      }
      .width('100%')
      .height(280)
      .margin({ top: 60 })

      // Spacer
      Blank()

      // Pattern Selection
      Text('Select Rhythm')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .padding({ left: 24, right: 24 })

      Row() {
        ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
          PatternCard({
            pattern: pattern,
            isSelected: index === this.selectedPatternIndex,
            onClick: () => { this.selectPattern(index); }
          })
        })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .margin({ top: 16 })
      .justifyContent(FlexAlign.SpaceBetween)

      // Bottom Control Bar
      Row() {
        PlayPauseButton({
          isPlaying: this.isPlaying,
          onClick: () => { this.togglePlaying(); }
        })
      }
      .width('100%')
      .padding(32)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  drawVisualizer(context: CanvasRenderingContext2D) {
    const w = 280; // Match height
    const h = 280;
    const center = { x: w / 2, y: h / 2 };
    const radius = Math.min(w, h) / 2.5;

    // Outer translucent circle
    context.beginPath();
    context.arc(center.x, center.y, radius, 0, 2 * Math.PI);
    context.fillStyle = 'rgba(0, 137, 123, 0.1)';
    context.fill();

    // Outer stroke circle
    context.beginPath();
    context.arc(center.x, center.y, radius, 0, 2 * Math.PI);
    context.strokeStyle = '#00897B';
    context.lineWidth = 4;
    context.stroke();

    // Petals
    const petalCount = 8;
    const angleStep = 360 / petalCount;
    for (let i = 0; i < petalCount; i++) {
      const angle = i * angleStep;
      const rad = angle * Math.PI / 180;
      const endX = center.x + radius * 0.7 * Math.cos(rad);
      const endY = center.y + radius * 0.7 * Math.sin(rad);

      // Line
      context.beginPath();
      context.moveTo(center.x, center.y);
      context.lineTo(endX, endY);
      context.strokeStyle = 'rgba(0, 137, 123, 0.4)';
      context.lineWidth = 2;
      context.lineCap = 'round';
      context.stroke();

      // Dot
      context.beginPath();
      context.arc(endX, endY, 6, 0, 2 * Math.PI);
      context.fillStyle = '#00897B';
      context.fill();
    }
  }
}

@Component
struct PatternCard {
  @Prop pattern: BreathingPattern;
  @Prop isSelected: boolean;
  private onClick: () => void = () => {};

  build() {
    Column() {
      if (this.isSelected) {
        Text('✓')
          .fontSize(16)
          .fontColor('#00897B')
          .margin({ bottom: 4 })
      }
      Text(this.pattern.name)
        .fontWeight(FontWeight.Bold)
        .fontSize(14)
        .fontColor(this.isSelected ? '#00897B' : '#2D2D2D')
      Text(`${this.pattern.inhale}-${this.pattern.exhale}`)
        .fontSize(12)
        .fontColor('#9E9E9E')
    }
    .width(100)
    .height(90)
    .borderRadius(20)
    .backgroundColor(this.isSelected ? 'rgba(0, 137, 123, 0.05)' : '#F5F5F5')
    .border({ width: 2, color: this.isSelected ? '#00897B' : 'transparent' })
    .onClick(() => {
      this.onClick();
    })
    .padding(12)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct PlayPauseButton {
  @Prop isPlaying: boolean;
  private onClick: () => void = () => {};

  build() {
    Row() {
      Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .letterSpacing(1)
        .fontColor('#FFFFFF')
      if (!this.isPlaying) {
        Text('▶')
          .fontSize(20)
          .fontColor('#FFFFFF')
          .margin({ left: 8 })
      }
    }
    .width('100%')
    .height(64)
    .borderRadius(32)
    .backgroundColor('#2D2D2D')
    .onClick(() => {
      this.onClick();
    })
    .justifyContent(FlexAlign.Center)
  }
}