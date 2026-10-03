import { curves } from '@kit.ArkUI';

// --------------------------------------------------------------------------------
// Theme & Colors
// --------------------------------------------------------------------------------

const PureWhite: string = '#FFFFFFFF';
const TextDark: string = '#FF2D2D2D';
const AccentTeal: string = '#FF00897B';
const AccentTealLight: string = '#1A00897B';
const LightGray: string = '#FFF5F5F5';

// --------------------------------------------------------------------------------
// Data Model
// --------------------------------------------------------------------------------

class BreathingPattern {
  name: string;
  inhale: number;
  exhale: number;

  constructor(name: string, inhale: number, exhale: number) {
    this.name = name;
    this.inhale = inhale;
    this.exhale = exhale;
  }

  get totalDuration(): number {
    return this.inhale + this.exhale;
  }
}

// --------------------------------------------------------------------------------
// BreathVisualizer Component
// --------------------------------------------------------------------------------

@Component
struct BreathVisualizer {
  @Prop isPlaying: boolean = false;
  @Prop durationSum: number = 10;

  @State scale: number = 1.0;
  @State rotation: number = 0;

  private scaleAnimator: AnimatorResult | null = null;
  private rotationAnimator: AnimatorResult | null = null;

  aboutToAppear() {
    this.setupAnimators();
  }

  aboutToDisappear() {
    this.scaleAnimator?.cancel();
    this.rotationAnimator?.cancel();
  }

  setupAnimators() {
    this.scaleAnimator = animator.create({
      duration: this.durationSum * 1000,
      easing: 'fast-out-slow-in',
      delay: 0,
      fill: 'forwards',
      direction: 'alternate',
      iterations: -1,
      begin: 0.8,
      end: 1.2
    });

    this.scaleAnimator.onFrame = (value: number) => {
      this.scale = value;
    };

    this.rotationAnimator = animator.create({
      duration: 20000,
      easing: 'linear',
      delay: 0,
      fill: 'forwards',
      direction: 'normal',
      iterations: -1,
      begin: 0,
      end: 360
    });

    this.rotationAnimator.onFrame = (value: number) => {
      this.rotation = value;
    };
  }

  onPlayingChanged() {
    if (this.isPlaying) {
      this.scaleAnimator?.play();
      this.rotationAnimator?.play();
    } else {
      this.scaleAnimator?.cancel();
      this.rotationAnimator?.cancel();
      this.scale = 1.0;
      this.rotation = 0;
    }
  }

  build() {
    Canvas(new RenderingContextSettings(true))
      .width('100%')
      .height('100%')
      .rotate({ angle: this.isPlaying ? this.rotation : 0 })
      .scale({ x: this.isPlaying ? this.scale : 1.0, y: this.isPlaying ? this.scale : 1.0 })
      .onReady((context: CanvasRenderingContext2D) => {
        this.drawVisualizer(context);
      })
      .onChange((context: CanvasRenderingContext2D) => {
        this.drawVisualizer(context);
      })
  }

  drawVisualizer(context: CanvasRenderingContext2D) {
    const width = context.width;
    const height = context.height;
    const centerX = width / 2;
    const centerY = height / 2;
    const radius = Math.min(width, height) / 2.5;

    context.clearRect(0, 0, width, height);

    // Outer fill circle
    context.beginPath();
    context.arc(centerX, centerY, radius, 0, Math.PI * 2);
    context.fillStyle = 'rgba(0, 137, 123, 0.1)';
    context.fill();

    // Outer stroke circle
    context.beginPath();
    context.arc(centerX, centerY, radius, 0, Math.PI * 2);
    context.strokeStyle = AccentTeal;
    context.lineWidth = 4;
    context.stroke();

    // Petals
    const petalCount = 8;
    const angleStep = (2 * Math.PI) / petalCount;

    for (let i = 0; i < petalCount; i++) {
      const angle = i * angleStep;
      const endX = centerX + radius * 0.7 * Math.cos(angle);
      const endY = centerY + radius * 0.7 * Math.sin(angle);

      // Line from center
      context.beginPath();
      context.moveTo(centerX, centerY);
      context.lineTo(endX, endY);
      context.strokeStyle = 'rgba(0, 137, 123, 0.4)';
      context.lineWidth = 2;
      context.lineCap = 'round';
      context.stroke();

      // Dot at end
      context.beginPath();
      context.arc(endX, endY, 6, 0, Math.PI * 2);
      context.fillStyle = AccentTeal;
      context.fill();
    }
  }
}

// --------------------------------------------------------------------------------
// PatternCard Component
// --------------------------------------------------------------------------------

@Component
struct PatternCard {
  @Prop pattern: BreathingPattern = new BreathingPattern('', 0, 0);
  @Prop isSelected: boolean = false;
  onClick: () => void = () => {};

  build() {
    Column({ space: 4 }) {
      if (this.isSelected) {
        Text('✓')
          .fontSize(16)
          .fontColor(AccentTeal)
          .fontWeight(FontWeight.Bold)
      }
      Text(this.pattern.name)
        .fontWeight(FontWeight.Bold)
        .fontSize(14)
        .fontColor(this.isSelected ? AccentTeal : TextDark)
      Text(`${this.pattern.inhale}-${this.pattern.exhale}`)
        .fontSize(12)
        .fontColor('#FF9E9E9E')
    }
    .width(100)
    .height(90)
    .borderRadius(20)
    .backgroundColor(this.isSelected ? AccentTealLight : LightGray)
    .border({
      width: 2,
      color: this.isSelected ? AccentTeal : Color.Transparent,
      radius: 20
    })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(12)
    .onClick(() => {
      this.onClick();
    })
  }
}

// --------------------------------------------------------------------------------
// PlayPauseButton Component
// --------------------------------------------------------------------------------

@Component
struct PlayPauseButton {
  @Prop isPlaying: boolean = false;
  onClick: () => void = () => {};

  build() {
    Button({ type: ButtonType.Normal }) {
      Row({ space: 8 }) {
        Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .letterSpacing(1)
        if (!this.isPlaying) {
          Text('▶')
            .fontSize(20)
            .fontColor(Color.White)
        }
      }
      .alignItems(VerticalAlign.Center)
    }
    .height(64)
    .width('100%')
    .borderRadius(32)
    .backgroundColor(TextDark)
    .shadow({ radius: 0, color: Color.Transparent })
    .onClick(() => {
      this.onClick();
    })
  }
}

// --------------------------------------------------------------------------------
// Main Screen
// --------------------------------------------------------------------------------

@Component
struct MainScreen {
  @State selectedPatternIndex: number = 0;
  @State isPlaying: boolean = false;

  private patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ];

  get currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex];
  }

  build() {
    Column() {
      // Content
      Column({ space: 0 }) {
        // Spacer top
        Blank().height(48)

        // Header
        Row() {
          Text('ZenBreather')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(TextDark)
            .letterSpacing(-1)
          Text('⚙')
            .fontSize(24)
            .fontColor('#FF9E9E9E')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Blank().height(60)

        // Visualizer
        Stack({ alignContent: Alignment.Center }) {
          BreathVisualizer({
            isPlaying: this.isPlaying,
            durationSum: this.currentPattern.totalDuration
          })
            .width(280)
            .height(280)

          Column({ space: 4 }) {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontSize(24)
              .fontColor(AccentTeal)
              .fontWeight(FontWeight.Medium)
            Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`)
              .fontSize(14)
              .fontColor('#FF9E9E9E')
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(280)
        .height(280)

        Blank().layoutWeight(1)

        // Pattern Selection Label
        Text('Select Rhythm')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(TextDark)
          .width('100%')
          .textAlign(TextAlign.Start)

        Blank().height(16)

        // Pattern Cards
        Row() {
          ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
            PatternCard({
              pattern: pattern,
              isSelected: index === this.selectedPatternIndex,
              onClick: () => {
                this.selectedPatternIndex = index;
                this.isPlaying = false;
              }
            })
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Blank().height(32)
      }
      .layoutWeight(1)
      .padding({ left: 24, right: 24 })
      .width('100%')

      // Bottom Bar
      Row() {
        PlayPauseButton({
          isPlaying: this.isPlaying,
          onClick: () => {
            this.isPlaying = !this.isPlaying;
          }
        })
      }
      .width('100%')
      .padding(32)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PureWhite)
  }
}

// --------------------------------------------------------------------------------
// Entry Point
// --------------------------------------------------------------------------------

@Entry
@Component
struct Index {
  build() {
    MainScreen()
  }
}