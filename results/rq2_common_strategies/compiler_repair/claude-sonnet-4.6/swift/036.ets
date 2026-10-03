import { curves } from '@kit.ArkUI';

// AppTokens - using classes instead of object literals
class ColorsClass {
  primary: string = '#FFFFA8A8';
  secondary: string = '#FFFFE1A8';
  tertiary: string = '#FFA8FFE1';
  background: string = '#FFFFFCF5';
  surface: string = '#FFFFFFFF';
  surfaceVariant: string = '#FFF7F7F7';
  outline: string = '#FFE2E2E2';
  success: string = '#FF22C55E';
  warning: string = '#FFF59E0B';
  error: string = '#FFEF4444';
  onPrimary: string = '#FF1E1E1E';
  onSecondary: string = '#FF1E1E1E';
  onTertiary: string = '#FF1E1E1E';
  onBackground: string = '#FF1E1E1E';
  onSurface: string = '#FF1E1E1E';
}

class SpacingClass {
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

class ShapesClass {
  small: number = 6;
  medium: number = 12;
  large: number = 20;
}

const Colors = new ColorsClass();
const Spacing = new SpacingClass();
const Shapes = new ShapesClass();

@Component
struct FilterChipView {
  text: string = '';
  isSelected: boolean = false;
  action: () => void = () => {};

  build() {
    Button() {
      Text(this.text)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onPrimary)
        .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
    }
    .backgroundColor(this.isSelected ? Colors.primary : Colors.surfaceVariant)
    .borderRadius(Shapes.small)
    .onClick(() => this.action())
    .type(ButtonType.Normal)
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;
  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true));

  build() {
    Column() {
      // Top Bar
      Text('Crypto Market')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: Spacing.lg, bottom: Spacing.lg })
        .backgroundColor(Colors.background)

      // Content Area
      Column({ space: Spacing.lg }) {
        // Filter Chips Row
        Row({ space: Spacing.md }) {
          ForEach(this.chips, (chip: string) => {
            FilterChipView({
              text: chip,
              isSelected: this.selectedChip === chip,
              action: () => {
                this.selectedChip = chip;
              }
            })
          })
        }
        .width('100%')

        // Chart Surface
        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawWave();
            })
        }
        .width('100%')
        .height(260)
        .backgroundColor(Colors.surface)
        .borderRadius(Shapes.large)
        .padding(Spacing.lg)
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

        // Linear Progress Indicator
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Row()
            .width('100%')
            .height(8)
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(4)

          // Progress
          Row()
            .width(`${this.progress * 100}%`)
            .height(8)
            .backgroundColor(Colors.primary)
            .borderRadius(4)
        }
        .width('100%')
        .height(8)

        // Auto Update Row
        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(Colors.onSurface)

          Blank()

          // Custom Toggle Switch
          Stack() {
            // Track
            Row()
              .width(51)
              .height(31)
              .borderRadius(15.5)
              .backgroundColor(this.isAutoUpdate ? Colors.primary : Colors.surfaceVariant)
              .animation({
                duration: 200,
                curve: curves.cubicBezierCurve(0.42, 0, 0.58, 1)
              })

            // Thumb
            Row()
              .width(27)
              .height(27)
              .borderRadius(13.5)
              .backgroundColor(this.isAutoUpdate ? Colors.secondary : Colors.outline)
              .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 1 })
              .offset({ x: this.isAutoUpdate ? 10 : -10 })
              .animation({
                duration: 200,
                curve: curves.cubicBezierCurve(0.42, 0, 0.58, 1)
              })
          }
          .width(51)
          .height(31)
          .onClick(() => {
            this.isAutoUpdate = !this.isAutoUpdate;
          })
        }
        .width('100%')
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

  drawWave() {
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
}