import prompt from '@system.prompt';

// MARK: - AppTokens
class AppTokens {
  static Colors = class {
    static primary: ResourceColor = '#FF111827';
    static secondary: ResourceColor = '#FF374151';
    static tertiary: ResourceColor = '#FF6B7280';
    static background: ResourceColor = '#FFF9FAFB';
    static surface: ResourceColor = '#FFFFFFFF';
    static surfaceVariant: ResourceColor = '#FFE5E7EB';
    static outline: ResourceColor = '#FFD1D5DB';
    static onPrimary: ResourceColor = '#FFFFFFFF';
    static onSecondary: ResourceColor = '#FFFFFFFF';
    static onBackground: ResourceColor = '#FF111827';
    static onSurface: ResourceColor = '#FF1F2937';
  };

  static TypographyTokens = class {
    static displayFontSize: number = 26;
    static displayFontWeight: FontWeight = FontWeight.Bold;
    static headlineFontSize: number = 18;
    static headlineFontWeight: FontWeight = FontWeight.SemiBold;
    static titleFontSize: number = 14;
    static titleFontWeight: FontWeight = FontWeight.Medium;
    static bodyFontSize: number = 12;
    static bodyFontWeight: FontWeight = FontWeight.Regular;
  };

  static Shapes = class {
    static smallCornerRadius: number = 6;
    static mediumCornerRadius: number = 10;
    static largeCornerRadius: number = 16;
  };

  static Spacing = class {
    static sm: number = 6;
    static md: number = 10;
    static lg: number = 14;
    static xl: number = 22;
  };
}

interface ParcelPoint {
  x: number;
  y: number;
}

// MARK: - ParcelCanvas
@Component
struct ParcelCanvas {
  @State dragX: number = 0;
  @State dragY: number = 0;
  @State parcelPoints: ParcelPoint[] = [];
  @State canvasWidth: number = 0;
  @State canvasHeight: number = 0;
  @State initialized: boolean = false;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private generateRandomPoints(width: number, height: number): ParcelPoint[] {
    const points: ParcelPoint[] = [];
    for (let i = 0; i < 25; i++) {
      points.push({
        x: Math.random() * width,
        y: Math.random() * height
      });
    }
    return points;
  }

  aboutToAppear() {
    this.canvasWidth = 300;
    this.canvasHeight = 280;
  }

  private drawCanvas() {
    const ctx = this.context;
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    // Draw parcel points
    for (const point of this.parcelPoints) {
      ctx.fillStyle = '#FF374151';
      ctx.beginPath();
      ctx.arc(point.x, point.y, 4, 0, Math.PI * 2);
      ctx.fill();
    }

    // Draw draggable circle
    ctx.strokeStyle = '#FF111827';
    ctx.lineWidth = 3;
    ctx.beginPath();
    ctx.arc(this.dragX, this.dragY, 20, 0, Math.PI * 2);
    ctx.stroke();
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .padding(AppTokens.Spacing.md)
        .onReady(() => {
          this.drawCanvas();
        })
        .onAreaChange((oldValue: Area, newValue: Area) => {
          const w = newValue.width as number - AppTokens.Spacing.md * 2;
          const h = newValue.height as number - AppTokens.Spacing.md * 2;
          if (!this.initialized && w > 0 && h > 0) {
            this.canvasWidth = w;
            this.canvasHeight = h;
            this.parcelPoints = this.generateRandomPoints(w, h);
            this.dragX = 20 + Math.random() * (w - 40);
            this.dragY = 20 + Math.random() * (h - 40);
            this.initialized = true;
            this.drawCanvas();
          }
        })

      Text('Drag to locate parcel')
        .fontSize(AppTokens.TypographyTokens.bodyFontSize)
        .fontWeight(AppTokens.TypographyTokens.bodyFontWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(300)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.largeCornerRadius)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.largeCornerRadius })
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Move || event.type === TouchType.Down) {
        const touch = event.touches[0];
        let x = touch.x;
        let y = touch.y;
        const minVal = 20;
        const maxX = this.canvasWidth - 20;
        const maxY = this.canvasHeight - 20;
        x = Math.max(minVal, Math.min(x, maxX));
        y = Math.max(minVal, Math.min(y, maxY));
        this.dragX = x;
        this.dragY = y;
        this.drawCanvas();
      }
    })
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      Text('Parcel Tracker')
        .fontSize(AppTokens.TypographyTokens.displayFontSize)
        .fontWeight(AppTokens.TypographyTokens.displayFontWeight)
        .fontColor(AppTokens.Colors.onBackground)
        .margin({ bottom: AppTokens.Spacing.xl })

      ParcelCanvas()
        .margin({ bottom: AppTokens.Spacing.xl })

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTokens.TypographyTokens.bodyFontSize)
        .fontWeight(AppTokens.TypographyTokens.bodyFontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppTokens.Colors.surfaceVariant, 0.0],
        [AppTokens.Colors.background, 1.0]
      ]
    })
  }
}
