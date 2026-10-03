class Theme {
  static pureWhite: string = '#FFFFFF';
  static textDark: string = '#2D2D2D';
  static accentTeal: string = '#00897B';
  static lightGray: string = '#F5F5F5';
  static textGray: string = '#808080';
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

  totalDuration(): number {
    return this.inhale + this.exhale;
  }
}

@Entry
@Component
struct MainScreen {
  @State private selectedPatternIndex: number = 0;
  @State private isPlaying: boolean = false;
  @State private visualScale: number = 0.8;
  @State private rotation: number = 0;

  private patterns: BreathingPattern[] = [
    new BreathingPattern('Relax', 4, 6),
    new BreathingPattern('Balance', 5, 5),
    new BreathingPattern('Focus', 4, 4)
  ];

  private currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex];
  }

  private stopBreathing(): void {
    this.isPlaying = false;
    this.visualScale = 0.8;
    this.rotation = 0;
  }

  private toggleBreathing(): void {
    if (this.isPlaying) {
      this.stopBreathing();
    } else {
      this.isPlaying = true;
      this.visualScale = 1.2;
      this.rotation = 360;
    }
  }

  @Builder
  private Header() {
    Row() {
      Text('ZenBreather')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(Theme.textDark)
      Blank()
      Text('⚙')
        .fontSize(24)
        .fontColor('#808080')
    }
    .padding({ left: 24, right: 24 })
    .width('100%')
  }

  @Builder
  private BreathVisualizer() {
    Stack() {
      Circle()
        .width(230)
        .height(230)
        .fill('#00897B1A')
        .scale({ x: this.visualScale, y: this.visualScale })
      Circle()
        .width(230)
        .height(230)
        .fill(Color.Transparent)
        .stroke(Theme.accentTeal)
        .strokeWidth(2)
        .scale({ x: this.visualScale, y: this.visualScale })

      ForEach([0, 1, 2, 3, 4, 5, 6, 7], (index: number) => {
        Rect()
          .width(140)
          .height(2)
          .fill('#00897B66')
          .translate({ x: 70, y: 0 })
          .rotate({ angle: index * 45 })
          .scale({ x: this.visualScale, y: this.visualScale })
        Circle()
          .width(6)
          .height(6)
          .fill(Theme.accentTeal)
          .translate({ x: 135, y: 0 })
          .rotate({ angle: index * 45 })
          .scale({ x: this.visualScale, y: this.visualScale })
      })
    }
    .width(280)
    .height(280)
    .rotate({ angle: this.rotation })
  }

  @Builder
  private PatternCard(pattern: BreathingPattern, index: number) {
    Stack() {
      Rect()
        .width(100)
        .height(90)
        .fill(this.selectedPatternIndex === index ? '#00897B0D' : Theme.lightGray)
        .stroke(this.selectedPatternIndex === index ? Theme.accentTeal : Color.Transparent)
        .strokeWidth(2)
        .radius(20)
      Column({ space: 4 }) {
        if (this.selectedPatternIndex === index) {
          Text('✓')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Theme.accentTeal)
        }
        Text(pattern.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.selectedPatternIndex === index ? Theme.accentTeal : Theme.textDark)
        if (this.selectedPatternIndex !== index) {
          Text(' ')
            .fontSize(16)
        }
      }
    }
    .width(100)
    .height(90)
    .onClick(() => {
      this.selectedPatternIndex = index;
      this.stopBreathing();
    })
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        Blank().height(48)
        this.Header()
        Blank().height(60)

        Stack() {
          this.BreathVisualizer()
          Column() {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(Theme.accentTeal)
            Text(`${this.currentPattern().inhale}s In / ${this.currentPattern().exhale}s Out`)
              .fontSize(14)
              .fontColor('#808080')
          }
        }
        .width(280)
        .height(280)

        Blank()

        Column({ space: 16 }) {
          Text('Select Rhythm')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Theme.textDark)
            .width('100%')
            .textAlign(TextAlign.Start)
          Row() {
            ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
              this.PatternCard(pattern, index)
              if (index < this.patterns.length - 1) {
                Blank()
              }
            })
          }
          .width('100%')
        }
        .padding({ left: 24, right: 24 })
        .width('100%')

        Blank().height(32)

        Button(this.isPlaying ? 'STOP SESSION' : 'START BREATHING  ▶')
          .height(64)
          .width('100%')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
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
