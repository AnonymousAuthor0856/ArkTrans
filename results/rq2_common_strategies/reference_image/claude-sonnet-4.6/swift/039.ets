// Index.ets
// HarmonyOS (ArkTS / ArkUI) 版本 —— 对应 SwiftUI 的 InstallmentPlanApp
// 直接将本文件放入 entry/src/main/ets/pages/ 下，并在 main_pages.json 中注册 "pages/Index"。

// MARK: - AppTokens
// 统一的 UI 令牌：颜色、字号、圆角、间距、阴影
class AppTokens {
  // ---- Colors ----
  static readonly primary: string = '#FFA500';
  static readonly secondary: string = '#FFC107';
  static readonly tertiary: string = '#FFE066';
  static readonly background: string = '#FFFBF2';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFEED6';
  static readonly outline: string = '#F1C27D';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';

  // ---- Shapes (vp) ----
  static readonly shapeSmall: number = 6;
  static readonly shapeMedium: number = 12;
  static readonly shapeLarge: number = 20;

  // ---- Spacing (vp) ----
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;

  // ---- Elevation（Compose ShadowSpec 的映射）----
  static readonly elev1Radius: number = 4;
  static readonly elev1Dy: number = 2;
  static readonly elev1Opacity: number = 0.12;
  static readonly elev2Radius: number = 8;
  static readonly elev2Dy: number = 4;
  static readonly elev2Opacity: number = 0.18;
}

// MARK: - SurfaceWithCanvas
// 相当于 SwiftUI 中带 Canvas 的 Surface 区域
@Component
struct SurfaceWithCanvas {
  // @Watch 保证 paymentProgress 变化时重绘 Canvas
  @Prop @Watch('onProgressChanged') paymentProgress: number = 0.3;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private isReady: boolean = false;

  // 与 SwiftUI Canvas 中的正弦曲线完全一致：
  // y = h/2 + sin(i * PI/5 + progress * PI) * (h/3)，共 20 段
  private draw(): void {
    if (!this.isReady) {
      return;
    }
    const w: number = this.ctx.width;
    const h: number = this.ctx.height;
    if (w <= 0 || h <= 0) {
      return;
    }

    this.ctx.clearRect(0, 0, w, h);

    // 防溢出：清除画布后重新设置绘制属性
    this.ctx.beginPath();
    this.ctx.lineWidth = 5;
    this.ctx.strokeStyle = AppTokens.primary;
    this.ctx.lineJoin = 'round';
    this.ctx.lineCap = 'round';

    const step: number = w / 20;
    const phase: number = this.paymentProgress * Math.PI;
    const amplitude: number = h / 3;

    const firstY: number = h / 2 + Math.sin(phase) * amplitude;
    this.ctx.moveTo(0, firstY);

    for (let i: number = 1; i <= 20; i++) {
      const x: number = i * step;
      const y: number = h / 2 + Math.sin(i * Math.PI / 5 + phase) * amplitude;
      this.ctx.lineTo(x, y);
    }
    this.ctx.stroke();
  }

  onProgressChanged(): void {
    this.draw();
  }

  build() {
    Stack() {
      Canvas(this.ctx)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.isReady = true;
          this.draw();
        })
    }
    .width('100%')
    .height(240)
    .padding(AppTokens.lg)
    .backgroundColor('rgba(255, 255, 255, 0.9)')
    .borderRadius(AppTokens.shapeLarge)
    .shadow({
      radius: AppTokens.elev2Radius,
      color: 'rgba(0, 0, 0, ' + AppTokens.elev2Opacity + ')',
      offsetX: 0,
      offsetY: AppTokens.elev2Dy
    })
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3;

  build() {
    Column() {
      // 顶部栏（对应 CenterAlignedTopAppBar，高度 64vp）
      Text('Installment Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(64)
        .backgroundColor(AppTokens.background)

      // 内容区域
      Column({ space: AppTokens.lg }) {
        SurfaceWithCanvas({ paymentProgress: this.paymentProgress })

        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.primary)

        // 自定义线性进度条（8vp 高，两端半圆）
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(8)
            .backgroundColor(AppTokens.surfaceVariant)
            .borderRadius(4)

          Row()
            .width((this.paymentProgress * 100) + '%')
            .height(8)
            .backgroundColor(AppTokens.primary)
            .borderRadius(4)
        }
        .width('100%')
        .height(8)

        // 滑块：对应 UISlider 封装（拇指 #FFC107，已走轨道 #FFA500，未走轨道 #FFEED6）
        Slider({
          value: this.paymentProgress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(AppTokens.secondary)
          .selectedColor(AppTokens.primary)
          .trackColor(AppTokens.surfaceVariant)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.paymentProgress = value;
          })

        // 重置按钮
        Button('Reset Progress', { type: ButtonType.Normal, stateEffect: true })
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onTertiary)
          .backgroundColor(AppTokens.tertiary)
          .borderRadius(AppTokens.shapeMedium)
          .width('100%')
          .height(48)
          .onClick(() => {
            this.paymentProgress = 0;
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.lg)
      .linearGradient({
        angle: 180, // 自上而下
        colors: [
          ['rgba(255, 193, 7, 0.25)', 0.0],
          ['rgba(255, 251, 242, 1.0)', 0.5],
          ['rgba(255, 165, 0, 0.25)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}