// Index.ets
import { drawing } from '@kit.ArkGraphics2D';

interface Position {
  x: number;
  y: number;
}

class AppTokens {
  static primary: string = '#60A5FA';
  static secondary: string = '#93C5FD';
  static tertiary: string = '#A5B4FC';
  static background: string = '#F9FAFB';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#EFF6FF';
  static outline: string = '#D1D5DB';
  static success: string = '#16A34A';
  static warning: string = '#F59E0B';
  static error: string = '#DC2626';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#1E293B';
  static onTertiary: string = '#1E1E2F';
  static onBackground: string = '#111827';
  static onSurface: string = '#111827';
}

@Entry
@Component
struct RootScreen {
  @State markerPosition: Position = { x: 200, y: 400 };

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(AppTokens.background)

      // Content Area
      Column() {
        // Map Container
        Stack({ alignContent: Alignment.Center }) {
          // Canvas for drawing circles and marker
          Canvas(this)
            .width('100%')
            .height('100%')
            .onReady(() => {
              const context = this.getCanvasContext();
              if (!context) return;
              const canvas = context.canvas;
              const width = canvas.width;
              const height = canvas.height;
              const centerX = width / 2;
              const centerY = height / 2;

              // Draw outer circle
              const outerPaint = new drawing.Paint();
              outerPaint.setAntiAlias(true);
              outerPaint.setColor({ alpha: 51, red: 147, green: 197, blue: 253 });
              canvas.drawCircle(centerX, centerY, 340, outerPaint);

              // Draw inner circle
              const innerPaint = new drawing.Paint();
              innerPaint.setAntiAlias(true);
              innerPaint.setColor({ alpha: 76, red: 147, green: 197, blue: 253 });
              canvas.drawCircle(centerX, centerY, 220, innerPaint);

              // Draw marker stroke
              const strokePaint = new drawing.Paint();
              strokePaint.setAntiAlias(true);
              strokePaint.setColor({ alpha: 76, red: 96, green: 165, blue: 250 });
              strokePaint.setStyle(drawing.PaintStyle.STROKE_STYLE);
              strokePaint.setStrokeWidth(3);
              canvas.drawCircle(this.markerPosition.x, this.markerPosition.y, 30, strokePaint);

              // Draw marker center
              const centerPaint = new drawing.Paint();
              centerPaint.setAntiAlias(true);
              centerPaint.setColor({ alpha: 255, red: 96, green: 165, blue: 250 });
              canvas.drawCircle(this.markerPosition.x, this.markerPosition.y, 14, centerPaint);
            })
        }
        .width('100%')
        .height(400)
        .borderRadius(24)
        .border({ width: 1, color: AppTokens.outline })
        .linearGradient({
          angle: 0,
          colors: [[AppTokens.surface, 0.8], [AppTokens.surfaceVariant, 0.6]]
        })

        // Bottom Controls
        Column() {
          Text(`Spot Coordinates: (${this.markerPosition.x.toFixed(0)}, ${this.markerPosition.y.toFixed(0)})`)
            .fontSize(14)
            .fontColor(AppTokens.onSurface)
            .margin({ bottom: 12 })

          Button('Save Marker')
            .type(ButtonType.Capsule)
            .width('100%')
            .height(48)
            .backgroundColor(AppTokens.primary)
            .fontColor(AppTokens.onPrimary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .margin({ top: 24 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [
          ['#FFFFFF', 0.6],
          [AppTokens.surfaceVariant, 0.5],
          ['#FFFFFF', 0.7]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}