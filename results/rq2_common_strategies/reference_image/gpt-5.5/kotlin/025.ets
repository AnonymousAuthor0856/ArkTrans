const NAME: string = '026MindMapen';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Dark Neon';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#00FFFF';
  static readonly secondary: string = '#00FF88';
  static readonly tertiary: string = '#BB86FC';
  static readonly background: string = '#0D0D0D';
  static readonly surface: string = '#1C1C1C';
  static readonly surfaceVariant: string = '#2E2E2E';
  static readonly outline: string = '#3F3F3F';
  static readonly success: string = '#00FFAA';
  static readonly warning: string = '#FFC107';
  static readonly error: string = '#FF1744';
  static readonly onPrimary: string = '#000000';
  static readonly onSecondary: string = '#000000';
  static readonly onTertiary: string = '#000000';
  static readonly onBackground: string = '#FFFFFF';
  static readonly onSurface: string = '#FFFFFF';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class MindMapNode {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct Index {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private canvasReady: boolean = false;

  @Watch('redrawCanvas')
  @State private nodes: MindMapNode[] = [
    new MindMapNode(200, 400),
    new MindMapNode(500, 700),
    new MindMapNode(350, 250)
  ];

  @Watch('redrawCanvas')
  @State private currentColor: string = AppColors.primary;

  private redrawCanvas(): void {
    if (!this.canvasReady) {
      return;
    }

    this.canvasContext.clearRect(0, 0, 10000, 10000);

    this.canvasContext.lineWidth = 6;
    this.canvasContext.strokeStyle = this.currentColor;

    for (let i = 1; i < this.nodes.length; i++) {
      const previousNode: MindMapNode = this.nodes[i - 1];
      const currentNode: MindMapNode = this.nodes[i];

      this.canvasContext.beginPath();
      this.canvasContext.moveTo(previousNode.x, previousNode.y);
      this.canvasContext.lineTo(currentNode.x, currentNode.y);
      this.canvasContext.stroke();
    }

    this.canvasContext.fillStyle = this.currentColor;

    for (let i = 0; i < this.nodes.length; i++) {
      const node: MindMapNode = this.nodes[i];

      this.canvasContext.beginPath();
      this.canvasContext.arc(node.x, node.y, 20, 0, Math.PI * 2);
      this.canvasContext.fill();
    }
  }

  private addRandomNode(): void {
    const x: number = 100 + Math.floor(Math.random() * 501);
    const y: number = 200 + Math.floor(Math.random() * 601);
    this.nodes = this.nodes.concat([new MindMapNode(x, y)]);
  }

  @Builder
  private ColorButton(label: string, color: string, contentColor: string) {
    Button(label, { type: ButtonType.Capsule, stateEffect: true })
      .width(180)
      .height(80)
      .backgroundColor(color)
      .fontColor(contentColor)
      .fontSize(26)
      .fontWeight(FontWeight.Medium)
      .onClick(() => {
        this.currentColor = color;
      })
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Text('Neon Mind Map')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.primary)
        }
        .width('100%')
        .height(128)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.background)

        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.canvasReady = true;
              this.redrawCanvas();
            })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppColors.background)
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Move && event.touches.length > 0) {
            this.nodes = this.nodes.concat([
              new MindMapNode(event.touches[0].x, event.touches[0].y)
            ]);
          }
        })

        Row() {
          this.ColorButton('Cyan', AppColors.primary, AppColors.onPrimary)
          this.ColorButton('Green', AppColors.secondary, AppColors.onSecondary)
          this.ColorButton('Purple', AppColors.tertiary, AppColors.onTertiary)
        }
        .width('100%')
        .height(144)
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.md
        })
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.surfaceVariant)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Button('+', { type: ButtonType.Circle, stateEffect: true })
        .width(112)
        .height(112)
        .fontSize(34)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .shadow({
          radius: 12,
          color: '#66000000',
          offsetX: 0,
          offsetY: 8
        })
        .align(Alignment.BottomEnd)
        .margin({
          right: 32,
          bottom: 176
        })
        .onClick(() => {
          this.addRandomNode();
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}