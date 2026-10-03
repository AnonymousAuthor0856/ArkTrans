class ColorTokens {
  primary: string = '#FFA8A8';
  secondary: string = '#FFE1A8';
  tertiary: string = '#A8FFE1';
  background: string = '#FFFCF5';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#F7F7F7';
  outline: string = '#E2E2E2';
  success: string = '#22C55E';
  warning: string = '#F59E0B';
  error: string = '#EF4444';
  onPrimary: string = '#1E1E1E';
  onSecondary: string = '#1E1E1E';
  onTertiary: string = '#1E1E1E';
  onBackground: string = '#1E1E1E';
  onSurface: string = '#1E1E1E';
}

class SpacingTokens {
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

class ShapeTokens {
  small: number = 6;
  medium: number = 12;
  large: number = 20;
}

const Colors = new ColorTokens();
const Spacing = new SpacingTokens();
const Shapes = new ShapeTokens();

@Entry
@Component
struct RootScreen {
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  drawWaveform() {
    const context = this.canvasContext;
    const w = context.width;
    const h = context.height;
    const step = w / 30;

    context.clearRect(0, 0, w, h);
    context.beginPath();
    context.strokeStyle = Colors.primary;
    context.lineWidth = 5;
    context.lineJoin = 'round';
    context.lineCap = 'round';

    const initialY = h / 2;
    context.moveTo(-step, initialY);

    for (let i = 0; i <= 30; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3);
      context.lineTo(x, y);
    }

    context.stroke();
  }

  build() {
    Stack() {
      Column() {
        // Top Bar
        Text('Crypto Market')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 48, bottom: Spacing.lg })
          .backgroundColor(Colors.background)

        // Content Area
        Column({ space: Spacing.lg }) {
          // Filter Chips Row
          Row({ space: Spacing.md }) {
            ForEach(this.chips, (chip: string) => {
              this.FilterChip(chip)
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)

          // Chart Surface
          Stack() {
            Column() {
              Canvas(this.canvasContext)
                .width('100%')
                .height('100%')
                .onReady(() => {
                  this.drawWaveform();
                })
            }
            .width('100%')
            .height('100%')
            .padding(Spacing.lg)
          }
          .width('100%')
          .height(260)
          .backgroundColor(Colors.surface)
          .borderRadius(Shapes.large)
          .shadow({
            radius: 8,
            color: '#2E000000',
            offsetX: 0,
            offsetY: 4
          })

          // Price Variation Text
          Text('Price Variation')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.primary)
            .width('100%')
            .textAlign(TextAlign.Center)

          // Linear Progress Indicator
          Stack({ alignContent: Alignment.Start }) {
            // Track
            Row()
              .width('100%')
              .height(8)
              .borderRadius(4)
              .backgroundColor(Colors.surfaceVariant)

            // Progress
            Row()
              .width(`${this.progress * 100}%`)
              .height(8)
              .borderRadius(4)
              .backgroundColor(Colors.primary)
          }
          .width('100%')
          .height(8)

          // Auto Update Row
          Row() {
            Text('Auto Update')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(Colors.onSurface)

            Blank()

            // Custom Toggle
            Stack() {
              // Track
              Row()
                .width(51)
                .height(31)
                .borderRadius(15.5)
                .backgroundColor(this.isAutoUpdate ? Colors.primary : Colors.surfaceVariant)

              // Thumb
              Row()
                .width(27)
                .height(27)
                .borderRadius(13.5)
                .backgroundColor(this.isAutoUpdate ? Colors.secondary : Colors.outline)
                .shadow({
                  radius: 2,
                  color: '#1A000000',
                  offsetX: 0,
                  offsetY: 1
                })
                .offset({ x: this.isAutoUpdate ? 10 : -10 })
                .animation({
                  duration: 200,
                  curve: Curve.EaseInOut
                })
            }
            .width(51)
            .height(31)
            .onClick(() => {
              this.isAutoUpdate = !this.isAutoUpdate;
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }
        .padding(Spacing.lg)
        .width('100%')
        .layoutWeight(1)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            ['#4DFFE1A8', 0.0],
            [Colors.background, 0.5],
            ['#4DA8FFE1', 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }

  @Builder
  FilterChip(text: string) {
    Text(text)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(Colors.onPrimary)
      .padding({
        left: Spacing.md,
        right: Spacing.md,
        top: Spacing.sm,
        bottom: Spacing.sm
      })
      .backgroundColor(this.selectedChip === text ? Colors.primary : Colors.surfaceVariant)
      .borderRadius(Shapes.small)
      .onClick(() => {
        this.selectedChip = text;
      })
  }
}