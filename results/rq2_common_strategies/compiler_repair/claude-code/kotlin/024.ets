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

class ColorTokens {
  primary: string = '#EF476F';
  secondary: string = '#FFD166';
  tertiary: string = '#06D6A0';
  background: string = '#FFFCF2';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#F7EDE2';
  outline: string = '#E5D4B1';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#1E1E1E';
  onTertiary: string = '#1E1E1E';
  onBackground: string = '#1E1E1E';
  onSurface: string = '#1E1E1E';
}

class SpacingTokens {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
}

class ShapeTokens {
  small: number = 6;
  medium: number = 10;
  large: number = 16;
}

class AppTokens {
  static Colors: ColorTokens = new ColorTokens();
  static Spacing: SpacingTokens = new SpacingTokens();
  static Shapes: ShapeTokens = new ShapeTokens();
}

class CanvasSettings {
  dotRadius: number = 10;
}

@Entry
@Component
struct RetroWhiteboard {
  @State points: Point[] = [];
  @State currentColor: string = AppTokens.Colors.primary;
  @State isDrawing: boolean = false;

  private canvasSettings: CanvasSettings = new CanvasSettings();

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
                if (event.fingerList && event.fingerList.length > 0) {
                  this.addPoint(event.fingerList[0].localX, event.fingerList[0].localY);
                }
              })
              .onActionUpdate((event: GestureEvent) => {
                if (this.isDrawing && event.fingerList && event.fingerList.length > 0) {
                  this.addPoint(event.fingerList[0].localX, event.fingerList[0].localY);
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
      const p: Point = this.points[i];
      ctx.beginPath();
      ctx.arc(p.x, p.y, this.canvasSettings.dotRadius, 0, Math.PI * 2);
      ctx.fillStyle = p.color;
      ctx.fill();
    }
  }
}
