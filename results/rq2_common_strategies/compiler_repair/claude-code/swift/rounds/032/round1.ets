@Entry
@Component
struct TransferWizardApp {
  @State markerPositionX: number = 200;
  @State markerPositionY: number = 400;
  @State progress: number = 0.4;
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  private readonly Colors = {
    primary: '#FFA500',
    secondary: '#FFC300',
    tertiary: '#FFE066',
    background: '#FFFBF2',
    surface: '#FFFFFF',
    surfaceVariant: '#FFEED6',
    outline: '#F1C27D',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  };

  private readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  };

  private readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  aboutToAppear(): void {
    this.drawCanvasContent();
  }

  private drawCanvasContent(): void {
    const ctx = this.canvasCtx;
    const width = 360;
    const height = 400;
    const centerX = width / 2;
    const centerY = height / 2;

    // Large background circle (radius 260)
    ctx.beginPath();
    ctx.arc(centerX, centerY, 260, 0, Math.PI * 2);
    ctx.fillStyle = this.Colors.surfaceVariant;
    ctx.fill();

    // Marker circle (radius 20)
    ctx.beginPath();
    ctx.arc(this.markerPositionX, this.markerPositionY, 20, 0, Math.PI * 2);
    ctx.fillStyle = this.Colors.primary;
    ctx.fill();
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            ['rgba(255, 195, 0, 0.2)', 0.0],
            [this.Colors.background, 0.5],
            ['rgba(255, 165, 0, 0.2)', 1.0]
          ]
        })

      Column() {
        // Top AppBar
        Row() {
          Text('Transfer Wizard')
            .fontSize(this.Typography.display.size)
            .fontWeight(this.Typography.display.weight)
            .fontColor(this.Colors.onSurface)
        }
        .width('100%')
        .height(56)
        .backgroundColor(this.Colors.background)
        .justifyContent(FlexAlign.Center)

        // Main content area
        Stack({ alignContent: Alignment.Center }) {
          // Canvas with circles
          Canvas(this.canvasCtx)
            .width('100%')
            .height('100%')
            .padding(this.Spacing.xl)
            .onReady(() => {
              this.drawCanvasContent();
            })

          // Bottom content: progress section
          Column() {
            Text('Transfer Progress')
              .fontSize(this.Typography.title.size)
              .fontWeight(this.Typography.title.weight)
              .fontColor(this.Colors.onSurface)
              .margin({ bottom: this.Spacing.lg })

            // Custom linear progress bar
            Stack({ alignContent: Alignment.Start }) {
              // Track
              Row()
                .width('100%')
                .height(8)
                .backgroundColor(this.Colors.surfaceVariant)
                .borderRadius(4)

              // Progress fill
              Row()
                .width(`${this.progress * 100}%`)
                .height(8)
                .backgroundColor(this.Colors.primary)
                .borderRadius(4)
            }
            .width('80%')
            .margin({ bottom: this.Spacing.lg })

            // Button row
            Row() {
              // + Button
              Button('+')
                .width(64)
                .height(64)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .backgroundColor(this.Colors.primary)
                .fontColor(this.Colors.onPrimary)
                .borderRadius(32)
                .margin({ right: this.Spacing.md })
                .onClick(() => {
                  this.progress = Math.min(this.progress + 0.1, 1.0);
                })

              // - Button
              Button('-')
                .width(64)
                .height(64)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .backgroundColor(this.Colors.secondary)
                .fontColor(this.Colors.onSecondary)
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
          .padding({ bottom: this.Spacing.xxl })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.Colors.background)
  }
}
