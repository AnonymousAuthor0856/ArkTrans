/**
 * ParcelTracker.ets
 * SwiftUI -> ArkTS (ArkUI 声明式) 转换
 */

class Point {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

/**
 * AppTokens：集中管理颜色、字号、圆角与间距
 * （0xFFRRGGBB -> '#RRGGBB'）
 */
class Tokens {
  static readonly primary: string = '#111827';
  static readonly secondary: string = '#374151';
  static readonly tertiary: string = '#6B7280';
  static readonly background: string = '#F9FAFB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';

  // Typography
  static readonly displaySize: number = 26;
  static readonly headlineSize: number = 18;
  static readonly titleSize: number = 14;
  static readonly bodySize: number = 12;

  // Shapes
  static readonly smallCornerRadius: number = 6;
  static readonly mediumCornerRadius: number = 10;
  static readonly largeCornerRadius: number = 16;

  // Spacing
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 22;

  // ParcelCanvas 常量
  static readonly dotRadius: number = 4;
  static readonly dotCount: number = 25;
  static readonly handleRadius: number = 20;
  static readonly handleStroke: number = 3;
  static readonly canvasHeight: number = 300;
}

@Entry
@Component
struct ParcelTracker {
  // 散布的包裹点
  private points: Point[] = [];
  // 可拖动圆圈的位置（Canvas 内部坐标系，已扣除 padding）
  private dragX: number = 0;
  private dragY: number = 0;
  // Canvas 组件测量尺寸（含 padding）
  private canvasWidth: number = 0;
  private canvasHeight: number = 0;
  // Canvas 是否已就绪
  private isReady: boolean = false;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  // ---------- 内部辅助 ----------

  private innerWidth(): number {
    return Math.max(0, this.canvasWidth - Tokens.md * 2);
  }

  private innerHeight(): number {
    return Math.max(0, this.canvasHeight - Tokens.md * 2);
  }

  // 生成随机包裹点，并给出拖动圆圈的初始位置
  private initCanvasState(): void {
    const w: number = this.innerWidth();
    const h: number = this.innerHeight();
    if (w <= 0 || h <= 0) {
      return;
    }
    const list: Point[] = [];
    for (let i = 0; i < Tokens.dotCount; i++) {
      list.push(new Point(Math.random() * w, Math.random() * h));
    }
    this.points = list;
    this.dragX = Tokens.handleRadius + Math.random() * Math.max(0, w - Tokens.handleRadius * 2);
    this.dragY = Tokens.handleRadius + Math.random() * Math.max(0, h - Tokens.handleRadius * 2);
  }

  // 拖动：坐标限制在有效绘制区域内（半径 20 保证圆圈完整可见）
  private applyDrag(x: number, y: number): void {
    const r: number = Tokens.handleRadius;
    const maxX: number = Math.max(r, this.innerWidth() - r);
    const maxY: number = Math.max(r, this.innerHeight() - r);
    this.dragX = Math.min(Math.max(x, r), maxX);
    this.dragY = Math.min(Math.max(y, r), maxY);
    this.draw();
  }

  // 绘制：包裹点 + 中心圆圈
  private draw(): void {
    if (!this.isReady) {
      return;
    }
    const w: number = this.innerWidth();
    const h: number = this.innerHeight();
    if (w <= 0 || h <= 0) {
      return;
    }
    const ctx: CanvasRenderingContext2D = this.context;
    ctx.clearRect(0, 0, w, h);

    // 包裹点
    ctx.fillStyle = Tokens.secondary;
    for (let i = 0; i < this.points.length; i++) {
      const p: Point = this.points[i];
      ctx.beginPath();
      ctx.arc(p.x, p.y, Tokens.dotRadius, 0, Math.PI * 2);
      ctx.fill();
    }

    // 可拖动圆圈
    ctx.strokeStyle = Tokens.primary;
    ctx.lineWidth = Tokens.handleStroke;
    ctx.beginPath();
    ctx.arc(this.dragX, this.dragY, Tokens.handleRadius, 0, Math.PI * 2);
    ctx.stroke();
  }

  build() {
    Column() {
      // 标题
      Text('Parcel Tracker')
        .fontSize(Tokens.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(Tokens.onBackground)

      // ParcelCanvas：白色卡片 + 圆角 + 边框
      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.context)
          .width('100%')
          .height('100%')
          .padding(Tokens.md) // 对应 .padding(10.dp)
          .onReady(() => {
            this.isReady = true;
            if (this.points.length === 0) {
              this.initCanvasState();
            }
            this.draw();
          })
          .onAreaChange((oldValue: Area, newValue: Area) => {
            this.canvasWidth = newValue.width as number;
            this.canvasHeight = newValue.height as number;
            if (this.points.length === 0) {
              this.initCanvasState();
            } else {
              // 尺寸变化时重新约束圆圈位置
              this.applyDrag(this.dragX, this.dragY);
            }
            this.draw();
          })
          .onTouch((event: TouchEvent) => {
            if (event.type !== TouchType.Down && event.type !== TouchType.Move) {
              return;
            }
            const touch: TouchObject = event.touches[0];
            if (touch === undefined) {
              return;
            }
            // 触摸坐标相对于组件左上角，需扣除 padding 才是 Canvas 绘制坐标
            this.applyDrag(touch.x - Tokens.md, touch.y - Tokens.md);
          })

        // 提示文本（不拦截触摸，让 Canvas 收到手势）
        Text('Drag to locate parcel')
          .fontSize(Tokens.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(Tokens.onSurface)
          .hitTestBehavior(HitTestMode.None)
      }
      .width('100%')
      .height(Tokens.canvasHeight)
      .backgroundColor(Tokens.surface)
      .borderRadius(Tokens.largeCornerRadius)
      .border({ width: 1, color: Tokens.outline })

      // 底部说明
      Text('Visualize parcel movements and positions.')
        .fontSize(Tokens.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(Tokens.onSurface)
    }
    .width('100%')
    .height('100%')
    .padding(Tokens.lg) // 对应 .padding(AppTokens.Spacing.lg)
    .justifyContent(FlexAlign.SpaceBetween)
    .linearGradient({
      angle: 180, // 从上到下
      colors: [[Tokens.surfaceVariant, 0.0], [Tokens.background, 1.0]]
    })
    // 对应 .ignoresSafeArea / 隐藏状态栏：内容扩展到系统安全区
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}