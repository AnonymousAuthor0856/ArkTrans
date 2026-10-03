// Index.ets - Main Entry Point
interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationTokens {
  level1: ShadowSpec;
  level2: ShadowSpec;
}

class AppTokens {
  static Colors: ColorTokens = {
    primary: '#FF7A00',
    secondary: '#FFC300',
    tertiary: '#FFF3C0',
    background: '#FFF8E7',
    surface: '#FFFFFF',
    surfaceVariant: '#FFEBC8',
    outline: '#BCA789',
    success: '#28A745',
    warning: '#FFC107',
    error: '#DC3545',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E',
  }

  static TypographyTokens: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  }

  static Spacing: SpacingTokens = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  }

  static ElevationMapping: ElevationTokens = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.16 },
  }
}

@Entry
@Component
struct RootScreen {
  @State knobPositionX: number = 90;
  @State knobPositionY: number = 140;
  @State powerOn: boolean = false;
  
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private togglePower() {
    this.powerOn = !this.powerOn;
  }

  private resetKnob() {
    this.knobPositionX = 90;
    this.knobPositionY = 140;
    this.drawKnob();
  }

  build() {
    Column() {
      // Top spacing
      Column()
        .width('100%')
        .height(40)
        .backgroundColor(AppTokens.Colors.background)

      // Top Bar
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height(64)
          .backgroundColor(AppTokens.Colors.background)
        
        Text('Retro Remote Control')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .height(64)

      // Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.xl }) {
          // Knob Surface
          Stack() {
            // Background layer
            Column()
              .width('100%')
              .height('100%')
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(24)

            // Canvas Drawing
            Canvas(this.context)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawKnob();
              })
              .gesture(
                PanGesture({ distance: 0 })
                  .onActionStart((event: GestureEvent) => {
                    this.updateKnobPosition(event.fingerList[0].localX, event.fingerList[0].localY);
                  })
                  .onActionUpdate((event: GestureEvent) => {
                    this.updateKnobPosition(event.fingerList[0].localX, event.fingerList[0].localY);
                  })
              )
          }
          .width(280)
          .height(280)
          .borderRadius(24)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })
          .padding(AppTokens.Spacing.lg)

          // Power Status
          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(this.powerOn ? AppTokens.Colors.success : AppTokens.Colors.error)

          // Buttons Row
          Row({ space: 60 }) {
            // On Button
            Button(this.togglePower) {
              Text('On')
                .fontSize(AppTokens.TypographyTokens.title.size)
                .fontWeight(AppTokens.TypographyTokens.title.weight)
                .fontColor(AppTokens.Colors.onPrimary)
            }
            .width(80)
            .height(80)
            .borderRadius(40) // Circle
            .backgroundColor(AppTokens.Colors.primary)
            .padding(0)

            // Reset Button
            Button(this.resetKnob) {
              Column({ space: 0 }) {
                Text('Res')
                  .fontSize(AppTokens.TypographyTokens.title.size)
                  .fontWeight(AppTokens.TypographyTokens.title.weight)
                  .fontColor(AppTokens.Colors.onSecondary)
                Text('et')
                  .fontSize(AppTokens.TypographyTokens.title.size)
                  .fontWeight(AppTokens.TypographyTokens.title.weight)
                  .fontColor(AppTokens.Colors.onSecondary)
              }
            }
            .width(80)
            .height(80)
            .borderRadius(40) // Circle
            .backgroundColor(AppTokens.Colors.secondary)
            .padding(0)
          }

          // Progress Bar
          Column()
            .width('100%')
            .height(6)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(3) // Capsule shape
            .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .align(Alignment.Top)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private updateKnobPosition(x: number, y: number) {
    // Clamp values within the 280x280 box (with 16px padding for knob radius)
    let boundedX = Math.max(16, Math.min(264, x));
    let boundedY = Math.max(16, Math.min(264, y));
    
    this.knobPositionX = boundedX;
    this.knobPositionY = boundedY;
    this.drawKnob();
  }

  private drawKnob() {
    const ctx = this.context;
    const centerX = 140; 
    const centerY = 140; 

    // Clear canvas
    ctx.clearRect(0, 0, 280, 280);

    // Background circle
    ctx.beginPath();
    ctx.arc(centerX, centerY, 100, 0, Math.PI * 2);
    ctx.fillStyle = AppTokens.Colors.secondary;
    ctx.globalAlpha = 0.2;
    ctx.fill();
    ctx.globalAlpha = 1.0;

    // Knob circle
    ctx.beginPath();
    ctx.arc(this.knobPositionX, this.knobPositionY, 16, 0, Math.PI * 2);
    ctx.fillStyle = AppTokens.Colors.primary;
    ctx.fill();
  }
}