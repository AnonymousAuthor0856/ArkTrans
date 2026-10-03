import prompt_action from '@ohos.promptAction';

// MARK: - AppTokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FFEF476F';
    export const secondary: string = '#FFFFD166';
    export const tertiary: string = '#FF06D6A0';
    export const background: string = '#FFFFFCF2';
    export const surface: string = '#FFFFFFFF';
    export const surfaceVariant: string = '#FFF7EDE2';
    export const outline: string = '#FFE5D4B1';
    export const success: string = '#FF06D6A0';
    export const warning: string = '#FFFFA600';
    export const error: string = '#FFD62828';
    export const onPrimary: string = '#FFFFFFFF';
    export const onSecondary: string = '#FF1E1E1E';
    export const onTertiary: string = '#FF1E1E1E';
    export const onBackground: string = '#FF1E1E1E';
    export const onSurface: string = '#FF1E1E1E';
  }

  export namespace TypographyTokens {
    export const display: { size: number; weight: FontWeight } = { size: 26, weight: FontWeight.Bold };
    export const title: { size: number; weight: FontWeight } = { size: 18, weight: FontWeight.Medium };
    export const body: { size: number; weight: FontWeight } = { size: 14, weight: FontWeight.Normal };
    export const label: { size: number; weight: FontWeight } = { size: 12, weight: FontWeight.Medium };
  }

  export namespace Shapes {
    export const smallCornerRadius: number = 6;
    export const mediumCornerRadius: number = 10;
    export const largeCornerRadius: number = 16;
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
  }

  export namespace ElevationMapping {
    export const level1 = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 };
    export const level2 = { elevation: 4, radius: 8, dy: 4, opacity: 0.16 };
  }
}

// MARK: - DrawPoint
interface DrawPoint {
  x: number;
  y: number;
}

// MARK: - RootScreen Component
@Entry
@Component
struct RootScreen {
  @State points: DrawPoint[] = [];
  @State currentColor: string = AppTokens.Colors.primary;
  @State canvasWidth: number = 0;
  @State canvasHeight: number = 0;

  private buttonHeight: number = 44;
  private fabSize: number = 56;
  private circleRadius: number = 10;

  private topBarActualHeight: number = 54;
  private bottomBarActualHeight: number = 68;
  private fabBottomMargin: number = AppTokens.Spacing.xl;

  private get canvasBottomPadding(): number {
    return Math.max(this.bottomBarActualHeight, this.fabSize + this.fabBottomMargin);
  }

  build() {
    Stack() {
      // 2. Canvas for drawing
      Canvas(this.drawOnCanvas)
        .width('100%')
        .height('100%')
        .onAreaChange((oldArea, newArea) => {
          this.canvasWidth = newArea.width as number;
          this.canvasHeight = newArea.height as number;
        })
        .gesture(
          PanGesture({ distance: 0 })
            .onActionStart((event: GestureEvent) => {
              const x = event.x;
              const y = event.y;
              if (this.isInCanvasBounds(x, y)) {
                this.points.push({ x, y });
              }
            })
            .onActionUpdate((event: GestureEvent) => {
              const x = event.x;
              const y = event.y;
              if (this.isInCanvasBounds(x, y)) {
                this.points.push({ x, y });
              }
            })
        )
        .padding({ top: this.topBarActualHeight, bottom: this.canvasBottomPadding })

      // 3. Top bar
      Column() {
        Text('Retro Whiteboard')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          .backgroundColor(AppTokens.Colors.background)
      }
      .width('100%')
      .alignContent(Alignment.Top)
      .position({ x: 0, y: 0 })

      // 4. Bottom color selection bar
      Column() {
        Row() {
          Blank()
          Button('Red')
            .fontSize(AppTokens.TypographyTokens.body.size)
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
            .fontSize(AppTokens.TypographyTokens.body.size)
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
            .fontSize(AppTokens.TypographyTokens.body.size)
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
      .position({ x: 0, y: 0 })
      .alignContent(Alignment.Bottom)

      // 5. Floating Action Button (Clear)
      Column() {
        Row() {
          Blank()
          Button('Clear')
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontColor(AppTokens.Colors.onSecondary)
            .width(this.fabSize)
            .height(this.fabSize)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(this.fabSize / 2)
            .onClick(() => {
              this.points = [];
            })
            .margin({ right: AppTokens.Spacing.xl, bottom: this.fabBottomMargin })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Bottom)
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private isInCanvasBounds(x: number, y: number): boolean {
    return y >= this.topBarActualHeight &&
      y <= this.canvasHeight - this.canvasBottomPadding &&
      x >= 0 && x <= this.canvasWidth;
  }

  private drawOnCanvas = (ctx: CanvasRenderingContext2D) => {
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);
    for (let i = 0; i < this.points.length; i++) {
      const point = this.points[i];
      ctx.beginPath();
      ctx.arc(point.x, point.y, this.circleRadius, 0, Math.PI * 2);
      ctx.fillStyle = this.currentColor;
      ctx.fill();
    }
  }
}
