// entry/src/main/ets/viewmodel/AppTokens.ets
export class AppTokens {
  static readonly Colors: ColorConfig = {
    primary: '#EF476F',
    secondary: '#FFD166',
    tertiary: '#06D6A0',
    background: '#FFFCF2',
    surface: '#FFFFFF',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E'
  }

  static readonly Spacing: SpacingConfig = {
    md: 12,
    xl: 24
  }

  static readonly Shapes: ShapeConfig = {
    smallCornerRadius: 6,
    largeCornerRadius: 16
  }
}

interface ColorConfig {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  onPrimary: string;
  onSecondary: string;
}

interface SpacingConfig {
  md: number;
  xl: number;
}

interface ShapeConfig {
  smallCornerRadius: number;
  largeCornerRadius: number;
}

// entry/src/main/ets/pages/Index.ets
@Entry
@Component
struct RetroWhiteboard {
  @State points: Point[] = []
  @State currentColor: string = AppTokens.Colors.primary

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Canvas Area
      Canvas()
        .width('100%')
        .height('100%')
        .padding({ top: 80, bottom: 100 })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down || event.type === TouchType.Move) {
            const touchInfo: TouchObject = event.touches[0];
            const point: Point = new Point(touchInfo.localX, touchInfo.localY);
            this.points.push(point);
          }
        })
        .drawContext((context: CanvasRenderingContext2D, canvas: CanvasAttribute) => {
          context.fillStyle = this.currentColor;
          for (let i = 0; i < this.points.length; i++) {
            context.beginPath();
            context.arc(this.points[i].x, this.points[i].y, 10, 0, 2 * Math.PI);
            context.fill();
          }
        })

      // Top Bar
      Column() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
          .margin({ top: 20, bottom: 12 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      // Bottom Controls Container
      Column() {
        // Color Buttons
        Row() {
          Button('Red')
            .type(ButtonType.Normal)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .height(44)
            .onClick(() => this.currentColor = AppTokens.Colors.primary)

          Button('Yellow')
            .type(ButtonType.Normal)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .height(44)
            .onClick(() => this.currentColor = AppTokens.Colors.secondary)

          Button('Green')
            .type(ButtonType.Normal)
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontColor(AppTokens.Colors.onSecondary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .height(44)
            .onClick(() => this.currentColor = AppTokens.Colors.tertiary)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .padding({ left: 20, right: 20, bottom: 10 })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 10, color: 'rgba(0,0,0,0.1)', offsetY: -2 })

        // Floating Action Button (Clear)
        Button('Clear')
          .type(ButtonType.Circle)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .width(56)
          .height(56)
          .position({ x: 'calc(100% - 70vp)', y: '-30vp' })
          .onClick(() => this.points = [])
      }
      .width('100%')
      .alignSelf(ItemAlign.End)
    }
    .width('100%')
    .height('100%')
  }
}

class Point {
  x: number;
  y: number;
  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}