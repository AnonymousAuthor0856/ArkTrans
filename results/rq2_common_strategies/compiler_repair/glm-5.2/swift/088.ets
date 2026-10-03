// ZenBreatherApp.ets
interface BreathingPattern {
  name: string;
  inhale: number;
  exhale: number;
}

@Entry
@Component
struct ZenBreatherApp {
  @State selectedPatternIndex: number = 0;
  @State isPlaying: boolean = false;
  @State scaleValue: number = 0.8;
  @State rotationValue: number = 0;

  private patterns: BreathingPattern[] = [
    { name: 'Relax', inhale: 4, exhale: 6 },
    { name: 'Balance', inhale: 5, exhale: 5 },
    { name: 'Focus', inhale: 4, exhale: 4 }
  ];

  private get currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex];
  }

  private toggleBreathing(): void {
    if (this.isPlaying) {
      this.stopBreathing();
    } else {
      this.startBreathing();
    }
  }

  private startBreathing(): void {
    this.isPlaying = true;
    
    // Scale animation (Inhale/Exhale)
    animateTo({
      duration: this.currentPattern.inhale * 1000,
      curve: Curve.EaseInOut,
      iterations: -1,
      playMode: PlayMode.Alternate
    }, () => {
      this.scaleValue = 1.2;
    });

    // Rotation animation
    animateTo({
      duration: 20000,
      curve: Curve.Linear,
      iterations: -1,
      playMode: PlayMode.Normal
    }, () => {
      this.rotationValue = 360;
    });
  }

  private stopBreathing(): void {
    this.isPlaying = false;
    animateTo({
      duration: 300,
      curve: Curve.EaseInOut
    }, () => {
      this.scaleValue = 0.8;
      this.rotationValue = 0;
    });
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
          
          Image($r('sys.symbol.gearshape'))
            .width(24)
            .height(24)
            .fillColor('#888888')
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .margin({ top: 48 })

        // Visualizer
        Stack() {
          // Outer faint ring
          Circle()
            .fill('#1A00897B')
            .width(280)
            .height(280)
            .scale({ x: this.scaleValue, y: this.scaleValue })

          // Stroke ring
          Circle()
            .stroke('#00897B')
            .strokeWidth(2)
            .width(280)
            .height(280)
            .scale({ x: this.scaleValue, y: this.scaleValue })

          // Petals / Spokes
          ForEach([0, 1, 2, 3, 4, 5, 6, 7], (i: number) => {
            Stack() {
              // Spoke line
              Rect()
                .fill('#6600897B')
                .width(140)
                .height(2)
                .position({ x: 0, y: -1 })
              
              // End dot
              Circle()
                .fill('#00897B')
                .width(6)
                .height(6)
                .position({ x: 135, y: -3 })
            }
            .width(280)
            .height(280)
            .rotate({ angle: i * 45 })
            .scale({ x: this.scaleValue, y: this.scaleValue })
          })

          // Center text
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
        }
        .width('100%')
        .layoutWeight(1)
        .rotate({ angle: this.rotationValue })

        // Pattern Selection
        Column() {
          Text('Select Rhythm')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2D2D2D')
            .alignSelf(ItemAlign.Start)
            .margin({ bottom: 16 })

          Row({ space: 12 }) {
            ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
              PatternCard({
                pattern: pattern,
                isSelected: index === this.selectedPatternIndex,
                onClickAction: () => {
                  this.selectedPatternIndex = index;
                  this.stopBreathing();
                }
              })
            })
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .margin({ bottom: 32 })

        // Control Button
        Button(this.isPlaying ? 'STOP SESSION' : 'START BREATHING', { type: ButtonType.Normal }) {
          Row({ space: 8 }) {
            Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .letterSpacing(1)
            
            if (!this.isPlaying) {
              Image($r('sys.symbol.play'))
                .width(20)
                .height(20)
                .fillColor('#FFFFFF')
            }
          }
          .width('100%')
          .height(64)
          .justifyContent(FlexAlign.Center)
        }
        .backgroundColor('#2D2D2D')
        .borderRadius(32)
        .width('100%')
        .padding({ left: 32, right: 32, bottom: 32 })
        .onClick(() => this.toggleBreathing())
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct PatternCard {
  @Prop pattern: BreathingPattern;
  @Prop isSelected: boolean;
  private onClickAction: () => void = () => {};

  build() {
    Stack() {
      // Background
      Column() {
        if (this.isSelected) {
          Image($r('sys.symbol.checkmark'))
            .width(16)
            .height(16)
            .fillColor('#00897B')
            .margin({ bottom: 4 })
        }
        
        Text(this.pattern.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isSelected ? '#00897B' : '#2D2D2D')
      }
      .width(100)
      .height(90)
      .borderRadius(20)
      .backgroundColor(this.isSelected ? '#0D00897B' : '#F5F5F5')
      .border({
        width: this.isSelected ? 2 : 0,
        color: '#00897B'
      })
      .justifyContent(FlexAlign.Center)
    }
    .onClick(() => {
      this.onClickAction();
    })
  }
}