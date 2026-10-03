// StockKLinePage.ets
// ArkTS (HarmonyOS ArkUI) port of the SwiftUI "Stock K-Line" screen.
// 1:1 mapping of AppTokens, the chart Canvas, the Slider and the custom
// LinearProgressIndicator.

// MARK: - AppTokens
class AppTokens {
  // ---- Colors (0xAARRGGBB / 0xFFRRGGBB -> '#RRGGBB') ----
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#60A5FA';
  static readonly tertiary: string = '#93C5FD';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#CBD5E1';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E3A8A';
  static readonly onTertiary: string = '#1E40AF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#0F172A';

  // Gradient overlays (15% alpha)
  static readonly secondary15: string = '#2660A5FA';
  static readonly primary15: string = '#262563EB';
  // Shadow (18% of onBackground)
  static readonly shadowLevel2: string = '#2E0F172A';

  // ---- Typography (display 28/Bold, title 18/Medium, body 14/Normal, label 12/Medium) ----
  static readonly fontSizeDisplay: number = 28;
  static readonly fontSizeTitle: number = 18;
  static readonly fontSizeBody: number = 14;
  static readonly fontSizeLabel: number = 12;
  static readonly weightDisplay: FontWeight = FontWeight.Bold;
  static readonly weightTitle: FontWeight = FontWeight.Medium;
  static readonly weightBody: FontWeight = FontWeight.Normal;
  static readonly weightLabel: FontWeight = FontWeight.Medium;

  // ---- Shapes ----
  static readonly shapeSmall: number = 4;
  static readonly shapeMedium: number = 8;
  static readonly shapeLarge: number = 16;

  // ---- Spacing ----
  static readonly spacingSm: number = 6;
  static readonly spacingMd: number = 10;
  static readonly spacingLg: number = 14;
  static readonly spacingXl: number = 20;
  static readonly spacingXxl: number = 28;

  // ---- Elevation (ElevationMapping.level2) ----
  static readonly elevationLevel2Radius: number = 8;
  static readonly elevationLevel2Dy: number = 4;
}

// MARK: - RootScreen
@Entry
@Component
struct StockKLinePage {
  @State progress: number = 0.5;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  // Mirrors the SwiftUI Canvas closure: a sine wave with a vertical entry
  // segment at x = 0, stroked at 4vp in the primary color.
  private drawChart(): void {
    const width: number = this.context.width;
    const height: number = this.context.height;
    if (width <= 0 || height <= 0) {
      return;
    }

    this.context.clearRect(0, 0, width, height);

    const step: number = width / 50.0;          // 50 steps across the canvas
    const startY: number = height / 2.0;        // starting Y coordinate

    this.context.beginPath();
    this.context.moveTo(0, startY);

    for (let i = 0; i <= 50; i++) {
      const x: number = i * step;
      const y: number = height / 2.0
        + Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * (height / 3.0);
      this.context.lineTo(x, y);
    }

    this.context.strokeStyle = AppTokens.primary;
    this.context.lineWidth = 4;
    this.context.lineJoin = 'round';
    this.context.lineCap = 'round';
    this.context.stroke();
  }

  build() {
    Column() {
      // ---- TopAppBar (CenterAligned) ----
      Row() {
        Text('Stock K-Line')
          .fontSize(AppTokens.fontSizeDisplay)
          .fontWeight(AppTokens.weightDisplay)
          .fontColor(AppTokens.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.background)

      // ---- Content Column ----
      Column({ space: AppTokens.spacingLg }) {
        // Chart Surface (elevation level 2)
        Stack() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart();
            })
        }
        .width('100%')
        .height(260)
        .padding(AppTokens.spacingLg)
        .backgroundColor(AppTokens.surface)
        .borderRadius(AppTokens.shapeLarge)
        .shadow({
          radius: AppTokens.elevationLevel2Radius,
          color: AppTokens.shadowLevel2,
          offsetX: 0,
          offsetY: AppTokens.elevationLevel2Dy
        })

        Text('Market Trend')
          .fontSize(AppTokens.fontSizeTitle)
          .fontWeight(AppTokens.weightTitle)
          .fontColor(AppTokens.primary)

        // Slider (active track + thumb tinted primary)
        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .height(44)
          .selectedColor(AppTokens.primary)
          .trackColor(AppTokens.surfaceVariant)
          .blockColor(AppTokens.surface)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.progress = value;
            this.drawChart();
          })

        // ---- LinearProgressIndicator (rounded 4vp track, 8vp tall) ----
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(8)
            .borderRadius(AppTokens.shapeSmall)
            .backgroundColor(AppTokens.surfaceVariant)

          Row()
            .width(this.progress * 100 + '%')
            .height(8)
            .borderRadius(AppTokens.shapeSmall)
            .backgroundColor(AppTokens.primary)
        }
        .width('100%')
        .height(8)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.spacingLg)
      .alignItems(HorizontalAlign.Center)
      // Brush.verticalGradient(secondary 15% -> background -> primary 15%)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.secondary15, 0.0],
          [AppTokens.background, 0.5],
          [AppTokens.primary15, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}