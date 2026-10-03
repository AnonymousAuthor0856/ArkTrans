@Entry
@Component
struct Index {
  @State progress: number = 0.4;
  @State markerX: number = 200;
  @State markerY: number = 400;

  private readonly colors = {
    primary: '#FFFFA500',
    secondary: '#FFFFC300',
    tertiary: '#FFFFE066',
    background: '#FFFFFBF2',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFFFEED6',
    outline: '#FFF1C27D',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E'
  };

  build() {
    Stack() {
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
          Canvas(this.canvasSettings)
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
          .align(Alignment.Bottom)
          .margin({ bottom: 32 })
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }

  private canvasSettings: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  private drawCanvas(): void {
    const ctx = this.canvasSettings;
    const width = ctx.width;
    const height = ctx.height;
    const centerX = width / 2;
    const centerY = height / 2;

    ctx.clearRect(0, 0, width, height);

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
