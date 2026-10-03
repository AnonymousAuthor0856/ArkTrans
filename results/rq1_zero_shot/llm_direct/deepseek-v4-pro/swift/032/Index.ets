@Entry
@Component
struct RootScreen {
  @State private markerPosition: Point = { x: 200, y: 400 } as Point;
  @State private progress: number = 0.4;

  private readonly primaryColor: string = '#FFA500';
  private readonly secondaryColor: string = '#FFC300';
  private readonly tertiaryColor: string = '#FFE066';
  private readonly backgroundColor: string = '#FFFBF2';
  private readonly surfaceColor: string = '#FFFFFF';
  private readonly surfaceVariantColor: string = '#FFEED6';
  private readonly outlineColor: string = '#F1C27D';
  private readonly successColor: string = '#22C55E';
  private readonly warningColor: string = '#F59E0B';
  private readonly errorColor: string = '#EF4444';
  private readonly onPrimaryColor: string = '#FFFFFF';
  private readonly onSecondaryColor: string = '#1E1E1E';
  private readonly onTertiaryColor: string = '#1E1E1E';
  private readonly onBackgroundColor: string = '#1E1E1E';
  private readonly onSurfaceColor: string = '#1E1E1E';

  private readonly spacingSm: number = 8;
  private readonly spacingMd: number = 12;
  private readonly spacingLg: number = 16;
  private readonly spacingXl: number = 24;
  private readonly spacingXxl: number = 32;

  @Builder
  private LinearProgressBar(progressValue: number) {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(8)
        .borderRadius(4)
        .backgroundColor(this.surfaceVariantColor)

      Row()
        .width(`${progressValue * 100}%`)
        .height(8)
        .borderRadius(4)
        .backgroundColor(this.primaryColor)
    }
    .width('100%')
    .height(8)
  }

  @Builder
  private TopAppBar() {
    Row() {
      Text('Transfer Wizard')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onSurfaceColor)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.backgroundColor)
  }

  @Builder
  private CanvasArea() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawCanvas();
      })
  }

  private drawCanvas(): void {
    const canvas = this.context;
    const canvasWidth = canvas.width;
    const canvasHeight = canvas.height;
    const centerX = canvasWidth / 2;
    const centerY = canvasHeight / 2;

    // Draw large background circle
    canvas.fillStyle = this.surfaceVariantColor;
    canvas.beginPath();
    canvas.arc(centerX, centerY, 260, 0, Math.PI * 2);
    canvas.fill();

    // Draw marker circle
    canvas.fillStyle = this.primaryColor;
    canvas.beginPath();
    canvas.arc(this.markerPosition.x, this.markerPosition.y, 20, 0, Math.PI * 2);
    canvas.fill();
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [[this.secondaryColor, 0.2], [this.backgroundColor, 1.0], [this.primaryColor, 0.2]]
        })

      Column({ space: 0 }) {
        // Top App Bar
        this.TopAppBar()

        // Main content area
        Stack({ alignContent: Alignment.Center }) {
          // Canvas
          this.CanvasArea()
            .width('100%')
            .height('100%')
            .padding(this.spacingXl)

          // Bottom content
          Column({ space: this.spacingLg }) {
            Text('Transfer Progress')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.onSurfaceColor)

            this.LinearProgressBar(this.progress)
              .width('80%')

            Row({ space: this.spacingMd }) {
              // "+" Button
              Button() {
                this.progress = Math.min(this.progress + 0.1, 1.0);
              }
              .width(64)
              .height(64)
              .borderRadius(32)
              .backgroundColor(this.primaryColor)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)

              Text('+')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.onPrimaryColor)

              // "-" Button
              Button() {
                this.progress = Math.max(this.progress - 0.1, 0.0);
              }
              .width(64)
              .height(64)
              .borderRadius(32)
              .backgroundColor(this.secondaryColor)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)

              Text('-')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.onSecondaryColor)
            }
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.End)
          .alignItems(HorizontalAlign.Center)
          .padding({ bottom: this.spacingXxl })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}