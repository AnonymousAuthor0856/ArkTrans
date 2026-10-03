// MARK: - AppTokens (Equivalent to Kotlin's AppTokens object)
// 集中管理应用的设计系统代币，方便统一修改和维护。

// 将十六进制值转换为 ArkUI 使用的 '#AARRGGBB' 颜色字符串。
// 对应 Swift 的 Color(hex:) 扩展初始化器，保持与 Kotlin 代码的颜色值一致。
function hex2(value: number): string {
  const digits: string = '0123456789ABCDEF';
  return digits.charAt((value >> 4) & 0xF) + digits.charAt(value & 0xF);
}

function colorFromHex(value: number): string {
  return '#' + hex2((value >> 24) & 0xFF) + hex2((value >> 16) & 0xFF) + hex2((value >> 8) & 0xFF) + hex2(value & 0xFF);
}

// 计算黑色阴影带透明度的颜色字符串，对应 Swift 的 Color.black.opacity(...)。
function blackWithOpacity(opacity: number): string {
  return colorFromHex(Math.round(opacity * 255) << 24);
}

class AppTokensColors {
  // 使用十六进制初始化器创建颜色，保持与 Kotlin 代码的颜色值一致。
  static readonly primary: string = colorFromHex(0xFF111111);
  static readonly secondary: string = colorFromHex(0xFF333333);
  static readonly tertiary: string = colorFromHex(0xFF777777);
  static readonly background: string = colorFromHex(0xFFFFFFFF);
  static readonly surface: string = colorFromHex(0xFFF9F9F9);
  static readonly surfaceVariant: string = colorFromHex(0xFFE5E5E5);
  static readonly outline: string = colorFromHex(0xFFCCCCCC);
  static readonly success: string = colorFromHex(0xFF16A34A);
  static readonly warning: string = colorFromHex(0xFFF59E0B);
  static readonly error: string = colorFromHex(0xFFDC2626);
  static readonly onPrimary: string = colorFromHex(0xFFFFFFFF);
  static readonly onSecondary: string = colorFromHex(0xFFFFFFFF);
  static readonly onTertiary: string = colorFromHex(0xFF111111);
  static readonly onBackground: string = colorFromHex(0xFF111111);
  static readonly onSurface: string = colorFromHex(0xFF111111);
}

class AppTokensTypography {
  // 定义字体样式，直接映射 Kotlin 的 fontSize 和 fontWeight。
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular; // FontWeight.Normal 对应 ArkUI 的 FontWeight.Regular
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppTokensShapes {
  // 定义圆角半径，直接映射 Kotlin 的 Dp 值。
  static readonly smallCornerRadius: number = 6;
  static readonly mediumCornerRadius: number = 10;
  static readonly largeCornerRadius: number = 14;
}

class AppTokensSpacing {
  // 定义间距值，直接映射 Kotlin 的 Dp 值。
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

// 阴影规范，用于将 Compose 的阴影参数映射到 ArkUI。
// ArkUI 的 shadow 接受 radius (模糊半径)、offsetX/offsetY (偏移) 和 color (颜色)。
class ShadowSpec {
  readonly elevation: number; // Compose 中的 elevation，在 ArkUI 中主要影响阴影强度或模糊，这里作为参考值。
  readonly radius: number; // 阴影的模糊半径，直接对应 ArkUI 的 radius。
  readonly dy: number; // 阴影的 Y 轴偏移，直接对应 ArkUI 的 offsetY。
  readonly opacity: number; // 阴影的透明度。
  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppTokensElevation {
  // 将 Compose 的阴影级别映射到 ArkUI 的 shadow 属性。
  // level2 = ShadowSpec(4.dp, 8.dp, 4.dp, 0.12f)
  // 对应 ArkUI: .shadow({ color: '#1F000000', radius: 8, offsetX: 0, offsetY: 4 })
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.12);
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.15);
}

// MARK: - Marker Data Model
// 对应 Kotlin 的 Marker 数据类，在 ArkUI 中为其提供唯一标识符。
class Marker {
  readonly id: string; // 唯一标识符，对应 SwiftUI 的 UUID()。
  x: number;
  y: number;
  readonly label: string;
  constructor(x: number, y: number, label: string) {
    this.id = Date.now().toString() + '_' + Math.random().toString();
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

// MARK: - RootScreen View (Equivalent to Kotlin's RootScreen Composable)
// 主 UI 视图，将 Kotlin 的 Composable 结构翻译为 ArkUI 的 @Component 结构。
// SwiftUI 的 @main App 入口点映射为 ArkUI 的 @Entry 装饰器。
@Entry
@Component
struct RootScreen {
  // 使用 @State 包装器管理可变状态，对应 Kotlin 的 remember { mutableStateListOf(...) }。
  @State markers: Marker[] = [
    new Marker(120, 200, 'Store A'),
    new Marker(360, 400, 'Store B')
  ];

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  // 自定义绘制地图区域：先绘制背景矩形，再绘制标记点，对应 Kotlin Canvas 的 drawRect 与 drawCircle。
  private drawMap(): void {
    const ctx: CanvasRenderingContext2D = this.context;
    ctx.clearRect(0, 0, ctx.width, ctx.height);
    // 绘制背景矩形，对应 Kotlin Canvas 内部的 drawRect。
    ctx.fillStyle = AppTokensColors.surfaceVariant;
    ctx.fillRect(0, 0, ctx.width, ctx.height);
    // 绘制标记点，对应 Kotlin Canvas 内部的 markers.forEach { drawCircle(...) }。
    ctx.fillStyle = AppTokensColors.primary;
    for (let i = 0; i < this.markers.length; i++) {
      const marker: Marker = this.markers[i];
      ctx.beginPath();
      ctx.arc(marker.x, marker.y, 14, 0, 2 * Math.PI);
      ctx.fill();
    }
  }

  build() {
    // 对应 Kotlin 的 Scaffold，使用 Stack 作为根容器。
    Stack() {
      // 主内容区域，使用 Column 垂直排列，并设置间距和外边距。
      Column({ space: AppTokensSpacing.lg }) {
        Text('Product Detail')
          .fontSize(AppTokensTypography.displaySize)
          .fontWeight(AppTokensTypography.displayWeight)
          .fontColor(AppTokensColors.primary)

        // 产品信息卡片，对应 Kotlin 的 Card。
        // 在 ArkUI 中，通过背景色、圆角和阴影属性来模拟 Card 的效果。
        Column({ space: AppTokensSpacing.md }) {
          // 图片占位符，对应 Kotlin 的 Box with background。
          Rect()
            .fill(AppTokensColors.surfaceVariant)
            .width('100%') // 对应 fillMaxWidth()
            .height(160) // 对应 height(160.dp)

          Text('Monochrome Bag')
            .fontSize(AppTokensTypography.titleSize)
            .fontWeight(AppTokensTypography.titleWeight)
            .fontColor(AppTokensColors.onSurface)

          Text('A minimalist and timeless design piece.')
            .fontSize(AppTokensTypography.bodySize)
            .fontWeight(AppTokensTypography.bodyWeight)
            .fontColor(AppTokensColors.tertiary)

          Text('$79.00')
            .fontSize(AppTokensTypography.titleSize)
            .fontWeight(AppTokensTypography.titleWeight)
            .fontColor(AppTokensColors.primary)

          // "Add to Cart" 按钮
          Button('Add to Cart', { type: ButtonType.Normal })
            .fontSize(AppTokensTypography.titleSize)
            .fontWeight(AppTokensTypography.titleWeight)
            .width('100%') // 对应 fillMaxWidth()
            .height(48) // 对应 height(48.dp)
            .backgroundColor(AppTokensColors.primary)
            .fontColor(AppTokensColors.onPrimary)
            .borderRadius(AppTokensShapes.mediumCornerRadius) // 对应 shape = AppTokens.Shapes.medium
            .onClick(() => {
              // 处理添加到购物车操作
              console.info('Add to Cart tapped!');
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(AppTokensSpacing.lg) // 对应 Card 内部的 padding
        .backgroundColor(AppTokensColors.surface) // 对应 Card 的 containerColor
        .borderRadius(AppTokensShapes.largeCornerRadius) // 对应 Card 的 shape
        // 阴影效果，根据 AppTokens.ElevationMapping.level2 进行映射。
        .shadow({
          radius: AppTokensElevation.level2.radius,
          color: blackWithOpacity(AppTokensElevation.level2.opacity),
          offsetX: 0, // Compose 默认 x 偏移为 0
          offsetY: AppTokensElevation.level2.dy
        })

        // 地图区域，包含 Canvas 绘制，对应 Kotlin 的 Box with Canvas。
        Stack() {
          // SwiftUI 的 Canvas，用于自定义绘制，对应 Kotlin 的 Canvas。
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .padding(AppTokensSpacing.lg) // 对应 Kotlin Canvas 修饰符上的 padding。
            .onReady(() => {
              this.drawMap();
            })
        }
        .width('100%') // 对应 fillMaxWidth()
        .height(240) // 对应 height(240.dp)
        .backgroundColor(AppTokensColors.surface) // 对应 Box 的 background(AppTokens.Colors.surface, AppTokens.Shapes.large)
        .borderRadius(AppTokensShapes.largeCornerRadius)

        // 底部操作按钮行，对应 Kotlin 的 Row。
        Row({ space: AppTokensSpacing.md }) { // 对应 Arrangement.spacedBy(AppTokens.Spacing.md)
          // "Add Marker" 按钮
          Button('Add Marker', { type: ButtonType.Normal })
            .fontSize(AppTokensTypography.labelSize)
            .fontWeight(AppTokensTypography.labelWeight)
            .layoutWeight(1) // 对应 Modifier.weight(1f)，使其占据可用宽度。
            .height(44) // 对应 height(44.dp)
            .backgroundColor(AppTokensColors.secondary) // 对应 containerColor
            .fontColor(AppTokensColors.onSecondary) // 对应 contentColor
            .borderRadius(AppTokensShapes.mediumCornerRadius) // 对应 shape
            .onClick(() => {
              // 随机生成新的标记点位置，对应 Kotlin 的 Random.nextInt。
              this.markers.push(new Marker(
                Math.round(100 + Math.random() * 400),
                Math.round(150 + Math.random() * 300),
                'New'
              ));
              this.drawMap();
            })

          // "Clear" 按钮
          Button('Clear', { type: ButtonType.Normal })
            .fontSize(AppTokensTypography.labelSize)
            .fontWeight(AppTokensTypography.labelWeight)
            .layoutWeight(1) // 对应 Modifier.weight(1f)
            .height(44) // 对应 height(44.dp)
            .backgroundColor(AppTokensColors.tertiary) // 对应 containerColor
            .fontColor(AppTokensColors.onTertiary) // 对应 contentColor
            .borderRadius(AppTokensShapes.mediumCornerRadius) // 对应 shape
            .onClick(() => {
              this.markers.splice(0, this.markers.length); // 清除所有标记点
              this.drawMap();
            })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(AppTokensSpacing.lg) // 对应 Column 外部的 padding
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokensColors.background)
    // SwiftUI 的 .ignoresSafeArea() 在 ArkUI 中可通过窗口全屏布局 / expandSafeArea 实现，
    // 这里使用 100% 尺寸的背景色填充整页。
  }
}

// MARK: - App Entry Point (Equivalent to MainActivity)
// 在 ArkUI 中，@Entry @Component 即应用页面入口，对应 SwiftUI 的 @main App 结构。
// 要求 2: App 必须设置为全屏显示，并确保顶部状态栏隐藏。
// 在 ArkUI 中，隐藏状态栏的最佳实践是在窗口创建时调用 window.setWindowLayoutFullScreen(true)，
// 或在 main_pages.json 对应页面的 Ability 上配置全屏。
// SwiftUI 中的 PreviewProvider 在 ArkUI 中对应 Previewer 预览能力。
