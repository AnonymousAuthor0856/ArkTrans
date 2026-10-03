import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { UIAbilityContext } from '@kit.AbilityKit';

// MARK: - Constants & Theme
const THEME = {
  pureWhite: '#FFFFFF',
  textDark: '#2D2D2D',
  accentTeal: '#00897B',
  lightGray: '#F5F5F5',
  textGray: '#9E9E9E'
};

interface BreathingPattern {
  id: number;
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
  @State rotation: number = 0.0;
  private timerId: number = -1;

  patterns: BreathingPattern[] = [
    { id: 0, name: "Relax", inhale: 4, exhale: 6 },
    { id: 1, name: "Balance", inhale: 5, exhale: 5 },
    { id: 2, name: "Focus", inhale: 4, exhale: 4 }
  ];

  get currentPattern(): BreathingPattern {
    return this.patterns[this.selectedPatternIndex];
  }

  aboutToAppear() {
    // Hide status bar for immersive experience
    try {
      const context: UIAbilityContext = this.getUIContext().getHostContext() as UIAbilityContext;
      const mainWindow = window.getWindowSync(context);
      mainWindow.setWindowSystemBarEnable([], (err) => {
        if (err) {
          console.error(`Failed to hide system bars. Code: ${err.code}, Message: ${err.message}`);
        }
      });
    } catch (exception) {
      console.error(`Failed to get main window. Code: ${(exception as BusinessError).code}, Message: ${(exception as BusinessError).message}`);
    }
  }

  aboutToDisappear() {
    this.stopBreathing();
  }

  build() {
    Column() {
      // Header
      Row() {
        Text("ZenBreather")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(THEME.textDark)
        
        Image($r('app.media.ic_settings')) // Assuming a settings icon exists, otherwise use placeholder or remove
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .margin({ top: 48 })

      Blank().height(60)

      // Visualizer
      BreathVisualizer({
        scale: $scaleValue,
        rotation: $rotation,
        isPlaying: this.isPlaying,
        pattern: this.currentPattern
      })
      .width(280)
      .height(280)

      Blank()

      // Pattern Selection
      Column({ space: 16 }) {
        Text("Select Rhythm")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(THEME.textDark)
          .alignSelf(ItemAlign.Start)

        Row({ space: 0 }) {
          ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
            PatternCard({
              pattern: pattern,
              isSelected: index === this.selectedPatternIndex,
              onClick: () => {
                this.selectedPatternIndex = index;
                this.stopBreathing();
              }
            })
            
            if (index < this.patterns.length - 1) {
              Blank()
            }
          })
        }
      }
      .padding({ left: 24, right: 24 })

      Blank().height(32)

      // Control Button
      Button() {
        Row({ space: 8 }) {
          Text(this.isPlaying ? "STOP SESSION" : "START BREATHING")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
            .fontColor(Color.White)
          
          if (!this.isPlaying) {
            Image($r('app.media.ic_play')) // Assuming play icon exists
              .width(20)
              .height(20)
              .fillColor(Color.White)
          }
        }
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(64)
      .backgroundColor(THEME.textDark)
      .borderRadius(32)
      .onClick(() => {
        this.toggleBreathing();
      })
      .padding({ left: 32, right: 32, bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(THEME.pureWhite)
  }

  toggleBreathing() {
    if (this.isPlaying) {
      this.stopBreathing();
    } else {
      this.startBreathing();
    }
  }

  startBreathing() {
    this.isPlaying = true;
    
    // Animate Scale
    animateTo({
      duration: this.currentPattern.inhale * 1000,
      curve: Curve.EaseInOut,
      iterations: -1, // Repeat forever
      playMode: PlayMode.Normal
    }, () => {
      this.scaleValue = 1.2;
    });

    // Animate Rotation
    animateTo({
      duration: 20000, // 20 seconds for full rotation
      curve: Curve.Linear,
      iterations: -1,
      playMode: PlayMode.Normal
    }, () => {
      this.rotation = 360;
    });
  }

  stopBreathing() {
    this.isPlaying = false;
    
    // Reset animations
    animateTo({
      duration: 300,
      curve: Curve.EaseOut
    }, () => {
      this.scaleValue = 0.8;
      this.rotation = 0;
    });
  }
}

@Component
struct BreathVisualizer {
  @Link scale: number;
  @Link rotation: number;
  @Prop isPlaying: boolean;
  @Prop pattern: BreathingPattern;

  build() {
    Stack() {
      // Outer faint ring
      Circle()
        .fill(Color.Transparent)
        .width(280)
        .height(280)
        .scale({ x: this.scale, y: this.scale })
        .opacity(0.1)
        .fillColor(THEME.accentTeal)

      // Stroke ring
      Circle()
        .stroke(THEME.accentTeal)
        .strokeWidth(2)
        .width(280)
        .height(280)
        .scale({ x: this.scale, y: this.scale })

      // Petals / Spokes
      ForEach([0, 1, 2, 3, 4, 5, 6, 7], (i: number) => {
        Stack() {
          // Line
          Rect()
            .width(140)
            .height(2)
            .fillColor(THEME.accentTeal)
            .opacity(0.4)
            .offset({ x: 70, y: 0 })
            .rotate({ angle: i * 45 })
            .scale({ x: this.scale, y: this.scale })

          // Dot at end
          Circle()
            .width(6)
            .height(6)
            .fillColor(THEME.accentTeal)
            .offset({ x: 135, y: 0 })
            .rotate({ angle: i * 45 })
            .scale({ x: this.scale, y: this.scale })
        }
      })

      // Center Text
      Column({ space: 8 }) {
        Text(this.isPlaying ? "Breathe" : "Ready")
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(THEME.accentTeal)
        
        Text(`${this.pattern.inhale}s In / ${this.pattern.exhale}s Out`)
          .fontSize(14)
          .fontColor(THEME.textGray)
      }
    }
    .width(280)
    .height(280)
    .rotate({ angle: this.rotation })
  }
}

@Component
struct PatternCard {
  @Prop pattern: BreathingPattern;
  @Prop isSelected: boolean;
  @Prop onClick: () => void;

  build() {
    Button() {
      Column({ space: 4 }) {
        if (this.isSelected) {
          Image($r('app.media.ic_check')) // Assuming check icon exists
            .width(16)
            .height(16)
            .fillColor(THEME.accentTeal)
        }

        Text(this.pattern.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isSelected ? THEME.accentTeal : THEME.textDark)
        
        if (!this.isSelected) {
           Text(" ") // Placeholder to keep height consistent
               .fontSize(16)
        }
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(100)
    .height(90)
    .backgroundColor(this.isSelected ? Color.Transparent : THEME.lightGray)
    .borderRadius(20)
    .border({
      width: this.isSelected ? 2 : 0,
      color: this.isSelected ? THEME.accentTeal : Color.Transparent,
      radius: 20
    })
    .onClick(() => {
      this.onClick();
    })
  }
}