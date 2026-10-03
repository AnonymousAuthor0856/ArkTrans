// MARK: - AppTokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#EF476F';
    export const secondary: string = '#FFD166';
    export const tertiary: string = '#06D6A0';
    export const background: string = '#FFFCF2';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#F7EDE2';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#1E1E1E';
    export const onTertiary: string = '#1E1E1E';
    export const onBackground: string = '#1E1E1E';
    export const onSurface: string = '#1E1E1E';
  }

  export namespace Shapes {
    export const smallCornerRadius: number = 6;
  }

  export namespace Spacing {
    export const md: number = 12;
    export const xl: number = 24;
  }
}

// MARK: - DrawPoint
interface DrawPoint {
  x: number;
  y: number;
}

// MARK: - Retro Whiteboard Entry
@Entry
@Component
struct RetroWhiteboard {
  @State points: DrawPoint[] = [];
  @State currentColor: string = AppTokens.Colors.primary;
  @State canvasWidth: number = 0;
  @State canvasHeight: number = 0;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private buttonHeight: number = 44;
  private fabSize: number = 56;
  private circleRadius: number = 10;
  private topBarHeight: number = 54;
  private bottomBarHeight: number = 68;
  private fabBottomMargin: number = AppTokens.Spacing.xl;

  private get canvasBottomInset(): number {
    return Math.max(this.bottomBarHeight, this.fabSize + this.fabBottomMargin);
  }

  build() {
    Stack() {
      // Drawing canvas
      Canvas(this.canvasCtx)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.redraw();
        })
        .onAreaChange((_old: Area, area: Area) => {
          this.canvasWidth = area.width as number;
          this.canvasHeight = area.height as number;
        })
        .gesture(
          PanGesture({ distance: 0 })
            .onActionStart((event: PanGestureEvent) => {
              const info: FingerInfo = event.fingerList[0];
              this.addPoint(info.localX, info.localY);
            })
            .onActionUpdate((event: PanGestureEvent) => {
              const info: FingerInfo = event.fingerList[0];
              this.addPoint(info.localX, info.localY);
            })
        )

      // Top bar
      Column() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          .backgroundColor(AppTokens.Colors.background)
      }
      .width('100%')

      // Bottom bar with color buttons
      Column() {
        Blank()
        Row() {
          Blank()
          Button('Red')
            .fontSize(14)
            .fontColor(AppTokens.Colors.onPrimary)
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.primary;
            })
          Blank()
          Button('Yellow')
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSecondary)
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.secondary;
            })
          Blank()
          Button('Green')
            .fontSize(14)
            .fontColor(AppTokens.Colors.onTertiary)
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.tertiary;
            })
          Blank()
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surface)
      }
      .width('100%')
      .height('100%')

      // FAB - Clear button
      Row() {
        Blank()
        Column() {
          Blank()
          Button('Clear')
            .fontSize(12)
            .fontColor(AppTokens.Colors.onSecondary)
            .width(this.fabSize)
            .height(this.fabSize)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(this.fabSize / 2)
            .onClick(() => {
              this.points = [];
              this.redraw();
            })
            .margin({ right: AppTokens.Spacing.xl, bottom: this.fabBottomMargin })
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private addPoint(x: number, y: number): void {
    if (y >= this.topBarHeight &&
        y <= this.canvasHeight - this.canvasBottomInset &&
        x >= 0 && x <= this.canvasWidth) {
      this.points.push({ x: x, y: y });
      this.redraw();
    }
  }

  private redraw(): void {
    this.canvasCtx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);
    this.canvasCtx.fillStyle = this.currentColor;
    for (let i = 0; i < this.points.length; i++) {
      const p: DrawPoint = this.points[i];
      this.canvasCtx.beginPath();
      this.canvasCtx.arc(p.x, p.y, this.circleRadius, 0, Math.PI * 2);
      this.canvasCtx.fill();
    }
  }
}
