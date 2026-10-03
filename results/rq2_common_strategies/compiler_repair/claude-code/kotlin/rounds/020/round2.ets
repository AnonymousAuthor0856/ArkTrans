// 020RemoteControlen - Media - Retro Flat - en - 720x1280

class ColorTokens {
  primary: string = '#FFFF7A00';
  secondary: string = '#FFFFC300';
  tertiary: string = '#FFFFF3C0';
  background: string = '#FFFFF8E7';
  surface: string = '#FFFFFFFF';
  surfaceVariant: string = '#FFFFEBC8';
  outline: string = '#FFBCA789';
  success: string = '#FF28A745';
  warning: string = '#FFFFC107';
  error: string = '#FFDC3545';
  onPrimary: string = '#FFFFFFFF';
  onSecondary: string = '#FF1E1E1E';
  onTertiary: string = '#FF1E1E1E';
  onBackground: string = '#FF1E1E1E';
  onSurface: string = '#FF1E1E1E';
}

class ShapeTokens {
  small: number = 8;
  medium: number = 14;
  large: number = 24;
}

class SpacingTokens {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

class AppTokens {
  static Colors: ColorTokens = new ColorTokens();
  static Shapes: ShapeTokens = new ShapeTokens();
  static Spacing: SpacingTokens = new SpacingTokens();
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
          const touch: TouchObject = event.touches[0];
          this.knobPosition = { x: touch.x, y: touch.y };
          this.render();
        }
      })
  }

  private render(): void {
    const ctx: CanvasRenderingContext2D = this.ctx;
    const centerX: number = this.canvasSize / 2;
    const centerY: number = this.canvasSize / 2;
    ctx.clearRect(0, 0, this.canvasSize, this.canvasSize);
    ctx.beginPath();
    ctx.arc(centerX, centerY, 200, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(255, 195, 0, 0.2)';
    ctx.fill();
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

  build() {
    Column() {
      Text('Retro Remote Control')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 8, bottom: 8 })

      Column() {
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

        Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.powerOn ? AppTokens.Colors.success : AppTokens.Colors.error)
          .margin({ top: AppTokens.Spacing.xl })

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
