import { CanvasRenderingContext2D } from '@ohos.graphics.canvas2d';

class AppColors {
  static primary: string = '#111827';
  static secondary: string = '#374151';
  static tertiary: string = '#6B7280';
  static background: string = '#F9FAFB';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E5E7EB';
  static outline: string = '#D1D5DB';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#FFFFFF';
  static onBackground: string = '#111827';
  static onSurface: string = '#1F2937';
}

class AppTypography {
  static displaySize: number = 26;
  static displayWeight: FontWeight = FontWeight.Bold;
  static headlineSize: number = 18;
  static headlineWeight: FontWeight = FontWeight.Medium;
  static titleSize: number = 14;
  static titleWeight: FontWeight = FontWeight.Medium;
  static bodySize: number = 12;
  static bodyWeight: FontWeight = FontWeight.Normal;
}

class AppShapes {
  static small: number = 6;
  static medium: number = 10;
  static large: number = 16;
}

class AppSpacing {
  static sm: number = 6;
  static md: number = 10;
  static lg: number = 14;
  static xl: number = 22;
}

interface ParcelPoint {
  x: number;
  y: number;
}

function generateParcelPoints(count: number, maxX: number, maxY: number): ParcelPoint[] {
  const points: ParcelPoint[] = [];
  for (let i: number = 0; i < count; i++) {
    points.push({
      x: Math.random() * maxX,
      y: Math.random() * maxY
    });
  }
  return points;
}

@Component
struct ParcelCanvas {
  @State dragX: number = 0;
  @State dragY: number = 0;
  @State parcelPoints: ParcelPoint[] = [];
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  @State canvasWidth: number = 0;
  @State canvasHeight: number = 0;
  private canvasPadding: number = 10;

  aboutToAppear(): void {
    this.parcelPoints = generateParcelPoints(25, 380, 280);
  }

  drawCanvas(): void {
    const ctx: CanvasRenderingContext2D = this.canvasContext;
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    ctx.fillStyle = AppColors.secondary;
    for (let i: number = 0; i < this.parcelPoints.length; i++) {
      const point: ParcelPoint = this.parcelPoints[i];
      ctx.beginPath();
      ctx.arc(point.x + this.canvasPadding, point.y + this.canvasPadding, 4, 0, Math.PI * 2);
      ctx.fill();
    }

    ctx.strokeStyle = AppColors.primary;
    ctx.lineWidth = 3;
    ctx.beginPath();
    ctx.arc(this.dragX, this.dragY, 20, 0, Math.PI * 2);
    ctx.stroke();
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.canvasContext)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawCanvas();
        })
        .onAreaChange((oldArea: Area, newArea: Area) => {
          this.canvasWidth = newArea.width as number;
          this.canvasHeight = newArea.height as number;
          this.drawCanvas();
        })

      Text('Drag to locate parcel')
        .fontSize(AppTypography.bodySize)
        .fontColor(AppColors.onSurface)
        .fontWeight(AppTypography.bodyWeight)
    }
    .width('100%')
    .height(300)
    .padding(this.canvasPadding)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline })
    .gesture(
      PanGesture()
        .onActionUpdate((event: GestureEvent) => {
          this.dragX = Math.max(0, Math.min(this.canvasWidth, this.dragX + event.offsetX));
          this.dragY = Math.max(0, Math.min(this.canvasHeight, this.dragY + event.offsetY));
          this.drawCanvas();
        })
    )
  }
}

@Entry
@Component
struct ParcelTracker {
  build() {
    Column() {
      Text('Parcel Tracker')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onBackground)
        .margin({ top: AppSpacing.xl })

      ParcelCanvas()
        .margin({ top: AppSpacing.xl })

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.onSurface)
        .margin({ top: AppSpacing.xl })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppColors.surfaceVariant, 0.0],
        [AppColors.background, 1.0]
      ]
    })
  }
}
