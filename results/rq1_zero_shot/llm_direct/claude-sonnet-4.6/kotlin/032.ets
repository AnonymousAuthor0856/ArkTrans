import { display } from '@kit.ArkUI';

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary = '#FFA500';
    export const secondary = '#FFC300';
    export const tertiary = '#FFE066';
    export const background = '#FFFBF2';
    export const surface = '#FFFFFF';
    export const surfaceVariant = '#FFEED6';
    export const outline = '#F1C27D';
    export const success = '#22C55E';
    export const warning = '#F59E0B';
    export const error = '#EF4444';
    export const onPrimary = '#FFFFFF';
    export const onSecondary = '#1E1E1E';
    export const onTertiary = '#1E1E1E';
    export const onBackground = '#1E1E1E';
    export const onSurface = '#1E1E1E';
  }

  export namespace Spacing {
    export const sm = 8;
    export const md = 12;
    export const lg = 16;
    export const xl = 24;
    export const xxl = 32;
  }
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.4;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Transfer Wizard')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main content area
      Stack({ alignContent: Alignment.Bottom }) {
        // Background gradient
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

        // Canvas drawing
        Canvas(this.context)
          .width('100%')
          .height('100%')
          .padding(AppTokens.Spacing.xl)
          .onReady(() => {
            this.drawCanvas();
          })

        // Bottom controls
        Column({ space: AppTokens.Spacing.lg }) {
          Text('Transfer Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Progress({
            value: this.progress * 100,
            total: 100,
            type: ProgressType.Linear
          })
            .width('80%')
            .height(8)
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)

          Row({ space: AppTokens.Spacing.md }) {
            Button('+')
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1.0);
              })
              .borderRadius(50)
              .backgroundColor(AppTokens.Colors.primary)
              .fontColor(AppTokens.Colors.onPrimary)
              .fontSize(18)
              .width(56)
              .height(56)

            Button('-')
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0.0);
              })
              .borderRadius(50)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .fontSize(18)
              .width(56)
              .height(56)
          }
        }
        .alignItems(HorizontalAlign.Center)
        .padding({ bottom: AppTokens.Spacing.xxl })
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  private drawCanvas() {
    const ctx = this.context;
    const width = ctx.width;
    const height = ctx.height;
    const centerX = width / 2;
    const centerY = height / 2;

    // Draw background circle
    ctx.beginPath();
    ctx.arc(centerX, centerY, 260, 0, Math.PI * 2);
    ctx.fillStyle = AppTokens.Colors.surfaceVariant;
    ctx.fill();
    ctx.closePath();

    // Draw marker circle
    const markerX = 200;
    const markerY = 400;
    ctx.beginPath();
    ctx.arc(markerX, markerY, 20, 0, Math.PI * 2);
    ctx.fillStyle = AppTokens.Colors.primary;
    ctx.fill();
    ctx.closePath();
  }
}