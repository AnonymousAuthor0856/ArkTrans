// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
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
  };

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 8,
    medium: 14,
    large: 24,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };

  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.16 },
  };
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  @State knobPositionX: number = 90;
  @State knobPositionY: number = 140;
  @State powerOn: boolean = false;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Column() {
      // Top spacing
      Column()
        .height(40)
        .width('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Top Bar
      Stack({ alignContent: Alignment.Center }) {
        Text('Retro Remote Control')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(64)
      .backgroundColor(AppTokens.Colors.background)

      // Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.xl }) {
          // Knob Surface
          Stack({ alignContent: Alignment.Center }) {
            // Canvas for drawing knob
            Canvas(this.context)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawKnob();
              })
              .gesture(
                PanGesture({ fingers: 1, distance: 0 })
                  .onActionUpdate((event: GestureEvent) => {
                    // Clamp coordinates within the 280x280 box
                    this.knobPositionX = Math.max(16, Math.min(264, event.fingerList[0].localX));
                    this.knobPositionY = Math.max(16, Math.min(264, event.fingerList[0].localY));
                    this.drawKnob();
                  })
              )
          }
          .width(280)
          .height(280)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
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
            Button() {
              Text('On')
                .fontSize(AppTokens.TypographyTokens.title.size)
                .fontWeight(AppTokens.TypographyTokens.title.weight)
                .fontColor(AppTokens.Colors.onPrimary)
            }
            .width(80)
            .height(80)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(40) // Circle
            .onClick(() => {
              this.powerOn = !this.powerOn;
            })

            // Reset Button
            Button() {
              Column() {
                Text('Res')
                Text('et')
              }
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
            }
            .width(80)
            .height(80)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(40) // Circle
            .onClick(() => {
              this.knobPositionX = 90;
              this.knobPositionY = 140;
              this.drawKnob();
            })
          }

          // Progress Bar
          Row()
            .width('100%')
            .height(6)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(3) // Capsule
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
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

  private drawKnob() {
    const ctx = this.context;
    const w = 280;
    const h = 280;
    const centerX = w / 2;
    const centerY = h / 2;

    // Clear canvas
    ctx.clearRect(0, 0, w, h);

    // Background circle
    ctx.fillStyle = AppTokens.Colors.secondary;
    ctx.globalAlpha = 0.2;
    ctx.beginPath();
    ctx.arc(centerX, centerY, 100, 0, Math.PI * 2);
    ctx.fill();

    // Knob circle
    ctx.globalAlpha = 1.0;
    ctx.fillStyle = AppTokens.Colors.primary;
    ctx.beginPath();
    ctx.arc(this.knobPositionX, this.knobPositionY, 16, 0, Math.PI * 2);
    ctx.fill();
  }
}