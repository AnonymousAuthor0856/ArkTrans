// 024PomodoroTimeren.ets
import curves from '@ohos.curves';

// --- Design Tokens ---
class AppTokens {
  static readonly Colors = {
    primary: '#FF8FAB',
    secondary: '#B4E3D0',
    tertiary: '#FFD6A5',
    background: '#FFFCF9',
    surface: '#FFFFFF',
    surfaceVariant: '#FDE2E4',
    outline: '#FCC2D7',
    success: '#4ADE80',
    warning: '#FACC15',
    error: '#FB7185',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E',
  };
  static readonly Typography = {
    display: { fontSize: '30fp', fontWeight: FontWeight.Bold },
    title: { fontSize: '20fp', fontWeight: FontWeight.Medium },
    body: { fontSize: '14fp', fontWeight: FontWeight.Normal },
    label: { fontSize: '12fp', fontWeight: FontWeight.Medium },
  };
  static readonly Spacing = {
    sm: '8vp',
    md: '12vp',
    lg: '16vp',
    xl: '24vp',
  };
}

@Entry
@Component
struct RootScreen {
  @State knobPositionX: number = 0;
  @State knobPositionY: number = 0;
  @State isRunning: boolean = false;
  @State progressValue: number = 0;

  // Track container dimensions to calculate relative knob position
  private containerWidth: number = 0;
  private containerHeight: number = 0;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Pomodoro Timer')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height('56vp')
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Content Area
      Column() {
        // Circular Surface with Canvas
        Stack({ alignContent: Alignment.Center }) {
          // Background Circle
          Circle({ width: '280vp', height: '280vp' })
            .fill(AppTokens.Colors.surfaceVariant)
            .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: 4 });

          // Canvas for drawing
          Canvas(this)
            .width('280vp')
            .height('280vp')
            .onAreaChange((oldValue, newValue) => {
              this.containerWidth = newValue.width;
              this.containerHeight = newValue.height;
              // Initialize knob position to center
              if (this.knobPositionX === 0 && this.knobPositionY === 0) {
                this.knobPositionX = this.containerWidth / 2;
                this.knobPositionY = this.containerHeight / 2;
              }
            })
            .onTouch((event: TouchEvent) => {
              if (event.type === TouchType.Move || event.type === TouchType.Down) {
                this.knobPositionX = event.touches[0].x;
                this.knobPositionY = event.touches[0].y;
                // Update progress based on position
                this.progressValue = ((this.knobPositionX + this.knobPositionY) % 400) / 400;
              }
            })
            .onReady(() => {
              // Initial draw trigger
              this.knobPositionX = this.containerWidth / 2;
              this.knobPositionY = this.containerHeight / 2;
            });

          // Canvas Drawing Context
          CanvasRenderingContext2D
        }
        .width('280vp')
        .height('280vp')
        .margin({ top: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.xl })

        // Focus Mode Text
        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(this.isRunning ? AppTokens.Colors.success : AppTokens.Colors.error)
          .margin({ bottom: AppTokens.Spacing.xl })

        // Buttons Row
        Row({ space: parseInt(AppTokens.Spacing.lg) }) {
          Button('Start')
            .width('90vp')
            .height('90vp')
            .borderRadius('45vp')
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .onClick(() => {
              this.isRunning = true;
            })

          Button('Stop')
            .width('90vp')
            .height('90vp')
            .borderRadius('45vp')
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontColor(AppTokens.Colors.onSecondary)
            .onClick(() => {
              this.isRunning = false;
            })
        }
        .margin({ bottom: AppTokens.Spacing.xl })

        // Linear Progress Indicator
        Progress({ value: this.progressValue * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height('8vp')
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius('4vp')
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

// Custom Canvas Component to handle drawing
@Component
struct Canvas {
  @Link knobPositionX: number;
  @Link knobPositionY: number;
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true));
  private settings: RenderingContextSettings = new RenderingContextSettings(true);

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.draw();
      })
      // Re-draw when position changes
      .onChange(() => {
        this.draw();
      })
  }

  private draw() {
    const ctx = this.context;
    const w = ctx.canvas.width;
    const h = ctx.canvas.height;
    const center = { x: w / 2, y: h / 2 };

    ctx.clearRect(0, 0, w, h);

    // Draw secondary circle
    ctx.beginPath();
    ctx.arc(center.x, center.y, 180, 0, Math.PI * 2);
    ctx.fillStyle = AppTokens.Colors.secondary;
    ctx.globalAlpha = 0.4;
    ctx.fill();
    ctx.globalAlpha = 1.0;

    // Draw primary knob
    ctx.beginPath();
    ctx.arc(this.knobPositionX, this.knobPositionY, 30, 0, Math.PI * 2);
    ctx.fillStyle = AppTokens.Colors.primary;
    ctx.fill();
  }
}