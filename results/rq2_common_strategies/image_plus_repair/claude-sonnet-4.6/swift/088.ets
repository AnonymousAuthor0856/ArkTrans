import animator, { AnimatorResult } from '@ohos.animator';

interface BreathingPattern {
  id: number;
  name: string;
  inhale: number;
  exhale: number;
}

@Entry
@Component
struct MainScreen {
  @State selectedPatternIndex: number = 0;
  @State isPlaying: boolean = false;
  @State vizScale: number = 0.8;
  @State vizRotation: number = 0;

  private scaleAnimator: AnimatorResult | null = null;
  private rotationAnimator: AnimatorResult | null = null;

  patterns: BreathingPattern[] = [
    { id: 0, name: 'Relax', inhale: 4, exhale: 6 },
    { id: 1, name: 'Balance', inhale: 5, exhale: 5 },
    { id: 2, name: 'Focus', inhale: 4, exhale: 4 }
  ];

  get currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex];
  }

  startBreathing() {
    this.isPlaying = true;

    this.scaleAnimator = animator.create({
      duration: this.currentPattern.inhale * 1000,
      easing: 'ease-in-out',
      delay: 0,
      fill: 'forwards',
      direction: 'alternate',
      iterations: -1,
      begin: 0.8,
      end: 1.2
    });
    this.scaleAnimator.onframe = (value: number) => {
      this.vizScale = value;
    };
    this.scaleAnimator.play();

    this.rotationAnimator = animator.create({
      duration: 8000,
      easing: 'linear',
      delay: 0,
      fill: 'forwards',
      direction: 'normal',
      iterations: -1,
      begin: 0,
      end: 360
    });
    this.rotationAnimator.onframe = (value: number) => {
      this.vizRotation = value;
    };
    this.rotationAnimator.play();
  }

  stopBreathing() {
    this.isPlaying = false;
    if (this.scaleAnimator) {
      this.scaleAnimator.cancel();
      this.scaleAnimator = null;
    }
    if (this.rotationAnimator) {
      this.rotationAnimator.cancel();
      this.rotationAnimator = null;
    }
    animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
      this.vizScale = 0.8;
      this.vizRotation = 0;
    });
  }

  toggleBreathing() {
    if (this.isPlaying) {
      this.stopBreathing();
    } else {
      this.startBreathing();
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Header
        Row() {
          Text('ZenBreather')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2D2D2D')
          Blank()
          Text('⚙')
            .fontSize(24)
            .fontColor('#888888')
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .margin({ top: 48 })

        // Visualizer
        Stack() {
          BreathVisualizerComponent({
            vizScale: this.vizScale,
            vizRotation: this.vizRotation
          })
            .width(280)
            .height(280)

          Column() {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#00897B')
            Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`)
              .fontSize(14)
              .fontColor('#888888')
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(280)
        .height(280)
        .margin({ top: 60 })

        Blank()

        // Pattern Selection
        Column({ space: 16 }) {
          Text('Select Rhythm')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2D2D2D')
            .alignSelf(ItemAlign.Start)

          Row() {
            ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
              PatternCardComponent({
                pattern: pattern,
                isSelected: index === this.selectedPatternIndex,
                onCardClick: () => {
                  this.selectedPatternIndex = index;
                  this.stopBreathing();
                }
              })
              if (index < this.patterns.length - 1) {
                Blank()
              }
            })
          }
          .width('100%')
        }
        .padding({ left: 24, right: 24 })
        .width('100%')

        // Control Button
        Button() {
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
        }
        .width('100%')
        .height(64)
        .backgroundColor('#2D2D2D')
        .borderRadius(32)
        .padding({ left: 32, right: 32 })
        .margin({ top: 32, bottom: 32, left: 32, right: 32 })
        .onClick(() => {
          this.toggleBreathing();
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct BreathVisualizerComponent {
  @Prop vizScale: number = 0.8;
  @Prop vizRotation: number = 0;

  build() {
    Stack() {
      // Outer faint circle fill
      Circle()
        .width(280)
        .height(280)
        .fill('rgba(0,137,123,0.1)')
        .scale({ x: this.vizScale, y: this.vizScale })

      // Stroke ring
      Circle()
        .width(276)
        .height(276)
        .stroke('#00897B')
        .strokeWidth(2)
        .fill('transparent')
        .scale({ x: this.vizScale, y: this.vizScale })

      // Spokes and dots
      Stack() {
        this.buildSpoke(0)
        this.buildSpoke(45)
        this.buildSpoke(90)
        this.buildSpoke(135)
        this.buildSpoke(180)
        this.buildSpoke(225)
        this.buildSpoke(270)
        this.buildSpoke(315)
      }
      .width(280)
      .height(280)
      .scale({ x: this.vizScale, y: this.vizScale })
    }
    .width(280)
    .height(280)
    .rotate({ angle: this.vizRotation })
  }

  @Builder
  buildSpoke(angle: number) {
    Stack() {
      Line()
        .width(140)
        .height(2)
        .startPoint([0, 1])
        .endPoint([140, 1])
        .stroke('rgba(0,137,123,0.4)')
        .strokeWidth(2)
        .offset({ x: 0, y: -1 })
        .rotate({ angle: angle, centerX: 0, centerY: 1 })
        .translate({ x: 140, y: 139 })

      Circle()
        .width(6)
        .height(6)
        .fill('#00897B')
        .translate({
          x: 140 + Math.cos(angle * Math.PI / 180) * 135 - 3,
          y: 140 + Math.sin(angle * Math.PI / 180) * 135 - 3
        })
    }
    .width(280)
    .height(280)
  }
}

@Component
struct PatternCardComponent {
  pattern: BreathingPattern = { id: 0, name: '', inhale: 0, exhale: 0 };
  isSelected: boolean = false;
  onCardClick: () => void = () => {};

  build() {
    Stack() {
      Column() {
        if (this.isSelected) {
          Text('✓')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#00897B')
        } else {
          Text(' ')
            .fontSize(16)
        }
        Text(this.pattern.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isSelected ? '#00897B' : '#2D2D2D')
          .margin({ top: 4 })
      }
      .width(100)
      .height(90)
      .borderRadius(20)
      .backgroundColor(this.isSelected ? 'rgba(0,137,123,0.05)' : '#F5F5F5')
      .border({
        width: this.isSelected ? 2 : 0,
        color: this.isSelected ? '#00897B' : 'transparent',
        radius: 20
      })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(100)
    .height(90)
    .onClick(() => {
      this.onCardClick();
    })
  }
}