// MARK: - Color Extension for Hex Initialization
// 允许使用十六进制值初始化颜色，与 Kotlin 的 Color(0xFF...) 对应

// 将 0xRRGGBB 形式的整数转换为 ArkUI 可用的 "#RRGGBB" 颜色字符串
function toHexComponent(value: number): string {
  const hex: string = value.toString(16).toUpperCase();
  return hex.length < 2 ? '0' + hex : hex;
}

function hexColor(hex: number): string {
  const r: number = (hex >>> 16) & 0xFF;
  const g: number = (hex >>> 8) & 0xFF;
  const b: number = hex & 0xFF;
  return '#' + toHexComponent(r) + toHexComponent(g) + toHexComponent(b);
}

// 根据透明度生成带透明度的黑色，用于阴影颜色
function blackWithOpacity(opacity: number): string {
  return 'rgba(0, 0, 0, ' + opacity.toString() + ')';
}

// MARK: - AppTokens
// 对应 Kotlin 中的 AppTokens 对象，定义了颜色、字体、间距、形状和阴影

interface ColorTokenSet {
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

// 文本样式：字号与字重，直接映射 Compose 的 TextStyle
interface FontToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokenSet {
  display: FontToken;
  title: FontToken;
  body: FontToken;
  label: FontToken;
}

interface ShapeTokenSet {
  smallCornerRadius: number;
  mediumCornerRadius: number;
  largeCornerRadius: number;
}

interface SpacingTokenSet {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

// 对应 SwiftUI 的 ShadowSpec
interface ShadowSpec {
  elevation: number; // 对应 SwiftUI shadow 的 blur radius
  radius: number; // 在 SwiftUI shadow 中不直接使用，elevation 承担主要作用
  dy: number; // 对应 SwiftUI shadow 的 y 偏移
  opacity: number;
}

interface ElevationMappingSet {
  level1: ShadowSpec;
  level2: ShadowSpec;
}

class AppTokens {
  static readonly Colors: ColorTokenSet = {
    primary: hexColor(0xFFEF476F),
    secondary: hexColor(0xFFFFD166),
    tertiary: hexColor(0xFF06D6A0),
    background: hexColor(0xFFFFFCF2),
    surface: hexColor(0xFFFFFFFF),
    surfaceVariant: hexColor(0xFFF7EDE2),
    outline: hexColor(0xFFE5D4B1),
    success: hexColor(0xFF06D6A0),
    warning: hexColor(0xFFFFA600),
    error: hexColor(0xFFD62828),
    onPrimary: hexColor(0xFFFFFFFF),
    onSecondary: hexColor(0xFF1E1E1E),
    onTertiary: hexColor(0xFF1E1E1E),
    onBackground: hexColor(0xFF1E1E1E),
    onSurface: hexColor(0xFF1E1E1E)
  };

  // 使用系统字体，直接映射 Compose 的 TextStyle
  static readonly TypographyTokens: TypographyTokenSet = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static readonly Shapes: ShapeTokenSet = {
    smallCornerRadius: 6.0,
    mediumCornerRadius: 10.0,
    largeCornerRadius: 16.0
  };

  static readonly Spacing: SpacingTokenSet = {
    xs: 4.0,
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
    xl: 24.0
  };

  // Compose 的 elevation 映射到 SwiftUI shadow 的 radius (模糊半径) 和 y 偏移
  static readonly ElevationMapping: ElevationMappingSet = {
    level1: { elevation: 2.0, radius: 4.0, dy: 2.0, opacity: 0.12 },
    level2: { elevation: 4.0, radius: 8.0, dy: 4.0, opacity: 0.16 }
  };
}

// 用于存储绘制点的坐标
class Point {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

// MARK: - RootScreen 对应的 ArkUI 视图
@Component
struct RootScreen {
  @State points: Point[] = []; // 存储绘制点的数组
  @State currentColor: string = AppTokens.Colors.primary; // 当前绘制颜色

  // 定义控件尺寸，以实现原子级对应
  private buttonHeight: number = 44.0; // 底部颜色按钮的高度，根据 Android Material3 默认按钮文本大小和垂直内边距估算
  private fabSize: number = 56.0; // 标准 Material Design Floating Action Button 尺寸
  private circleRadius: number = 10.0; // 绘制圆点的半径

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  // 计算顶部栏的实际高度，用于内容区域的内边距
  private get topBarActualHeight(): number {
    // 字体大小 26pt，近似行高 30pt。加上 2 倍垂直内边距 (AppTokens.Spacing.md = 12pt)
    return 30.0 + (2 * AppTokens.Spacing.md); // 30 + 2*12 = 54
  }

  // 计算底部栏的实际高度，用于内容区域的内边距
  private get bottomBarActualHeight(): number {
    // 按钮高度 (44pt) 加上 2 倍垂直内边距 (AppTokens.Spacing.md = 12pt)
    return this.buttonHeight + (2 * AppTokens.Spacing.md); // 44 + 2*12 = 68
  }

  // FAB 距离屏幕底部的内边距
  private get fabBottomMargin(): number {
    return AppTokens.Spacing.xl; // 24pt
  }

  // 绘制画布的底部内边距，需考虑底部栏和 FAB 中占据空间较大的一个
  private get canvasBottomPadding(): number {
    // Compose Scaffold 的内容区域内边距会取底部栏高度和 FAB 底部边缘位置的最大值
    // FAB 底部边缘位置 = FAB 尺寸 + FAB 距离屏幕底部边距 = 56 + 24 = 80
    // 所以取 max(底部栏实际高度, FAB 底部边缘位置) = max(68, 80) = 80
    return Math.max(this.bottomBarActualHeight, this.fabSize + this.fabBottomMargin);
  }

  // 在画布上重绘所有点
  private redraw(): void {
    this.context.clearRect(0, 0, this.context.width, this.context.height);
    this.context.fillStyle = this.currentColor;
    for (let i = 0; i < this.points.length; i++) {
      const p: Point = this.points[i];
      this.context.beginPath();
      this.context.arc(p.x, p.y, this.circleRadius, 0, Math.PI * 2);
      this.context.fill();
    }
  }

  build() {
    Stack() {
      // 1. 背景色：填充整个屏幕，包括状态栏区域
      // (背景色直接设置在 Stack 上，等价于 ignoresSafeArea)

      // 2. 绘制画布区域：用户在此区域进行绘制
      Canvas(this.context)
        .onReady(() => {
          this.redraw();
        })
        .onTouch((event: TouchEvent) => {
          // minimumDistance: 0 意味着即使是点击也会触发 onChanged
          if (event.touches.length > 0 && (event.type === TouchType.Down || event.type === TouchType.Move)) {
            const touch: TouchObject = event.touches[0];
            // touch 坐标相对于 Canvas 视图左上角，与 Compose padding 后的 pointerInput 行为一致
            this.points.push(new Point(touch.x, touch.y));
            this.redraw();
          }
        })
        .width('100%')
        .height('100%')
        .padding({ top: this.topBarActualHeight, bottom: this.canvasBottomPadding })

      // 3. 顶部栏
      Column() {
        Text('Retro Whiteboard')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md }) // 标题的垂直内边距
          .width('100%') // 使文本水平居中
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.background) // 顶部栏背景色
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Start) // 将内容对齐到 Stack 的顶部

      // 4. 底部颜色选择栏
      Column() {
        Blank() // 将 Row 推到 Stack 的底部
        Row({ space: AppTokens.Spacing.md }) { // 按钮之间的间距
          Button('Red')
            .layoutWeight(1) // 允许按钮水平填充可用空间
            .height(this.buttonHeight) // 固定按钮高度
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.primary;
            })

          Button('Yellow')
            .layoutWeight(1)
            .height(this.buttonHeight)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.secondary;
            })

          Button('Green')
            .layoutWeight(1)
            .height(this.buttonHeight)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onTertiary)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.smallCornerRadius)
            .onClick(() => {
              this.currentColor = AppTokens.Colors.tertiary;
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.md) // 底部栏内部，按钮 Row 的内边距
        .backgroundColor(AppTokens.Colors.surface) // 底部栏背景色
        .shadow({
          radius: AppTokens.ElevationMapping.level1.elevation, // 模糊半径
          color: blackWithOpacity(AppTokens.ElevationMapping.level1.opacity),
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy // Y 轴偏移
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End) // 将内容对齐到 Stack 的底部

      // 5. 浮动操作按钮 (Floating Action Button) - 清除画布
      Column() {
        Blank() // 将 Row 推到 Stack 的底部
        Row() {
          Blank() // 将 Button 推到 Row 的右侧 (trailing)
          Button('Clear')
            .width(this.fabSize)
            .height(this.fabSize) // 固定 FAB 尺寸
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(this.fabSize / 2) // 圆形剪裁
            .shadow({
              radius: AppTokens.ElevationMapping.level1.elevation,
              color: blackWithOpacity(AppTokens.ElevationMapping.level1.opacity),
              offsetX: 0,
              offsetY: AppTokens.ElevationMapping.level1.dy
            })
            .onClick(() => {
              this.points = []; // 清除所有绘制点
              this.redraw();
            })
        }
        .width('100%')
        .padding({ right: AppTokens.Spacing.xl, bottom: this.fabBottomMargin }) // FAB 右侧/底部内边距
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End) // 将内容对齐到 Stack 的底部
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    // 隐藏整个视图的状态栏 (iOS 16.0 兼容)：由页面全屏配置负责
  }
}

// MARK: - 主应用结构
// @Entry 入口点，使应用可直接运行
@Entry
@Component
struct RetroWhiteboardApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}
