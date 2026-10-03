import { curves } from '@kit.ArkUI';

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary = '#FFFFA8A8';
    export const secondary = '#FFFFE1A8';
    export const tertiary = '#FFA8FFE1';
    export const background = '#FFFFFCF5';
    export const surface = '#FFFFFFFF';
    export const surfaceVariant = '#FFF7F7F7';
    export const outline = '#FFE2E2E2';
    export const success = '#FF22C55E';
    export const warning = '#FFF59E0B';
    export const error = '#FFEF4444';
    export const onPrimary = '#FF1E1E1E';
    export const onSecondary = '#FF1E1E1E';
    export const onTertiary = '#FF1E1E1E';
    export const onBackground = '#FF1E1E1E';
    export const onSurface = '#FF1E1E1E';
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
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Crypto Market')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column({ space: AppTokens.Spacing.lg }) {
        // Filter Chips Row
        Row({ space: AppTokens.Spacing.md }) {
          ForEach(this.chips, (chip: string) => {
            Text(chip)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onPrimary)
              .padding({ left: 14, right: 14, top: 8, bottom: 8 })
              .backgroundColor(this.selectedChip === chip
                ? AppTokens.Colors.primary
                : AppTokens.Colors.surfaceVariant)
              .borderRadius(20)
              .onClick(() => {
                this.selectedChip = chip;
              })
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        // Chart Card
        Column() {
          Canvas(new RenderingContextSettings(true))
            .width('100%')
            .height('100%')
            .onReady((context: CanvasRenderingContext2D) => {
              this.drawChart(context);
            })
        }
        .width('100%')
        .height(260)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(20)
        .shadow({
          radius: 8,
          color: '#1E000000',
          offsetX: 0,
          offsetY: 4
        })
        .clip(true)

        // Price Variation Label
        Text('Price Variation')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Progress Bar
        Progress({
          value: this.progress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .style({ strokeWidth: 8, enableSmoothEffect: true })

        // Auto Update Row
        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppTokens.Colors.onSurface)

          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .selectedColor(AppTokens.Colors.primary)
            .switchPointColor(AppTokens.Colors.secondary)
            .onChange((isOn: boolean) => {
              this.isAutoUpdate = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#4DFFE1A8', 0.0],
        ['#FFFFFCF5', 0.5],
        ['#4DA8FFE1', 1.0]
      ]
    })
  }

  private drawChart(context: CanvasRenderingContext2D): void {
    const w = context.width;
    const h = context.height;
    const padding = AppTokens.Spacing.lg;
    const drawW = w - padding * 2;
    const drawH = h - padding * 2;
    const step = drawW / 30;

    context.clearRect(0, 0, w, h);
    context.strokeStyle = AppTokens.Colors.primary;
    context.lineWidth = 5;
    context.lineCap = 'round';
    context.lineJoin = 'round';

    let prevY = padding + drawH / 2;

    context.beginPath();
    context.moveTo(padding, prevY);

    for (let i = 1; i <= 30; i++) {
      const x = padding + i * step;
      const y = padding + drawH / 2 +
        Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (drawH / 3);
      context.lineTo(x, y);
    }

    context.stroke();
  }
}