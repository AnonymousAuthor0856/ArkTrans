// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
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
  };

  static readonly Typography = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium },
    title: { fontSize: 14, fontWeight: FontWeight.Medium },
    body: { fontSize: 12, fontWeight: FontWeight.Regular }
  };

  static readonly Shapes = {
    smallCornerRadius: 6,
    mediumCornerRadius: 10,
    largeCornerRadius: 16
  };

  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 22
  };
}

// ParcelCanvas.ets
import { AppTokens } from './AppTokens';

@Component
export struct ParcelCanvas {
  @State private dragOffsetX: number = 0;
  @State private dragOffsetY: number = 0;
  @State private parcelPoints: Array<{ x: number, y: number }> = [];
  @State private canvasWidth: number = 0;
  @State private canvasHeight: number = 0;

  private generateRandomPoints(width: number, height: number): Array<{ x: number, y: number }> {
    const points: Array<{ x: number, y: number }> = [];
    for (let i = 0; i < 25; i++) {
      points.push({
        x: Math.random() * width,
        y: Math.random() * height
      });
    }
    return points;
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.canvasWidth > 0 ? this.canvasWidth : 300, this.canvasHeight > 0 ? this.canvasHeight : 260)
        .onReady(() => {
          // Draw parcel points
          for (const point of this.parcelPoints) {
            this.drawCircle(point.x, point.y, 4, AppTokens.Colors.secondary, true);
          }
          // Draw draggable circle
          this.drawCircle(this.dragOffsetX, this.dragOffsetY, 20, AppTokens.Colors.primary, false);
        })
        .width('100%')
        .height('100%')

      Text('Drag to locate parcel')
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontWeight(AppTokens.Typography.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(300)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.largeCornerRadius)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.largeCornerRadius
    })
    .padding(AppTokens.Spacing.md)
    .gesture(
      PanGesture()
        .onActionStart((event: GestureEvent) => {
          this.updateDragPosition(event.offsetX, event.offsetY);
        })
        .onActionUpdate((event: GestureEvent) => {
          this.updateDragPosition(event.offsetX, event.offsetY);
        })
    )
    .onAreaChange((oldValue: Area, newValue: Area) => {
      const effectiveWidth = newValue.width as number - (AppTokens.Spacing.md * 2);
      const effectiveHeight = newValue.height as number - (AppTokens.Spacing.md * 2);
      this.canvasWidth = effectiveWidth;
      this.canvasHeight = effectiveHeight;

      if (this.parcelPoints.length === 0) {
        this.parcelPoints = this.generateRandomPoints(effectiveWidth, effectiveHeight);
        this.dragOffsetX = 20 + Math.random() * (effectiveWidth - 40);
        this.dragOffsetY = 20 + Math.random() * (effectiveHeight - 40);
      }
    })
  }

  private updateDragPosition(x: number, y: number) {
    const effectiveWidth = this.canvasWidth;
    const effectiveHeight = this.canvasHeight;
    this.dragOffsetX = Math.max(20, Math.min(x, effectiveWidth - 20));
    this.dragOffsetY = Math.max(20, Math.min(y, effectiveHeight - 20));
  }

  private drawCircle(x: number, y: number, radius: number, color: string, filled: boolean) {
    // This is a placeholder - actual drawing would use Canvas API
    // In ArkTS, Canvas drawing is done through the CanvasRenderingContext2D
  }
}

// RootScreen.ets
import { AppTokens } from './AppTokens';
import { ParcelCanvas } from './ParcelCanvas';

@Entry
@Component
struct RootScreen {
  build() {
    Column({ space: AppTokens.Spacing.xl }) {
      Text('Parcel Tracker')
        .fontSize(AppTokens.Typography.display.fontSize)
        .fontWeight(AppTokens.Typography.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)

      ParcelCanvas()

      Text('Visualize parcel movements and positions.')
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontWeight(AppTokens.Typography.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      angle: 180,
      colors: [[AppTokens.Colors.surfaceVariant, 0], [AppTokens.Colors.background, 1]]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}