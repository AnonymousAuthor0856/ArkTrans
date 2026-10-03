import curves from '@ohos.curves';

// Colors
const PureWhite: string = '#FFFFFFFF';
const TextDark: string = '#FF2D2D2D';
const AccentTeal: string = '#FF00897B';
const AccentTealLight: string = '#1A00897B';
const LightGray: string = '#FFF5F5F5';

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

@Component
struct BreathVisualizer {
  @Prop isPlaying: boolean = false;
  @Prop durationSum: number = 10;
  @State scaleValue: number = 1.0;
  @State rotationValue: number = 0;
  private scaleTimer: number = -1;
  private rotationTimer: number = -1;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear() {
    this.startAnimations();
  }

  aboutToDisappear() {
    if (this.scaleTimer !== -1) {
      clearInterval(this.scaleTimer);
    }
    if (this.rotationTimer !== -1) {
      clearInterval(this.rotationTimer);
    }
  }

  startAnimations() {
    // Rotation animation
    this.rotationTimer = setInterval(() => {
      if (this.isPlaying) {
        this.rotationValue = (this.rotationValue + 1) % 360;
      }
    }, 55); // ~360 degrees in 20 seconds

    // Scale animation using animateTo
    this.animateScale();
  }

  animateScale() {
    if (this.isPlaying) {
      animateTo({
        duration: this.durationSum * 500,
        curve: Curve.EaseInOut,
        iterations: -1,
        playMode: PlayMode.Alternate,
      }, () => {
        this.scaleValue = this.isPlaying ? 1.2 : 1.0;
      });
    } else {
      animateTo({
        duration: 300,
        curve: Curve.EaseInOut,
      }, () => {
        this.scaleValue = 1.0;
      });
    }
  }

  drawVisualizer() {
    const ctx = this.context;
    ctx.clearRect(0, 0, ctx.width, ctx.height);

    const centerX = ctx.width / 2;
    const centerY = ctx.height / 2;
    const radius = Math.min(ctx.width, ctx.height) / 2.5;

    // Draw filled circle
    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(0, 137, 123, 0.1)';
    ctx.fill();

    // Draw outer ring
    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2);
    ctx.strokeStyle = AccentTeal;
    ctx.lineWidth = 4;
    ctx.stroke();

    // Draw petals
    const petalCount = 8;
    const angleStep = (Math.PI * 2) / petalCount;
    const rotRad = (this.rotationValue * Math.PI) / 180;

    for (let i = 0; i < petalCount; i++) {
      const angle = i * angleStep + rotRad;
      const endX = centerX + radius * 0.7 * Math.cos(angle);
      const endY = centerY + radius * 0.7 * Math.sin(angle);

      // Draw line
      ctx.beginPath();
      ctx.moveTo(centerX, centerY);
      ctx.lineTo(endX, endY);
      ctx.strokeStyle = 'rgba(0, 137, 123, 0.4)';
      ctx.lineWidth = 2;
      ctx.lineCap = 'round';
      ctx.stroke();

      // Draw dot
      ctx.beginPath();
      ctx.arc(endX, endY, 6, 0, Math.PI * 2);
      ctx.fillStyle = AccentTeal;
      ctx.fill();
    }
  }

  build() {
    Stack() {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawVisualizer();
        })
        .scale({ x: this.scaleValue, y: this.scaleValue })
        .rotate({ angle: this.rotationValue })

      Column() {
        Text(this.isPlaying ? 'Breathe' : 'Ready')
          .fontSize(24)
          .fontColor(AccentTeal)
          .fontWeight(FontWeight.Medium)
        Text(`${this.durationSum > 9 ? Math.floor(this.durationSum / 2) : 4}s In / ${this.durationSum > 9 ? Math.ceil(this.durationSum / 2) : 6}s Out`)
          .fontSize(14)
          .fontColor('#FF888888')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(280)
    .height(280)
    .alignContent(Alignment.Center)
  }
}

@Component
struct PatternCard {
  @Prop pattern: BreathingPattern = new BreathingPattern('Relax', 4, 6);
  @Prop isSelected: boolean = false;
  onCardClick: () => void = () => {};

  build() {
    Column() {
      if (this.isSelected) {
        Text('✓')
          .fontSize(14)
          .fontColor(AccentTeal)
          .fontWeight(FontWeight.Bold)
        Blank().height(4)
      }
      Text(this.pattern.name)
        .fontWeight(FontWeight.Bold)
        .fontSize(14)
        .fontColor(this.isSelected ? AccentTeal : TextDark)
      Text(`${this.pattern.inhale}-${this.pattern.exhale}`)
        .fontSize(12)
        .fontColor('#FF888888')
    }
    .width(100)
    .height(90)
    .borderRadius(20)
    .backgroundColor(this.isSelected ? '#0D00897B' : LightGray)
    .border({
      width: 2,
      color: this.isSelected ? AccentTeal : '#00000000',
      radius: 20
    })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .padding(12)
    .onClick(() => {
      this.onCardClick();
    })
  }
}

@Component
struct PlayPauseButton {
  @Prop isPlaying: boolean = false;
  onButtonClick: () => void = () => {};

  build() {
    Button() {
      Row() {
        Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .letterSpacing(1)
        if (!this.isPlaying) {
          Blank().width(8)
          Text('▶')
            .fontSize(16)
            .fontColor(Color.White)
        }
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(64)
    .borderRadius(32)
    .backgroundColor(TextDark)
    .onClick(() => {
      this.onButtonClick();
    })
  }
}

@Entry
@Component
struct MainScreen {
  @State selectedPatternIndex: number = 0;
  @State isPlaying: boolean = false;
  private patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ];

  getCurrentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex];
  }

  build() {
    Column() {
      // Main content
      Column() {
        // Spacer
        Blank().height(48)

        // Header
        Row() {
          Text('ZenBreather')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(TextDark)
            .letterSpacing(-1)
          Blank()
          Text('⚙')
            .fontSize(24)
            .fontColor('#FF888888')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Blank().height(60)

        // Visualizer
        Stack() {
          BreathVisualizer({
            isPlaying: this.isPlaying,
            durationSum: this.getCurrentPattern().totalDuration
          })

          Column() {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontSize(24)
              .fontColor(AccentTeal)
              .fontWeight(FontWeight.Medium)
            Text(`${this.getCurrentPattern().inhale}s In / ${this.getCurrentPattern().exhale}s Out`)
              .fontSize(14)
              .fontColor('#FF888888')
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(280)
        .height(280)
        .alignContent(Alignment.Center)

        Blank().layoutWeight(1)

        // Pattern Selection Label
        Text('Select Rhythm')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
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
              onCardClick: () => {
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
          onButtonClick: () => {
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