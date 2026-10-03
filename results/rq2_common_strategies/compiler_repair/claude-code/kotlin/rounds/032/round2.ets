class AppColors {
  primary: string = '#FFFFA500';
  secondary: string = '#FFFFC300';
  tertiary: string = '#FFFFE066';
  background: string = '#FFFFFBF2';
  surface: string = '#FFFFFFFF';
  surfaceVariant: string = '#FFFFEED6';
  outline: string = '#FFF1C27D';
  success: string = '#FF22C55E';
  warning: string = '#FFF59E0B';
  error: string = '#FFEF4444';
  onPrimary: string = '#FFFFFFFF';
  onSecondary: string = '#FF1E1E1E';
  onTertiary: string = '#FF1E1E1E';
  onBackground: string = '#FF1E1E1E';
  onSurface: string = '#FF1E1E1E';
}

@Entry
@Component
struct Index {
  @State progress: number = 0.4;
  private markerX: number = 200;
  private markerY: number = 400;
  private colors: AppColors = new AppColors();
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  build() {
    Column() {
      Row() {
        Text('Transfer Wizard')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.colors.background)

      Stack() {
        Canvas(this.canvasCtx)
          .width('100%')
          .height('100%')
          .padding(24)
          .onReady(() => {
            this.drawCanvas();
          })

        Column() {
          Text('Transfer Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onSurface)
            .margin({ bottom: 16 })

          Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
            .width('80%')
            .height(8)
            .color(this.colors.primary)
            .backgroundColor(this.colors.surfaceVariant)
            .margin({ bottom: 16 })

          Row() {
            Button('+')
              .width(56)
              .height(56)
              .borderRadius(28)
              .fontSize(24)
              .backgroundColor(this.colors.primary)
              .fontColor(this.colors.onPrimary)
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1.0);
              })

            Button('-')
              .width(56)
              .height(56)
              .borderRadius(28)
              .fontSize(24)
              .backgroundColor(this.colors.secondary)
              .fontColor(this.colors.onSecondary)
              .margin({ left: 12 })
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0.0);
              })
          }
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.End)
        .margin({ bottom: 32 })
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [this.colors.secondary + '33', 0.0],
          [this.colors.background, 0.5],
          [this.colors.primary + '33', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }

  private drawCanvas(): void {
    const ctx = this.canvasCtx;
    const centerX = ctx.width / 2;
    const centerY = ctx.height / 2;

    ctx.clearRect(0, 0, ctx.width, ctx.height);

    ctx.beginPath();
    ctx.arc(centerX, centerY, 260, 0, Math.PI * 2);
    ctx.fillStyle = this.colors.surfaceVariant;
    ctx.fill();

    ctx.beginPath();
    ctx.arc(this.markerX, this.markerY, 20, 0, Math.PI * 2);
    ctx.fillStyle = this.colors.primary;
    ctx.fill();
  }
}
