import { curves } from '@kit.ArkUI';

// Colors
const PureWhite: string = '#FFFFFFFF';
const TextDark: string = '#FF2D2D2D';
const AccentTeal: string = '#FF00897B';
const LightGray: string = '#FFF5F5F5';

interface BreathingPatternData {
  name: string;
  inhale: number;
  exhale: number;
}

@Entry
@Component
struct MainScreen {
  @State selectedPatternIndex: number = 0;
  @State isPlaying: boolean = false;

  patterns: BreathingPatternData[] = [
    { name: 'Relax', inhale: 4, exhale: 6 },
    { name: 'Balance', inhale: 5, exhale: 5 },
    { name: 'Focus', inhale: 4, exhale: 4 }
  ];

  get currentPattern(): BreathingPatternData {
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
            .letterSpacing(-1)
            .fontColor(TextDark)

          Text('⚙')
            .fontSize(24)
            .fontColor('#FF9E9E9E')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Blank().height(60)

        // Visualizer Section
        Stack({ alignContent: Alignment.Center }) {
          BreathVisualizerComponent({
            isPlaying: this.isPlaying,
            durationSum: this.currentPattern.inhale + this.currentPattern.exhale
          })

          Column() {
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

        // Pattern Selection
        Text('Select Rhythm')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .fontColor(TextDark)

        Blank().height(16)

        Row() {
          ForEach(this.patterns, (pattern: BreathingPatternData, index: number) => {
            PatternCardComponent({
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

      // Bottom bar
      Row() {
        PlayPauseButtonComponent({
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

@Component
struct BreathVisualizerComponent {
  @Prop isPlaying: boolean = false;
  @Prop durationSum: number = 10;

  @State scaleValue: number = 1.0;
  @State rotationValue: number = 0;

  private scaleAnimating: boolean = false;
  private rotationAnimating: boolean = false;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  startAnimations() {
    if (this.isPlaying && !this.scaleAnimating) {
      this.scaleAnimating = true;
      this.animateScale(true);
    }
    if (this.isPlaying && !this.rotationAnimating) {
      this.rotationAnimating = true;
      this.animateRotation();
    }
  }

  animateScale(expanding: boolean) {
    if (!this.isPlaying) {
      this.scaleAnimating = false;
      animateTo({ duration: 300 }, () => {
        this.scaleValue = 1.0;
      });
      return;
    }
    const target = expanding ? 1.2 : 0.8;
    animateTo({
      duration: this.durationSum * 500,
      curve: Curve.EaseInOut,
      onFinish: () => {
        this.animateScale(!expanding);
      }
    }, () => {
      this.scaleValue = target;
    });
  }

  animateRotation() {
    if (!this.isPlaying) {
      this.rotationAnimating = false;
      return;
    }
    this.rotationValue = 0;
    animateTo({
      duration: 20000,
      curve: Curve.Linear,
      onFinish: () => {
        this.rotationValue = 0;
        if (this.isPlaying) {
          this.animateRotation();
        } else {
          this.rotationAnimating = false;
        }
      }
    }, () => {
      this.rotationValue = 360;
    });
  }

  drawCanvas() {
    const ctx = this.context;
    ctx.clearRect(0, 0, ctx.width, ctx.height);

    const centerX = ctx.width / 2;
    const centerY = ctx.height / 2;
    const radius = Math.min(ctx.width, ctx.height) / 2.5;

    // Outer circle fill
    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(0, 137, 123, 0.1)';
    ctx.fill();

    // Outer circle stroke
    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2);
    ctx.strokeStyle = AccentTeal;
    ctx.lineWidth = 4;
    ctx.stroke();

    // Petals
    const petalCount = 8;
    const angleStep = (2 * Math.PI) / petalCount;

    for (let i = 0; i < petalCount; i++) {
      const angle = i * angleStep;
      const endX = centerX + radius * 0.7 * Math.cos(angle);
      const endY = centerY + radius * 0.7 * Math.sin(angle);

      ctx.beginPath();
      ctx.moveTo(centerX, centerY);
      ctx.lineTo(endX, endY);
      ctx.strokeStyle = 'rgba(0, 137, 123, 0.4)';
      ctx.lineWidth = 2;
      ctx.lineCap = 'round';
      ctx.stroke();

      ctx.beginPath();
      ctx.arc(endX, endY, 6, 0, Math.PI * 2);
      ctx.fillStyle = AccentTeal;
      ctx.fill();
    }
  }

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .scale({ x: this.isPlaying ? this.scaleValue : 1.0, y: this.isPlaying ? this.scaleValue : 1.0 })
      .rotate({ angle: this.isPlaying ? this.rotationValue : 0 })
      .onReady(() => {
        this.drawCanvas();
      })
      .onAppear(() => {
        this.startAnimations();
      })
  }
}

@Component
struct PatternCardComponent {
  @Prop pattern: BreathingPatternData = { name: '', inhale: 0, exhale: 0 };
  @Prop isSelected: boolean = false;
  onCardClick: () => void = () => {};

  build() {
    Column() {
      if (this.isSelected) {
        Text('✓')
          .fontSize(16)
          .fontColor(AccentTeal)
        Blank().height(4)
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
    .backgroundColor(this.isSelected ? '#0D00897B' : LightGray)
    .border({
      width: 2,
      color: this.isSelected ? AccentTeal : Color.Transparent,
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
struct PlayPauseButtonComponent {
  @Prop isPlaying: boolean = false;
  onButtonClick: () => void = () => {};

  build() {
    Row() {
      Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .letterSpacing(1)

      if (!this.isPlaying) {
        Blank().width(8)
        Text('▶')
          .fontSize(20)
          .fontColor(Color.White)
      }
    }
    .height(64)
    .width('100%')
    .borderRadius(32)
    .backgroundColor(TextDark)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.onButtonClick();
    })
  }
}