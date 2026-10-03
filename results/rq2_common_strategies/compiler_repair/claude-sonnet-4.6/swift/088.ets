import { AnimatorOptions, AnimatorResult } from '@ohos.animator';
import animator from '@ohos.animator';

// Theme constants
const PURE_WHITE = '#FFFFFF';
const TEXT_DARK = '#2D2D2D';
const ACCENT_TEAL = '#00897B';
const LIGHT_GRAY = '#F5F5F5';
const TEXT_GRAY = '#808080';

interface BreathingPattern {
  id: number;
  name: string;
  inhale: number;
  exhale: number;
}

const PATTERNS: BreathingPattern[] = [
  { id: 0, name: 'Relax', inhale: 4, exhale: 6 },
  { id: 1, name: 'Balance', inhale: 5, exhale: 5 },
  { id: 2, name: 'Focus', inhale: 4, exhale: 4 },
];

@Entry
@Component
struct MainScreen {
  @State selectedPatternIndex: number = 0;
  @State isPlaying: boolean = false;
  @State breathScale: number = 0.8;
  @State rotation: number = 0;
  private animatorScale: AnimatorResult | null = null;
  private animatorRotation: AnimatorResult | null = null;

  get currentPattern(): BreathingPattern {
    return PATTERNS[this.selectedPatternIndex];
  }

  startBreathing() {
    this.isPlaying = true;

    const scaleOptions: AnimatorOptions = {
      duration: this.currentPattern.inhale * 1000,
      easing: 'ease-in-out',
      delay: 0,
      fill: 'forwards',
      direction: 'alternate',
      iterations: -1,
      begin: 0.8,
      end: 1.2,
    };
    this.animatorScale = animator.create(scaleOptions);
    this.animatorScale.onFrame = (progress: number) => {
      this.breathScale = progress;
    };
    this.animatorScale.play();

    const rotationOptions: AnimatorOptions = {
      duration: 8000,
      easing: 'linear',
      delay: 0,
      fill: 'forwards',
      direction: 'normal',
      iterations: -1,
      begin: 0,
      end: 360,
    };
    this.animatorRotation = animator.create(rotationOptions);
    this.animatorRotation.onFrame = (progress: number) => {
      this.rotation = progress;
    };
    this.animatorRotation.play();
  }

  stopBreathing() {
    this.isPlaying = false;
    if (this.animatorScale) {
      this.animatorScale.cancel();
      this.animatorScale = null;
    }
    if (this.animatorRotation) {
      this.animatorRotation.cancel();
      this.animatorRotation = null;
    }
    animateTo({ duration: 300, curve: Curve.EaseInOut }, () => {
      this.breathScale = 0.8;
      this.rotation = 0;
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
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(PURE_WHITE)

      Column({ space: 0 }) {
        Blank().height(48)

        // Header
        Row() {
          Text('ZenBreather')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(TEXT_DARK)
          Blank()
          Text('⚙')
            .fontSize(24)
            .fontColor(TEXT_GRAY)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })

        Blank().height(60)

        // Visualizer
        Stack() {
          // Outer faint circle
          Circle()
            .width(280 * this.breathScale)
            .height(280 * this.breathScale)
            .fill('rgba(0,137,123,0.1)')

          // Stroke ring
          Circle()
            .width(280 * this.breathScale)
            .height(280 * this.breathScale)
            .stroke(ACCENT_TEAL)
            .strokeWidth(2)
            .fill('transparent')

          // Spokes and dots
          Stack() {
            ForEach([0, 1, 2, 3, 4, 5, 6, 7], (i: number) => {
              Row() {
                Blank().width(70)
                Column()
                  .width(140)
                  .height(2)
                  .backgroundColor('rgba(0,137,123,0.4)')
              }
              .rotate({ angle: i * 45 })
              .width(280)
              .height(2)
              .justifyContent(FlexAlign.Start)
              .alignItems(VerticalAlign.Center)

              Circle()
                .width(6)
                .height(6)
                .fill(ACCENT_TEAL)
                .translate({
                  x: 135 * Math.cos(i * 45 * Math.PI / 180),
                  y: 135 * Math.sin(i * 45 * Math.PI / 180)
                })
            })
          }
          .width(280)
          .height(280)
          .scale({ x: this.breathScale, y: this.breathScale })
          .rotate({ angle: this.rotation })

          // Center text
          Column({ space: 4 }) {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(ACCENT_TEAL)
            Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`)
              .fontSize(14)
              .fontColor(TEXT_GRAY)
          }
        }
        .width(280)
        .height(280)

        Blank()

        // Pattern Selection
        Column({ space: 16 }) {
          Text('Select Rhythm')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(TEXT_DARK)
            .width('100%')

          Row({ space: 0 }) {
            ForEach(PATTERNS, (pattern: BreathingPattern, index: number) => {
              PatternCard({
                pattern: pattern,
                isSelected: index === this.selectedPatternIndex,
                onCardClick: () => {
                  this.selectedPatternIndex = index;
                  this.stopBreathing();
                }
              })
              if (index < PATTERNS.length - 1) {
                Blank()
              }
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .padding({ left: 24, right: 24 })
        .alignItems(HorizontalAlign.Start)

        Blank().height(32)

        // Control Button
        Button() {
          Row({ space: 8 }) {
            Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(PURE_WHITE)
              .letterSpacing(1)
            if (!this.isPlaying) {
              Text('▶')
                .fontSize(20)
                .fontColor(PURE_WHITE)
            }
          }
        }
        .width('85%')
        .height(64)
        .backgroundColor(TEXT_DARK)
        .borderRadius(32)
        .onClick(() => {
          this.toggleBreathing();
        })
        .margin({ bottom: 32 })
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct PatternCard {
  pattern: BreathingPattern = { id: 0, name: '', inhale: 0, exhale: 0 };
  isSelected: boolean = false;
  onCardClick: () => void = () => {};

  build() {
    Column({ space: 4 }) {
      if (this.isSelected) {
        Text('✓')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(ACCENT_TEAL)
      }
      Text(this.pattern.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isSelected ? ACCENT_TEAL : TEXT_DARK)
      if (!this.isSelected) {
        Text(' ')
          .fontSize(16)
      }
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width(100)
    .height(90)
    .backgroundColor(this.isSelected ? 'rgba(0,137,123,0.05)' : LIGHT_GRAY)
    .borderRadius(20)
    .border({
      width: this.isSelected ? 2 : 0,
      color: this.isSelected ? ACCENT_TEAL : 'transparent',
    })
    .onClick(() => {
      this.onCardClick();
    })
  }
}