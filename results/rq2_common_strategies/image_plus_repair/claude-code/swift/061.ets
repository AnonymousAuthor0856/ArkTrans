// MARK: - AppTokens
namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#FF111827';
    export const secondary: ResourceColor = '#FF374151';
    export const tertiary: ResourceColor = '#FF6B7280';
    export const background: ResourceColor = '#FFF9FAFB';
    export const surface: ResourceColor = '#FFFFFFFF';
    export const surfaceVariant: ResourceColor = '#FFE5E7EB';
    export const outline: ResourceColor = '#FFD1D5DB';
    export const onPrimary: ResourceColor = '#FFFFFFFF';
    export const onSecondary: ResourceColor = '#FFFFFFFF';
    export const onBackground: ResourceColor = '#FF111827';
    export const onSurface: ResourceColor = '#FF1F2937';
  }

  export namespace TypographyTokens {
    export const displayFontSize: number = 26;
    export const displayFontWeight: FontWeight = FontWeight.Bold;
    export const headlineFontSize: number = 18;
    export const headlineFontWeight: FontWeight = FontWeight.Bold;
    export const titleFontSize: number = 14;
    export const titleFontWeight: FontWeight = FontWeight.Medium;
    export const bodyFontSize: number = 12;
    export const bodyFontWeight: FontWeight = FontWeight.Normal;
  }

  export namespace Shapes {
    export const smallCornerRadius: number = 6;
    export const mediumCornerRadius: number = 10;
    export const largeCornerRadius: number = 16;
  }

  export namespace Spacing {
    export const sm: number = 6;
    export const md: number = 10;
    export const lg: number = 14;
    export const xl: number = 22;
  }
}

interface ParcelPoint {
  x: number;
  y: number;
}

// MARK: - ParcelCanvas
@Component
struct ParcelCanvas {
  @State dragX: number = 50;
  @State dragY: number = 50;
  @State parcelPoints: ParcelPoint[] = [];
  @State canvasDrawWidth: number = 200;
  @State canvasDrawHeight: number = 280;
  @State isReady: boolean = false;
  private paddingVal: number = AppTokens.Spacing.md;
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

  private drawCanvas(): void {
    const ctx = this.context;
    ctx.clearRect(0, 0, this.canvasDrawWidth, this.canvasDrawHeight);

    ctx.fillStyle = '#FF374151';
    for (const point of this.parcelPoints) {
      ctx.beginPath();
      ctx.arc(point.x, point.y, 4, 0, Math.PI * 2);
      ctx.fill();
    }

    ctx.strokeStyle = '#FF111827';
    ctx.lineWidth = 3;
    ctx.beginPath();
    ctx.arc(this.dragX, this.dragY, 20, 0, Math.PI * 2);
    ctx.stroke();
  }

  private updateAndDraw(w: number, h: number): void {
    if (w <= 0 || h <= 0) {
      return;
    }
    this.canvasDrawWidth = w;
    this.canvasDrawHeight = h;
    if (!this.isReady) {
      this.parcelPoints = this.generateRandomPoints(w, h);
      this.dragX = 20 + Math.random() * (w - 40);
      this.dragY = 20 + Math.random() * (h - 40);
      this.isReady = true;
    }
    this.drawCanvas();
  }

  build() {
    Stack() {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawCanvas();
        })

      Text('Drag to locate parcel')
        .fontSize(AppTokens.TypographyTokens.bodyFontSize)
        .fontWeight(AppTokens.TypographyTokens.bodyFontWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(300)
    .padding(this.paddingVal)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.largeCornerRadius)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.largeCornerRadius })
    .onAreaChange((oldValue: Area, newValue: Area) => {
      const w = (newValue.width as number) - this.paddingVal * 2;
      const h = (newValue.height as number) - this.paddingVal * 2;
      this.updateAndDraw(w, h);
    })
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down || event.type === TouchType.Move) {
        const touch = event.touches[0];
        let x = touch.x - this.paddingVal;
        let y = touch.y - this.paddingVal;
        x = Math.max(20, Math.min(x, this.canvasDrawWidth - 20));
        y = Math.max(20, Math.min(y, this.canvasDrawHeight - 20));
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

      Blank()

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTokens.TypographyTokens.bodyFontSize)
        .fontWeight(AppTokens.TypographyTokens.bodyFontWeight)
        .fontColor(AppTokens.Colors.onSurface)
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
