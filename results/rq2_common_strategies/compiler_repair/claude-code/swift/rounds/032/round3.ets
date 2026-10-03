@Entry
@Component
struct TransferWizardApp {
  @State markerPositionX: number = 200;
  @State markerPositionY: number = 400;
  @State progress: number = 0.4;
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  private readonly primaryColor: string = '#FFA500';
  private readonly secondaryColor: string = '#FFC300';
  private readonly tertiaryColor: string = '#FFE066';
  private readonly bgColor: string = '#FFFBF2';
  private readonly surfaceColor: string = '#FFFFFF';
  private readonly surfaceVariantColor: string = '#FFEED6';
  private readonly outlineC: string = '#F1C27D';
  private readonly successColor: string = '#22C55E';
  private readonly warningColor: string = '#F59E0B';
  private readonly errorColor: string = '#EF4444';
  private readonly onPrimaryColor: string = '#FFFFFF';
  private readonly onSecondaryColor: string = '#1E1E1E';
  private readonly onTertiaryColor: string = '#1E1E1E';
  private readonly onBackgroundColor: string = '#1E1E1E';
  private readonly onSurfaceColor: string = '#1E1E1E';

  private readonly displaySize: number = 28;
  private readonly displayWeight: number = FontWeight.Bold;
  private readonly titleSize: number = 18;
  private readonly titleWeight: number = FontWeight.Medium;
  private readonly bodySize: number = 14;
  private readonly bodyWeight: number = FontWeight.Regular;
  private readonly labelSize: number = 12;
  private readonly labelWeight: number = FontWeight.Medium;

  private readonly sm: number = 8;
  private readonly md: number = 12;
  private readonly lg: number = 16;
  private readonly xl: number = 24;
  private readonly xxl: number = 32;

  aboutToAppear(): void {
    this.drawCanvasContent();
  }

  private drawCanvasContent(): void {
    const ctx: CanvasRenderingContext2D = this.canvasCtx;
    const width: number = 360;
    const height: number = 400;
    const centerX: number = width / 2;
    const centerY: number = height / 2;

    ctx.beginPath();
    ctx.arc(centerX, centerY, 260, 0, Math.PI * 2);
    ctx.fillStyle = this.surfaceVariantColor;
    ctx.fill();

    ctx.beginPath();
    ctx.arc(this.markerPositionX, this.markerPositionY, 20, 0, Math.PI * 2);
    ctx.fillStyle = this.primaryColor;
    ctx.fill();
  }

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            ['rgba(255, 195, 0, 0.2)', 0.0],
            [this.backgroundColor, 0.5],
            ['rgba(255, 165, 0, 0.2)', 1.0]
          ]
        })

      Column() {
        Row() {
          Text('Transfer Wizard')
            .fontSize(this.displaySize)
            .fontWeight(this.displayWeight)
            .fontColor(this.onSurfaceColor)
        }
        .width('100%')
        .height(56)
        .backgroundColor(this.backgroundColor)
        .justifyContent(FlexAlign.Center)

        Stack({ alignContent: Alignment.Center }) {
          Canvas(this.canvasCtx)
            .width('100%')
            .height('100%')
            .padding(this.xl)
            .onReady(() => {
              this.drawCanvasContent();
            })

          Column() {
            Text('Transfer Progress')
              .fontSize(this.titleSize)
              .fontWeight(this.titleWeight)
              .fontColor(this.onSurfaceColor)
              .margin({ bottom: this.lg })

            Stack({ alignContent: Alignment.Start }) {
              Row()
                .width('100%')
                .height(8)
                .backgroundColor(this.surfaceVariantColor)
                .borderRadius(4)

              Row()
                .width(`${this.progress * 100}%`)
                .height(8)
                .backgroundColor(this.primaryColor)
                .borderRadius(4)
            }
            .width('80%')
            .margin({ bottom: this.lg })

            Row() {
              Button('+')
                .width(64)
                .height(64)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .backgroundColor(this.primaryColor)
                .fontColor(this.onPrimaryColor)
                .borderRadius(32)
                .margin({ right: this.md })
                .onClick(() => {
                  this.progress = Math.min(this.progress + 0.1, 1.0);
                })

              Button('-')
                .width(64)
                .height(64)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .backgroundColor(this.secondaryColor)
                .fontColor(this.onSecondaryColor)
                .borderRadius(32)
                .onClick(() => {
                  this.progress = Math.max(this.progress - 0.1, 0.0);
                })
            }
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.End)
          .alignItems(HorizontalAlign.Center)
          .padding({ bottom: this.xxl })
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
