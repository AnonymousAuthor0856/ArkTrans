import window from '@ohos.window';
import { BusinessError } from '@ohos.base';

interface DrawPoint {
  x: number;
  y: number;
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#EF476F';
    export const secondary: string = '#FFD166';
    export const tertiary: string = '#06D6A0';
    export const background: string = '#FFFCF2';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#F7EDE2';
    export const outline: string = '#E5D4B1';
    export const success: string = '#06D6A0';
    export const warning: string = '#FFA600';
    export const error: string = '#D62828';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#1E1E1E';
    export const onTertiary: string = '#1E1E1E';
    export const onBackground: string = '#1E1E1E';
    export const onSurface: string = '#1E1E1E';
  }

  export namespace TypographyTokens {
    export const displaySize: number = 26;
    export const displayWeight: FontWeight = FontWeight.Bold;
    export const titleSize: number = 18;
    export const titleWeight: FontWeight = FontWeight.Medium;
    export const bodySize: number = 14;
    export const bodyWeight: FontWeight = FontWeight.Regular;
    export const labelSize: number = 12;
    export const labelWeight: FontWeight = FontWeight.Medium;
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

  export class ShadowSpec {
    elevation: number;
    radius: number;
    dy: number;
    opacity: number;

    constructor(elevation: number, radius: number, dy: number, opacity: number) {
      this.elevation = elevation;
      this.radius = radius;
      this.dy = dy;
      this.opacity = opacity;
    }
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
    export const level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16);
  }
}

function rgbaBlack(opacity: number): string {
  return `rgba(0, 0, 0, ${opacity})`;
}

@Entry
@Component
struct RootScreen {
  @State points: DrawPoint[] = [];
  @State currentColor: string = AppTokens.Colors.primary;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private readonly buttonHeight: number = 44;
  private readonly fabSize: number = 56;
  private readonly circleRadius: number = 10;

  private readonly topBarActualHeight: number = 54;
  private readonly bottomBarActualHeight: number = 68;
  private readonly fabBottomMargin: number = AppTokens.Spacing.xl;
  private readonly canvasBottomPadding: number = 80;

  private canvasWidth: number = 0;
  private canvasHeight: number = 0;

  aboutToAppear(): void {
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowSystemBarEnable([]);
      })
      .catch((_err: BusinessError) => {
      });
  }

  private drawCanvas(): void {
    if (this.canvasWidth <= 0 || this.canvasHeight <= 0) {
      return;
    }

    this.context.clearRect(0, 0, this.canvasWidth, this.canvasHeight);
    this.context.fillStyle = this.currentColor;

    for (let i = 0; i < this.points.length; i++) {
      const point: DrawPoint = this.points[i];
      this.context.beginPath();
      this.context.arc(point.x, point.y, this.circleRadius, 0, Math.PI * 2);
      this.context.fill();
    }
  }

  private addPoint(x: number, y: number): void {
    this.points.push({ x, y });
    this.drawCanvas();
  }

  private selectColor(color: string): void {
    this.currentColor = color;
    this.drawCanvas();
  }

  private clearCanvas(): void {
    this.points = [];
    this.drawCanvas();
  }

  @Builder
  private ColorButton(label: string, color: string, textColor: string) {
    Button({ type: ButtonType.Normal, stateEffect: true }) {
      Text(label)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(AppTokens.TypographyTokens.bodyWeight)
        .fontColor(textColor)
    }
    .height(this.buttonHeight)
    .layoutWeight(1)
    .backgroundColor(color)
    .borderRadius(AppTokens.Shapes.smallCornerRadius)
    .padding(0)
    .onClick(() => {
      this.selectColor(color);
    })
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Blank()
          .height(this.topBarActualHeight)

        Canvas(this.context)
          .width('100%')
          .layoutWeight(1)
          .onReady(() => {
            this.drawCanvas();
          })
          .onAreaChange((_oldValue: Area, newValue: Area) => {
            this.canvasWidth = Number(newValue.width);
            this.canvasHeight = Number(newValue.height);
            this.drawCanvas();
          })
          .onTouch((event: TouchEvent) => {
            if ((event.type === TouchType.Down || event.type === TouchType.Move) &&
              event.touches !== undefined &&
              event.touches.length > 0) {
              this.addPoint(event.touches[0].x, event.touches[0].y);
            }
          })

        Blank()
          .height(this.canvasBottomPadding)
      }
      .width('100%')
      .height('100%')

      Column() {
        Text('Retro Whiteboard')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
          .height(this.topBarActualHeight)
          .backgroundColor(AppTokens.Colors.background)
      }
      .width('100%')

      Column() {
        Blank()
          .layoutWeight(1)

        Row({ space: AppTokens.Spacing.md }) {
          this.ColorButton('Red', AppTokens.Colors.primary, AppTokens.Colors.onPrimary)
          this.ColorButton('Yellow', AppTokens.Colors.secondary, AppTokens.Colors.onSecondary)
          this.ColorButton('Green', AppTokens.Colors.tertiary, AppTokens.Colors.onTertiary)
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level1.elevation,
          color: rgbaBlack(AppTokens.ElevationMapping.level1.opacity),
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy
        })
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
          .layoutWeight(1)

        Row() {
          Blank()
            .layoutWeight(1)

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Clear')
              .fontSize(AppTokens.TypographyTokens.labelSize)
              .fontWeight(AppTokens.TypographyTokens.labelWeight)
              .fontColor(AppTokens.Colors.onSecondary)
          }
          .width(this.fabSize)
          .height(this.fabSize)
          .borderRadius(this.fabSize / 2)
          .backgroundColor(AppTokens.Colors.secondary)
          .padding(0)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.elevation,
            color: rgbaBlack(AppTokens.ElevationMapping.level1.opacity),
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })
          .onClick(() => {
            this.clearCanvas();
          })
        }
        .width('100%')
        .padding({
          right: AppTokens.Spacing.xl,
          bottom: this.fabBottomMargin
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}