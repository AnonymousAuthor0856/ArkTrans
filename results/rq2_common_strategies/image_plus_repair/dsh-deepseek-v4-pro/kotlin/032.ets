// Translation of 032.kt -> ArkTS (ArkUI)
// "Transfer Wizard" — Finance, Warm Gradient theme

class AppColors {
  static readonly primary: string = '#FFA500';
  static readonly secondary: string = '#FFC300';
  static readonly tertiary: string = '#FFE066';
  static readonly background: string = '#FFFBF2';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFEED6';
  static readonly outline: string = '#F1C27D';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

@Entry
@Component
struct TransferWizard {
  @State progress: number = 0.4;
  private markerX: number = 200;
  private markerY: number = 400;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private drawScene(): void {
    this.ctx.clearRect(0, 0, this.ctx.width, this.ctx.height);
    const cw: number = this.ctx.width;
    const ch: number = this.ctx.height;
    // large circle (surfaceVariant)
    this.ctx.fillStyle = AppColors.surfaceVariant;
    this.ctx.beginPath();
    this.ctx.arc(cw / 2, ch / 2, 260, 0, Math.PI * 2);
    this.ctx.fill();
    // marker circle (primary)
    this.ctx.fillStyle = AppColors.primary;
    this.ctx.beginPath();
    this.ctx.arc(this.markerX, this.markerY, 20, 0, Math.PI * 2);
    this.ctx.fill();
  }

  build() {
    Column() {
      // CenterAlignedTopAppBar
      Row() {
        Text('Transfer Wizard')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      // Body (Box with vertical gradient)
      Stack({ alignContent: Alignment.Bottom }) {
        Canvas(this.ctx)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawScene();
          })

        Column({ space: 16 }) {
          Text('Transfer Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
            .width('80%')
            .height(8)
            .color(AppColors.primary)
            .backgroundColor(AppColors.surfaceVariant)

          Row({ space: 12 }) {
            Button('+')
              .width(48)
              .height(48)
              .borderRadius(24)
              .backgroundColor(AppColors.primary)
              .fontColor(AppColors.onPrimary)
              .fontSize(20)
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1);
              })

            Button('-')
              .width(48)
              .height(48)
              .borderRadius(24)
              .backgroundColor(AppColors.secondary)
              .fontColor(AppColors.onSecondary)
              .fontSize(20)
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0);
              })
          }
        }
        .width('100%')
        .padding({ bottom: 32 })
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      .width('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#33FFC300', 0.0], ['#FFFBF2', 0.5], ['#33FFA500', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}