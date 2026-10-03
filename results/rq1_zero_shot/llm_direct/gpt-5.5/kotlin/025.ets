import window from '@ohos.window';

const NAME: string = '026MindMapen';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Dark Neon';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class MindNode {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#00FFFF';
    export const secondary: string = '#00FF88';
    export const tertiary: string = '#BB86FC';
    export const background: string = '#0D0D0D';
    export const surface: string = '#1C1C1C';
    export const surfaceVariant: string = '#2E2E2E';
    export const outline: string = '#3F3F3F';
    export const success: string = '#00FFAA';
    export const warning: string = '#FFC107';
    export const error: string = '#FF1744';
    export const onPrimary: string = '#000000';
    export const onSecondary: string = '#000000';
    export const onTertiary: string = '#000000';
    export const onBackground: string = '#FFFFFF';
    export const onSurface: string = '#FFFFFF';
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28;
    export const titleSize: number = 18;
    export const bodySize: number = 14;
    export const labelSize: number = 12;
  }

  export namespace Spacing {
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
    export const level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18);
  }
}

@Entry
@Component
struct RootScreen {
  @State private nodes: MindNode[] = [
    new MindNode(200, 400),
    new MindNode(500, 700),
    new MindNode(350, 250)
  ];
  @State private currentColor: string = AppTokens.Colors.primary;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context2d: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private canvasWidth: number = 720;
  private canvasHeight: number = 1040;

  aboutToAppear(): void {
    this.enableImmersiveMode();
  }

  onPageShow(): void {
    this.enableImmersiveMode();
    this.renderMindMapAsync();
  }

  private enableImmersiveMode(): void {
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch(() => {
      });
  }

  private addNode(x: number, y: number): void {
    this.nodes = [...this.nodes, new MindNode(x, y)];
    this.renderMindMapAsync();
  }

  private setNodeColor(color: string): void {
    this.currentColor = color;
    this.renderMindMapAsync();
  }

  private renderMindMapAsync(): void {
    setTimeout(() => {
      this.renderMindMap();
    }, 0);
  }

  private renderMindMap(): void {
    const width: number = this.canvasWidth > 0 ? this.canvasWidth : 720;
    const height: number = this.canvasHeight > 0 ? this.canvasHeight : 1040;

    this.context2d.clearRect(0, 0, width, height);
    this.context2d.fillStyle = AppTokens.Colors.background;
    this.context2d.fillRect(0, 0, width, height);

    this.context2d.strokeStyle = this.currentColor;
    this.context2d.lineWidth = 6;
    this.context2d.lineCap = 'round';
    this.context2d.lineJoin = 'round';
    this.context2d.shadowColor = this.currentColor;
    this.context2d.shadowBlur = 14;

    for (let i = 1; i < this.nodes.length; i++) {
      this.context2d.beginPath();
      this.context2d.moveTo(this.nodes[i - 1].x, this.nodes[i - 1].y);
      this.context2d.lineTo(this.nodes[i].x, this.nodes[i].y);
      this.context2d.stroke();
    }

    this.context2d.fillStyle = this.currentColor;
    this.context2d.shadowBlur = 18;

    this.nodes.forEach((node: MindNode) => {
      this.context2d.beginPath();
      this.context2d.arc(node.x, node.y, 20, 0, Math.PI * 2);
      this.context2d.fill();
    });

    this.context2d.shadowBlur = 0;
  }

  @Builder
  private TopBar() {
    Row() {
      Text('Neon Mind Map')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.primary)
    }
    .width('100%')
    .height(88)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  private BottomBar() {
    Row() {
      Button('Cyan')
        .height(44)
        .padding({ left: 18, right: 18 })
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          this.setNodeColor(AppTokens.Colors.primary);
        })

      Button('Green')
        .height(44)
        .padding({ left: 18, right: 18 })
        .backgroundColor(AppTokens.Colors.secondary)
        .fontColor(AppTokens.Colors.onSecondary)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          this.setNodeColor(AppTokens.Colors.secondary);
        })

      Button('Purple')
        .height(44)
        .padding({ left: 18, right: 18 })
        .backgroundColor(AppTokens.Colors.tertiary)
        .fontColor(AppTokens.Colors.onTertiary)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          this.setNodeColor(AppTokens.Colors.tertiary);
        })
    }
    .width('100%')
    .height(80)
    .padding(AppTokens.Spacing.md)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()

        Stack() {
          Canvas(this.context2d)
            .width('100%')
            .height('100%')
            .backgroundColor(AppTokens.Colors.background)
            .onReady(() => {
              this.renderMindMap();
            })
            .onAreaChange((oldArea: Area, newArea: Area) => {
              this.canvasWidth = Number(newArea.width);
              this.canvasHeight = Number(newArea.height);
              this.renderMindMapAsync();
            })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background)
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Move && event.touches.length > 0) {
            this.addNode(event.touches[0].x, event.touches[0].y);
          }
        })

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      Button('+', { type: ButtonType.Circle, stateEffect: true })
        .width(56)
        .height(56)
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .margin({ right: AppTokens.Spacing.xl, bottom: 104 })
        .onClick(() => {
          const x: number = Math.floor(Math.random() * 501) + 100;
          const y: number = Math.floor(Math.random() * 601) + 200;
          this.addNode(x, y);
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}