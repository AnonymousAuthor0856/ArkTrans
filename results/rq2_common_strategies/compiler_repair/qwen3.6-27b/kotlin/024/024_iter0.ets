import { common, window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

// Token Definitions matching the Kotlin AppTokens
const AppTokens = {
  Colors: {
    primary: '#EF476F',
    secondary: '#FFD166',
    tertiary: '#06D6A0',
    background: '#FFFDCF', // Adjusted slightly for ArkTS hex format if needed, but standard hex works
    surface: '#FFFFFF',
    surfaceVariant: '#F7EDE2',
    outline: '#E5D4B1',
    success: '#06D6A0',
    warning: '#FFA600',
    error: '#D62828',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  },
  Shapes: {
    small: 6,
    medium: 10,
    large: 16
  }
};

@Entry
@Component
struct RootScreen {
  @State points: Point[] = [];
  @State currentColor: string = AppTokens.Colors.primary;
  private canvasContext: CanvasRenderingContext2D | null = null;
  private renderTask: RenderTask | null = null;

  aboutToAppear() {
    // Hide system bars to match the immersive mode in Kotlin code
    try {
      const ctx = getContext(this) as common.UIAbilityContext;
      const w = ctx.getWindowSync();
      w.setWindowSystemBarEnable([], (err) => {
        if (err) {
          console.error(`Failed to set window system bar enable. Code is ${err.code}, message is ${err.message}`);
        }
      });
    } catch (e) {
      console.error('Error accessing window context');
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60)
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)

      // Main Canvas Area
      Stack() {
        Canvas(this)
          .width('100%')
          .height('100%')
          .backgroundColor(AppTokens.Colors.background)
          .onReady((canvasRenderingContext: CanvasRenderingContext2D) => {
            this.canvasContext = canvasRenderingContext;
            this.renderTask = canvasRenderingContext.getRenderTask();
            this.drawPoints();
          })
          .gesture(
            PanGesture()
              .onActionUpdate((event?: GestureEvent) => {
                if (event) {
                  const x = event.localX;
                  const y = event.localY;
                  this.points.push({ x, y });
                  this.drawPoints();
                }
              })
          )
      }
      .layoutWeight(1)

      // Bottom Bar
      Row() {
        Button('Red')
          .onClick(() => {
            this.currentColor = AppTokens.Colors.primary;
            this.drawPoints();
          })
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(AppTokens.Shapes.small)
          .margin({ right: AppTokens.Spacing.sm })

        Button('Yellow')
          .onClick(() => {
            this.currentColor = AppTokens.Colors.secondary;
            this.drawPoints();
          })
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .borderRadius(AppTokens.Shapes.small)
          .margin({ right: AppTokens.Spacing.sm })

        Button('Green')
          .onClick(() => {
            this.currentColor = AppTokens.Colors.tertiary;
            this.drawPoints();
          })
          .backgroundColor(AppTokens.Colors.tertiary)
          .fontColor(AppTokens.Colors.onTertiary)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')
      .padding(AppTokens.Spacing.md)
      .justifyContent(FlexAlign.SpaceEvenly)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  drawPoints() {
    if (!this.canvasContext || !this.renderTask) {
      return;
    }
    
    const ctx = this.canvasContext;
    const task = this.renderTask;
    
    // Clear canvas
    ctx.clearRect(0, 0, ctx.width, ctx.height);
    
    // Draw all points
    for (let i = 0; i < this.points.length; i++) {
      const point = this.points[i];
      ctx.beginPath();
      ctx.arc(point.x, point.y, 10, 0, 2 * Math.PI);
      ctx.fillStyle = this.currentColor;
      ctx.fill();
    }
    
    // Commit changes
    task.commit();
  }
}

interface Point {
  x: number;
  y: number;
}