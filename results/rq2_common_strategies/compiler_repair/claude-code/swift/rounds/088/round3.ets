import prompt from '@ohos.promptAction';

@Entry
@Component
struct ZenBreatherApp {
  build() {
    Column() {
      MainScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

class Theme {
  static readonly pureWhite: string = '#FFFFFF';
  static readonly textDark: string = '#2D2D2D';
  static readonly accentTeal: string = '#00897B';
  static readonly lightGray: string = '#F5F5F5';
  static readonly textGray: string = '#8E8E93';
}

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
  @Link breathScale: number;
  @Link breathRotation: number;

  build() {
    Stack() {
      Circle()
        .fill(Theme.accentTeal + '1A')
        .width(280)
        .height(280)
        .scale({ x: this.breathScale, y: this.breathScale })

      Circle()
        .stroke(Theme.accentTeal)
        .strokeWidth(2)
        .width(280)
        .height(280)
        .scale({ x: this.breathScale, y: this.breathScale })

      ForEach([0, 1, 2, 3, 4, 5, 6, 7], (i: number) => {
        Stack() {
          Rect()
            .fill(Theme.accentTeal + '66')
            .width(140)
            .height(2)
            .translate({ x: 70 })

          Circle()
            .fill(Theme.accentTeal)
            .width(6)
            .height(6)
            .translate({ x: 135, y: -2 })
        }
        .width(280)
        .height(280)
        .rotate({ angle: i * 45, centerX: '50%', centerY: '50%' })
        .scale({ x: this.breathScale, y: this.breathScale })
      }, (i: number) => i.toString())
    }
    .width(280)
    .height(280)
    .rotate({ angle: this.breathRotation, centerX: '50%', centerY: '50%' })
  }
}

@Component
struct PatternCard {
  patternItem: BreathingPattern = new BreathingPattern('', 0, 0);
  isSelected: boolean = false;
  onCardClick: (() => void) | null = null;

  build() {
    Column() {
      if (this.isSelected) {
        Text('✓')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Theme.accentTeal)
          .margin({ bottom: 4 })
      } else {
        Text('')
          .fontSize(16)
          .margin({ bottom: 4 })
      }

      Text(this.patternItem.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isSelected ? Theme.accentTeal : Theme.textDark)
    }
    .width(100)
    .height(90)
    .justifyContent(FlexAlign.Center)
    .borderRadius(20)
    .backgroundColor(this.isSelected ? Theme.accentTeal + '0D' : Theme.lightGray)
    .border({
      width: 2,
      color: this.isSelected ? Theme.accentTeal : 'transparent',
      radius: 20
    })
    .onClick(() => {
      if (this.onCardClick) {
        this.onCardClick();
      }
    })
  }
}

@Component
struct MainScreen {
  @State selectedPatternIndex: number = 0;
  @State isPlaying: boolean = false;
  @State breathScale: number = 0.8;
  @State breathRotation: number = 0;

  private patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ];

  private get currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex];
  }

  aboutToDisappear() {
    this.stopAnimations();
  }

  private startBreathing(): void {
    this.isPlaying = true;
    this.startScaleAnimation();
    this.startRotationAnimation();
  }

  private startScaleAnimation(): void {
    const inhaleDuration = this.currentPattern.inhale * 1000;
    const exhaleDuration = this.currentPattern.exhale * 1000;

    const animateInhale = () => {
      if (!this.isPlaying) return;
      animateTo({
        duration: inhaleDuration,
        curve: Curve.EaseInOut,
        onFinish: () => {
          if (!this.isPlaying) return;
          animateTo({
            duration: exhaleDuration,
            curve: Curve.EaseInOut,
            onFinish: () => {
              if (this.isPlaying) {
                animateInhale();
              }
            }
          }, () => {
            this.breathScale = 0.8;
          });
        }
      }, () => {
        this.breathScale = 1.2;
      });
    };

    animateInhale();
  }

  private startRotationAnimation(): void {
    const rotateOnce = () => {
      if (!this.isPlaying) return;
      animateTo({
        duration: 20000,
        curve: Curve.Linear,
        onFinish: () => {
          if (this.isPlaying) {
            this.breathRotation = 0;
            rotateOnce();
          }
        }
      }, () => {
        this.breathRotation = 360;
      });
    };

    rotateOnce();
  }

  private stopAnimations(): void {
    this.isPlaying = false;
    animateTo({
      duration: 300,
      curve: Curve.EaseInOut
    }, () => {
      this.breathScale = 0.8;
      this.breathRotation = 0;
    });
  }

  private toggleBreathing(): void {
    if (this.isPlaying) {
      this.stopAnimations();
    } else {
      this.startBreathing();
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Column() {
        }
        .height(48)

        Row() {
          Text('ZenBreather')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Theme.textDark)

          Blank()

          Text('⚙')
            .fontSize(24)
            .fontColor(Theme.textGray)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })

        Column() {
        }
        .height(60)

        Stack() {
          BreathVisualizer({ breathScale: $breathScale, breathRotation: $breathRotation })

          Column() {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(Theme.accentTeal)

            Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`)
              .fontSize(14)
              .fontColor(Theme.textGray)
              .margin({ top: 4 })
          }
        }
        .width('100%')
        .height(280)

        Blank()

        Column() {
          Text('Select Rhythm')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Theme.textDark)
            .margin({ bottom: 16 })

          Row() {
            ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
              PatternCard({
                patternItem: pattern,
                isSelected: index === this.selectedPatternIndex,
                onCardClick: () => {
                  this.selectedPatternIndex = index;
                  this.stopAnimations();
                }
              })
              if (index < this.patterns.length - 1) {
                Blank()
              }
            }, (pattern: BreathingPattern, index: number) => index.toString())
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .alignItems(HorizontalAlign.Start)

        Column() {
        }
        .height(32)

        Row() {
          Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .letterSpacing(1)

          if (!this.isPlaying) {
            Text('▶')
              .fontSize(14)
              .fontColor('#FFFFFF')
              .margin({ left: 8 })
          }
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Theme.textDark)
        .borderRadius(32)
        .margin({ left: 32, right: 32, bottom: 32 })
        .onClick(() => {
          this.toggleBreathing();
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Theme.pureWhite)
  }
}
