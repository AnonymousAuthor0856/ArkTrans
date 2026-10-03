// import SwiftUI
// ArkTS 使用 ArkUI 声明式组件，无需显式 import SwiftUI；系统组件与内置类型可直接使用。

// MARK: - AppTokens (Translated from Kotlin)

// 辅助函数：用于从 Kotlin 的 0xFFRRGGBBAA 格式的 UInt 值创建 ArkUI 颜色。
// ArkUI 的颜色采用 '#AARRGGBB' 字符串格式，因此 Swift 的 Color(hex:) 扩展被折叠为下面的十六进制字符串。
// 本函数根据给定的透明度（0~1）修改 '#AARRGGBB' 颜色的 alpha 通道，返回新的颜色字符串。
function colorWithAlpha(hex: string, alpha: number): string {
  const alphaInt: number = Math.round(alpha * 255);
  let alphaHex: string = alphaInt.toString(16).toUpperCase();
  if (alphaHex.length < 2) {
    alphaHex = '0' + alphaHex;
  }
  return '#' + alphaHex + hex.substring(3);
}

// 原 Swift 中 AppTokens.Colors 嵌套结构体，因 ArkTS 不支持嵌套类，扁平化为顶层类。
class AppTokensColors {
  static readonly primary: string = '#FF7B61FF';
  static readonly secondary: string = '#FF26C6DA';
  static readonly tertiary: string = '#FFFF8A80';
  static readonly background: string = '#FFF5F7FF';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFF0F2F8';
  static readonly outline: string = '#FFE0E3EB';
  static readonly success: string = '#FF22C55E';
  static readonly warning: string = '#FFF59E0B';
  static readonly error: string = '#FFEF4444';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FF0B1220';
  static readonly onTertiary: string = '#FF0B1220';
  static readonly onBackground: string = '#FF0B1220';
  static readonly onSurface: string = '#FF0B1220';
}

// Kotlin 的 TextStyle 直接映射到 ArkUI 的 fontSize/fontWeight。
class AppTypographyTokens {
  static readonly displaySize: number = 28;
  static readonly displayWeight: number = 700; // .bold
  static readonly headlineSize: number = 20;
  static readonly headlineWeight: number = 600; // .semibold
  static readonly titleSize: number = 16;
  static readonly titleWeight: number = 500; // .medium
  static readonly bodySize: number = 14;
  static readonly bodyWeight: number = 400; // .regular
  static readonly labelSize: number = 12;
  static readonly labelWeight: number = 500; // .medium
}

class AppTokensShapes {
  // 圆角半径直接映射为 number(vp)
  static readonly smallCornerRadius: number = 8;
  static readonly mediumCornerRadius: number = 14;
  static readonly largeCornerRadius: number = 20;
}

class AppTokensSpacing {
  // 间距值直接映射为 number(vp)
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

// 阴影规范，用于 ArkUI 的 .shadow({ radius, color, offsetX, offsetY })
class AppShadowSpec {
  elevation: number; // Compose 中的概念，ArkUI 中不直接使用此值
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

class AppElevationMapping {
  static readonly level1: AppShadowSpec = new AppShadowSpec(2, 4, 2, 0.12);
  static readonly level2: AppShadowSpec = new AppShadowSpec(6, 10, 6, 0.16);
  static readonly level3: AppShadowSpec = new AppShadowSpec(10, 14, 8, 0.18);
}

// MARK: - AppColorScheme (Mimics MaterialTheme.colorScheme)

// 创建一个类来模拟 Compose 的 MaterialTheme.colorScheme，方便访问主题颜色
class AppColorScheme {
  primary: string = AppTokensColors.primary;
  onPrimary: string = AppTokensColors.onPrimary;
  secondary: string = AppTokensColors.secondary;
  onSecondary: string = AppTokensColors.onSecondary;
  tertiary: string = AppTokensColors.tertiary;
  onTertiary: string = AppTokensColors.onTertiary;
  background: string = AppTokensColors.background;
  onBackground: string = AppTokensColors.onBackground;
  surface: string = AppTokensColors.surface;
  onSurface: string = AppTokensColors.onSurface;
  surfaceVariant: string = AppTokensColors.surfaceVariant;
  outline: string = AppTokensColors.outline;
  error: string = AppTokensColors.error;
}

// MARK: - Data Models (Translated from Kotlin data classes)

class Coupon {
  id: number;
  title: string;
  value: string;
  colorA: string;
  colorB: string;
  constructor(id: number, title: string, value: string, colorA: string, colorB: string) {
    this.id = id;
    this.title = title;
    this.value = value;
    this.colorA = colorA;
    this.colorB = colorB;
  }
}

class MapPin {
  id: string; // ArkUI ForEach 需要唯一 key（此处的 id 类似 Swift 的 UUID()）
  x: number;
  y: number;
  label: string;
  tint: string;
  constructor(x: number, y: number, label: string, tint: string) {
    this.id = label + '_' + x.toString() + '_' + y.toString();
    this.x = x;
    this.y = y;
    this.label = label;
    this.tint = tint;
  }
}

// MARK: - RootScreen (Translated from Kotlin Composable)

@Entry
@Component
struct RootScreen {
  // 实例化 AppColorScheme 以便在视图中访问主题颜色
  private appColorScheme: AppColorScheme = new AppColorScheme();

  // 优惠券数据，直接作为常量
  private coupons: Coupon[] = [
    new Coupon(1, 'Grocery Pack', '-$5', AppTokensColors.primary, AppTokensColors.secondary),
    new Coupon(2, 'Cafe Bundle', '-15%', AppTokensColors.secondary, AppTokensColors.tertiary),
    new Coupon(3, 'Electro Deal', '-$20', AppTokensColors.tertiary, AppTokensColors.primary),
    new Coupon(4, 'Fashion Duo', '-10%', AppTokensColors.secondary, AppTokensColors.primary)
  ];

  // 地图标记数据，使用 @State 以便未来可变
  @State pins: MapPin[] = [
    new MapPin(140, 220, 'A', AppTokensColors.primary),
    new MapPin(320, 400, 'B', AppTokensColors.secondary),
    new MapPin(520, 300, 'C', AppTokensColors.tertiary)
  ];

  private mapContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true));

  build() {
    // Stack 模拟 Scaffold 的背景和内容层叠
    Stack() {
      // 背景渐变，对应 Kotlin Column 的 background Brush.verticalGradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180, // .top -> .bottom
          colors: [
            [colorWithAlpha(AppTokensColors.secondary, 0.25), 0.0],
            [AppTokensColors.background, 0.5],
            [colorWithAlpha(AppTokensColors.primary, 0.25), 1.0]
          ]
        })

      // 主内容 Column，对应 Kotlin 的 Column
      Column({ space: AppTokensSpacing.lg }) {
        // 顶部导航栏，对应 Kotlin 的 CenterAlignedTopAppBar
        Row() {
          // 左侧 IconButton
          Button() {
            Circle()
              .fill(this.appColorScheme.onSurface)
              .width(20)
              .height(20) // Modifier.size(20.dp)
          }
          .type(ButtonType.Normal)
          .onClick(() => {})
          .padding({ left: AppTokensSpacing.lg }) // 对应 IconButton 的 padding

          Blank() // 用于居中标题

          // 标题 Text
          Text('Coupon Pack')
            .fontSize(AppTypographyTokens.displaySize) // style = MaterialTheme.typography.displayLarge
            .fontWeight(AppTypographyTokens.displayWeight)
            .fontColor(this.appColorScheme.onSurface) // color = MaterialTheme.colorScheme.onSurface

          Blank() // 用于居中标题

          // 右侧 IconButton
          Button() {
            Circle()
              .fill(this.appColorScheme.primary)
              .width(20)
              .height(20) // Modifier.size(20.dp)
          }
          .type(ButtonType.Normal)
          .onClick(() => {})
          .padding({ right: AppTokensSpacing.lg }) // 对应 IconButton 的 padding
        }
        .width('100%')
        .padding({ top: AppTokensSpacing.lg }) // 顶部填充，确保内容不被状态栏遮挡（即使状态栏隐藏）

        // 主内容区域的 Column
        Column({ space: AppTokensSpacing.lg }) {
          // "Nearby Packs" 文本
          Text('Nearby Packs')
            .fontSize(AppTypographyTokens.headlineSize) // style = MaterialTheme.typography.headlineMedium
            .fontWeight(AppTypographyTokens.headlineWeight)
            .fontColor(this.appColorScheme.onSurface) // color = MaterialTheme.colorScheme.onSurface

          // 地图区域 Stack
          Stack({ alignContent: Alignment.TopEnd }) { // Modifier.align(Alignment.TopEnd)
            Stack() {
              Rect() // AppTokens.Shapes.large
                .fill(this.appColorScheme.surface) // background(MaterialTheme.colorScheme.surface)
                .width('100%')
                .height('100%')
                .borderRadius(AppTokensShapes.largeCornerRadius)
              // Canvas 用于绘制地图和图钉
              Canvas(this.mapContext)
                .width('100%')
                .height('100%')
                .padding(AppTokensSpacing.md) // .padding(AppTokensSpacing.md)
                .onReady(() => {
                  // drawRect(color = AppTokens.Colors.surfaceVariant)
                  this.mapContext.fillStyle = AppTokensColors.surfaceVariant;
                  this.mapContext.fillRect(0, 0, this.mapContext.width, this.mapContext.height);

                  // 绘制地图图钉
                  for (let i = 0; i < this.pins.length; i++) {
                    const pin: MapPin = this.pins[i];
                    // drawCircle(color = p.tint, radius = 14f, center = Offset(p.x, p.y))
                    this.mapContext.fillStyle = pin.tint;
                    this.mapContext.beginPath();
                    this.mapContext.arc(pin.x, pin.y, 14, 0, Math.PI * 2);
                    this.mapContext.fill();
                  }
                })
            }
            .width('100%')
            .aspectRatio(16 / 9) // aspectRatio(16f / 9f)
            // 阴影，对应 CardDefaults.cardElevation(AppTokens.ElevationMapping.level2.elevation)
            .shadow({
              radius: AppElevationMapping.level2.radius,
              color: colorWithAlpha('#FF000000', AppElevationMapping.level2.opacity),
              offsetX: 0,
              offsetY: AppElevationMapping.level2.dy
            })

            // 地图上的 A B C 标签 Row
            Row({ space: AppTokensSpacing.sm }) { // horizontalArrangement = Arrangement.spacedBy(AppTokensSpacing.sm)
              Circle()
                .fill(AppTokensColors.primary)
                .width(10)
                .height(10) // Modifier.size(10.dp)
              Text('A')
                .fontSize(AppTypographyTokens.labelSize) // style = MaterialTheme.typography.labelMedium
                .fontWeight(AppTypographyTokens.labelWeight)
                .fontColor(this.appColorScheme.onSurface)

              Circle()
                .fill(AppTokensColors.secondary)
                .width(10)
                .height(10)
              Text('B')
                .fontSize(AppTypographyTokens.labelSize)
                .fontWeight(AppTypographyTokens.labelWeight)
                .fontColor(this.appColorScheme.onSurface)

              Circle()
                .fill(AppTokensColors.tertiary)
                .width(10)
                .height(10)
              Text('C')
                .fontSize(AppTypographyTokens.labelSize)
                .fontWeight(AppTypographyTokens.labelWeight)
                .fontColor(this.appColorScheme.onSurface)
            }
            .padding({ left: AppTokensSpacing.md, right: AppTokensSpacing.md, top: AppTokensSpacing.xs, bottom: AppTokensSpacing.xs })
            .backgroundColor(colorWithAlpha(this.appColorScheme.surface, 0.9)) // background(MaterialTheme.colorScheme.surface.copy(alpha = 0.9f))
            .borderRadius(AppTokensShapes.smallCornerRadius) // AppTokens.Shapes.small
            .padding(AppTokensSpacing.md) // 确保这个浮动框在地图内部有间距
          }
          .width('100%')

          // "Your Coupon Packs" 文本
          Text('Your Coupon Packs')
            .fontSize(AppTypographyTokens.headlineSize)
            .fontWeight(AppTypographyTokens.headlineWeight)
            .fontColor(this.appColorScheme.onSurface)

          // 优惠券 Scroll (对应 LazyRow)
          Scroll() {
            Row({ space: AppTokensSpacing.lg }) { // horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
              ForEach(this.coupons, (coupon: Coupon) => {
                // Card 结构
                Stack() {
                  // 卡片背景和阴影
                  Rect() // AppTokens.Shapes.large
                    .fill(this.appColorScheme.surface) // containerColor = MaterialTheme.colorScheme.surface
                    .width('100%')
                    .height('100%')
                    .borderRadius(AppTokensShapes.largeCornerRadius)
                    .shadow({ // elevation = CardDefaults.cardElevation(AppTokens.ElevationMapping.level2.elevation)
                      radius: AppElevationMapping.level2.radius,
                      color: colorWithAlpha('#FF000000', AppElevationMapping.level2.opacity),
                      offsetX: 0,
                      offsetY: AppElevationMapping.level2.dy
                    })

                  // 卡片内容 Column
                  Column({ space: AppTokensSpacing.sm }) { // verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                    Row({ space: AppTokensSpacing.sm }) { // horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                      Circle()
                        .fill(this.appColorScheme.primary) // background(MaterialTheme.colorScheme.primary)
                        .width(14)
                        .height(14) // Modifier.size(14.dp)
                      Text(coupon.title)
                        .fontSize(AppTypographyTokens.titleSize) // style = MaterialTheme.typography.titleMedium
                        .fontWeight(AppTypographyTokens.titleWeight)
                        .fontColor(this.appColorScheme.onSurface)
                    }
                    Text(coupon.value)
                      .fontSize(AppTypographyTokens.displaySize) // style = MaterialTheme.typography.displayLarge
                      .fontWeight(AppTypographyTokens.displayWeight)
                      .fontColor(this.appColorScheme.onSurface)
                    // 兑换按钮
                    Button() {
                      Text('Redeem')
                        .fontSize(AppTypographyTokens.labelSize) // style = MaterialTheme.typography.labelMedium
                        .fontWeight(AppTypographyTokens.labelWeight)
                        .fontColor(this.appColorScheme.onPrimary) // contentColor = MaterialTheme.colorScheme.onPrimary
                    }
                    .type(ButtonType.Normal)
                    .width('100%') // Modifier.fillMaxWidth()
                    .height(40) // Modifier.height(40.dp)
                    .backgroundColor(this.appColorScheme.primary) // containerColor = MaterialTheme.colorScheme.primary
                    .borderRadius(AppTokensShapes.mediumCornerRadius) // shape = AppTokens.Shapes.medium
                    .onClick(() => {})
                  }
                  .alignItems(HorizontalAlign.Start)
                  .padding(AppTokensSpacing.lg) // .padding(AppTokens.Spacing.lg)
                  .linearGradient({ // 卡片内部渐变背景
                    angle: 90, // .leading -> .trailing
                    colors: [
                      [colorWithAlpha(coupon.colorA, 0.18), 0.0], // Brush.horizontalGradient(...)
                      [colorWithAlpha(coupon.colorB, 0.18), 1.0]
                    ]
                  })
                  .borderRadius(AppTokensShapes.largeCornerRadius) // 确保渐变背景也应用相同的圆角
                }
                .width(200)
                .height(140) // Modifier.size(200.dp, 140.dp)
              }, (coupon: Coupon) => coupon.id.toString())
            }
            .padding({ left: AppTokensSpacing.xs, right: AppTokensSpacing.xs }) // contentPadding = PaddingValues(horizontal = AppTokens.Spacing.xs)
          }
          .scrollable(ScrollDirection.Horizontal) // LazyRow
          .scrollBar(BarState.Off) // showsIndicators: false
          .width('100%')

          // 底部 Spacer
          Blank()
            .height(AppTokensSpacing.sm) // Modifier.height(AppTokens.Spacing.sm)

          // 底部两个按钮的 Row
          Row({ space: AppTokensSpacing.md }) { // horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
            // "My Coupons" 按钮
            Button() {
              Text('My Coupons')
                .fontSize(AppTypographyTokens.titleSize) // style = MaterialTheme.typography.titleMedium
                .fontWeight(AppTypographyTokens.titleWeight)
                .fontColor(this.appColorScheme.onSecondary) // contentColor = MaterialTheme.colorScheme.onSecondary
            }
            .type(ButtonType.Normal)
            .layoutWeight(1) // Modifier.weight(1f)
            .height(52) // Modifier.height(52.dp)
            .backgroundColor(this.appColorScheme.secondary) // containerColor = MaterialTheme.colorScheme.secondary
            .borderRadius(AppTokensShapes.largeCornerRadius) // shape = AppTokens.Shapes.large
            .onClick(() => {})
            // "Explore More" 按钮
            Button() {
              Text('Explore More')
                .fontSize(AppTypographyTokens.titleSize) // style = MaterialTheme.typography.titleMedium
                .fontWeight(AppTypographyTokens.titleWeight)
                .fontColor(this.appColorScheme.onPrimary) // contentColor = MaterialTheme.colorScheme.onPrimary
            }
            .type(ButtonType.Normal)
            .layoutWeight(1) // Modifier.weight(1f)
            .height(52) // Modifier.height(52.dp)
            .backgroundColor(this.appColorScheme.primary) // containerColor = MaterialTheme.colorScheme.primary
            .borderRadius(AppTokensShapes.largeCornerRadius) // shape = AppTokens.Shapes.large
            .onClick(() => {})
          }
          .width('100%')
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg }) // Modifier.padding(AppTokens.Spacing.lg)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM]) // 确保整个视图内容忽略安全区域，实现全屏
    // .statusBarHidden(true) —— ArkUI 中隐藏状态栏需通过窗口/系统栏 API 配置，此处省略。
  }
}

// MARK: - App Entry Point (@main)
// SwiftUI 的 @main struct CouponPackApp: App 在 ArkUI 中对应上面的 @Entry 注解，
// 该页面即应用的入口页面。

// MARK: - Preview (Xcode Canvas Preview)
// SwiftUI 的 RootScreen_Previews: PreviewProvider 对应 ArkUI 的 Previewer 注解；
// 此处不生成 Previewer，仅保留 RootScreen 作为可预览页面。
