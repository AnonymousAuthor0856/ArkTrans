@Entry
@Component
struct ZenBreatherPage {
  @State selectedPatternIndex: number = 0;
  @State isPlaying: boolean = false;
  @State breathScale: number = 0.8;
  @State rotation: number = 0;
  @State breathText: string = 'Ready';

  private patterns: Pattern[] = [
    { name: 'Relax', inhale: 4, exhale: 6 },
    { name: 'Balance', inhale: 5, exhale: 5 },
    { name: 'Focus', inhale: 4, exhale: 4 }
  ];

  aboutToAppear(): void {
  }

  build() {
    Column() {
      // Header
      Row() {
        Text('ZenBreather')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2D2D2D')

        Blank()

        Text('⚙')
          .fontSize(28)
          .fontColor('#9E9E9E')
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48 })

      // Visualizer
      Stack() {
        // Outer fill circle
        Circle()
          .fill('#00897B1A')
          .width(280)
          .height(280)
          .scale({ x: this.breathScale, y: this.breathScale })
          .animation({
            duration: this.isPlaying ? this.patterns[this.selectedPatternIndex].inhale * 1000 : 300,
            curve: Curve.EaseInOut,
            iterations: this.isPlaying ? -1 : 1,
            playMode: PlayMode.Alternate
          })

        // Stroke ring
        Circle()
          .fill(Color.Transparent)
          .stroke({ color: '#00897B', width: 2 })
          .width(280)
          .height(280)
          .scale({ x: this.breathScale, y: this.breathScale })
          .animation({
            duration: this.isPlaying ? this.patterns[this.selectedPatternIndex].inhale * 1000 : 300,
            curve: Curve.EaseInOut,
            iterations: this.isPlaying ? -1 : 1,
            playMode: PlayMode.Alternate
          })

        // Spokes and dots
        ForEach([0, 1, 2, 3, 4, 5, 6, 7], (i: number) => {
          Stack() {
            // Spoke line
            Rect()
              .fill('#00897B66')
              .width(140)
              .height(2)
              .translate({ x: 70 })

            // Dot at end
            Circle()
              .fill('#00897B')
              .width(6)
              .height(6)
              .translate({ x: 135 })
          }
          .width(280)
          .height(280)
          .rotate({ angle: i * 45 })
          .scale({ x: this.breathScale, y: this.breathScale })
          .animation({
            duration: this.isPlaying ? this.patterns[this.selectedPatternIndex].inhale * 1000 : 300,
            curve: Curve.EaseInOut,
            iterations: this.isPlaying ? -1 : 1,
            playMode: PlayMode.Alternate
          })
        }, (i: number) => i.toString())

        // Rotation container (decorative rotation effect)
        Stack() {
          // Center text overlay
          Column() {
            Text(this.isPlaying ? 'Breathe' : 'Ready')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#00897B')

            Text(`${this.patterns[this.selectedPatternIndex].inhale}s In / ${this.patterns[this.selectedPatternIndex].exhale}s Out`)
              .fontSize(14)
              .fontColor('#9E9E9E')
              .margin({ top: 4 })
          }
        }
        .width(280)
        .height(280)
      }
      .width(280)
      .height(280)
      .margin({ top: 60 })

      Blank()

      // Pattern Selection
      Column() {
        Text('Select Rhythm')
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#2D2D2D')
          .width('100%')
          .margin({ bottom: 16 })

        Row() {
          ForEach(this.patterns, (pattern: Pattern, index: number) => {
            this.PatternCardComp(pattern, index === this.selectedPatternIndex, () => {
              this.selectedPatternIndex = index;
              this.stopBreathing();
            })
          }, (pattern: Pattern) => pattern.name)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })

      // Control Button
      Button() {
        Row() {
          Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .letterSpacing(1)

          if (!this.isPlaying) {
            Text('▶')
              .fontSize(16)
              .fontColor(Color.White)
              .margin({ left: 8 })
          }
        }
      }
      .type(ButtonType.Normal)
      .height(64)
      .borderRadius(32)
      .backgroundColor('#2D2D2D')
      .width('100%')
      .margin({ left: 32, right: 32, top: 32, bottom: 32 })
      .onClick(() => {
        this.toggleBreathing();
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  PatternCardComp(pattern: Pattern, isSelected: boolean, onClick: () => void) {
    Column() {
      if (isSelected) {
        Text('✓')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00897B')
          .margin({ bottom: 4 })
      }

      Text(pattern.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(isSelected ? '#00897B' : '#2D2D2D')

      if (!isSelected) {
        Text(' ')
          .fontSize(16)
      }
    }
    .width(100)
    .height(90)
    .justifyContent(FlexAlign.Center)
    .borderRadius(20)
    .backgroundColor(isSelected ? '#00897B0D' : '#F5F5F5')
    .border({
      width: isSelected ? 2 : 0,
      color: isSelected ? '#00897B' : Color.Transparent
    })
    .onClick(() => {
      onClick();
    })
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
    this.breathScale = 1.2;
    this.breathText = 'Breathe';
  }

  stopBreathing(): void {
    this.isPlaying = false;
    this.breathScale = 0.8;
    this.rotation = 0;
    this.breathText = 'Ready';
  }
}

interface Pattern {
  name: string;
  inhale: number;
  exhale: number;
}
