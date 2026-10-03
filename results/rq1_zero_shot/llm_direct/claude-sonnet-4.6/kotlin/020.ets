import { display } from '@kit.ArkUI';

// Design tokens
const AppColors = {
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

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
};

@Entry
@Component
struct RootScreen {
  @State knobX: number = 0;
  @State knobY: number = 0;
  @State powerOn: boolean = false;

  private canvasWidth: number = 280;
  private canvasHeight: number = 280;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    const ctx = this.canvasContext;
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    // Draw background circle
    const centerX = this.canvasWidth / 2;
    const centerY = this.canvasHeight / 2;
    ctx.beginPath();
    ctx.arc(centerX, centerY, 120, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(255, 195, 0, 0.2)';
    ctx.fill();

    // Draw knob
    if (this.knobX !== 0 || this.knobY !== 0) {
      ctx.beginPath();
      ctx.arc(this.knobX, this.knobY, 18, 0, Math.PI * 2);
      ctx.fillStyle = AppColors.primary;
      ctx.fill();
    } else {
      // Draw knob at center initially
      ctx.beginPath();
      ctx.arc(centerX, centerY, 18, 0, Math.PI * 2);
      ctx.fillStyle = AppColors.primary;
      ctx.fill();
    }
  }

  getProgressValue(): number {
    const raw = (this.knobX + this.knobY) % 400;
    return raw / 400;
  }

  build() {
    Column() {
      // Top bar
      Row() {
        Text('Retro Remote Control')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      // Main content
      Column({ space: AppSpacing.xl }) {

        // Canvas area
        Stack() {
          Canvas(this.canvasContext)
            .width(this.canvasWidth)
            .height(this.canvasHeight)
            .onReady(() => {
              this.knobX = this.canvasWidth / 2;
              this.knobY = this.canvasHeight / 2;
              this.drawCanvas();
            })
            .onTouch((event: TouchEvent) => {
              if (
                event.type === TouchType.Move ||
                event.type === TouchType.Down
              ) {
                const touch = event.touches[0];
                this.knobX = touch.x;
                this.knobY = touch.y;
                this.drawCanvas();
              }
            })
        }
        .width(this.canvasWidth)
        .height(this.canvasHeight)
        .borderRadius(24)
        .backgroundColor(AppColors.surfaceVariant)
        .shadow({
          radius: 8,
          color: '#1F000000',
          offsetX: 0,
          offsetY: 4
        })

        // Power status text
        Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.powerOn ? AppColors.success : AppColors.error)

        // Buttons row
        Row({ space: AppSpacing.xl }) {
          // Power button
          Button(this.powerOn ? 'Off' : 'On')
            .width(80)
            .height(80)
            .borderRadius(40)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .onClick(() => {
              this.powerOn = !this.powerOn;
            })

          // Reset button
          Button('Reset')
            .width(80)
            .height(80)
            .borderRadius(40)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .onClick(() => {
              this.knobX = this.canvasWidth / 2;
              this.knobY = this.canvasHeight / 2;
              this.drawCanvas();
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        // Progress bar
        Column() {
          Progress({
            value: this.getProgressValue() * 100,
            total: 100,
            type: ProgressType.Linear
          })
            .width('100%')
            .height(6)
            .color(AppColors.primary)
            .backgroundColor(AppColors.surfaceVariant)
        }
        .width('100%')

      }
      .width('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}