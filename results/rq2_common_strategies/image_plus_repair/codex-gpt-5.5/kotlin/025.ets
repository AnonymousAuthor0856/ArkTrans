interface MindNode {
  id: number;
  x: number;
  y: number;
}

const PRIMARY_COLOR: string = '#00FFFF';
const SECONDARY_COLOR: string = '#00FF88';
const TERTIARY_COLOR: string = '#BB86FC';
const BACKGROUND_COLOR: string = '#0D0D0D';
const SURFACE_VARIANT_COLOR: string = '#2E2E2E';
const BLACK_COLOR: string = '#000000';

@Entry
@Component
struct MainPage {
  @State private currentColor: string = PRIMARY_COLOR;
  @State private nodes: MindNode[] = [
    { id: 0, x: 200, y: 400 },
    { id: 1, x: 500, y: 700 },
    { id: 2, x: 350, y: 250 }
  ];

  private nextId: number = 3;

  private addNode(event: TouchEvent): void {
    const point = event.touches[0];
    if (point === undefined) {
      return;
    }

    const node: MindNode = {
      id: this.nextId++,
      x: point.x,
      y: point.y
    };
    this.nodes = [...this.nodes, node];
  }

  private chooseColor(color: string): void {
    this.currentColor = color;
  }

  private addRandomNode(): void {
    const node: MindNode = {
      id: this.nextId++,
      x: 100 + Math.random() * 500,
      y: 200 + Math.random() * 600
    };
    this.nodes = [...this.nodes, node];
  }

  private lineLength(start: MindNode, end: MindNode): number {
    const dx: number = end.x - start.x;
    const dy: number = end.y - start.y;
    return Math.sqrt(dx * dx + dy * dy);
  }

  private lineAngle(start: MindNode, end: MindNode): number {
    const dx: number = end.x - start.x;
    const dy: number = end.y - start.y;
    return Math.atan2(dy, dx) * 180 / Math.PI;
  }

  @Builder
  private graphLine(start: MindNode, end: MindNode) {
    Rect()
      .width(this.lineLength(start, end))
      .height(6)
      .fill(this.currentColor)
      .position({ x: start.x, y: start.y - 3 })
      .rotate({
        x: 0,
        y: 0,
        z: 1,
        angle: this.lineAngle(start, end)
      });
  }

  build() {
    Column() {
      Text('Neon Mind Map')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor(PRIMARY_COLOR)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(120)
        .padding({ top: 34 });

      Stack() {
        ForEach(this.nodes, (node: MindNode, index: number) => {
          if (index > 0) {
            this.graphLine(this.nodes[index - 1], node);
          }
        }, (node: MindNode) => `line-${node.id}`);

        ForEach(this.nodes, (node: MindNode) => {
          Circle()
            .width(40)
            .height(40)
            .fill(this.currentColor)
            .position({ x: node.x - 20, y: node.y - 20 });
        }, (node: MindNode) => `node-${node.id}`);

        Button('+')
          .width(112)
          .height(112)
          .fontSize(34)
          .fontWeight(FontWeight.Medium)
          .fontColor(BLACK_COLOR)
          .backgroundColor(SECONDARY_COLOR)
          .borderRadius(56)
          .shadow({
            radius: 10,
            color: '#30000000',
            offsetX: 0,
            offsetY: 8
          })
          .position({ right: 32, bottom: 32 })
          .onClick(() => {
            this.addRandomNode();
          });
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(BACKGROUND_COLOR)
      .onTouch((event: TouchEvent) => {
        if (event.type === TouchType.Down || event.type === TouchType.Move) {
          this.addNode(event);
        }
      });

      Row() {
        Button('Cyan')
          .width(160)
          .height(80)
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(BLACK_COLOR)
          .backgroundColor(PRIMARY_COLOR)
          .borderRadius(40)
          .onClick(() => {
            this.chooseColor(PRIMARY_COLOR);
          });

        Button('Green')
          .width(173)
          .height(80)
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(BLACK_COLOR)
          .backgroundColor(SECONDARY_COLOR)
          .borderRadius(40)
          .onClick(() => {
            this.chooseColor(SECONDARY_COLOR);
          });

        Button('Purple')
          .width(181)
          .height(80)
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(BLACK_COLOR)
          .backgroundColor(TERTIARY_COLOR)
          .borderRadius(40)
          .onClick(() => {
            this.chooseColor(TERTIARY_COLOR);
          });
      }
      .width('100%')
      .height(144)
      .padding({ left: 63, right: 63, top: 32, bottom: 32 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(SURFACE_VARIANT_COLOR);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_COLOR);
  }
}
