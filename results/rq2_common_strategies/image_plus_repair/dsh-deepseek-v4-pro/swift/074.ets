// MARK: - AppTokens
// 翻译自 Kotlin 的 AppTokens 对象，用于定义颜色、字体、间距、形状和阴影。
// 这种结构使得修改 UI 比例和控件大小变得非常方便。

// 将单个字节转换为两位十六进制字符串（大写）
function toHex2(v: number): string {
  const s: string = v.toString(16).toUpperCase();
  return s.length < 2 ? '0' + s : s;
}

// 十六进制字符 -> 数值
function hexDigitToInt(c: string): number {
  const code: number = c.charCodeAt(0);
  if (code >= 48 && code <= 57) { return code - 48; } // '0'-'9'
  if (code >= 65 && code <= 70) { return code - 55; } // 'A'-'F'
  if (code >= 97 && code <= 102) { return code - 87; } // 'a'-'f'
  return 0;
}

// 对应 SwiftUI 的 Color(hex: UInt)：从 0xFF... 格式的十六进制整数创建颜色
// 如果没有 alpha 值（高字节为 0），默认为不透明（0xFF）
function colorFromHex(hex: number): string {
  let alpha: number = (hex >> 24) & 0xFF;
  if (alpha === 0) {
    alpha = 0xFF;
  }
  const r: number = (hex >> 16) & 0xFF;
  const g: number = (hex >> 8) & 0xFF;
  const b: number = hex & 0xFF;
  return '#' + toHex2(alpha) + toHex2(r) + toHex2(g) + toHex2(b);
}

// 对应 SwiftUI 的 Color.opacity(_:)：调整 #AARRGGBB 颜色字符串的透明度
function withOpacity(hexColor: string, opacity: number): string {
  const alphaInt: number = hexDigitToInt(hexColor.charAt(1)) * 16 + hexDigitToInt(hexColor.charAt(2));
  const newAlpha: number = Math.round(alphaInt * opacity);
  return '#' + toHex2(newAlpha) + hexColor.substring(3);
}

// AppTokens.Colors
class Colors {
  static readonly primary: string = colorFromHex(0xFFD95F02);
  static readonly secondary: string = colorFromHex(0xFF1B9AAA);
  static readonly tertiary: string = colorFromHex(0xFFFEC601);
  static readonly background: string = colorFromHex(0xFFF9F4EB);
  static readonly surface: string = colorFromHex(0xFFFFFFFF);
  static readonly surfaceVariant: string = colorFromHex(0xFFF0E3D1);
  static readonly outline: string = colorFromHex(0xFFE1CDB2);
  static readonly success: string = colorFromHex(0xFF56C271);
  static readonly warning: string = colorFromHex(0xFFF4A259);
  static readonly error: string = colorFromHex(0xFFD7263D);
  static readonly onPrimary: string = colorFromHex(0xFF1B1B1B);
  static readonly onSecondary: string = colorFromHex(0xFF041012);
  static readonly onTertiary: string = colorFromHex(0xFF1E1200);
  static readonly onBackground: string = colorFromHex(0xFF2C2A29);
  static readonly onSurface: string = colorFromHex(0xFF2E2924);
}

// 字体规格：size（字号）+ weight（字重）
class FontSpec {
  size: number;
  weight: number;
  constructor(size: number, weight: number) {
    this.size = size;
    this.weight = weight;
  }
}

// AppTokens.TypographyTokens
// SwiftUI 的 Font.system 提供了 size 和 weight。
// lineHeight（行高）和 letterSpacing（字间距/kerning）在 ArkTS 中需要单独处理。
// 由于 Kotlin 代码中的 letterSpacing 均为 0，我们主要关注 size 和 weight。
// semibold 对应数值字重 600，medium 对应 500，regular 对应 400。
class TypographyTokens {
  static readonly display: FontSpec = new FontSpec(28, 600);
  static readonly headline: FontSpec = new FontSpec(20, 600);
  static readonly title: FontSpec = new FontSpec(16, 500);
  static readonly body: FontSpec = new FontSpec(13, 400);
  static readonly label: FontSpec = new FontSpec(11, 500);
}

// AppTokens.Shapes
class Shapes {
  // 圆角半径直接映射为数值（vp）
  static readonly small: number = 12;
  static readonly medium: number = 16;
  static readonly large: number = 20;
}

// AppTokens.Spacing
class Spacing {
  // 间距直接映射为数值（vp）
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
  static readonly xxxl: number = 40;
}

// 阴影规格结构体
class ShadowSpec {
  elevation: number; // 在 SwiftUI 中通常映射为 shadow 的 radius 或 y 偏移的强度
  radius: number;    // 阴影的模糊半径
  dy: number;        // 阴影的 Y 轴偏移
  opacity: number;   // 阴影的透明度
  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

// AppTokens.ElevationMapping
class ElevationMapping {
  // 阴影映射，根据 Kotlin 定义进行转换
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16);
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.2);
  static readonly level4: ShadowSpec = new ShadowSpec(12, 16, 8, 0.24);
  static readonly level5: ShadowSpec = new ShadowSpec(16, 20, 10, 0.28);
}

// MARK: - Data Models
// 翻译自 Kotlin 的 Zone 数据类
class Zone {
  id: string; // SwiftUI ForEach 需要 Identifiable 协议，对应 UUID()
  name: string;
  humidity: number;
  temp: string;
  constructor(id: string, name: string, humidity: number, temp: string) {
    this.id = id;
    this.name = name;
    this.humidity = humidity;
    this.temp = temp;
  }
}

// MARK: - Reusable Components
// 翻译自 Kotlin 的 StatusRow Composable
@Component
struct StatusRow {
  @Prop label: string;
  @Prop value: number;
  @Prop accent: string;

  build() {
    Column({ space: Spacing.xs }) {
      Row() {
        Text(this.label)
          .fontSize(TypographyTokens.body.size)
          .fontWeight(TypographyTokens.body.weight)
          .fontColor(Colors.onSurface)
        Blank()
        Text(`${Math.round(this.value * 100)}%`)
          .fontSize(TypographyTokens.label.size)
          .fontWeight(TypographyTokens.label.weight)
          .fontColor(this.accent)
      }
      .width('100%')

      // 线性进度条，近似 Compose 的 LinearProgressIndicator
      Progress({ value: this.value, total: 1, type: ProgressType.Linear })
        .color(this.accent) // 进度条颜色
        .backgroundColor(Colors.surface) // 轨道颜色
        .height(4) // 近似 Compose 进度条高度
        .borderRadius(2) // 进度条圆角
        .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// 翻译自 Kotlin 的 ZoneRow Composable
@Component
struct ZoneRow {
  @Prop zone: Zone;

  build() {
    Column({ space: Spacing.xs }) {
      Row() {
        Text(this.zone.name)
          .fontSize(TypographyTokens.title.size)
          .fontWeight(TypographyTokens.title.weight)
          .fontColor(Colors.onSurface)
        Blank()
        Text(this.zone.temp)
          .fontSize(TypographyTokens.label.size)
          .fontWeight(TypographyTokens.label.weight)
          .fontColor(Colors.primary)
      }
      .width('100%')

      // 线性进度条，近似 Compose 的 LinearProgressIndicator
      Progress({ value: this.zone.humidity, total: 1, type: ProgressType.Linear })
        .color(Colors.secondary)
        .backgroundColor(Colors.surface) // 轨道颜色
        .height(4) // 近似 Compose 进度条高度
        .borderRadius(2) // 进度条圆角
        .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(Spacing.sm)
    .backgroundColor(withOpacity(Colors.surfaceVariant, 0.5)) // 背景色和透明度
    .borderRadius(Shapes.small) // 圆角
  }
}

// MARK: - Main Screen
// 翻译自 Kotlin 的 RootScreen Composable
// SwiftUI 的 @main SmartOrbitPanelApp 入口在 ArkTS 中由 @Entry 装饰器表示
@Entry
@Component
struct RootScreen {
  // 使用 @State 存储可变状态，对应 Kotlin 的 remember { mutableStateOf(...) }
  @State activeMode: string = 'Orbit';
  @State solarLevel: number = 0.6;
  @State ambientGlow: number = 0.35;

  modes: string[] = ['Orbit', 'Eclipse', 'Manual'];
  zones: Zone[] = [
    new Zone('zone-1', 'Atrium', 0.45, '72°F'),
    new Zone('zone-2', 'Lab East', 0.62, '68°F'),
    new Zone('zone-3', 'Hab Deck', 0.30, '70°F')
  ];

  build() {
    // Stack 用于将背景色铺满整个屏幕，并允许内容忽略安全区域
    Stack() {
      // 主 Column 结构，对应 Kotlin 的 Scaffold，包含顶部栏、可滚动内容和底部栏
      Column({ space: 0 }) {
        // MARK: 顶部栏 (Top Bar)
        // 对应 Kotlin 的 CenterAlignedTopAppBar
        Row() {
          Button({ type: ButtonType.Normal }) {
            Text('Dock')
              .fontSize(TypographyTokens.label.size)
              .fontWeight(TypographyTokens.label.weight)
              .fontColor(Colors.onSurface)
          }
          .onClick(() => {
            // "Dock" 按钮点击事件
          })

          Blank() // 居中标题

          Text('Smart Orbit Panel')
            .fontSize(TypographyTokens.title.size)
            .fontWeight(TypographyTokens.title.weight)
            .fontColor(Colors.onSurface)

          Blank() // 居中标题

          Button({ type: ButtonType.Normal }) {
            Text('Alerts')
              .fontSize(TypographyTokens.label.size)
              .fontWeight(TypographyTokens.label.weight)
              .fontColor(Colors.secondary)
          }
          .onClick(() => {
            // "Alerts" 按钮点击事件
          })
        }
        .width('100%')
        .padding({ left: Spacing.lg, right: Spacing.lg }) // 水平内边距
        .height(56) // 近似 Material3 TopAppBar 的标准高度
        .backgroundColor(Colors.surface) // 背景色
        // Kotlin 代码中 TopAppBar 没有明确的阴影，因此这里不添加

        // MARK: 可滚动内容区域 (Scrollable Content)
        // 对应 Kotlin 的 Column.verticalScroll
        Scroll() {
          Column({ space: Spacing.md }) {
            // 模式选择芯片 (Filter Chips)
            Row({ space: Spacing.sm }) {
              ForEach(this.modes, (mode: string) => {
                Button({ type: ButtonType.Normal }) {
                  Text(mode)
                    .fontSize(TypographyTokens.label.size)
                    .fontWeight(TypographyTokens.label.weight)
                    .fontColor(Colors.onSurface)
                    .padding({
                      left: Spacing.md,
                      right: Spacing.md,
                      top: Spacing.sm,
                      bottom: Spacing.sm
                    }) // 芯片内部文本的内边距
                    .backgroundColor(this.activeMode === mode ? withOpacity(Colors.primary, 0.15) : Colors.surface) // 选中/未选中背景色
                    .border({ width: 1, color: Colors.outline }) // 芯片边框
                    .borderRadius(Shapes.small) // 芯片形状
                }
                .onClick(() => {
                  this.activeMode = mode;
                })
              }, (mode: string) => mode)
            }
            .width('100%')
            // 确保芯片靠左对齐（Row 默认从起始位置排列，无需额外设置）

            // Solar Wash 卡片
            // 对应 Kotlin 的 Card
            Column({ space: Spacing.sm }) {
              Text('Solar wash')
                .fontSize(TypographyTokens.headline.size)
                .fontWeight(TypographyTokens.headline.weight)
                .fontColor(Colors.onSurface)
              Text('Adjust orbital window glow')
                .fontSize(TypographyTokens.body.size)
                .fontWeight(TypographyTokens.body.weight)
                .fontColor(withOpacity(Colors.onSurface, 0.7))

              // Slider (滑块)
              Slider({ value: this.solarLevel, min: 0, max: 1 })
                .selectedColor(Colors.primary) // 滑块拇指和激活轨道的颜色
                .onChange((value: number) => {
                  this.solarLevel = value;
                })
                .width('100%')

              // Slider 下方的 0% 和 X% 文本
              Row() {
                Text('0%')
                  .fontSize(TypographyTokens.label.size)
                  .fontWeight(TypographyTokens.label.weight)
                  .fontColor(Colors.onSurface)
                Blank()
                Text(`${Math.round(this.solarLevel * 100)}%`)
                  .fontSize(TypographyTokens.title.size)
                  .fontWeight(TypographyTokens.title.weight)
                  .fontColor(Colors.primary)
              }
              .width('100%')

              // Ambient Glow
              Text('Ambient glow')
                .fontSize(TypographyTokens.headline.size)
                .fontWeight(TypographyTokens.headline.weight)
                .fontColor(Colors.onSurface)

              // Slider (滑块)
              Slider({ value: this.ambientGlow, min: 0, max: 1 })
                .selectedColor(Colors.secondary) // 滑块拇指和激活轨道的颜色
                .onChange((value: number) => {
                  this.ambientGlow = value;
                })
                .width('100%')

              // 线性进度条
              Progress({ value: this.ambientGlow, total: 1, type: ProgressType.Linear })
                .color(Colors.secondary)
                .backgroundColor(Colors.surfaceVariant) // 轨道颜色
                .height(4) // 近似 Compose 进度条高度
                .borderRadius(2) // 进度条圆角
                .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(Spacing.lg) // 卡片内部内边距
            .backgroundColor(Colors.surface) // 卡片背景色
            .borderRadius(Shapes.large) // 卡片圆角
            // 卡片阴影，对应 AppTokens.ElevationMapping.level1
            .shadow({
              radius: ElevationMapping.level1.radius,
              color: withOpacity('#FF000000', ElevationMapping.level1.opacity),
              offsetX: 0,
              offsetY: ElevationMapping.level1.dy
            })

            // Orbit Health 卡片
            // 对应 Kotlin 的 Card
            Column({ space: Spacing.sm }) {
              Text('Orbit health')
                .fontSize(TypographyTokens.headline.size)
                .fontWeight(TypographyTokens.headline.weight)
                .fontColor(Colors.onSurface)
              StatusRow({ label: 'Atmos mix', value: 0.74, accent: Colors.secondary })
              StatusRow({ label: 'Hull temp', value: 0.42, accent: Colors.primary })
              StatusRow({ label: 'Shield sync', value: 0.88, accent: Colors.tertiary })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(Spacing.lg) // 卡片内部内边距
            .backgroundColor(Colors.surfaceVariant) // 卡片背景色
            .borderRadius(Shapes.large) // 卡片圆角
            // 卡片阴影，对应 AppTokens.ElevationMapping.level1
            .shadow({
              radius: ElevationMapping.level1.radius,
              color: withOpacity('#FF000000', ElevationMapping.level1.opacity),
              offsetX: 0,
              offsetY: ElevationMapping.level1.dy
            })

            // Deck Zones 卡片
            // 对应 Kotlin 的 Card
            Column({ space: Spacing.sm }) {
              Text('Deck zones')
                .fontSize(TypographyTokens.headline.size)
                .fontWeight(TypographyTokens.headline.weight)
                .fontColor(Colors.onSurface)
              ForEach(this.zones, (zone: Zone) => {
                ZoneRow({ zone: zone })
              }, (zone: Zone) => zone.id)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(Spacing.lg) // 卡片内部内边距
            .backgroundColor(Colors.surface) // 卡片背景色
            .borderRadius(Shapes.large) // 卡片圆角
            // 卡片阴影，对应 AppTokens.ElevationMapping.level1
            .shadow({
              radius: ElevationMapping.level1.radius,
              color: withOpacity('#FF000000', ElevationMapping.level1.opacity),
              offsetX: 0,
              offsetY: ElevationMapping.level1.dy
            })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          // 整个可滚动内容的水平和垂直内边距，对应 Scaffold 的 contentPadding
          .padding({
            left: Spacing.lg,
            right: Spacing.lg,
            top: Spacing.sm,
            bottom: Spacing.sm
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .width('100%')

        // MARK: 底部栏 (Bottom Bar)
        // 对应 Kotlin 的 Scaffold bottomBar
        Row() {
          Column({ space: Spacing.xs }) {
            Text('Grid draw')
              .fontSize(TypographyTokens.label.size)
              .fontWeight(TypographyTokens.label.weight)
              .fontColor(Colors.onSurface)
            Text('18.4 kWh')
              .fontSize(TypographyTokens.title.size)
              .fontWeight(TypographyTokens.title.weight)
              .fontColor(Colors.primary)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button({ type: ButtonType.Normal }) {
            Text('Engage eco hold')
              .fontSize(TypographyTokens.label.size)
              .fontWeight(TypographyTokens.label.weight)
              .padding({
                left: Spacing.md,
                right: Spacing.md,
                top: Spacing.sm,
                bottom: Spacing.sm
              }) // 按钮内部文本的内边距
              .backgroundColor(Colors.primary) // 按钮背景色
              .fontColor(Colors.onPrimary) // 按钮文本颜色
              .borderRadius(Shapes.medium) // 按钮圆角
          }
          .onClick(() => {
            // "Engage eco hold" 按钮点击事件
          })
        }
        .width('100%')
        .padding({
          left: Spacing.lg,
          right: Spacing.lg,
          top: Spacing.sm,
          bottom: Spacing.sm
        }) // 内边距
        .backgroundColor(Colors.surface) // 背景色
        // 底部栏阴影，对应 AppTokens.ElevationMapping.level2
        .shadow({
          radius: ElevationMapping.level2.radius,
          color: withOpacity('#FF000000', ElevationMapping.level2.opacity),
          offsetX: 0,
          offsetY: ElevationMapping.level2.dy
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background) // 设置整个屏幕的背景色
    // 使整个内容忽略安全区域，实现全屏效果（对应 .ignoresSafeArea(.all, edges: .vertical)）
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    // SwiftUI 的 .statusBarHidden(true)（隐藏顶部状态栏）在 ArkTS 中通过系统栏属性设置，此处省略
  }
}
