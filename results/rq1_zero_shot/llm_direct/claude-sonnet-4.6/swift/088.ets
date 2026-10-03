import { router } from '@kit.ArkUI';

// Constants & Theme
const PURE_WHITE = '#FFFFFF';
const TEXT_DARK = '#2D2D2D';
const ACCENT_TEAL = '#00897B';
const LIGHT_GRAY = '#F5F5F5';
const TEXT_GRAY = '#808080';
const ACCENT_TEAL_OPACITY_10 = '#1A00897B';
const ACCENT_TEAL_OPACITY_40 = '#6600897B';
const ACCENT_TEAL_OPACITY_05 = '#0D00897B';

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

@Component
struct BreathVisualizer {
  @Prop scale: number = 0.8;
  @Prop rotation: number = 0;

  build() {
    Stack() {
      // Outer faint ring
      Circle()
        .width(280)
        .height(280)
        .fill(ACCENT_TEAL_OPACITY_10)
        .scale({ x: this.scale, y: this.scale })

      // Stroke ring
      Circle()
        .width(280)
        .height(280)
        .stroke(ACCENT_TEAL, { width: 2 })
        .fill('transparent')
        .scale({ x: this.scale, y: this.scale })

      // Petals / Spokes
      ForEach([0, 1, 2, 3, 4, 5, 6, 7], (i: number) => {
        Stack() {
          // Spoke line
          Row()
            .width(140)
            .height(2)
            .backgroundColor(ACCENT_TEAL_OPACITY_40)
            .offset({ x: 70 })
            .rotate({ angle: i * 45 })
            .scale({ x: this.scale, y: this.scale })

          // Dot at end
          Circle()
            .width(6)
            .height(6)
            .fill(ACCENT_TEAL)
            .offset({ x: 135 })
            .rotate({ angle: i * 45 })
            .scale({ x: this.scale, y: this.scale })
        }
        .width(280)
        .height(280)
      })
    }
    .width(280)
    .height(280)
    .rotate({ angle: this.rotation })
  }
}

@Component
struct PatternCard {
  @Prop pattern: BreathingPattern = { id: 0, name: '', inhale: 0, exhale: 0 };
  @Prop isSelected: boolean = false;
  onClick: () => void = () => {};

  build() {
    Stack() {
      // Background
      Column()
        .width(100)
        .height(90)
        .borderRadius(20)
        .backgroundColor(this.isSelected ? ACCENT_TEAL_OPACITY_05 : LIGHT_GRAY)
        .border(this.isSelected
          ? { width: 2, color: ACCENT_TEAL, radius: 20 }
          : { width: 0, color: 'transparent', radius: 20 })

      // Content
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
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width(100)
    .height(90)
    .onClick(() => {
      this.onClick();
    })
  }
}

@Entry
@Component
struct MainScreen {
  @State selectedPatternIndex: number = 0;
  @State isPlaying: boolean = false;
  @State scale: number = 0.8;
  @State rotation: number = 0;

  private animatorScale: AnimatorResult | null = null;
  private animatorRotation: AnimatorResult | null = null;
  private intervalId: number = -1;

  get currentPattern(): BreathingPattern {
    return PATTERNS[this.selectedPatternIndex];
  }

  startBreathing() {
    this.isPlaying = true;

    // Scale animation: 0.8 -> 1.2 -> 0.8 repeating
    this.animatorScale = animator.create({
      duration: this.currentPattern.inhale * 1000,
      easing: 'ease-in-out',
      delay: 0,
      fill: 'forwards',
      direction: 'alternate',
      iterations: -1,
      begin: 0.8,
      end: 1.2,
    });
    this.animatorScale.onFrame = (progress: number) => {
      this.scale = progress;
    };
    this.animatorScale.play();

    // Rotation animation: 0 -> 360 repeating
    this.animatorRotation = animator.create({
      duration: 20000,
      easing: 'linear',
      delay: 0,
      fill: 'forwards',
      direction: 'normal',
      iterations: -1,
      begin: 0,
      end: 360,
    });
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
      this.scale = 0.8;
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
    Column() {
      // Spacer top
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
        BreathVisualizer({
          scale: this.scale,
          rotation: this.rotation,
        })
          .width(280)
          .height(280)

        Column({ space: 4 }) {
          Text(this.isPlaying ? 'Breathe' : 'Ready')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(ACCENT_TEAL)

          Text(`${this.currentPattern.inhale}s In / ${this.currentPattern.exhale}s Out`)
            .fontSize(14)
            .fontColor(TEXT_GRAY)
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
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
          .alignSelf(ItemAlign.Start)

        Row() {
          ForEach(PATTERNS, (pattern: BreathingPattern, index: number) => {
            PatternCard({
              pattern: pattern,
              isSelected: index === this.selectedPatternIndex,
              onClick: () => {
                this.selectedPatternIndex = index;
                this.stopBreathing();
              },
            })

            if (index < PATTERNS.length - 1) {
              Blank()
            }
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })

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
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(64)
      .backgroundColor(TEXT_DARK)
      .borderRadius(32)
      .padding({ left: 32, right: 32 })
      .margin({ left: 32, right: 32, bottom: 32 })
      .onClick(() => {
        this.toggleBreathing();
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PURE_WHITE)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}