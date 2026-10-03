// Index.ets  —  ZenBreather (ArkTS / ArkUI port of the SwiftUI source)

const TEXT_DARK: string = '#2D2D2D';
const ACCENT_TEAL: string = '#00897B';
const ACCENT_TEAL_05: string = '#0D00897B';
const ACCENT_TEAL_10: string = '#1A00897B';
const ACCENT_TEAL_40: string = '#6600897B';
const LIGHT_GRAY: string = '#F5F5F5';
const TEXT_GRAY: string = '#8C8C8C';

interface BreathingPattern {
  name: string;
  inhale: number;
  exhale: number;
}

@Entry
@Component
struct Index {
  @State selectedPatternIndex: number = 0;
  @State isPlaying: boolean = false;
  @State breathScale: number = 0.8;
  @State rotation: number = 0;

  private patterns: BreathingPattern[] = [
    { name: 'Relax', inhale: 4, exhale: 6 },
    { name: 'Balance', inhale: 5, exhale: 5 },
    { name: 'Focus', inhale: 4, exhale: 4 }
  ];

  private spokeAngles: number[] = [0, 45, 90, 135, 180, 225, 270, 315];

  currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex];
  }

  toggleBreathing(): void {
    if (this.isPlaying) {
      this.stopBreathing();
    } else {
      this.startBreathing();
    }
  }

  startBreathing(): void {
    this.isPlaying = true;
    animateTo({
      duration: this.currentPattern().inhale * 1000,
      curve: Curve.EaseInOut,
      iterations: -1,
      playMode: PlayMode.Alternate
    }, () => {
      this.breathScale = 1.2;
    });
    animateTo({
      duration: 20000,
      curve: Curve.Linear,
      iterations: -1,
      playMode: PlayMode.Normal
    }, () => {
      this.rotation = 360;
    });
  }

  stopBreathing(): void {
    this.isPlaying = false;
    animateTo({ duration: 300, curve: Curve.EaseOut }, () => {
      this.breathScale = 0.8;
      this.rotation = 0;
    });
  }

  // MARK: - Visualizer

  @Builder
  breathVisualizer() {
    Stack() {
      // Faint filled disc
      Circle()
        .width(280)
        .height(280)
        .fill(ACCENT_TEAL_10)

      // Spokes + end dots (each spoke lives in its own full-size box so the
      // rotation pivots around the centre of the visualizer)
      ForEach(this.spokeAngles, (angle: number) => {
        Stack() {
          Row()
            .width(140)
            .height(2)
            .backgroundColor(ACCENT_TEAL_40)
            .offset({ x: 70 })

          Circle()
            .width(6)
            .height(6)
            .fill(ACCENT_TEAL)
            .offset({ x: 135 })
        }
        .width(280)
        .height(280)
        .rotate({ angle: angle })
      }, (angle: number) => angle.toString())

      // Stroke ring
      Circle()
        .width(280)
        .height(280)
        .fill(Color.Transparent)
        .stroke(ACCENT_TEAL)
        .strokeWidth(2)
    }
    .width(280)
    .height(280)
    .scale({ x: this.breathScale, y: this.breathScale })
    .rotate({ angle: this.rotation })
  }

  // MARK: - Pattern card

  @Builder
  patternCard(pattern: BreathingPattern, index: number) {
    Column() {
      if (index === this.selectedPatternIndex) {
        Text('✓')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(ACCENT_TEAL)
          .margin({ bottom: 4 })
      }
      Text(pattern.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(index === this.selectedPatternIndex ? ACCENT_TEAL : TEXT_DARK)
    }
    .width(100)
    .height(90)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(index === this.selectedPatternIndex ? ACCENT_TEAL_05 : LIGHT_GRAY)
    .borderRadius(20)
    .border({
      width: 2,
      color: index === this.selectedPatternIndex ? ACCENT_TEAL : Color.Transparent
    })
    .onClick(() => {
      this.selectedPatternIndex = index;
      this.stopBreathing();
    })
  }

  // MARK: - Screen

  build() {
    Column() {
      // Header
      Row() {
        Text('ZenBreather')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_DARK)
        Blank()
        Text('⚙')
          .fontSize(26)
          .fontColor(TEXT_GRAY)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .margin({ top: 32 })

      Blank()

      // Visualizer + centred labels
      Stack() {
        this.breathVisualizer()

        Column({ space: 4 }) {
          Text(this.isPlaying ? 'Breathe' : 'Ready')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(ACCENT_TEAL)
          Text(`${this.currentPattern().inhale}s In / ${this.currentPattern().exhale}s Out`)
            .fontSize(14)
            .fontColor(TEXT_GRAY)
        }
        .justifyContent(FlexAlign.Center)
      }
      .width(280)
      .height(280)

      Blank()

      // Rhythm selection
      Column({ space: 16 }) {
        Text('Select Rhythm')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_DARK)
          .width('100%')

        Row() {
          ForEach(this.patterns, (item: BreathingPattern, index: number) => {
            this.patternCard(item, index)
          }, (item: BreathingPattern) => item.name)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })

      Blank()

      // Control button
      Row() {
        Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .letterSpacing(1)

        if (!this.isPlaying) {
          Path()
            .commands('M0 0 L16 9 L0 18 Z')
            .fill(Color.White)
            .width(16)
            .height(18)
            .margin({ left: 10 })
        }
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(TEXT_DARK)
      .borderRadius(32)
      .margin({ left: 32, right: 32, bottom: 32 })
      .onClick(() => {
        this.toggleBreathing();
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}