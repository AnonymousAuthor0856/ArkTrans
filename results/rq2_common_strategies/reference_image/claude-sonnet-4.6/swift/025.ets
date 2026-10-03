// entry/src/main/ets/pages/Index.ets
import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

// MARK: - 节点模型（对应 SwiftUI 的 CGPoint）
class MapNode {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

// MARK: - 设计令牌类型
interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyTokens {
  display: number;
  title: number;
  body: number;
  label: number;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationTokens {
  level1: ShadowSpec;
  level2: ShadowSpec;
}

// MARK: - AppTokens
class AppTokens {
  static readonly colors: ColorTokens = {
    primary: '#00FFFF',
    secondary: '#00FF88',
    tertiary: '#BB86FC',
    background: '#0D0D0D',
    surface: '#1C1C1C',
    surfaceVariant: '#2E2E2E',
    outline: '#3F3F3F',
    success: '#00FFAA',
    warning: '#FFC107',
    error: '#FF1744',
    onPrimary: '#000000',
    onSecondary: '#000000',
    onTertiary: '#000000',
    onBackground: '#FFFFFF',
    onSurface: '#FFFFFF'
  };

  static readonly typography: TypographyTokens = {
    display: 28,
    title: 18,
    body: 14,
    label: 12
  };

  static readonly spacing: SpacingTokens = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static readonly elevation: ElevationTokens = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  };

  // 把不透明度折算成 ARGB 阴影颜色
  static shadowColor(opacity: number): string {
    const alpha: number = Math.round(opacity * 255);
    const hex: string = alpha.toString(16).padStart(2, '0');
    return '#' + hex + '000000';
  }
}

// MARK: - 画布常量
const NODE_RADIUS: number = 20;
const LINK_WIDTH: number = 6;

@Entry
@Component
struct RootScreen {
  // 对应 mutableStateListOf<Offset> 与 mutableStateOf(Color)
  @State nodes: MapNode[] = [
    new MapNode(200, 400),
    new MapNode(500, 700),
    new MapNode(350, 250)
  ];
  @State currentColor: string = AppTokens.colors.primary;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private canvasW: number = 0;
  private canvasH: number = 0;
  private dragStartX: number = 0;
  private dragStartY: number = 0;

  // 对应 WindowInsetsControllerCompat.hide(systemBars())
  aboutToAppear(): void {
    window.getLastWindow(getContext(this) as common.UIAbilityContext)
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      });
  }

  // 对应 Canvas 的 draw 闭包：先连线，再画节点
  private draw(): void {
    const w: number = this.canvasW > 0 ? this.canvasW : this.ctx.width;
    const h: number = this.canvasH > 0 ? this.canvasH : this.ctx.height;
    if (w <= 0 || h <= 0) {
      return;
    }

    this.ctx.clearRect(0, 0, w, h);

    // 连线
    this.ctx.lineWidth = LINK_WIDTH;
    this.ctx.lineCap = 'round';
    this.ctx.strokeStyle = this.currentColor;
    for (let i = 1; i < this.nodes.length; i++) {
      this.ctx.beginPath();
      this.ctx.moveTo(this.nodes[i - 1].x, this.nodes[i - 1].y);
      this.ctx.lineTo(this.nodes[i].x, this.nodes[i].y);
      this.ctx.stroke();
    }

    // 节点（radius = 20f）
    this.ctx.fillStyle = this.currentColor;
    for (let i = 0; i < this.nodes.length; i++) {
      this.ctx.beginPath();
      this.ctx.arc(this.nodes[i].x, this.nodes[i].y, NODE_RADIUS, 0, Math.PI * 2);
      this.ctx.fill();
    }
  }

  @Builder
  colorPill(label: string, background: string, foreground: string, target: string) {
    Button(label, { type: ButtonType.Normal, stateEffect: true })
      .fontSize(AppTokens.typography.body)
      .fontWeight(FontWeight.Normal)
      .fontColor(foreground)
      .backgroundColor(background)
      .borderRadius(16)
      .height(32)
      .padding({ left: AppTokens.spacing.lg, right: AppTokens.spacing.lg })
      .onClick(() => {
        this.currentColor = target;
        this.draw();
      })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // 画布层：绘制所有连线与节点
      Canvas(this.ctx)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.canvasW = this.ctx.width;
          this.canvasH = this.ctx.height;
          this.draw();
        })
        .onAreaChange((oldValue: Area, newValue: Area) => {
          this.canvasW = newValue.width as number;
          this.canvasH = newValue.height as number;
          this.draw();
        })

      // 顶栏 + 底栏
      Column() {
        Text('Neon Mind Map')
          .fontSize(AppTokens.typography.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.colors.primary)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: AppTokens.spacing.lg, bottom: AppTokens.spacing.lg })
          .backgroundColor(AppTokens.colors.background)

        Blank()

        Row({ space: AppTokens.spacing.md }) {
          this.colorPill('Cyan', AppTokens.colors.primary, AppTokens.colors.onPrimary, AppTokens.colors.primary)
          this.colorPill('Green', AppTokens.colors.secondary, AppTokens.colors.onSecondary, AppTokens.colors.secondary)
          this.colorPill('Purple', AppTokens.colors.tertiary, AppTokens.colors.onTertiary, AppTokens.colors.tertiary)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding(AppTokens.spacing.md)
        .backgroundColor(AppTokens.colors.surfaceVariant)
        .shadow({
          radius: AppTokens.elevation.level1.radius,
          color: AppTokens.shadowColor(AppTokens.elevation.level1.opacity),
          offsetX: 0,
          offsetY: AppTokens.elevation.level1.dy
        })
      }
      .width('100%')
      .height('100%')

      // 浮动操作按钮
      Button('+', { type: ButtonType.Circle, stateEffect: true })
        .width(56)
        .height(56)
        .fontSize(AppTokens.typography.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.colors.onSecondary)
        .backgroundColor(AppTokens.colors.secondary)
        .shadow({
          radius: AppTokens.elevation.level2.radius,
          color: AppTokens.shadowColor(AppTokens.elevation.level2.opacity),
          offsetX: 0,
          offsetY: AppTokens.elevation.level2.dy
        })
        .margin({ right: AppTokens.spacing.lg, bottom: AppTokens.spacing.lg })
        .onClick(() => {
          const randomX: number = 100 + Math.random() * 500;
          const randomY: number = 200 + Math.random() * 600;
          const safeX: number = Math.max(NODE_RADIUS, Math.min(randomX, this.canvasW - NODE_RADIUS));
          const safeY: number = Math.max(NODE_RADIUS, Math.min(randomY, this.canvasH - NODE_RADIUS));
          this.nodes.push(new MapNode(safeX, safeY));
          this.draw();
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    // 对应 pointerInput + detectDragGestures，挂在根容器上保证整屏可拖拽
    .gesture(
      PanGesture({ fingers: 1, direction: PanDirection.All, distance: 1 })
        .onActionStart((event: GestureEvent) => {
          if (event.fingerList.length > 0) {
            this.dragStartX = event.fingerList[0].localX;
            this.dragStartY = event.fingerList[0].localY;
            this.nodes.push(new MapNode(this.dragStartX, this.dragStartY));
            this.draw();
          }
        })
        .onActionUpdate((event: GestureEvent) => {
          if (event.fingerList.length > 0) {
            this.nodes.push(new MapNode(event.fingerList[0].localX, event.fingerList[0].localY));
            this.draw();
          }
        })
    )
  }
}