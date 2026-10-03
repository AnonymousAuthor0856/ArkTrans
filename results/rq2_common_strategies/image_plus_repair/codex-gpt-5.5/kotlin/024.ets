interface InkPoint {
  id: number;
  x: number;
  y: number;
}

const BACKGROUND: string = '#FFFCF2';
const TEXT: string = '#1E1E1E';
const RED: string = '#EF476F';
const YELLOW: string = '#FFD166';
const GREEN: string = '#06D6A0';
const BOTTOM_SURFACE: string = '#FFF4F6';
const WHITE: string = '#FFFFFFFF';

@Entry
@Component
struct MainPage {
  @State private points: InkPoint[] = [];
  @State private inkColor: string = RED;
  private nextPointId: number = 0;

  private addPoint(event: GestureEvent): void {
    const finger = event.fingerList[0];
    if (finger === undefined) {
      return;
    }

    const point: InkPoint = {
      id: this.nextPointId++,
      x: finger.localX,
      y: finger.localY
    };
    this.points = [...this.points, point];
  }

  build() {
    Stack() {
      Column() {
        Text('Retro Whiteboard')
          .fontSize(52)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT)
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ top: 34, bottom: 10 });

        Stack() {
          ForEach(this.points, (point: InkPoint) => {
            Circle()
              .width(20)
              .height(20)
              .fill(this.inkColor)
              .position({ x: point.x - 10, y: point.y - 10 });
          }, (point: InkPoint) => point.id.toString());
        }
        .width('100%')
        .layoutWeight(1)
        .gesture(
          PanGesture()
            .onActionStart((event: GestureEvent) => {
              this.addPoint(event);
            })
            .onActionUpdate((event: GestureEvent) => {
              this.addPoint(event);
            })
        );

        Row() {
          Button('Red')
            .width(147)
            .height(80)
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor(WHITE)
            .backgroundColor(RED)
            .borderRadius(12)
            .onClick(() => {
              this.inkColor = RED;
            });

          Button('Yellow')
            .width(181)
            .height(80)
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor(TEXT)
            .backgroundColor(YELLOW)
            .borderRadius(12)
            .onClick(() => {
              this.inkColor = YELLOW;
            });

          Button('Green')
            .width(173)
            .height(80)
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor(TEXT)
            .backgroundColor(GREEN)
            .borderRadius(12)
            .onClick(() => {
              this.inkColor = GREEN;
            });
        }
        .width('100%')
        .height(145)
        .padding({ left: 67, right: 67, top: 33, bottom: 32 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(BOTTOM_SURFACE)
        .shadow({
          radius: 4,
          color: '#18000000',
          offsetX: 0,
          offsetY: -1
        });
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BACKGROUND);

      Button('Clear')
        .width(112)
        .height(112)
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(TEXT)
        .backgroundColor(YELLOW)
        .borderRadius(56)
        .shadow({
          radius: 10,
          color: '#30000000',
          offsetX: 0,
          offsetY: 8
        })
        .position({ right: 32, bottom: 176 })
        .onClick(() => {
          this.points = [];
        });
    }
    .width('100%')
    .height('100%');
  }
}
