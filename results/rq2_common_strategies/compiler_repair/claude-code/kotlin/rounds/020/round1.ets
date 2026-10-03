// 020RemoteControlen - Media - Retro Flat - en - 720x1280

class AppTokens {
  static Colors = {
    primary: '#FFFF7A00',
    secondary: '#FFFFC300',
    tertiary: '#FFFFF3C0',
    background: '#FFFFF8E7',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFFFEBC8',
    outline: '#FFBCA789',
    success: '#FF28A745',
    warning: '#FFFFC107',
    error: '#FFDC3545',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E'
  };

  static Shapes = {
    small: 8,
    medium: 14,
    large: 24
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };
}

interface Point {
  x: number;
  y: number;
}

@Component
struct KnobCanvas {
  @Link knobPosition: Point;
  private canvasSize: number = 280 - 2 * AppTokens.Spacing.lg;
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  aboutToAppear(): void {
    this.knobPosition = { x: 0, y: 0 };
  }

  build() {
    Canvas(this.ctx)
      .width(this.canvasSize)
      .height(this.canvasSize)
      .onReady(() => {
        this.render();
      })
      .onTouch((event: TouchEvent) => {
        if (event.type === TouchType.Down || event.type === TouchType.Move) {
          const touch = event.touches[0];
          this.knobPosition = { x: touch.x, y: touch.y };
          this.render();
        }
      })
  }

  private render(): void {
    const ctx = this.ctx;
    const centerX = this.canvasSize / 2;
    const centerY = this.canvasSize / 2;
    ctx.clearRect(0, 0, this.canvasSize, this.canvasSize);
    // Outer ring
    ctx.beginPath();
    ctx.arc(centerX, centerY, 200, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(255, 195, 0, 0.2)';
    ctx.fill();
    // Knob
    ctx.beginPath();
    ctx.arc(this.knobPosition.x, this.knobPosition.y, 24, 0, Math.PI * 2);
    ctx.fillStyle = AppTokens.Colors.primary;
    ctx.fill();
  }
}

@Entry
@Component
struct RootScreen {
  @State knobPosition: Point = { x: 0, y: 0 };
  @State powerOn: boolean = false;
  @State progressValue: number = 0;

  private canvasSize: number = 280 - 2 * AppTokens.Spacing.lg;

  build() {
    Column() {
      // Top bar title
      Text('Retro Remote Control')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 8, bottom: 8 })

      Column() {
        // Canvas surface
        Stack() {
          KnobCanvas({ knobPosition: $knobPosition })
        }
        .width(280)
        .height(280)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.large)
        .padding(AppTokens.Spacing.lg)
        .alignContent(Alignment.Center)
        .shadow({
          radius: 4,
          color: 'rgba(0, 0, 0, 0.12)',
          offsetY: 2
        })

        // Power status text
        Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.powerOn ? AppTokens.Colors.success : AppTokens.Colors.error)
          .margin({ top: AppTokens.Spacing.xl })

        // Buttons row
        Row() {
          Button(this.powerOn ? 'Off' : 'On')
            .width(80)
            .height(80)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .borderRadius(40)
            .onClick(() => {
              this.powerOn = !this.powerOn;
            })

          Button('Reset')
            .width(80)
            .height(80)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .borderRadius(40)
            .onClick(() => {
              this.knobPosition = { x: 0, y: 0 };
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: AppTokens.Spacing.xl })

        // Progress indicator
        Progress({
          value: (this.knobPosition.x + this.knobPosition.y) % 400,
          total: 400,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .margin({ top: AppTokens.Spacing.xl })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
