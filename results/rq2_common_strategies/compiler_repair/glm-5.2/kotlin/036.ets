// Index.ets

const NAME: string = "047CryptoMarketen";
const UI_TYPE: string = "Finance";
const STYLE_THEME: string = "Soft Pastel";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  primary: ResourceColor = 0xFFFFA8A8;
  secondary: ResourceColor = 0xFFFFE1A8;
  tertiary: ResourceColor = 0xFFA8FFE1;
  background: ResourceColor = 0xFFFFFCF5;
  surface: ResourceColor = 0xFFFFFFFF;
  surfaceVariant: ResourceColor = 0xFFF7F7F7;
  outline: ResourceColor = 0xFFE2E2E2;
  success: ResourceColor = 0xFF22C55E;
  warning: ResourceColor = 0xFFF59E0B;
  error: ResourceColor = 0xFFEF4444;
  onPrimary: ResourceColor = 0xFF1E1E1E;
  onSecondary: ResourceColor = 0xFF1E1E1E;
  onTertiary: ResourceColor = 0xFF1E1E1E;
  onBackground: ResourceColor = 0xFF1E1E1E;
  onSurface: ResourceColor = 0xFF1E1E1E;
}

class AppSpacing {
  sm: Length = 8;
  md: Length = 12;
  lg: Length = 16;
  xl: Length = 24;
  xxl: Length = 32;
}

class AppShapes {
  small: number = 6;
  medium: number = 12;
  large: number = 20;
}

class AppTokens {
  static Colors: AppColors = new AppColors();
  static Spacing: AppSpacing = new AppSpacing();
  static Shapes: AppShapes = new AppShapes();
}

@Entry
@Component
struct RootScreen {
  @State selectedChip: string = "BTC";
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true));
  private chartConfig: RenderingContextSettings = new RenderingContextSettings(true);

  drawChart(): void {
    const ctx = this.canvasContext;
    const w = ctx.width;
    const h = ctx.height;
    ctx.clearRect(0, 0, w, h);
    const step = w / 30;
    let prevY = h / 2;
    for (let i = 0; i <= 30; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3);
      ctx.beginPath();
      ctx.moveTo(x - step, prevY);
      ctx.lineTo(x, y);
      ctx.lineWidth = 5;
      ctx.strokeStyle = '#FFFFA8A8';
      ctx.stroke();
      prevY = y;
    }
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Crypto Market")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Content
      Column() {
        // Chips
        Row({ space: AppTokens.Spacing.md }) {
          ForEach(["BTC", "ETH", "SOL", "ADA"], (item: string) => {
            Text(item)
              .fontSize(14)
              .fontColor(AppTokens.Colors.onPrimary)
              .backgroundColor(this.selectedChip === item ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
              .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
              .borderRadius(AppTokens.Shapes.small)
              .onClick(() => {
                this.selectedChip = item;
              })
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        // Chart Surface
        Column() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart();
            })
        }
        .width('100%')
        .height(260)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: 8, color: '#1A000000', offsetX: 0, offsetY: 4 })
        .padding(AppTokens.Spacing.lg)
        .margin({ top: AppTokens.Spacing.lg })

        // Price Variation
        Text("Price Variation")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.lg })

        // Linear Progress Indicator
        Row() {
          Column() {
            Column()
              .width(`${this.progress * 100}%`)
              .height(8)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(4)
          }
          .width('100%')
          .height(8)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(4)
        }
        .width('100%')
        .margin({ top: AppTokens.Spacing.sm })

        // Auto Update Row
        Row() {
          Text("Auto Update")
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSurface)
          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .selectedColor(AppTokens.Colors.secondary)
            .onChange((isOn: boolean) => {
              this.isAutoUpdate = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: AppTokens.Spacing.lg })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary as number, 0.3],
          [AppTokens.Colors.background as number, 1.0],
          [AppTokens.Colors.tertiary as number, 0.3]
        ]
      })
    }
    .width('100%')
    .height('100%')
  }
}