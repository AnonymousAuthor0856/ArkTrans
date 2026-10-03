import { router } from '@kit.ArkUI';

// Design tokens
const AppColors = {
  primary: '#FFFF8FAB',
  secondary: '#FFB4E3D0',
  tertiary: '#FFFFD6A5',
  background: '#FFFFFCF9',
  surface: '#FFFFFFFF',
  surfaceVariant: '#FFFDE2E4',
  outline: '#FFFCC2D7',
  success: '#FF4ADE80',
  warning: '#FFFACC15',
  error: '#FFFB7185',
  onPrimary: '#FFFFFFFF',
  onSecondary: '#FF1E1E1E',
  onTertiary: '#FF1E1E1E',
  onBackground: '#FF1E1E1E',
  onSurface: '#FF1E1E1E',
};

const Spacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
};

@Entry
@Component
struct RootScreen {
  @State knobX: number = 140;
  @State knobY: number = 140;
  @State isRunning: boolean = false;
  @State progressValue: number = 0;

  private canvasSize: number = 280;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    const ctx = this.context;
    ctx.clearRect(0, 0, this.canvasSize, this.canvasSize);

    // Background circle
    const center = this.canvasSize / 2;
    ctx.beginPath();
    ctx.arc(center, center, 180, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(180, 227, 208, 0.4)';
    ctx.fill();

    // Knob circle
    ctx.beginPath();
    ctx.arc(this.knobX, this.knobY, 30, 0, Math.PI * 2);
    ctx.fillStyle = AppColors.primary;
    ctx.fill();
  }

  updateProgress() {
    this.progressValue = ((this.knobX + this.knobY) % 400) / 400;
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Pomodoro Timer')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      // Main content
      Column({ space: Spacing.xl }) {

        // Circular canvas area
        Stack() {
          // Background surface circle
          Circle({ width: 280, height: 280 })
            .fill(AppColors.surfaceVariant)
            .shadow({
              radius: 8,
              color: 'rgba(0,0,0,0.18)',
              offsetX: 0,
              offsetY: 4
            })

          // Canvas for drawing
          Canvas(this.context)
            .width(this.canvasSize)
            .height(this.canvasSize)
            .borderRadius(this.canvasSize / 2)
            .onReady(() => {
              this.drawCanvas();
            })
            .gesture(
              PanGesture()
                .onActionStart((event: GestureEvent) => {
                  this.knobX = event.offsetX;
                  this.knobY = event.offsetY;
                  this.drawCanvas();
                  this.updateProgress();
                })
                .onActionUpdate((event: GestureEvent) => {
                  const x = event.offsetX;
                  const y = event.offsetY;
                  this.knobX = Math.max(0, Math.min(x, this.canvasSize));
                  this.knobY = Math.max(0, Math.min(y, this.canvasSize));
                  this.drawCanvas();
                  this.updateProgress();
                })
            )
        }
        .width(280)
        .height(280)
        .clip(true)
        .borderRadius(140)

        // Focus mode status text
        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? AppColors.success : AppColors.error)

        // Start / Stop buttons
        Row({ space: Spacing.lg }) {
          Button('Start')
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor(AppColors.primary)
            .fontColor(AppColors.onPrimary)
            .fontSize(16)
            .onClick(() => {
              this.isRunning = true;
            })

          Button('Stop')
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor(AppColors.tertiary)
            .fontColor(AppColors.onSecondary)
            .fontSize(16)
            .onClick(() => {
              this.isRunning = false;
            })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)

        // Progress bar
        Progress({
          value: this.progressValue * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .style({ strokeWidth: 8 })

      }
      .width('100%')
      .padding(Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}