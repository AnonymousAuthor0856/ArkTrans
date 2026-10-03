const Colors = {
  primary: '#EF476F',
  secondary: '#FFD166',
  tertiary: '#06D6A0',
  background: '#FFFCF2',
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
};

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
};

interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct Index {
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true));
  @State points: Point[] = [];
  @State color: string = Colors.primary;

  drawWhiteboard() {
    const ctx = this.context;
    ctx.clearRect(0, 0, ctx.width, ctx.height);
    ctx.fillStyle = this.color;
    for (const p of this.points) {
      ctx.beginPath();
      ctx.arc(p.x, p.y, 10, 0, 2 * Math.PI);
      ctx.fill();
    }
  }

  build() {
    Column() {
      Row() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Colors.background)

      Stack() {
        Canvas(this.context)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawWhiteboard();
          })
          .onTouch((event: TouchEvent) => {
            if (event.touches.length > 0) {
              this.points.push({ x: event.touches[0].x, y: event.touches[0].y });
              this.drawWhiteboard();
            }
          })
        Button('Clear')
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(Colors.secondary)
          .fontColor(Colors.onSecondary)
          .fontSize(12)
          .onClick(() => {
            this.points = [];
            this.drawWhiteboard();
          })
          .position({ right: 16, bottom: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(Colors.background)

      Row() {
        Button('Red')
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .borderRadius(6)
          .onClick(() => {
            this.color = Colors.primary;
          })
        Button('Yellow')
          .backgroundColor(Colors.secondary)
          .fontColor(Colors.onSecondary)
          .borderRadius(6)
          .onClick(() => {
            this.color = Colors.secondary;
          })
        Button('Green')
          .backgroundColor(Colors.tertiary)
          .fontColor(Colors.onTertiary)
          .borderRadius(6)
          .onClick(() => {
            this.color = Colors.tertiary;
          })
      }
      .width('100%')
      .padding(Spacing.md)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.surface)
      .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.12)', offsetY: 2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
