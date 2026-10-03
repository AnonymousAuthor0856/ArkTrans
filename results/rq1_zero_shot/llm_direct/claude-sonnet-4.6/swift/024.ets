import { display } from '@kit.ArkUI';

// AppTokens
const AppColors = {
  primary: 0xFFEF476F,
  secondary: 0xFFFFD166,
  tertiary: 0xFF06D6A0,
  background: 0xFFFFFCF2,
  surface: 0xFFFFFFFF,
  surfaceVariant: 0xFFF7EDE2,
  outline: 0xFFE5D4B1,
  success: 0xFF06D6A0,
  warning: 0xFFFFA600,
  error: 0xFFD62828,
  onPrimary: 0xFFFFFFFF,
  onSecondary: 0xFF1E1E1E,
  onTertiary: 0xFF1E1E1E,
  onBackground: 0xFF1E1E1E,
  onSurface: 0xFF1E1E1E,
};

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
};

const AppShapes = {
  smallCornerRadius: 6,
  mediumCornerRadius: 10,
  largeCornerRadius: 16,
};

const ElevationLevel1 = {
  elevation: 2,
  radius: 4,
  dy: 2,
  opacity: 0.12,
};

interface DrawPoint {
  x: number;
  y: number;
  color: number;
}

@Entry
@Component
struct RootScreen {
  @State points: DrawPoint[] = [];
  @State currentColor: number = AppColors.primary;

  private buttonHeight: number = 44;
  private fabSize: number = 56;
  private circleRadius: number = 10;

  private topBarActualHeight: number = 30 + 2 * AppSpacing.md;
  private bottomBarActualHeight: number = 44 + 2 * AppSpacing.md;
  private fabBottomMargin: number = AppSpacing.xl;

  private get canvasBottomPadding(): number {
    return Math.max(this.bottomBarActualHeight, this.fabSize + this.fabBottomMargin);
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 1. Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.background)

      // 2. Drawing Canvas
      Canvas(new CanvasRenderingContext2D(new RenderingContextSettings(true)))
        .width('100%')
        .height('100%')
        .padding({
          top: this.topBarActualHeight,
          bottom: this.canvasBottomPadding
        })
        .onReady(() => {})
        .gesture(
          PanGesture({ fingers: 1, distance: 0 })
            .onActionStart((event: GestureEvent) => {
              const offsetX = event.offsetX;
              const offsetY = event.offsetY - this.topBarActualHeight;
              if (offsetY >= 0) {
                this.points.push({ x: offsetX, y: offsetY + this.topBarActualHeight, color: this.currentColor });
              }
            })
            .onActionUpdate((event: GestureEvent) => {
              const offsetX = event.offsetX;
              const offsetY = event.offsetY;
              this.points.push({ x: offsetX, y: offsetY, color: this.currentColor });
            })
        )

      // Canvas drawing overlay
      CanvasDrawLayer({ points: this.points, circleRadius: this.circleRadius })
        .width('100%')
        .height('100%')

      // 3. Top Bar
      Column() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.background)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      // 4. Bottom Color Bar
      Column() {
        Row({ space: AppSpacing.md }) {
          Button('Red')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onPrimary)
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.smallCornerRadius)
            .onClick(() => {
              this.currentColor = AppColors.primary;
            })

          Button('Yellow')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSecondary)
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.smallCornerRadius)
            .onClick(() => {
              this.currentColor = AppColors.secondary;
            })

          Button('Green')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onTertiary)
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(AppShapes.smallCornerRadius)
            .onClick(() => {
              this.currentColor = AppColors.tertiary;
            })
        }
        .width('100%')
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface)
        .shadow({
          color: `rgba(0,0,0,${ElevationLevel1.opacity})`,
          radius: ElevationLevel1.elevation,
          offsetX: 0,
          offsetY: -ElevationLevel1.dy
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .height('100%')

      // 5. FAB - Clear Button
      Column() {
        Row() {
          Button('Clear')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .width(this.fabSize)
            .height(this.fabSize)
            .backgroundColor(AppColors.secondary)
            .borderRadius(this.fabSize / 2)
            .shadow({
              color: `rgba(0,0,0,${ElevationLevel1.opacity})`,
              radius: ElevationLevel1.elevation,
              offsetX: 0,
              offsetY: ElevationLevel1.dy
            })
            .onClick(() => {
              this.points = [];
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
        .padding({
          right: AppSpacing.xl,
          bottom: this.fabBottomMargin
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct CanvasDrawLayer {
  @Prop points: DrawPoint[];
  @Prop circleRadius: number;
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true));

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawPoints();
      })
      .onChange(() => {
        this.drawPoints();
      })
  }

  private drawPoints() {
    this.context.clearRect(0, 0, this.context.width, this.context.height);
    for (const point of this.points) {
      const r = (point.color >> 16) & 0xFF;
      const g = (point.color >> 8) & 0xFF;
      const b = point.color & 0xFF;
      const a = ((point.color >> 24) & 0xFF) / 255;
      this.context.fillStyle = `rgba(${r},${g},${b},${a})`;
      this.context.beginPath();
      this.context.arc(point.x, point.y, this.circleRadius, 0, Math.PI * 2);
      this.context.fill();
    }
  }
}