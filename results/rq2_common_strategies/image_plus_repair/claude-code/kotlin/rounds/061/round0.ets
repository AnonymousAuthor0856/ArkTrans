// @ts-nocheck
import { Canvas, Path2D, CanvasRenderingContext2D } from '@kit.ArkUI';

// Design tokens
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
  static display: Font = { size: 26, weight: FontWeight.Bold };
  static headline: Font = { size: 18, weight: FontWeight.SemiBold };
  static title: Font = { size: 14, weight: FontWeight.Medium };
  static body: Font = { size: 12, weight: FontWeight.Normal };
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
  for (let i = 0; i < count; i++) {
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
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D();
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  private padding: number = 10;

  aboutToAppear() {
    this.parcelPoints = generateParcelPoints(25, 380, 280);
  }

  drawCanvas() {
    const ctx = this.canvasContext;
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);

    // Draw parcel points
    ctx.fillStyle = AppColors.secondary;
    for (const point of this.parcelPoints) {
      ctx.beginPath();
      ctx.arc(point.x + this.padding, point.y + this.padding, 4, 0, Math.PI * 2);
      ctx.fill();
    }

    // Draw draggable circle (stroke)
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
        .padding(this.padding)
        .onReady(() => {
          this.drawCanvas();
        })
        .onAreaChange((oldArea: Area, newArea: Area) => {
          this.canvasWidth = newArea.width as number;
          this.canvasHeight = newArea.height as number;
          this.drawCanvas();
        })

      Text('Drag to locate parcel')
        .fontSize(AppTypography.body.size)
        .fontColor(AppColors.onSurface)
        .fontWeight(AppTypography.body.weight)
    }
    .width('100%')
    .height(300)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline })
    .gesture(
      PanGesture()
        .onActionStart((event: GestureEvent) => {
          // Initialize drag position on first touch
          const x = event.x;
          const y = event.y;
          this.dragX = Math.max(0, Math.min(this.canvasWidth, x));
          this.dragY = Math.max(0, Math.min(this.canvasHeight, y));
          this.drawCanvas();
        })
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
        .fontSize(AppTypography.display.size)
        .fontWeight(AppTypography.display.weight)
        .fontColor(AppColors.onBackground)
        .margin({ top: AppSpacing.xl })

      ParcelCanvas()
        .margin({ top: AppSpacing.xl })

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTypography.body.size)
        .fontWeight(AppTypography.body.weight)
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
