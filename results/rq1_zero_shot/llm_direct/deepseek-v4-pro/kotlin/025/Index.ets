// MindMapApp.ets
import { window } from '@kit.ArkUI';

// AppTokens
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

interface NodePoint {
  x: number;
  y: number;
}

@Entry
@Component
struct MindMapScreen {
  @State private nodes: NodePoint[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ];
  @State private currentColor: string = AppColors.primary;
  @State private canvasWidth: number = 0;
  @State private canvasHeight: number = 0;

  private addRandomNode(): void {
    const randomX = Math.floor(Math.random() * 500) + 100;
    const randomY = Math.floor(Math.random() * 600) + 200;
    this.nodes = [...this.nodes, { x: randomX, y: randomY }];
  }

  private handleDrag(event: TouchEvent): void {
    if (event.touches.length > 0) {
      const touch = event.touches[0];
      const newPoint: NodePoint = {
        x: touch.x,
        y: touch.y
      };
      this.nodes = [...this.nodes, newPoint];
    }
  }

  @Builder
  TopBar() {
    Row() {
      Text('Neon Mind Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .height(64)
    .backgroundColor(AppColors.background)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      Button('Cyan')
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .height(40)
        .layoutWeight(1)
        .margin({ left: 8, right: 8 })
        .onClick(() => {
          this.currentColor = AppColors.primary;
        })

      Button('Green')
        .backgroundColor(AppColors.secondary)
        .fontColor(AppColors.onSecondary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .height(40)
        .layoutWeight(1)
        .margin({ left: 8, right: 8 })
        .onClick(() => {
          this.currentColor = AppColors.secondary;
        })

      Button('Purple')
        .backgroundColor(AppColors.tertiary)
        .fontColor(AppColors.onTertiary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .height(40)
        .layoutWeight(1)
        .margin({ left: 8, right: 8 })
        .onClick(() => {
          this.currentColor = AppColors.tertiary;
        })
    }
    .width('100%')
    .height(64)
    .backgroundColor(AppColors.surfaceVariant)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .padding({ left: AppSpacing.md, right: AppSpacing.md })
  }

  @Builder
  FloatingAddButton() {
    Button('+')
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(AppColors.secondary)
      .fontColor(AppColors.onSecondary)
      .fontSize(24)
      .fontWeight(FontWeight.Bold)
      .shadow({ radius: 8, color: '#3300FF88', offsetY: 4 })
      .onClick(() => {
        this.addRandomNode();
      })
  }

  @Builder
  MindMapCanvas() {
    Canvas(this.canvasWidth, this.canvasHeight)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawMindMap();
      })
      .onTouch((event: TouchEvent) => {
        if (event.type === TouchType.Down || event.type === TouchType.Move) {
          this.handleDrag(event);
          this.drawMindMap();
        }
      })
  }

  private drawMindMap(): void {
    // Canvas drawing is handled through the Canvas component's rendering context
    // The actual drawing will be done in the Canvas onReady callback
  }

  build() {
    Column() {
      // Top Bar
      this.TopBar()

      // Main Canvas Area
      Stack() {
        Canvas(this.canvasWidth, this.canvasHeight)
          .width('100%')
          .height('100%')
          .backgroundColor(AppColors.background)
          .onReady(() => {
            // Draw lines between nodes
            for (let i = 1; i < this.nodes.length; i++) {
              const startNode = this.nodes[i - 1];
              const endNode = this.nodes[i];
              // Draw line
              this.drawLine(startNode.x, startNode.y, endNode.x, endNode.y, this.currentColor, 6);
            }
            // Draw circles for each node
            for (const node of this.nodes) {
              this.drawCircle(node.x, node.y, 20, this.currentColor);
            }
          })
          .onTouch((event: TouchEvent) => {
            if (event.touches.length > 0) {
              const touch = event.touches[0];
              const newPoint: NodePoint = {
                x: touch.x,
                y: touch.y
              };
              this.nodes = [...this.nodes, newPoint];
            }
          })

        // Floating Action Button
        Button('+')
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(AppColors.secondary)
          .fontColor(AppColors.onSecondary)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .shadow({ radius: 8, color: '#3300FF88', offsetY: 4 })
          .position({ x: '85%', y: '85%' })
          .onClick(() => {
            this.addRandomNode();
          })
      }
      .layoutWeight(1)
      .width('100%')

      // Bottom Bar
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  private drawLine(x1: number, y1: number, x2: number, y2: number, color: string, strokeWidth: number): void {
    // This is a placeholder - actual drawing is handled by Canvas component
  }

  private drawCircle(x: number, y: number, radius: number, color: string): void {
    // This is a placeholder - actual drawing is handled by Canvas component
  }
}

@Entry
@Component
struct MindMapApp {
  build() {
    MindMapScreen()
  }
}