// Retro Whiteboard - ArkTS Conversion
// Productivity | Retro Flat theme | Drawing canvas with color picker

class Point {
  x: number = 0;
  y: number = 0;
  color: string = '#EF476F';

  constructor(x: number, y: number, color: string) {
    this.x = x;
    this.y = y;
    this.color = color;
  }
}

class AppTokens {
  static readonly Colors = {
    primary: '#EF476F',
    secondary: '#FFD166',
    tertiary: '#06D6A0',
    background: '#FFFCF2',
    surface: '#FFFFFF',
    surfaceVariant: '#F7EDE2',
    outline: '#E5D4B1',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16
  };
}

@Entry
@Component
struct RetroWhiteboard {
  @State points: Point[] = [];
  @State currentColor: string = AppTokens.Colors.primary;
  @State isDrawing: boolean = false;

  private canvasSettings = {
    dotRadius: 10
  };

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Canvas Area
      Stack({ alignContent: Alignment.BottomEnd }) {
        // Drawing Canvas
        Canvas(this.paintCanvas.bind(this))
          .width('100%')
          .height('100%')
          .backgroundColor(AppTokens.Colors.background)
          .gesture(
            PanGesture()
              .onActionStart((event: GestureEvent) => {
                this.isDrawing = true;
                this.addPoint(event.locationInfo.localX, event.locationInfo.localY);
              })
              .onActionUpdate((event: GestureEvent) => {
                if (this.isDrawing) {
                  this.addPoint(event.locationInfo.localX, event.locationInfo.localY);
                }
              })
              .onActionEnd(() => {
                this.isDrawing = false;
              })
              .onActionCancel(() => {
                this.isDrawing = false;
              })
          )

        // Floating Action Button - Clear
        Button('Clear')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(28)
          .width(80)
          .height(56)
          .margin({ right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .onClick(() => {
            this.points = [];
          })
      }
      .width('100%')
      .layoutWeight(1)

      // Bottom Bar - Color Selection
      Row() {
        Button('Red')
          .fontSize(14)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
          .height(40)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .onClick(() => {
            this.currentColor = AppTokens.Colors.primary;
          })

        Button('Yellow')
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .height(40)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .onClick(() => {
            this.currentColor = AppTokens.Colors.secondary;
          })

        Button('Green')
          .fontSize(14)
          .fontColor(AppTokens.Colors.onTertiary)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.small)
          .height(40)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .onClick(() => {
            this.currentColor = AppTokens.Colors.tertiary;
          })
      }
      .width('100%')
      .padding(AppTokens.Spacing.md)
      .justifyContent(FlexAlign.SpaceEvenly)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: 4,
        color: 'rgba(0, 0, 0, 0.12)',
        offsetY: -2
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private addPoint(x: number, y: number): void {
    this.points.push(new Point(x, y, this.currentColor));
  }

  private paintCanvas(ctx: CanvasRenderingContext2D): void {
    for (let i = 0; i < this.points.length; i++) {
      const p = this.points[i];
      ctx.beginPath();
      ctx.arc(p.x, p.y, this.canvasSettings.dotRadius, 0, Math.PI * 2);
      ctx.fillStyle = p.color;
      ctx.fill();
    }
  }
}
