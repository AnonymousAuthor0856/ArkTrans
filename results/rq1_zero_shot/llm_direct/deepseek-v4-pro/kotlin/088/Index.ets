import { display } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

@Entry
@Component
struct MainScreen {
  @State selectedPatternIndex: number = 0;
  @State isPlaying: boolean = false;
  @State scaleValue: number = 0.8;
  @State rotationValue: number = 0;
  @State animationRunning: boolean = false;
  
  private patterns: BreathingPattern[] = [
    new BreathingPattern("Relax", 4, 6),
    new BreathingPattern("Balance", 5, 5),
    new BreathingPattern("Focus", 4, 4)
  ];
  
  private pureWhite: string = '#FFFFFF';
  private textDark: string = '#2D2D2D';
  private accentTeal: string = '#00897B';
  private lightGray: string = '#F5F5F5';
  
  private breathAnimation: number = -1;
  private rotationAnimation: number = -1;

  aboutToAppear() {
    this.startBreathAnimation();
  }

  aboutToDisappear() {
    this.stopAnimations();
  }

  private stopAnimations() {
    if (this.breathAnimation !== -1) {
      this.getUIContext().getAnimator().cancel(this.breathAnimation);
      this.breathAnimation = -1;
    }
    if (this.rotationAnimation !== -1) {
      this.getUIContext().getAnimator().cancel(this.rotationAnimation);
      this.rotationAnimation = -1;
    }
  }

  private startBreathAnimation() {
    this.stopAnimations();
    
    const currentPattern = this.patterns[this.selectedPatternIndex];
    const duration = currentPattern.totalDuration * 1000;
    
    if (this.isPlaying) {
      // Breath scale animation
      this.breathAnimation = this.getUIContext().getAnimator().create({
        duration: duration,
        easing: 'ease-in-out',
        delay: 0,
        fill: 'none',
        direction: 'alternate',
        iterations: -1,
        begin: 0.8,
        end: 1.2
      });
      
      this.getUIContext().getAnimator().onFinish(this.breathAnimation, () => {
        // Animation repeats infinitely
      });
      
      this.getUIContext().getAnimator().play(this.breathAnimation);
      
      // Rotation animation
      this.rotationAnimation = this.getUIContext().getAnimator().create({
        duration: 20000,
        easing: 'linear',
        delay: 0,
        fill: 'none',
        direction: 'normal',
        iterations: -1,
        begin: 0,
        end: 360
      });
      
      this.getUIContext().getAnimator().play(this.rotationAnimation);
    } else {
      this.scaleValue = 0.8;
      this.rotationValue = 0;
    }
  }

  private togglePlayPause() {
    this.isPlaying = !this.isPlaying;
    this.startBreathAnimation();
  }

  private selectPattern(index: number) {
    this.selectedPatternIndex = index;
    this.isPlaying = false;
    this.startBreathAnimation();
  }

  build() {
    Column() {
      // Header
      Row() {
        Text('ZenBreather')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textDark)
          .letterSpacing(-1)
        
        Blank()
        
        Text('⚙')
          .fontSize(24)
          .fontColor('#808080')
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Visualizer Section
      Stack() {
        // Canvas for breathing circle
        Canvas(this.getUIContext())
          .width(280)
          .height(280)
          .scale({ 
            x: this.isPlaying ? this.scaleValue : 1, 
            y: this.isPlaying ? this.scaleValue : 1 
          })
          .rotate({ 
            angle: this.isPlaying ? this.rotationValue : 0,
            centerX: '140vp',
            centerY: '140vp'
          })
          .onReady(() => {
            this.drawBreathingCircle();
          })
        
        // Text inside circle
        Column() {
          Text(this.isPlaying ? 'Breathe' : 'Ready')
            .fontSize(24)
            .fontColor(this.accentTeal)
            .fontWeight(FontWeight.Medium)
          
          Text(`${this.patterns[this.selectedPatternIndex].inhale}s In / ${this.patterns[this.selectedPatternIndex].exhale}s Out`)
            .fontSize(14)
            .fontColor('#808080')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)
      .margin({ top: 60 })

      Blank()
        .layoutWeight(1)

      // Pattern Selection
      Text('Select Rhythm')
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(this.textDark)
        .width('100%')
        .padding({ left: 24, right: 24 })

      Blank()
        .height(16)

      Row() {
        ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
          this.PatternCard(pattern, index === this.selectedPatternIndex, () => {
            this.selectPattern(index);
          })
        })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)

      Blank()
        .height(32)

      // Play/Pause Button
      Button(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
        .width('100%')
        .height(64)
        .margin({ left: 32, right: 32, bottom: 32 })
        .backgroundColor(this.textDark)
        .fontColor('#FFFFFF')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .letterSpacing(1)
        .borderRadius(32)
        .onClick(() => {
          this.togglePlayPause();
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pureWhite)
  }

  @Builder
  PatternCard(pattern: BreathingPattern, isSelected: boolean, onClick: () => void) {
    Column() {
      if (isSelected) {
        Text('✓')
          .fontSize(16)
          .fontColor(this.accentTeal)
        
        Blank()
          .height(4)
      }
      
      Text(pattern.name)
        .fontWeight(FontWeight.Bold)
        .fontSize(14)
        .fontColor(isSelected ? this.accentTeal : this.textDark)
      
      Text(`${pattern.inhale}-${pattern.exhale}`)
        .fontSize(12)
        .fontColor('#808080')
    }
    .width(100)
    .height(90)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(isSelected ? '#0D00897B' : this.lightGray)
    .borderRadius(20)
    .border({
      width: isSelected ? 2 : 0,
      color: isSelected ? this.accentTeal : '#00000000',
      radius: 20
    })
    .onClick(onClick)
  }

  private drawBreathingCircle() {
    // This method would be implemented using Canvas drawing APIs
    // Drawing circles, lines, and dots for the breathing visualizer
  }
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