// AppTokens
class AppColors {
  static primary: string = '#FF7A00';
  static secondary: string = '#FFC300';
  static tertiary: string = '#FFF3C0';
  static background: string = '#FFF8E7';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#FFEBC8';
  static outline: string = '#BCA789';
  static success: string = '#28A745';
  static warning: string = '#FFC107';
  static error: string = '#DC3545';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#1E1E1E';
  static onTertiary: string = '#1E1E1E';
  static onBackground: string = '#1E1E1E';
  static onSurface: string = '#1E1E1E';
}

class AppSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 32;
}

@Entry
@Component
struct RootScreen {
  @State knobX: number = 90;
  @State knobY: number = 140;
  @State powerOn: boolean = false;

  private canvasWidth: number = 280;
  private canvasHeight: number = 280;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    const ctx = this.canvasContext;
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    const centerX = this.canvasWidth / 2;
    const centerY = this.canvasHeight / 2;

    // Background circle with secondary color opacity 0.2
    ctx.beginPath();
    ctx.arc(centerX, centerY, 100, 0, Math.PI * 2);
    ctx.fillStyle = 'rgba(255, 195, 0, 0.2)';
    ctx.fill();
    ctx.closePath();

    // Knob circle
    ctx.beginPath();
    ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2);
    ctx.fillStyle = AppColors.primary;
    ctx.fill();
    ctx.closePath();
  }

  build() {
    Column({ space: 0 }) {
      // Top spacer
      Blank()
        .height(40)
        .backgroundColor(AppColors.background)

      // Top Bar
      Stack() {
        Text('Retro Remote Control')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .backgroundColor(AppColors.background)
      .alignContent(Alignment.Center)

      // Scroll Content
      Scroll() {
        Column({ space: AppSpacing.xl }) {

          // Knob Surface
          Stack() {
            // Background fill
            Column()
              .width(280)
              .height(280)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(24)

            // Canvas for drawing
            Canvas(this.canvasContext)
              .width(280)
              .height(280)
              .borderRadius(24)
              .onReady(() => {
                this.drawCanvas();
              })
              .gesture(
                PanGesture({ fingers: 1, distance: 0 })
                  .onActionStart((event: GestureEvent) => {
                    const x = Math.max(16, Math.min(264, event.offsetX));
                    const y = Math.max(16, Math.min(264, event.offsetY));
                    this.knobX = x;
                    this.knobY = y;
                    this.drawCanvas();
                  })
                  .onActionUpdate((event: GestureEvent) => {
                    const x = Math.max(16, Math.min(264, event.offsetX));
                    const y = Math.max(16, Math.min(264, event.offsetY));
                    this.knobX = x;
                    this.knobY = y;
                    this.drawCanvas();
                  })
              )
          }
          .width(280)
          .height(280)
          .borderRadius(24)
          .shadow({
            radius: 4,
            color: '#1F000000',
            offsetX: 0,
            offsetY: 2
          })
          .margin({ top: AppSpacing.lg, left: AppSpacing.lg, right: AppSpacing.lg })
          .clip(true)

          // Power Status
          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.powerOn ? AppColors.success : AppColors.error)

          // Buttons Row
          Row({ space: 60 }) {
            // On Button
            Button({ type: ButtonType.Circle }) {
              Text('On')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onPrimary)
            }
            .width(80)
            .height(80)
            .backgroundColor(AppColors.primary)
            .onClick(() => {
              this.powerOn = !this.powerOn;
            })

            // Reset Button
            Button({ type: ButtonType.Circle }) {
              Column({ space: 0 }) {
                Text('Res')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSecondary)
                Text('et')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSecondary)
              }
            }
            .width(80)
            .height(80)
            .backgroundColor(AppColors.secondary)
            .onClick(() => {
              this.knobX = 90;
              this.knobY = 140;
              this.drawCanvas();
            })
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')

          // Progress Bar - full red
          Row()
            .width('100%')
            .height(6)
            .backgroundColor(AppColors.primary)
            .borderRadius(3)
            .margin({
              left: AppSpacing.lg,
              right: AppSpacing.lg
            })

        }
        .padding(AppSpacing.lg)
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .backgroundColor(AppColors.background)
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}