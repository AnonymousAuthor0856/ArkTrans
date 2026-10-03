/**
 * Retro Whiteboard —— ArkTS / ArkUI 实现（SwiftUI 版等价迁移）
 * 入口页面：RootScreen
 */

import window from '@ohos.window';

// MARK: - 绘制点
class DrawPoint {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

// MARK: - AppTokens
class AppTokens {
  // --- Colors ---
  static readonly PRIMARY: string = '#EF476F';
  static readonly SECONDARY: string = '#FFD166';
  static readonly TERTIARY: string = '#06D6A0';
  static readonly BACKGROUND: string = '#FFFCF2';
  static readonly SURFACE: string = '#FFFFFF';
  static readonly SURFACE_VARIANT: string = '#F7EDE2';
  static readonly OUTLINE: string = '#E5D4B1';
  static readonly SUCCESS: string = '#06D6A0';
  static readonly WARNING: string = '#FFA600';
  static readonly ERROR: string = '#D62828';
  static readonly ON_PRIMARY: string = '#FFFFFF';
  static readonly ON_SECONDARY: string = '#1E1E1E';
  static readonly ON_TERTIARY: string = '#1E1E1E';
  static readonly ON_BACKGROUND: string = '#1E1E1E';
  static readonly ON_SURFACE: string = '#1E1E1E';

  // --- Typography (fp) ---
  static readonly FONT_DISPLAY: number = 26; // bold
  static readonly FONT_TITLE: number = 18;   // medium
  static readonly FONT_BODY: number = 14;    // regular
  static readonly FONT_LABEL: number = 12;   // medium

  // --- Shapes (vp) ---
  static readonly RADIUS_SMALL: number = 6;
  static readonly RADIUS_MEDIUM: number = 10;
  static readonly RADIUS_LARGE: number = 16;

  // --- Spacing (vp) ---
  static readonly SPACE_XS: number = 4;
  static readonly SPACE_SM: number = 8;
  static readonly SPACE_MD: number = 12;
  static readonly SPACE_LG: number = 16;
  static readonly SPACE_XL: number = 24;
}

// MARK: - ElevationMapping.level1 -> ShadowOptions（blur 4 / dy 2 / opacity 0.12）
const SHADOW_LEVEL1: ShadowOptions = {
  radius: 4,
  color: '#1F000000',
  offsetX: 0,
  offsetY: 2
};

@Entry
@Component
struct RootScreen {
  // 存储绘制点 / 当前绘制颜色
  @State points: DrawPoint[] = [];
  @State currentColor: string = AppTokens.PRIMARY;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  // 尺寸常量：与 SwiftUI 版逐一对应
  private buttonHeight: number = 44;          // 底部颜色按钮高度
  private fabSize: number = 56;               // FAB 尺寸
  private circleRadius: number = 10;          // 绘制圆点半径
  private fabBottomMargin: number = AppTokens.SPACE_XL; // 24
  private topBarHeight: number = 54;          // 30(行高) + 2 * 12
  private bottomBarHeight: number = 68;       // 44 + 2 * 12
  private canvasBottomPadding: number = 80;   // max(68, 56 + 24)

  aboutToAppear(): void {
    // 对应 SwiftUI 的 .statusBarHidden(true)
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowSystemBarEnable([]);
    });
  }

  // 重绘画布：所有点统一使用当前颜色（与 SwiftUI Canvas 的行为一致）
  private redraw(): void {
    const w: number = this.ctx.width;
    const h: number = this.ctx.height;
    if (w <= 0 || h <= 0) {
      return;
    }
    this.ctx.clearRect(0, 0, w, h);
    this.ctx.fillStyle = this.currentColor;
    for (let i = 0; i < this.points.length; i++) {
      const p: DrawPoint = this.points[i];
      this.ctx.beginPath();
      this.ctx.arc(p.x, p.y, this.circleRadius, 0, Math.PI * 2);
      this.ctx.fill();
    }
  }

  private addPoint(x: number, y: number): void {
    this.points.push(new DrawPoint(x, y));
    this.redraw();
  }

  private clearBoard(): void {
    this.points = [];
    this.redraw();
  }

  @Builder
  colorButton(label: string, bgColor: string, fgColor: string) {
    Button(label, { type: ButtonType.Normal, stateEffect: true })
      .fontSize(AppTokens.FONT_BODY)
      .fontWeight(FontWeight.Normal)
      .fontColor(fgColor)
      .backgroundColor(bgColor)
      .borderRadius(AppTokens.RADIUS_SMALL)
      .height(this.buttonHeight)
      .layoutWeight(1)
      .onClick(() => {
        this.currentColor = bgColor;
        this.redraw();
      })
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {

      // 1. 内容层：顶部栏占位 + 绘图画布 + 底部留白
      Column() {
        Row()
          .width('100%')
          .height(this.topBarHeight)

        // 绘图画布（坐标原点即画布左上角，等价于 SwiftUI 中 padding 后的 Canvas）
        Canvas(this.ctx)
          .width('100%')
          .layoutWeight(1)
          .onReady(() => {
            this.redraw();
          })
          .onAreaChange((oldValue: Area, newValue: Area) => {
            this.redraw();
          })
          .onTouch((event: TouchEvent) => {
            if ((event.type === TouchType.Down || event.type === TouchType.Move) && event.touches.length > 0) {
              const t: TouchObject = event.touches[0];
              this.addPoint(t.x, t.y);
            }
          })

        Row()
          .width('100%')
          .height(this.canvasBottomPadding)
      }
      .width('100%')
      .height('100%')

      // 2. 顶部栏
      Row() {
        Text('Retro Whiteboard')
          .fontSize(AppTokens.FONT_DISPLAY)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.ON_SURFACE)
      }
      .width('100%')
      .height(this.topBarHeight)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.BACKGROUND)

      // 3. 底部颜色选择栏
      Column() {
        Row({ space: AppTokens.SPACE_MD }) {
          this.colorButton('Red', AppTokens.PRIMARY, AppTokens.ON_PRIMARY)
          this.colorButton('Yellow', AppTokens.SECONDARY, AppTokens.ON_SECONDARY)
          this.colorButton('Green', AppTokens.TERTIARY, AppTokens.ON_TERTIARY)
        }
        .width('100%')
        .padding(AppTokens.SPACE_MD)
        .backgroundColor(AppTokens.SURFACE)
        .shadow(SHADOW_LEVEL1)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)

      // 4. 悬浮按钮：清除画布
      Column() {
        Button('Clear', { type: ButtonType.Circle, stateEffect: true })
          .width(this.fabSize)
          .height(this.fabSize)
          .fontSize(AppTokens.FONT_LABEL)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.ON_SECONDARY)
          .backgroundColor(AppTokens.SECONDARY)
          .shadow(SHADOW_LEVEL1)
          .onClick(() => {
            this.clearBoard();
          })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
      .alignItems(HorizontalAlign.End)
      .padding({
        right: AppTokens.SPACE_XL,
        bottom: this.fabBottomMargin
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.BACKGROUND)
  }
}