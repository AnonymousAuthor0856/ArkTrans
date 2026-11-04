class MindNode {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

class MindColors {
  static primary: string = '#00FFFF';
  static secondary: string = '#00FF88';
  static tertiary: string = '#BB86FC';
  static background: string = '#0D0D0D';
  static surface: string = '#1C1C1C';
  static surfaceVariant: string = '#2E2E2E';
  static outline: string = '#3F3F3F';
  static onPrimary: string = '#000000';
  static onSecondary: string = '#000000';
  static onTertiary: string = '#000000';
  static onSurface: string = '#FFFFFF';
}

@Entry
@Component
struct Index {
  @State currentColor: string = MindColors.primary;
  @State nodes: MindNode[] = [
    new MindNode(200, 400),
    new MindNode(500, 700),
    new MindNode(350, 250)
  ];

  @Builder
  ColorButton(label: string, color: string, textColor: string) {
    Button(label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(textColor)
      .height(40)
      .backgroundColor(color)
      .borderRadius(20)
      .onClick(() => {
        this.currentColor = color;
      })
  }

  @Builder
  NodeView(node: MindNode) {
    Circle()
      .width(40)
      .height(40)
      .fill(this.currentColor)
      .position({ x: node.x, y: node.y })
  }

  @Builder
  LinkView(x: number, y: number, width: number, angle: number) {
    Text('')
      .width(width)
      .height(6)
      .backgroundColor(this.currentColor)
      .borderRadius(3)
      .rotate({ angle: angle })
      .position({ x: x, y: y })
  }

  private addNode() {
    let index: number = this.nodes.length;
    let x: number = 100 + ((index * 137) % 500);
    let y: number = 200 + ((index * 173) % 600);
    this.nodes.push(new MindNode(x, y));
  }

  build() {
    Column() {
      Text('Neon Mind Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(MindColors.primary)
        .lineHeight(34)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Stack() {
        this.LinkView(220, 420, 420, 35)
        this.LinkView(370, 270, 330, 118)

        ForEach(this.nodes, (node: MindNode, index: number) => {
          this.NodeView(node)
        }, (node: MindNode, index: number) => index.toString())

        Button('+')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(MindColors.onSecondary)
          .width(64)
          .height(64)
          .backgroundColor(MindColors.secondary)
          .borderRadius(32)
          .position({ x: 300, y: 520 })
          .onClick(() => {
            this.addNode();
          })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(MindColors.background)
      .gesture(
        PanGesture()
          .onActionEnd((event: GestureEvent) => {
            this.nodes.push(new MindNode(event.fingerList[0].localX, event.fingerList[0].localY));
          })
      )

      Row() {
        this.ColorButton('Cyan', MindColors.primary, MindColors.onPrimary)
        this.ColorButton('Green', MindColors.secondary, MindColors.onSecondary)
        this.ColorButton('Purple', MindColors.tertiary, MindColors.onTertiary)
      }
      .width('100%')
      .padding(12)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(MindColors.surfaceVariant)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(MindColors.background)
  }
}
