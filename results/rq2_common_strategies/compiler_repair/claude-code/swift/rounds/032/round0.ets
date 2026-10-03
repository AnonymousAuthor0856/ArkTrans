@Entry
@Component
struct TransferWizardApp {
  @State markerPosition: { x: number, y: number } = { x: 200, y: 400 };
  @State progress: number = 0.4;

  private readonly AppTokens = {
    Colors: {
      primary: Color(0xFFFFA500),
      secondary: Color(0xFFFFC300),
      tertiary: Color(0xFFFFE066),
      background: Color(0xFFFFFBF2),
      surface: Color(0xFFFFFFFF),
      surfaceVariant: Color(0xFFFFEED6),
      outline: Color(0xFFF1C27D),
      success: Color(0xFF22C55E),
      warning: Color(0xFFF59E0B),
      error: Color(0xFFEF4444),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFF1E1E1E),
      onTertiary: Color(0xFF1E1E1E),
      onBackground: Color(0xFF1E1E1E),
      onSurface: Color(0xFF1E1E1E)
    },
    TypographyTokens: {
      display: { size: 28, weight: FontWeight.Bold },
      title: { size: 18, weight: FontWeight.Medium },
      body: { size: 14, weight: FontWeight.Regular },
      label: { size: 12, weight: FontWeight.Medium }
    },
    Spacing: {
      sm: 8,
      md: 12,
      lg: 16,
      xl: 24,
      xxl: 32
    }
  };

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [this.AppTokens.Colors.secondary.opacity(0.2), 0.0],
            [this.AppTokens.Colors.background, 0.5],
            [this.AppTokens.Colors.primary.opacity(0.2), 1.0]
          ]
        })

      Column() {
        // Top AppBar
        Row() {
          Text('Transfer Wizard')
            .fontSize(this.AppTokens.TypographyTokens.display.size)
            .fontWeight(this.AppTokens.TypographyTokens.display.weight)
            .fontColor(this.AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(56)
        .backgroundColor(this.AppTokens.Colors.background)
        .justifyContent(FlexAlign.Center)

        // Main content area
        Stack({ alignContent: Alignment.Center }) {
          // Canvas with circles
          Canvas(this.canvasSettings)
            .width('100%')
            .height('100%')
            .padding(this.AppTokens.Spacing.xl)

          // Bottom content: progress section
          Column() {
            Text('Transfer Progress')
              .fontSize(this.AppTokens.TypographyTokens.title.size)
              .fontWeight(this.AppTokens.TypographyTokens.title.weight)
              .fontColor(this.AppTokens.Colors.onSurface)
              .margin({ bottom: this.AppTokens.Spacing.lg })

            // Custom linear progress bar
            Stack({ alignContent: Alignment.Start }) {
              // Track
              Row()
                .width('100%')
                .height(8)
                .backgroundColor(this.AppTokens.Colors.surfaceVariant)
                .borderRadius(4)

              // Progress fill
              Row()
                .width(`${this.progress * 100}%`)
                .height(8)
                .backgroundColor(this.AppTokens.Colors.primary)
                .borderRadius(4)
            }
            .width('80%')
            .margin({ bottom: this.AppTokens.Spacing.lg })

            // Button row
            Row() {
              // + Button
              Button('+')
                .width(64)
                .height(64)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .backgroundColor(this.AppTokens.Colors.primary)
                .fontColor(this.AppTokens.Colors.onPrimary)
                .borderRadius(32)
                .margin({ right: this.AppTokens.Spacing.md })
                .onClick(() => {
                  this.progress = Math.min(this.progress + 0.1, 1.0);
                })

              // - Button
              Button('-')
                .width(64)
                .height(64)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .backgroundColor(this.AppTokens.Colors.secondary)
                .fontColor(this.AppTokens.Colors.onSecondary)
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
          .padding({ bottom: this.AppTokens.Spacing.xxl })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.AppTokens.Colors.background)
  }

  private canvasSettings = new CanvasRenderingContext2D();

  @Builder
  private drawCanvas() {
    // Draw on canvas using onReady callback approach
  }
}
