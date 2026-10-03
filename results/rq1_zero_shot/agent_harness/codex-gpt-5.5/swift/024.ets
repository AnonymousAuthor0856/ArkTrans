class DrawPoint {
  x: number;
  y: number;
  color: string;

  constructor(x: number, y: number, color: string) {
    this.x = x;
    this.y = y;
    this.color = color;
  }
}

@Entry
@Component
struct RootScreen {
  @State private currentColor: string = '#EF476F';
  @State private points: DrawPoint[] = [];

  @Builder
  ColorButton(label: string, color: string, textColor: string) {
    Button(label)
      .fontSize(14)
      .fontColor(textColor)
      .backgroundColor(color)
      .height(44)
      .borderRadius(6)
      .layoutWeight(1)
      .onClick(() => {
        this.currentColor = color;
      })
  }

  @Builder
  BottomBar() {
    Row() {
      Blank()
      this.ColorButton('Red', '#EF476F', '#FFFFFF')
      Blank()
      this.ColorButton('Yellow', '#FFD166', '#1E1E1E')
      Blank()
      this.ColorButton('Green', '#06D6A0', '#1E1E1E')
      Blank()
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 2, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  DrawingCanvas() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .fill('#FFFCF2')
      ForEach(this.points, (point: DrawPoint, index: number) => {
        Circle()
          .width(20)
          .height(20)
          .fill(point.color)
          .position({ x: point.x, y: point.y })
      }, (point: DrawPoint, index: number) => index.toString())
    }
    .width('100%')
    .height('100%')
    .onClick(() => {
      const next = this.points.slice();
      next.push(new DrawPoint(120 + next.length * 18 % 160, 140 + next.length * 12 % 220, this.currentColor));
      this.points = next;
    })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 12, bottom: 12 })
          .backgroundColor('#FFFCF2')

        this.DrawingCanvas()
          .layoutWeight(1)

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFCF2')

      Button('Clear')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E1E1E')
        .backgroundColor('#FFD166')
        .width(56)
        .height(56)
        .borderRadius(28)
        .shadow({ radius: 2, color: '#1F000000', offsetX: 0, offsetY: 2 })
        .margin({ right: 24, bottom: 24 })
        .onClick(() => {
          this.points = [];
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF2')
  }
}
