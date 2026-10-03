import { common, window } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

// --------------------------------------------------------------------------------
// Theme & Colors
// --------------------------------------------------------------------------------

const PureWhite = '#FFFFFF'
const TextDark = '#2D2D2D'
const AccentTeal = '#00897B'
const LightGray = '#F5F5F5'
const GrayText = '#9E9E9E'

// --------------------------------------------------------------------------------
// Data Models
// --------------------------------------------------------------------------------

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
  @State scaleValue: number = 1.0;
  @State rotationValue: number = 0;
  
  private patterns: BreathingPattern[] = [
    { name: 'Relax', inhale: 4, exhale: 6 },
    { name: 'Balance', inhale: 5, exhale: 5 },
    { name: 'Focus', inhale: 4, exhale: 4 }
  ];

  aboutToAppear() {
    // Immersive Mode: Hide System Bars
    try {
      let ctx = getContext(this) as common.UIAbilityContext;
      let windowClass = ctx.getWindowSync();
      windowClass.setWindowSystemBarEnable([window.SystemBarType.STATUS_BAR, window.SystemBarType.NAVIGATION_BAR], false);
    } catch (e) {
      console.error('Failed to set immersive mode');
    }
  }

  build() {
    Column() {
      // Header
      Row() {
        Text('ZenBreather')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(-1)
          .fontColor(TextDark)
        
        Blank()
        
        Image($r('app.media.ic_settings')) // Placeholder for Settings Icon
          .width(24)
          .height(24)
          .fillColor('#757575')
      }
      .width('100%')
      .padding({ left: 24, right: 24 })

      Spacer().height(60)

      // Visualizer Section
      Stack({ alignContent: Alignment.Center }) {
        BreathVisualizer({
          isPlaying: this.isPlaying,
          durationSum: this.patterns[this.selectedPatternIndex].inhale + this.patterns[this.selectedPatternIndex].exhale,
          onScaleChange: (val: number) => { this.scaleValue = val },
          onRotationChange: (val: number) => { this.rotationValue = val }
        })
        .width(280)
        .height(280)

        Column() {
          Text(this.isPlaying ? 'Breathe' : 'Ready')
            .fontSize(24)
            .fontColor(AccentTeal)
            .fontWeight(FontWeight.Medium)
          
          Text(`${this.patterns[this.selectedPatternIndex].inhale}s In / ${this.patterns[this.selectedPatternIndex].exhale}s Out`)
            .fontSize(14)
            .fontColor(GrayText)
            .margin({ top: 4 })
        }
      }

      Spacer().layoutWeight(1)

      // Pattern Selection
      Text('Select Rhythm')
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(TextDark)
        .width('100%')
      
      Spacer().height(16)
      
      Row() {
        ForEach(this.patterns, (pattern: BreathingPattern, index: number) => {
          PatternCard({
            pattern: pattern,
            isSelected: index === this.selectedPatternIndex,
            onClick: () => {
              this.selectedPatternIndex = index;
              this.isPlaying = false;
            }
          })
        }, (pattern: BreathingPattern) => pattern.name)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 24, right: 24 })
      
      Spacer().height(32)

      // Bottom Control Bar
      Row() {
        PlayPauseButton({
          isPlaying: this.isPlaying,
          onClick: () => {
            this.isPlaying = !this.isPlaying;
          }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(32)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PureWhite)
  }
}

// --------------------------------------------------------------------------------
// Components
// --------------------------------------------------------------------------------

@Component
struct BreathVisualizer {
  @Prop isPlaying: boolean;
  @Prop durationSum: number;
  @Link scaleValue: number;
  @Link rotationValue: number;

  private timer: number = -1;
  private startTime: number = 0;
  private lastFrameTime: number = 0;

  aboutToAppear() {
    this.startAnimation();
  }

  aboutToDisappear() {
    if (this.timer !== -1) {
      cancelAnimation(this.timer);
    }
  }

  startAnimation() {
    if (this.timer !== -1) {
      cancelAnimation(this.timer);
    }
    
    this.startTime = Date.now();
    this.lastFrameTime = this.startTime;
    
    this.timer = setInterval(() => {
      const now = Date.now();
      const elapsed = now - this.startTime;
      
      if (this.isPlaying) {
        // Scale Animation: Ping Pong between 0.8 and 1.2
        const cycleDuration = this.durationSum * 1000;
        const progress = (elapsed % (cycleDuration * 2)) / cycleDuration;
        // Simple triangle wave logic for ping pong
        let normalizedProgress = progress < 1 ? progress : 2 - progress;
        // Apply ease-in-out approximation
        const eased = normalizedProgress < 0.5 
          ? 2 * normalizedProgress * normalizedProgress 
          : 1 - Math.pow(-2 * normalizedProgress + 2, 2) / 2;
        
        this.scaleValue = 0.8 + (0.4 * eased);

        // Rotation Animation: Continuous 360 over 20s
        const rotDuration = 20000;
        this.rotationValue = (elapsed % rotDuration) / rotDuration * 360;
      } else {
        this.scaleValue = 1.0;
        this.rotationValue = 0;
      }
    }, 16); // ~60fps
  }

  build() {
    Canvas(this)
      .width('100%')
      .height('100%')
      .attr('scaleX', this.scaleValue)
      .attr('scaleY', this.scaleValue)
      .attr('rotationZ', this.rotationValue)
  }

  onDraw(canvas: Canvas, context: CanvasRenderingContext2D) {
    const width = context.width;
    const height = context.height;
    const centerX = width / 2;
    const centerY = height / 2;
    const radius = Math.min(width, height) / 2.5;

    // Draw outer distinctive circle rings
    context.beginPath();
    context.arc(centerX, centerY, radius, 0, 2 * Math.PI);
    context.fillStyle = hexToRgba(AccentTeal, 0.1);
    context.fill();

    context.beginPath();
    context.arc(centerX, centerY, radius, 0, 2 * Math.PI);
    context.strokeStyle = AccentTeal;
    context.lineWidth = 4;
    context.stroke();

    // Draw decorative abstract shapes (Petals)
    const petalCount = 8;
    const angleStep = 360 / petalCount;

    for (let i = 0; i < petalCount; i++) {
      const angle = i * angleStep;
      const rad = angle * Math.PI / 180;
      const endX = centerX + radius * 0.7 * Math.cos(rad);
      const endY = centerY + radius * 0.7 * Math.sin(rad);

      // Draw a line/petal from center
      context.beginPath();
      context.moveTo(centerX, centerY);
      context.lineTo(endX, endY);
      context.strokeStyle = hexToRgba(AccentTeal, 0.4);
      context.lineWidth = 2;
      context.lineCap = LineCap.Round;
      context.stroke();
      
      // Draw small dots at ends
      context.beginPath();
      context.arc(endX, endY, 6, 0, 2 * Math.PI);
      context.fillStyle = AccentTeal;
      context.fill();
    }
  }
}

@Component
struct PatternCard {
  @Prop pattern: BreathingPattern;
  @Prop isSelected: boolean;
  @State localIsSelected: boolean = false;
  onClick: () => void;

  aboutToAppear() {
    this.localIsSelected = this.isSelected;
  }

  build() {
    Column() {
      if (this.localIsSelected) {
        Image($r('app.media.ic_check')) // Placeholder for Check Icon
          .width(16)
          .height(16)
          .fillColor(AccentTeal)
        Spacer().height(4)
      }
      Text(this.pattern.name)
        .fontWeight(FontWeight.Bold)
        .fontSize(14)
        .fontColor(this.localIsSelected ? AccentTeal : TextDark)
      
      Text(`${this.pattern.inhale}-${this.pattern.exhale}`)
        .fontSize(12)
        .fontColor(GrayText)
    }
    .width(100)
    .height(90)
    .borderRadius(20)
    .backgroundColor(this.localIsSelected ? hexToRgba(AccentTeal, 0.05) : LightGray)
    .border({
      width: 2,
      color: this.localIsSelected ? AccentTeal : Color.Transparent,
      radius: 20
    })
    .onClick(() => {
      this.onClick();
    })
    .padding(12)
  }
}

@Component
struct PlayPauseButton {
  @Prop isPlaying: boolean;
  onClick: () => void;

  build() {
    Button() {
      Row() {
        Text(this.isPlaying ? 'STOP SESSION' : 'START BREATHING')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(1)
          .fontColor(Color.White)
        
        if (!this.isPlaying) {
          Spacer().width(8)
          Image($r('app.media.ic_play_arrow')) // Placeholder for Play Icon
            .width(20)
            .height(20)
            .fillColor(Color.White)
        }
      }
      .verticalCenter()
    }
    .height(64)
    .width('100%')
    .borderRadius(32)
    .backgroundColor(TextDark)
    .onClick(() => {
      this.onClick();
    })
  }
}

// Helper function to convert Hex to RGBA for ArkTS Canvas
function hexToRgba(hex: string, alpha: number): string {
  let r = parseInt(hex.slice(1, 3), 16);
  let g = parseInt(hex.slice(3, 5), 16);
  let b = parseInt(hex.slice(5, 7), 16);
  return `rgba(${r}, ${g}, ${b}, ${alpha})`;
}