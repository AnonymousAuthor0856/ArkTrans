// NAME: 051*InstallmentPlan*en
// UI_TYPE: Finance
// STYLE_THEME: Warm Gradient
// LANG: en
// BASELINE_SIZE: 720x1280



namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FFFFA500';
    export const secondary: string = '#FFFFC107';
    export const tertiary: string = '#FFFFE066';
    export const background: string = '#FFFFFBF2';
    export const surface: string = '#FFFFFFFF';
    export const surfaceVariant: string = '#FFFFEED6';
    export const outline: string = '#FFFFC27D';
    export const success: string = '#FF22C55E';
    export const warning: string = '#FFF59E0B';
    export const error: string = '#FFEF4444';
    export const onPrimary: string = '#FFFFFFFF';
    export const onSecondary: string = '#FF1E1E1E';
    export const onTertiary: string = '#FF1E1E1E';
    export const onBackground: string = '#FF1E1E1E';
    export const onSurface: string = '#FF1E1E1E';
  }
  export namespace Spacing {
    export const sm: Length = 8;
    export const md: Length = 12;
    export const lg: Length = 16;
    export const xl: Length = 24;
    export const xxl: Length = 32;
  }
  export namespace Radius {
    export const small: Length = 6;
    export const medium: Length = 12;
    export const large: Length = 20;
  }
}

@Entry
@Component
struct InstallmentPlanPage {
  @State paymentProgress: number = 0.3;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear(): void {
    this.drawWave();
  }

  private drawWave(): void {
    const w: number = 360;
    const h: number = 200;
    this.ctx.clearRect(0, 0, w, h);
    const step: number = w / 20;
    let prevY: number = h / 2;
    this.ctx.strokeStyle = AppTokens.Colors.primary;
    this.ctx.lineWidth = 5;
    this.ctx.lineCap = 'round';
    this.ctx.lineJoin = 'round';
    this.ctx.beginPath();
    for (let i: number = 0; i <= 20; i++) {
      const x: number = i * step;
      const y: number = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
      if (i === 0) {
        this.ctx.moveTo(x, y);
      } else {
        this.ctx.lineTo(x, y);
      }
      prevY = y;
    }
    this.ctx.stroke();
  }

  build() {
    Column() {
      // Top bar
      Row() {
        Text('Installment Plan')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Column() {
        // Wave card
        Stack() {
          Canvas(this.ctx)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawWave();
            })
        }
        .width('100%')
        .height(240)
        .backgroundColor('rgba(255, 255, 255, 0.9)')
        .borderRadius(AppTokens.Radius.large)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetY: 4
        })
        .padding(AppTokens.Spacing.lg)
        .clip(true)

        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.lg })

        // Linear progress indicator
        Progress({ value: this.paymentProgress * 100, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(4)
          .margin({ top: AppTokens.Spacing.md })

        // Slider
        Slider({
          value: this.paymentProgress * 100,
          min: 0,
          max: 100,
          step: 1,
          style: SliderStyle.OutSet
        })
          .blockColor(AppTokens.Colors.secondary)
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .width('100%')
          .margin({ top: AppTokens.Spacing.md })
          .onChange((value: number) => {
            this.paymentProgress = value / 100;
            this.drawWave();
          })

        // Reset button
        Button('Reset Progress')
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onTertiary)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Radius.medium)
          .margin({ top: AppTokens.Spacing.lg })
          .onClick(() => {
            this.paymentProgress = 0;
            this.drawWave();
          })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['rgba(255, 193, 7, 0.25)', 0.0],
        [AppTokens.Colors.background, 0.5],
        ['rgba(255, 165, 0, 0.25)', 1.0]
      ]
    })
  }
}
