class MindNode {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct RootScreen {
  @State private nodes: MindNode[] = [new MindNode(200, 400), new MindNode(500, 700), new MindNode(350, 250)];
  @State private currentColor: string = '#00FFFF';

  @Builder
  ColorButton(label: string, color: string) {
    Button(label)
      .fontSize(14)
      .fontColor('#000000')
      .backgroundColor(color)
      .height(32)
      .padding({ left: 16, right: 16 })
      .borderRadius(16)
      .onClick(() => {
        this.currentColor = color;
      })
  }

  @Builder
  MindCanvas() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .fill('#0D0D0D')
      ForEach(this.nodes, (node: MindNode, index: number) => {
        Circle()
          .width(40)
          .height(40)
          .fill(this.currentColor)
          .position({ x: node.x, y: node.y })
      }, (node: MindNode, index: number) => index.toString())
    }
    .width('100%')
    .height('100%')
    .onClick(() => {
      const next = this.nodes.slice();
      next.push(new MindNode(120 + (next.length * 77) % 420, 180 + (next.length * 113) % 520));
      this.nodes = next;
    })
  }

  @Builder
  BottomBar() {
    Row() {
      this.ColorButton('Cyan', '#00FFFF')
      this.ColorButton('Green', '#00FF88')
        .margin({ left: 12 })
      this.ColorButton('Purple', '#BB86FC')
        .margin({ left: 12 })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding(12)
    .backgroundColor('#2E2E2E')
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      this.MindCanvas()

      Column() {
        Text('Neon Mind Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FFFF')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 16, bottom: 16 })
          .backgroundColor('#0D0D0D')
        Blank()
        this.BottomBar()
      }
      .width('100%')
      .height('100%')

      Button('+')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .backgroundColor('#00FF88')
        .width(56)
        .height(56)
        .borderRadius(28)
        .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
        .margin({ right: 16, bottom: 76 })
        .onClick(() => {
          const next = this.nodes.slice();
          next.push(new MindNode(100 + (next.length * 91) % 500, 200 + (next.length * 73) % 600));
          this.nodes = next;
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0D0D0D')
  }
}
