@Entry
@Component
struct TransferWizardPage {
  @State markerPosition: Point = { x: 200, y: 400 };
  @State progress: number = 0.4;

  build() {
    Stack() {
      // Background vertical gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          colors: [
            ['#33FFC300', 0.0],
            ['#FFFBF2', 0.5],
            ['#33FFA500', 1.0]
          ],
          direction: GradientDirection.Bottom
        })

      Column({ space: 0 }) {
        // Top App Bar
        Stack() {
          Column()
            .width('100%')
            .height(56)
            .backgroundColor('#FFFBF2')

          Text('Transfer Wizard')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E1E1E')
        }
        .width('100%')

        // Main content area
        Stack() {
          // Canvas with large circle and marker circle
          Canvas(this.canvasSettings)
            .width('100%')
            .height('100%')
            .padding(24)
            .onReady(() => {
              this.drawCanvas();
            })

          // Bottom content: title, progress bar, buttons
          Column({ space: 16 }) {
            Text('Transfer Progress')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1E1E1E')

            // Custom linear progress bar
            this.ProgressBar(this.progress, '#FFA500', '#FFEED6', 8)
              .width('80%')

            // Button row
            Row({ space: 12 }) {
              // "+" button
              Button('+')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .width(64)
                .height(64)
                .backgroundColor('#FFA500')
                .borderRadius(32)
                .onClick(() => {
                  this.progress = Math.min(this.progress + 0.1, 1.0);
                })

              // "-" button
              Button('-')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1E1E1E')
                .width(64)
                .height(64)
                .backgroundColor('#FFC300')
                .borderRadius(32)
                .onClick(() => {
                  this.progress = Math.max(this.progress - 0.1, 0.0);
                })
            }
          }
          .width('100%')
          .height('100%')
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.End)
          .padding({ bottom: 32 })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFBF2')
  }

  private canvasSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings);

  @Builder
  ProgressBar(progress: number, progressColor: string, trackColor: string, height: number) {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Row()
        .width('100%')
        .height(height)
        .backgroundColor(trackColor)
        .borderRadius(height / 2)

      // Progress fill
      Row()
        .width(`${progress * 100}%`)
        .height(height)
        .backgroundColor(progressColor)
        .borderRadius(height / 2)
    }
    .width('100%')
    .height(height)
  }

  drawCanvas() {
    let ctx = this.canvasCtx;
    // Get canvas size - we'll use approximate values based on screen
    // The canvas fills the area minus padding(24)
    // We'll draw relative to the canvas center
    let w = ctx.width;
    let h = ctx.height;
    let centerX = w / 2;
    let centerY = h / 2;

    // Large background circle (surfaceVariant) - radius 260
    ctx.beginPath();
    ctx.arc(centerX, centerY, 260, 0, Math.PI * 2);
    ctx.fillStyle = '#FFEED6';
    ctx.fill();

    // Marker circle (primary) - radius 20
    ctx.beginPath();
    ctx.arc(this.markerPosition.x, this.markerPosition.y, 20, 0, Math.PI * 2);
    ctx.fillStyle = '#FFA500';
    ctx.fill();
  }
}

interface Point {
  x: number;
  y: number;
}
