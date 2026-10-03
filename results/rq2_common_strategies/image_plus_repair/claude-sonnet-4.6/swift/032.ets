// Design Tokens
const primaryColor: string = '#FFA500';
const secondaryColor: string = '#FFC300';
const backgroundColor: string = '#FFFBF2';
const surfaceVariantColor: string = '#FFEED6';
const onPrimaryColor: string = '#FFFFFF';
const onSecondaryColor: string = '#1E1E1E';
const onSurfaceColor: string = '#1E1E1E';

const spacingSm: number = 8;
const spacingMd: number = 12;
const spacingLg: number = 16;
const spacingXl: number = 24;
const spacingXxl: number = 32;

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.4;
  private markerX: number = 200;
  private markerY: number = 400;
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  private drawCanvas(): void {
    const ctx: CanvasRenderingContext2D = this.context;
    const width: number = ctx.width;
    const height: number = ctx.height;
    const centerX: number = width / 2;
    const centerY: number = height / 2;

    ctx.clearRect(0, 0, width, height);

    // Draw large background circle
    ctx.beginPath();
    ctx.arc(centerX, centerY, 260, 0, Math.PI * 2);
    ctx.fillStyle = surfaceVariantColor;
    ctx.fill();

    // Draw marker circle
    ctx.beginPath();
    ctx.arc(this.markerX, this.markerY, 20, 0, Math.PI * 2);
    ctx.fillStyle = primaryColor;
    ctx.fill();
  }

  build() {
    Stack() {
      // Background gradient
      Column() {
      }
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

      // Main content
      Column() {
        // Top App Bar
        Stack() {
          Row() {
          }
          .width('100%')
          .height(56)
          .backgroundColor(backgroundColor)

          Text('Transfer Wizard')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(onSurfaceColor)
        }
        .width('100%')
        .height(56)

        // Main content area
        Stack({ alignContent: Alignment.Center }) {
          // Canvas for drawing circles
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawCanvas();
            })

          // Bottom content
          Column({ space: spacingLg }) {
            Text('Transfer Progress')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(onSurfaceColor)

            // Progress bar
            Stack({ alignContent: Alignment.Start }) {
              // Track
              Row() {
              }
              .width('100%')
              .height(8)
              .borderRadius(4)
              .backgroundColor(surfaceVariantColor)

              // Progress fill
              Row() {
              }
              .width(`${this.progress * 100}%`)
              .height(8)
              .borderRadius(4)
              .backgroundColor(primaryColor)
            }
            .width('80%')
            .height(8)

            // Buttons row
            Row({ space: spacingMd }) {
              // "+" button
              Button('+')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .width(64)
                .height(64)
                .borderRadius(32)
                .backgroundColor(primaryColor)
                .fontColor(onPrimaryColor)
                .onClick(() => {
                  this.progress = Math.min(this.progress + 0.1, 1.0);
                })

              // "-" button
              Button('-')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .width(64)
                .height(64)
                .borderRadius(32)
                .backgroundColor(secondaryColor)
                .fontColor(onSecondaryColor)
                .onClick(() => {
                  this.progress = Math.max(this.progress - 0.1, 0.0);
                })
            }
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .padding({ bottom: spacingXxl })
          .height('100%')
          .justifyContent(FlexAlign.End)
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundColor)
  }
}