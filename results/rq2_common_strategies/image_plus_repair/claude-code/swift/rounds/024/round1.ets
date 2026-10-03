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

  export namespace TypographyTokens {
    export const display = { size: 26, weight: FontWeight.Bold };
    export const body = { size: 14, weight: FontWeight.Normal };
    export const label = { size: 12, weight: FontWeight.Medium };
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
      Canvas(this.drawOnCanvas)
        .width('100%')
        .height('100%')
        .onAreaChange((_old, area) => {
          this.canvasWidth = area.width as number;
          this.canvasHeight = area.height as number;
        })
        .gesture(
          PanGesture({ distance: 0 })
            .onActionStart((event: GestureEvent) => {
              this.addPoint(event.x, event.y);
            })
            .onActionUpdate((event: GestureEvent) => {
              this.addPoint(event.x, event.y);
            })
        )

      // Top bar
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

      // Bottom bar with color buttons
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
      .alignContent(Alignment.Bottom)

      // FAB - Clear button
      Row() {
        Blank()
        Column() {
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
        }
        .margin({ right: AppTokens.Spacing.xl, bottom: this.fabBottomMargin })
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Bottom)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private addPoint(x: number, y: number): void {
    if (y >= this.topBarHeight &&
        y <= this.canvasHeight - this.canvasBottomInset &&
        x >= 0 && x <= this.canvasWidth) {
      this.points.push({ x, y });
    }
  }

  private drawOnCanvas = (ctx: CanvasRenderingContext2D) => {
    ctx.clearRect(0, 0, this.canvasWidth, this.canvasHeight);
    ctx.fillStyle = this.currentColor;
    for (let i = 0; i < this.points.length; i++) {
      const p = this.points[i];
      ctx.beginPath();
      ctx.arc(p.x, p.y, this.circleRadius, 0, Math.PI * 2);
      ctx.fill();
    }
  }
}
