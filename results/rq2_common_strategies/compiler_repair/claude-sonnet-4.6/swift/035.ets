// AppTokens - using explicit class definitions instead of object literals

class ColorTokens {
  primary: string = '#FF2563EB';
  secondary: string = '#FF60A5FA';
  tertiary: string = '#FF93C5FD';
  background: string = '#FFF8FAFC';
  surface: string = '#FFFFFFFF';
  surfaceVariant: string = '#FFE2E8F0';
  outline: string = '#FFCBD5E1';
  success: string = '#FF22C55E';
  warning: string = '#FFF59E0B';
  error: string = '#FFEF4444';
  onPrimary: string = '#FFFFFFFF';
  onSecondary: string = '#FF1E3A8A';
  onTertiary: string = '#FF1E40AF';
  onBackground: string = '#FF0F172A';
  onSurface: string = '#FF0F172A';
}

class SpacingTokens {
  sm: number = 6;
  md: number = 10;
  lg: number = 14;
  xl: number = 20;
  xxl: number = 28;
}

class ShapeTokens {
  small: number = 4;
  medium: number = 8;
  large: number = 16;
}

const Colors: ColorTokens = new ColorTokens();
const Spacing: SpacingTokens = new SpacingTokens();
const Shapes: ShapeTokens = new ShapeTokens();

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5;
  private canvasSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings);

  drawKLine() {
    const ctx = this.canvasContext;
    const width = ctx.width;
    const height = ctx.height;
    ctx.clearRect(0, 0, width, height);

    const step = width / 50.0;
    ctx.beginPath();
    ctx.moveTo(0, height / 2.0);

    for (let i = 0; i <= 50; i++) {
      const x = i * step;
      const y = height / 2.0 + Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * (height / 3.0);
      ctx.lineTo(x, y);
    }

    ctx.strokeStyle = Colors.primary;
    ctx.lineWidth = 4;
    ctx.lineJoin = 'round';
    ctx.lineCap = 'round';
    ctx.stroke();
  }

  build() {
    Column({ space: 0 }) {
      // Top App Bar
      Row() {
        Text('Stock K-Line')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(Colors.background)
      .justifyContent(FlexAlign.Center)

      // Main Content
      Column({ space: Spacing.lg }) {
        // Chart Card
        Stack() {
          // Shadow + Background
          Column()
            .width('100%')
            .height('100%')
            .borderRadius(Shapes.large)
            .backgroundColor(Colors.surface)
            .shadow({
              radius: 8,
              color: '#1F0F172A',
              offsetX: 0,
              offsetY: 4
            })

          // Canvas for K-Line
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .borderRadius(Shapes.large)
            .padding(Spacing.lg)
            .onReady(() => {
              this.drawKLine();
            })
        }
        .width('100%')
        .height(260)
        .borderRadius(Shapes.large)
        .clip(true)

        // Market Trend Label
        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Center)

        // Slider
        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor(Colors.surfaceVariant)
          .selectedColor(Colors.primary)
          .blockColor(Colors.primary)
          .onChange((value: number) => {
            this.progress = value;
            this.drawKLine();
          })

        // Progress Bar
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Row()
            .width('100%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(Colors.surfaceVariant)

          // Progress Fill
          Row()
            .width(`${this.progress * 100}%`)
            .height(8)
            .borderRadius(4)
            .backgroundColor(Colors.primary)
        }
        .width('100%')
        .height(8)
      }
      .padding(Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#2660A5FA', 0.0],
          [Colors.background, 0.5],
          ['#262563EB', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}