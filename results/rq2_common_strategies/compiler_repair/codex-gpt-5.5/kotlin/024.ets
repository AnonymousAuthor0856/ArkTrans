class WhiteboardPoint {
  x: number;
  y: number;
  color: string;

  constructor(x: number, y: number, color: string) {
    this.x = x;
    this.y = y;
    this.color = color;
  }
}

class WhiteboardColors {
  static primary: string = '#EF476F';
  static secondary: string = '#FFD166';
  static tertiary: string = '#06D6A0';
  static background: string = '#FFFCF2';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#F7EDE2';
  static outline: string = '#E5D4B1';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#1E1E1E';
  static onTertiary: string = '#1E1E1E';
  static onSurface: string = '#1E1E1E';
}

@Entry
@Component
struct Index {
  @State currentColor: string = WhiteboardColors.primary;
  @State points: WhiteboardPoint[] = [];

  @Builder
  ColorButton(label: string, color: string, textColor: string) {
    Button(label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(textColor)
      .height(40)
      .backgroundColor(color)
      .borderRadius(6)
      .onClick(() => {
        this.currentColor = color;
      })
  }

  @Builder
  DrawingPoint(point: WhiteboardPoint) {
    Circle()
      .width(20)
      .height(20)
      .fill(point.color)
      .position({ x: point.x, y: point.y })
  }

  build() {
    Column() {
      Text('Retro Whiteboard')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(WhiteboardColors.onSurface)
        .lineHeight(32)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Stack() {
        ForEach(this.points, (point: WhiteboardPoint, index: number) => {
          this.DrawingPoint(point)
        }, (point: WhiteboardPoint, index: number) => index.toString())

        Button('Clear')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(WhiteboardColors.onSecondary)
          .width(72)
          .height(72)
          .backgroundColor(WhiteboardColors.secondary)
          .borderRadius(36)
          .position({ x: 280, y: 500 })
          .onClick(() => {
            this.points = [];
          })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(WhiteboardColors.background)
      .gesture(
        PanGesture()
          .onActionUpdate((event: GestureEvent) => {
            let newPoint: WhiteboardPoint = new WhiteboardPoint(event.fingerList[0].localX, event.fingerList[0].localY, this.currentColor);
            this.points.push(newPoint);
          })
      )

      Row() {
        this.ColorButton('Red', WhiteboardColors.primary, WhiteboardColors.onPrimary)
        this.ColorButton('Yellow', WhiteboardColors.secondary, WhiteboardColors.onSecondary)
        this.ColorButton('Green', WhiteboardColors.tertiary, WhiteboardColors.onTertiary)
      }
      .width('100%')
      .padding(12)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(WhiteboardColors.surface)
      .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(WhiteboardColors.background)
  }
}
