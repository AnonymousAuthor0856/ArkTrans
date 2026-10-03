// MARK: - AppTokens
// 集中管理应用程序的颜色、字体、形状和间距。
const AppTokens = {
  Colors: {
    primary: '#111827',
    secondary: '#374151',
    tertiary: '#6B7280',
    background: '#F9FAFB',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onBackground: '#111827',
    onSurface: '#1F2937'
  },
  Typography: {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Semibold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular }
  },
  Shapes: {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 16
  },
  Spacing: {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 22
  }
};

// MARK: - ParcelCanvas
@Component
struct ParcelCanvas {
  @State dragX: number = 150;
  @State dragY: number = 150;
  @State points: number[][] = [];
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear() {
    for (let i = 0; i < 25; i++) {
      this.points.push([Math.random() * 280, Math.random() * 280]);
    }
    this.dragX = 20 + Math.random() * 260;
    this.dragY = 20 + Math.random() * 260;
  }

  private draw() {
    this.ctx.clearRect(0, 0, 320, 300);
    this.ctx.fillStyle = AppTokens.Colors.secondary;
    for (const p of this.points) {
      this.ctx.beginPath();
      this.ctx.arc(p[0] + 10, p[1] + 10, 4, 0, 2 * Math.PI);
      this.ctx.fill();
    }
    this.ctx.strokeStyle = AppTokens.Colors.primary;
    this.ctx.lineWidth = 3;
    this.ctx.beginPath();
    this.ctx.arc(this.dragX + 10, this.dragY + 10, 20, 0, 2 * Math.PI);
    this.ctx.stroke();
  }

  build() {
    Stack() {
      Canvas(this.ctx)
        .width('100%')
        .height(300)
        .onReady(() => {
          this.draw();
        })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.dragX = Math.max(20, Math.min(this.dragX + event.offsetX, 280));
              this.dragY = Math.max(20, Math.min(this.dragY + event.offsetY, 280));
              this.draw();
            })
        )

      Text('Drag to locate parcel')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(300)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.largeCornerRadius)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

// MARK: - RootScreen
@Component
struct RootScreen {
  build() {
    Column({ space: AppTokens.Spacing.xl }) {
      Text('Parcel Tracker')
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onBackground)

      ParcelCanvas()

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.background, 1.0]]
    })
    .padding(AppTokens.Spacing.lg)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL])
  }
}

// MARK: - ParcelTrackerApp
@Entry
@Component
struct ParcelTrackerApp {
  build() {
    RootScreen()
  }
}
