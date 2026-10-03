import { window } from '@kit.ArkUI';
import { common, UIAbility, Want } from '@kit.AbilityKit';

interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct PomodoroTimer {
  @State knobPosition: Point = { x: 0, y: 0 };
  @State isRunning: boolean = false;
  private dragOffset: Point = { x: 0, y: 0 };

  // AppTokens Colors
  private readonly primary: string = '#FF8FAB';
  private readonly secondary: string = '#B4E3D0';
  private readonly tertiary: string = '#FFD6A5';
  private readonly backgroundColor: string = '#FFFCF9';
  private readonly surface: string = '#FFFFFF';
  private readonly surfaceVariant: string = '#FDE2E4';
  private readonly outlineColor: string = '#FCC2D7';
  private readonly success: string = '#4ADE80';
  private readonly warning: string = '#FACC15';
  private readonly error: string = '#FB7185';
  private readonly onPrimary: string = '#FFFFFF';
  private readonly onSecondary: string = '#1E1E1E';
  private readonly onTertiary: string = '#1E1E1E';
  private readonly onBackground: string = '#1E1E1E';
  private readonly onSurface: string = '#1E1E1E';

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Pomodoro Timer')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 20, bottom: 20 })

      Spacer({ size: 24 })

      // Timer Circle Surface
      Stack() {
        // Background Canvas for the circle track and knob
        Canvas(this.drawCanvas.bind(this))
          .width(280)
          .height(280)
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                // Calculate new position relative to center of the canvas (140, 140)
                const centerX = 140;
                const centerY = 140;
                
                // Get global offset of the gesture
                let newX = event.offsetX - this.dragOffset.x;
                let newY = event.offsetY - this.dragOffset.y;
                
                // Clamp within a reasonable radius (e.g., 100px from center) to keep it inside the visual area
                const dx = newX - centerX;
                const dy = newY - centerY;
                const distance = Math.sqrt(dx * dx + dy * dy);
                const maxRadius = 100;
                
                if (distance > maxRadius) {
                  const angle = Math.atan2(dy, dx);
                  newX = centerX + Math.cos(angle) * maxRadius;
                  newY = centerY + Math.sin(angle) * maxRadius;
                }
                
                this.knobPosition = { x: newX, y: newY };
              })
              .onActionStart((event: GestureEvent) => {
                this.dragOffset = { x: event.offsetX, y: event.offsetY };
              })
          )
        
        // Centered Text or other overlays could go here if needed
      }
      .width(280)
      .height(280)
      .borderRadius(140)
      .backgroundColor(this.surfaceVariant)
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: 4 })

      Spacer({ size: 24 })

      // Status Text
      Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isRunning ? this.success : this.error)

      Spacer({ size: 24 })

      // Buttons Row
      Row() {
        Button('Start')
          .type(ButtonType.Circle)
          .width(90)
          .height(90)
          .backgroundColor(this.primary)
          .fontColor(this.onPrimary)
          .onClick(() => {
            this.isRunning = true;
          })

        Button('Stop')
          .type(ButtonType.Circle)
          .width(90)
          .height(90)
          .backgroundColor(this.tertiary)
          .fontColor(this.onSecondary)
          .onClick(() => {
            this.isRunning = false;
          })
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .width('100%')

      Spacer({ size: 24 })

      // Progress Indicator
      Progress({ value: this.calculateProgress(), total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(this.primary)
        .trackColor(Color.Transparent)
        .borderRadius(4)

    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
    .padding(16)
  }

  private drawCanvas(context: CanvasRenderingContext2D, width: number, height: number) {
    const centerX = width / 2;
    const centerY = height / 2;

    // Clear canvas
    context.clearRect(0, 0, width, height);

    // Draw background circle (secondary with alpha)
    context.beginPath();
    context.arc(centerX, centerY, 180, 0, 2 * Math.PI);
    context.fillStyle = this.hexToRgba(this.secondary, 0.4);
    context.fill();

    // Draw knob (primary)
    context.beginPath();
    context.arc(this.knobPosition.x, this.knobPosition.y, 30, 0, 2 * Math.PI);
    context.fillStyle = this.primary;
    context.fill();
  }

  private calculateProgress(): number {
    // Mimic the Kotlin logic: (knobPosition.x + knobPosition.y) % 400 / 400f
    // Note: In ArkTS, coordinates are pixels. The original code used Offset which is also pixels/dp depending on context.
    // We'll assume pixel values for simplicity in this conversion.
    const sum = this.knobPosition.x + this.knobPosition.y;
    const progress = (sum % 400) / 400;
    return progress * 100; // ProgressBar expects 0-100
  }

  private hexToRgba(hex: string, alpha: number): string {
    const r = parseInt(hex.slice(1, 3), 16);
    const g = parseInt(hex.slice(3, 5), 16);
    const b = parseInt(hex.slice(5, 7), 16);
    return `rgba(${r}, ${g}, ${b}, ${alpha})`;
  }
}