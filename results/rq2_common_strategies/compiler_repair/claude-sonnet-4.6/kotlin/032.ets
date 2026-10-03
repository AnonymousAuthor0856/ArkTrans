@Entry
@Component
struct RootScreen {
  @State progress: number = 0.4;

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Transfer Wizard')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFBF2')

      // Main Content Area
      Stack() {
        // Background gradient simulation
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              ['#33FFC300', 0.0],
              ['#FFFBF2', 0.5],
              ['#33FFA500', 1.0]
            ]
          })

        // Canvas for circles
        Canvas(this.context)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawCanvas();
          })

        // Bottom controls
        Column() {
          Text('Transfer Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
            .margin({ bottom: 12 })

          Progress({
            value: this.progress * 100,
            total: 100,
            type: ProgressType.Linear
          })
            .width('80%')
            .height(8)
            .color('#FFA500')
            .backgroundColor('#FFEED6')
            .margin({ bottom: 16 })

          Row() {
            Button('+')
              .width(56)
              .height(56)
              .borderRadius(28)
              .backgroundColor('#FFA500')
              .fontColor('#FFFFFF')
              .fontSize(20)
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1.0);
              })
              .margin({ right: 12 })

            Button('-')
              .width(56)
              .height(56)
              .borderRadius(28)
              .backgroundColor('#FFC300')
              .fontColor('#1E1E1E')
              .fontSize(20)
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0.0);
              })
          }
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .padding({ bottom: 32 })
        .position({ x: 0, y: 0 })
        .markAnchor({ x: 0, y: 0 })
        .offset({ x: 0, y: 0 })
        .align(Alignment.Bottom)
      }
      .width('100%')
      .layoutWeight(1)
      .alignContent(Alignment.Bottom)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFBF2')
  }

  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  private drawCanvas(): void {
    const ctx = this.context;
    const width = ctx.width;
    const height = ctx.height;
    const centerX = width / 2;
    const centerY = height / 2;

    // Draw background circle
    ctx.beginPath();
    ctx.arc(centerX, centerY, 260, 0, Math.PI * 2);
    ctx.fillStyle = '#FFEED6';
    ctx.fill();
    ctx.closePath();

    // Draw marker circle
    ctx.beginPath();
    ctx.arc(200, 400, 20, 0, Math.PI * 2);
    ctx.fillStyle = '#FFA500';
    ctx.fill();
    ctx.closePath();
  }
}