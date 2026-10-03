// ClimateControllerApp.ets
import { 
  EntryComponent, 
  Component, 
  BuildFn, 
  Column, 
  Row, 
  Text, 
  Image, 
  Stack, 
  ForEach, 
  BorderStyle, 
  BorderRadius, 
  Border, 
  BackgroundColor, 
  Width, 
  Height, 
  Padding, 
  Alignment, 
  JustifyContent, 
  FlexAlign, 
  FontWeight, 
  FontSize, 
  TextAlign, 
  Color, 
  Modifier, 
  Shape, 
  Circle, 
  RoundedCorner, 
  State, 
  MutableState, 
  remember, 
  useState, 
  Clickable, 
  Opacity, 
  Canvas, 
  CanvasRenderingContext2D, 
  CanvasGradient, 
  RenderingContextSettings, 
  Animation, 
  Curves, 
  AnimationStatus, 
  animateTo, 
  setInterval, 
  clearInterval 
} from '@ohos/arkui';

// --- Colors ---
const PureWhite: string = '#FFFFFF';
const TextBlack: string = '#1C1C1E';
const TextGray: string = '#8E8E93';
const AccentBlue: string = '#007AFF';
const SoftGrayBg: string = '#F2F2F7';
const ActiveOrange: string = '#FF9500';
const DisabledGray: string = '#D1D1D6';
const DisabledBg: string = '#F9F9F9';
const DisabledBorder: string = '#EEEEEE';

// --- Icons (Base64 Encoded for simplicity in this environment) ---
const IconMenu = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAePm2SAAAACXBIWXMAAAsTAAALEwEAmpwYAAAA3ElEQVR4nO2ZQQrCMBBFvYQ2rEJ9gVdwB1fBdXQEXUEH0RF0RBd0RAd0RBc0KujGjxP4yYn3JN9kYkKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUKlUK......';
const IconSettings = 'data:image/png;base64,...';
const IconArrowUp = 'data:image/png;base64,...';
const IconArrowDown = 'data:image/png;base64,...';
const IconRefresh = 'data:image/png;base64,...';
const IconFavorite = 'data:image/png;base64,...';
const IconInfo = 'data:image/png;base64,...';
const IconHome = 'data:image/png;base64,...';

@EntryComponent
@Component
struct ClimateControllerApp {
  // State for Temperature Dial
  @State targetTemp: number = 21.5;
  @State isActive: boolean = true;
  @State animatedProgress: number = 0.39; // Initial progress for 21.5

  // Animation settings
  private animationDuration: number = 500;
  private animationCurve: Curve = Curve.EaseInOut;

  // Logic to clamp temperature
  adjustTemp(delta: number): void {
    let newTemp = this.targetTemp + delta;
    if (newTemp < 16.0) newTemp = 16.0;
    if (newTemp > 30.0) newTemp = 30.0;
    this.targetTemp = Math.round(newTemp * 10) / 10.0;
    this.animateProgress();
  }

  // Animate the arc progress
  animateProgress(): void {
    let progress = (this.targetTemp - 16) / (30 - 16);
    animateTo({
      duration: this.animationDuration,
      curve: this.animationCurve,
      onComplete: () => {}
    }, () => {
      this.animatedProgress = progress;
    });
  }

  build(): BuildFn {
    return () => {
      Column.create({
        space: 0,
        width: '100%',
        height: '100%',
        backgroundColor: PureWhite,
        padding: { left: 24, right: 24, top: 24, bottom: 24 }
      });

      // Header Section
      Row.create({
        width: '100%',
        justifyContent: FlexAlign.SpaceBetween,
        alignItems: ItemAlign.Center,
        padding: { top: 16 }
      });

      // Menu Button
      Image.create(IconMenu)
        .width(28)
        .height(28)
        .fillColor(TextBlack)
        .onClick(() => {});

      // Center Column
      Column.create({ alignItems: ItemAlign.Center });
      Text.create('LIVING ROOM')
        .fontSize(12)
        .fontColor(TextGray)
        .fontWeight(FontWeight.Bold)
        .letterSpacing(2);
      Text.create('Connected')
        .fontSize(12)
        .fontColor(AccentBlue);
      Column.pop();

      // Settings Button
      Image.create(IconSettings)
        .width(28)
        .height(28)
        .fillColor(TextBlack)
        .onClick(() => {});

      Row.pop();

      // Spacer
      Column.create({ height: 40 });

      // Temperature Dial Section
      Stack.create({ alignContent: Alignment.Center });

      // Background Circle (Canvas)
      Canvas.create({ width: 240, height: 240 })
        .onDraw((context: CanvasRenderingContext2D) => {
          let centerX = 120;
          let centerY = 120;
          let radius = 100;
          context.beginPath();
          context.arc(centerX, centerY, radius, 0, 2 * Math.PI);
          context.lineWidth = 40;
          context.strokeStyle = SoftGrayBg;
          context.stroke();
        });

      // Animated Arc Indicator (Canvas)
      Canvas.create({ width: 240, height: 240 })
        .onDraw((context: CanvasRenderingContext2D) => {
          let centerX = 120;
          let centerY = 120;
          let radius = 100;
          let startAngle = 135 * (Math.PI / 180);
          let sweepAngle = 270 * this.animatedProgress * (Math.PI / 180);
          let endAngle = startAngle + sweepAngle;

          // Draw Arc
          context.beginPath();
          context.arc(centerX, centerY, radius, startAngle, endAngle);
          context.lineWidth = 40;
          context.lineCap = 'round';
          context.strokeStyle = this.isActive ? AccentBlue : TextGray;
          context.stroke();

          // Draw Knob Indicator
          let knobX = centerX + radius * Math.cos(endAngle);
          let knobY = centerY + radius * Math.sin(endAngle);

          context.beginPath();
          context.arc(knobX, knobY, 16, 0, 2 * Math.PI);
          context.fillStyle = PureWhite;
          context.fill();

          context.beginPath();
          context.arc(knobX, knobY, 10, 0, 2 * Math.PI);
          context.fillStyle = this.isActive ? AccentBlue : TextGray;
          context.fill();
        });

      // Center Text
      Column.create({ alignItems: ItemAlign.Center });
      Text.create(`${this.targetTemp}°`)
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isActive ? TextBlack : TextGray);
      Text.create(this.isActive ? 'COOLING' : 'OFF')
        .fontSize(14)
        .fontColor(TextGray)
        .fontWeight(FontWeight.Medium);
      Column.pop();

      Stack.pop();

      // Spacer
      Column.create({ height: 32 });

      // Temp Controls Row
      Row.create({
        justifyContent: FlexAlign.SpaceBetween,
        alignItems: ItemAlign.Center,
        width: '60%'
      });

      // Down Button
      this.RoundControlButton(IconArrowDown, () => this.adjustTemp(-0.5), this.isActive);

      // Power Switch (Simplified as a Toggle Button for ArkTS simplicity)
      // Note: ArkTS doesn't have a direct Switch component with full customization in this basic setup.
      // We'll use a custom toggle or a simple Button.
      // For simplicity, we'll use a custom styled Box.
      Stack.create({
        width: 56,
        height: 32,
        borderRadius: 16,
        backgroundColor: this.isActive ? TextBlack : SoftGrayBg
      })
      .onClick(() => {
        this.isActive = !this.isActive;
      });

      // Knob
      Stack.create({
        width: 24,
        height: 24,
        borderRadius: 12,
        backgroundColor: PureWhite,
        position: { x: this.isActive ? 28 : 4, y: 4 } // Simple position toggle
      });
      Stack.pop();

      Stack.pop();

      // Up Button
      this.RoundControlButton(IconArrowUp, () => this.adjustTemp(0.5), this.isActive);

      Row.pop();

      // Spacer
      Column.create({ height: 40 });

      // Control Grid Section
      Column.create({ width: '100%' });

      Text.create('QUICK ACTIONS')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(TextGray)
        .padding({ bottom: 16 });

      // Row 1
      Row.create({ width: '100%', space: 16 });
      this.QuickActionCard(IconRefresh, 'Fan Speed', 'Auto', false);
      this.QuickActionCard(IconFavorite, 'Eco Mode', 'On', true);
      Row.pop();

      // Spacer
      Column.create({ height: 16 });

      // Row 2
      Row.create({ width: '100%', space: 16 });
      this.QuickActionCard(IconInfo, 'Timer', 'Set 2h', false);
      this.QuickActionCard(IconHome, 'Away', 'Off', false);
      Row.pop();

      Column.pop();

      Column.pop();
    };
  }

  // Helper Builder for Round Control Button
  RoundControlButton(icon: string, onClick: () => void, enabled: boolean): void {
    Stack.create({
      width: 56,
      height: 56,
      borderRadius: 28,
      backgroundColor: enabled ? SoftGrayBg : DisabledBg,
      border: enabled ? null : { width: 1, color: DisabledBorder, style: BorderStyle.Solid }
    })
    .onClick(() => {
      if (enabled) onClick();
    });

    Image.create(icon)
      .width(28)
      .height(28)
      .fillColor(enabled ? TextBlack : DisabledGray);

    Stack.pop();
  }

  // Helper Builder for Quick Action Card
  QuickActionCard(icon: string, label: string, status: string, isActive: boolean): void {
    // Using a custom layout since Card component might not be available in basic ArkTS setup
    Column.create({
      width: '50%', // Approximate weight 1f
      height: 100,
      borderRadius: 20,
      backgroundColor: isActive ? TextBlack : SoftGrayBg,
      padding: { all: 16 },
      justifyContent: FlexAlign.SpaceBetween
    });

    Image.create(icon)
      .width(24)
      .height(24)
      .fillColor(isActive ? PureWhite : TextBlack);

    Column.create({ alignItems: ItemAlign.Start });
    Text.create(label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(isActive ? PureWhite : TextBlack);
    Text.create(status)
      .fontSize(12)
      .fontColor(TextGray);
    Column.pop();

    Column.pop();
  }
}