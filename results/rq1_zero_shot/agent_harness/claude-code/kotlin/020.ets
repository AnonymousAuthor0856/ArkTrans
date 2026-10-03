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

@Component
struct DraggableKnob {
  @Link knobPosition: { x: number; y: number };
  private canvasSize: number = 280 - 2 * AppTokens.Spacing.lg;

  aboutToAppear() {
    this.knobPosition = { x: this.canvasSize / 2, y: this.canvasSize / 2 };
  }

  build() {
    Canvas(this.canvasSettings)
      .width(this.canvasSize)
      .height(this.canvasSize)
      .onReady(() => {
        this.drawKnob();
      })
      .gesture(
        PanGesture()
          .onActionUpdate((event: GestureEvent) => {
            const newX = this.knobPosition.x + event.offsetX;
            const newY = this.knobPosition.y + event.offsetY;
            const centerX = this.canvasSize / 2;
            const centerY = this.canvasSize / 2;
            const dx = newX - centerX;
            const dy = newY - centerY;
            const dist = Math.sqrt(dx * dx + dy * dy);
            const maxRadius = 200;
            if (dist <= maxRadius) {
              this.knobPosition = { x: newX, y: newY };
            } else {
              const ratio = maxRadius / dist;
              this.knobPosition = {
                x: centerX + dx * ratio,
                y: centerY + dy * ratio
              };
            }
            this.drawKnob();
          })
      )
  }

  private canvasSettings = new CanvasRenderingContext2D();

  private drawKnob() {
    const ctx = this.canvasSettings;
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
  @State knobPosition: { x: number; y: number } = { x: 0, y: 0 };
  @State powerOn: boolean = false;

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
          DraggableKnob({ knobPosition: $knobPosition })
        }
        .width(280)
        .height(280)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.large)
        .padding(AppTokens.Spacing.lg)
        .justifyContent(FlexAlign.Center)
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
              const canvasSize = 280 - 2 * AppTokens.Spacing.lg;
              this.knobPosition = { x: canvasSize / 2, y: canvasSize / 2 };
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: AppTokens.Spacing.xl })

        // Progress indicator
        Progress({
          value: (Math.abs(this.knobPosition.x) + Math.abs(this.knobPosition.y)) % 400,
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
