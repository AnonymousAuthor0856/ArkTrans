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

class NodePoint {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct MainActivity {
  @State nodes: NodePoint[] = [new NodePoint(200, 400), new NodePoint(500, 700), new NodePoint(350, 250)];
  @State currentColor: string = AppColors.primary;

  addNode(): void {
    const x = 100 + ((this.nodes.length * 97) % 500);
    const y = 200 + ((this.nodes.length * 131) % 600);
    this.nodes = [...this.nodes, new NodePoint(x, y)];
  }

  @Builder
  Header(): void {
    Text('Neon Mind Map')
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.primary)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  MapCanvas(): void {
    Stack() {
      ForEach(this.nodes, (node: NodePoint, index: number) => {
        Circle()
          .width(40)
          .height(40)
          .fill(this.currentColor)
          .position({ x: node.x, y: node.y });
      }, (_node: NodePoint, index: number) => index.toString())
      Button('+')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(28)
        .width(56)
        .height(56)
        .position({ x: '80%', y: '78%' })
        .onClick(() => {
          this.addNode();
        });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .gesture(PanGesture().onActionUpdate((event: GestureEvent) => {
      this.nodes = [...this.nodes, new NodePoint(event.offsetX, event.offsetY)];
    }));
  }

  @Builder
  ColorButton(label: string, value: string, textColor: string): void {
    Button(label)
      .fontSize(14)
      .fontColor(textColor)
      .backgroundColor(value)
      .onClick(() => {
        this.currentColor = value;
      });
  }

  @Builder
  BottomBar(): void {
    Row() {
      this.ColorButton('Cyan', AppColors.primary, AppColors.onPrimary);
      this.ColorButton('Green', AppColors.secondary, AppColors.onSecondary);
      this.ColorButton('Purple', AppColors.tertiary, AppColors.onTertiary);
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surfaceVariant)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center);
  }

  build() {
    Column() {
      this.Header();
      this.MapCanvas();
      this.BottomBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
