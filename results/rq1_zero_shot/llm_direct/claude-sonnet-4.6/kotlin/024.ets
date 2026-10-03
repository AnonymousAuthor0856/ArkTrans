import { router } from '@kit.ArkUI';

// Token definitions
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FFEF476F';
    export const secondary: string = '#FFFFD166';
    export const tertiary: string = '#FF06D6A0';
    export const background: string = '#FFFFFCF2';
    export const surface: string = '#FFFFFFFF';
    export const surfaceVariant: string = '#FFF7EDE2';
    export const outline: string = '#FFE5D4B1';
    export const onPrimary: string = '#FFFFFFFF';
    export const onSecondary: string = '#FF1E1E1E';
    export const onTertiary: string = '#FF1E1E1E';
    export const onBackground: string = '#FF1E1E1E';
    export const onSurface: string = '#FF1E1E1E';
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
  }
}

interface DrawPoint {
  x: number;
  y: number;
  color: string;
}

@Entry
@Component
struct RootScreen {
  @State points: DrawPoint[] = [];
  @State currentColor: string = AppTokens.Colors.primary;
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  redrawCanvas(): void {
    this.canvasContext.clearRect(
      0,
      0,
      this.canvasContext.width,
      this.canvasContext.height
    );
    for (const pt of this.points) {
      this.canvasContext.beginPath();
      this.canvasContext.fillStyle = pt.color;
      this.canvasContext.arc(pt.x, pt.y, 10, 0, Math.PI * 2);
      this.canvasContext.fill();
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
          .width('100%')
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)

      // Canvas drawing area
      Stack() {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .backgroundColor(AppTokens.Colors.background)
          .onReady(() => {
            this.redrawCanvas();
          })
          .onTouch((event: TouchEvent) => {
            if (
              event.type === TouchType.Move ||
              event.type === TouchType.Down
            ) {
              const touches = event.touches;
              for (let i = 0; i < touches.length; i++) {
                const touch = touches[i];
                const newPoint: DrawPoint = {
                  x: touch.x,
                  y: touch.y,
                  color: this.currentColor,
                };
                this.points.push(newPoint);
                // Draw incrementally
                this.canvasContext.beginPath();
                this.canvasContext.fillStyle = newPoint.color;
                this.canvasContext.arc(
                  newPoint.x,
                  newPoint.y,
                  10,
                  0,
                  Math.PI * 2
                );
                this.canvasContext.fill();
              }
            }
          })

        // Floating Action Button (Clear)
        Button('Clear')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(50)
          .width(72)
          .height(72)
          .position({ right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .onClick(() => {
            this.points = [];
            this.canvasContext.clearRect(
              0,
              0,
              this.canvasContext.width,
              this.canvasContext.height
            );
          })
      }
      .width('100%')
      .layoutWeight(1)

      // Bottom Bar
      Row() {
        Button('Red')
          .fontSize(14)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(6)
          .height(40)
          .layoutWeight(1)
          .margin({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
          .onClick(() => {
            this.currentColor = AppTokens.Colors.primary;
          })

        Button('Yellow')
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(6)
          .height(40)
          .layoutWeight(1)
          .margin({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
          .onClick(() => {
            this.currentColor = AppTokens.Colors.secondary;
          })

        Button('Green')
          .fontSize(14)
          .fontColor(AppTokens.Colors.onTertiary)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(6)
          .height(40)
          .layoutWeight(1)
          .margin({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
          .onClick(() => {
            this.currentColor = AppTokens.Colors.tertiary;
          })
      }
      .width('100%')
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .shadow({
        radius: 4,
        color: '#1F000000',
        offsetX: 0,
        offsetY: -2,
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}