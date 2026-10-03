// MARK: - AppTokens
// 定义应用程序的颜色、排版、形状、间距和阴影规范
// 注：ArkTS 不支持嵌套类型与把类当作对象引用，因此 Swift 的嵌套 struct（AppTokens.Colors 等）
// 被平铺为顶层类，在 UI 中直接以 Colors / TypographyTokens / Shapes / Spacing / ElevationMapping 引用。

// 辅助函数：对应 Swift 的 Color 十六进制初始化扩展（extension Color { init(hex: UInt) }）
function toHexByte(value: number): string {
  let hex: string = value.toString(16).toUpperCase();
  if (hex.length < 2) {
    hex = '0' + hex;
  }
  return hex;
}

function colorFromHex(hex: number): string {
  const red: number = (hex & 0xFF0000) >> 16;
  const green: number = (hex & 0x00FF00) >> 8;
  const blue: number = hex & 0x0000FF;
  return '#FF' + toHexByte(red) + toHexByte(green) + toHexByte(blue);
}

// 将不透明度应用到颜色上，对应 Swift 的 Color.opacity()
function withOpacity(color: string, opacity: number): string {
  const alpha: number = Math.round(opacity * 255);
  return '#' + toHexByte(alpha) + color.substring(3);
}

class Colors {
  static readonly primary: string = colorFromHex(0xFF8E6BF2);
  static readonly secondary: string = colorFromHex(0xFFD3C1FF);
  static readonly tertiary: string = colorFromHex(0xFFB39DDB);
  static readonly background: string = colorFromHex(0xFFF5F3FF);
  static readonly surface: string = colorFromHex(0xFFFFFFFF);
  static readonly surfaceVariant: string = colorFromHex(0xFFECE6F8);
  static readonly outline: string = colorFromHex(0xFFD1C4E9);
  static readonly success: string = colorFromHex(0xFF4CAF50);
  static readonly warning: string = colorFromHex(0xFFFFB300);
  static readonly error: string = colorFromHex(0xFFE53935);
  static readonly onPrimary: string = colorFromHex(0xFFFFFFFF);
  static readonly onSecondary: string = colorFromHex(0xFF2E1A47);
  static readonly onBackground: string = colorFromHex(0xFF2E1A47);
  static readonly onSurface: string = colorFromHex(0xFF2E1A47);
}

class TypographyTokens {
  // Swift 中使用 Font.system(size:weight:)，ArkUI 中以 fontSize/fontWeight 组合表达
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular; // FontWeight.Normal 对应 .regular
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class Shapes {
  static readonly small: number = 8.0;
  static readonly medium: number = 14.0;
  static readonly large: number = 20.0;
}

class Spacing {
  static readonly sm: number = 6.0;
  static readonly md: number = 10.0;
  static readonly lg: number = 16.0;
  static readonly xl: number = 24.0;
}

class ShadowSpec {
  elevation: number; // 对应 Compose 的 elevation，在 SwiftUI 中通常映射为 shadow radius
  radius: number;    // 对应 Compose 的 radius，在 SwiftUI 中通常映射为 shadow radius
  dy: number;        // 对应 Compose 的 dy，在 SwiftUI 中映射为 shadow y 偏移
  opacity: number;   // 对应 Compose 的 opacity

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(4.0, 8.0, 2.0, 0.18);
  static readonly level2: ShadowSpec = new ShadowSpec(8.0, 12.0, 4.0, 0.22);
  static readonly level3: ShadowSpec = new ShadowSpec(12.0, 20.0, 8.0, 0.26);
}

// MARK: - CustomCardStyle ViewModifier
// 用于模拟 Compose Card 的样式，包括圆角、背景色和阴影。
// ArkUI 没有 ViewModifier 机制，此处通过通用属性（backgroundColor/borderRadius/shadow）
// 直接作用在 Card 的 Column 上（见 RootScreen 中的 card 区域）。
// Compose 的 spotColor 和 ambientColor 在单个 shadow modifier 中难以完全复制，
// 这里使用 ambientColor 作为主阴影颜色，并结合 opacity。

// MARK: - RootScreen
// 应用程序的主要 UI 视图
// Swift 中的 @main App 入口点（AfterSaleServiceApp: App）在 ArkUI 中以 @Entry 表示
@Entry
@Component
struct RootScreen {
  @State orderId: string = '';
  @State issue: string = '';
  @State submitted: boolean = false;

  // 用于 TextField 和 TextEditor 的焦点状态，以便精确控制样式
  @State orderIdIsFocused: boolean = false;
  @State issueIsFocused: boolean = false;

  build() {
    Stack() { // 相当于 Compose 的 Scaffold，用于设置整个屏幕的背景色
      // 设置背景色并忽略安全区域
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(Colors.background)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

      Column({ space: Spacing.lg }) { // 对应 Compose 的 Column，垂直间距为 lg
        Text('After-Sale Service')
          .fontSize(TypographyTokens.displaySize)
          .fontWeight(TypographyTokens.displayWeight)
          .fontColor(Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start) // 文本左对齐

        // Card 区域
        Column({ space: Spacing.md }) { // Card 内部的 Column
          Text('Order ID')
            .fontSize(TypographyTokens.titleSize)
            .fontWeight(TypographyTokens.titleWeight)
            .fontColor(Colors.onSurface)

          // Order ID 输入框
          Stack({ alignContent: Alignment.TopStart }) { // 用于实现带自定义颜色的 placeholder
            if (this.orderId.length === 0 && !this.orderIdIsFocused) { // 当输入为空且未聚焦时显示 placeholder
              Text('Enter order number')
                .fontSize(TypographyTokens.bodySize)
                .fontWeight(TypographyTokens.bodyWeight)
                .fontColor(withOpacity(Colors.onSurface, 0.5))
                .padding({
                  left: Spacing.md,
                  right: Spacing.md,
                  top: (56 - TypographyTokens.bodySize) / 2 // 垂直居中 placeholder
                })
            }
            TextInput({ text: this.orderId, placeholder: '' }) // TextField 本身不带 placeholder
              .fontSize(TypographyTokens.bodySize)
              .fontWeight(TypographyTokens.bodyWeight)
              .fontColor(Colors.onSurface)
              .padding({ left: Spacing.md, right: Spacing.md })
              .width('100%')
              .height(56) // 对应 Compose TextField 的默认高度 (如 56.dp)
              .backgroundColor(Colors.surfaceVariant) // unfocusedContainerColor 和 focusedContainerColor 相同
              .borderRadius(Shapes.medium)
              .border({
                width: 1,
                color: this.orderIdIsFocused ? Colors.primary : Colors.outline
              })
              .onFocus(() => {
                this.orderIdIsFocused = true;
              })
              .onBlur(() => {
                this.orderIdIsFocused = false;
              })
              .onChange((value: string) => {
                this.orderId = value;
              })
          }
          .width('100%')

          Text('Issue Description')
            .fontSize(TypographyTokens.titleSize)
            .fontWeight(TypographyTokens.titleWeight)
            .fontColor(Colors.onSurface)

          // Issue Description 输入框 (TextArea 对应多行 TextField)
          Stack({ alignContent: Alignment.TopStart }) { // 用于实现带自定义颜色的 placeholder
            if (this.issue.length === 0 && !this.issueIsFocused) { // 当输入为空且未聚焦时显示 placeholder
              Text('Describe your issue')
                .fontSize(TypographyTokens.bodySize)
                .fontWeight(TypographyTokens.bodyWeight)
                .fontColor(withOpacity(Colors.onSurface, 0.5))
                .padding({
                  left: Spacing.md,
                  right: Spacing.md,
                  top: Spacing.sm + 4 // 调整 TextArea 内部默认 padding
                })
            }
            TextArea({ text: this.issue, placeholder: '' })
              .fontSize(TypographyTokens.bodySize)
              .fontWeight(TypographyTokens.bodyWeight)
              .fontColor(Colors.onSurface)
              .padding({
                left: Spacing.md,
                right: Spacing.md,
                top: Spacing.sm + 4, // 匹配 placeholder 垂直 padding
                bottom: Spacing.sm + 4
              })
              .width('100%')
              .height(120) // 对应 Kotlin 代码中的 height(120.dp)
              .backgroundColor(Colors.surfaceVariant) // unfocusedContainerColor 和 focusedContainerColor 相同
              .borderRadius(Shapes.medium)
              .border({
                width: 1,
                color: this.issueIsFocused ? Colors.primary : Colors.outline
              })
              .onFocus(() => {
                this.issueIsFocused = true;
              })
              .onBlur(() => {
                this.issueIsFocused = false;
              })
              .onChange((value: string) => {
                this.issue = value;
              })
          }
          .width('100%')
        }
        .width('100%') // 对应 Compose 的 fillMaxWidth()
        .alignItems(HorizontalAlign.Start) // 对应 VStack(alignment: .leading)
        // CustomCardStyle 修饰符：圆角、背景色和阴影
        .backgroundColor(Colors.surface)
        .borderRadius(Shapes.large)
        .shadow({
          radius: ElevationMapping.level2.radius,
          color: withOpacity(Colors.outline, ElevationMapping.level2.opacity),
          offsetX: 0,
          offsetY: ElevationMapping.level2.dy
        })

        // 提交按钮
        Button() {
          Text('Submit Request')
            .fontSize(TypographyTokens.titleSize)
            .fontWeight(TypographyTokens.titleWeight)
            .fontColor(Colors.onPrimary)
        }
        .width('100%') // 对应 Compose 的 fillMaxWidth()
        .height(56) // 对应 Compose 的 height(56.dp)
        .backgroundColor(Colors.primary)
        .borderRadius(Shapes.large)
        .onClick(() => {
          this.submitted = true;
        })

        // 提交成功消息
        if (this.submitted) {
          Text('Request submitted successfully!')
            .fontSize(TypographyTokens.bodySize)
            .fontWeight(TypographyTokens.bodyWeight)
            .fontColor(Colors.success)
            .width('100%') // 对应 Compose 的 fillMaxWidth()
            .padding(Spacing.lg)
            .backgroundColor(withOpacity(Colors.success, 0.15))
            .borderRadius(Shapes.medium)
            .textAlign(TextAlign.Center) // 对应 Alignment.Center
        }

        Blank() // 将内容推到顶部，模拟 Compose Column 的 fillMaxSize 行为
      }
      .width('100%')
      .height('100%')
      .padding(Spacing.lg) // 对应 Compose Column 上的 padding(Spacing.lg)
    }
    .width('100%')
    .height('100%')
    // .statusBarHidden(true) // 隐藏顶部状态栏 (iOS 16.0 兼容) —— ArkUI 中通过 expandSafeArea 或窗口 API 设置
  }
}

// MARK: - Font Extension
// Swift 中通过 extension Font 提供 pointSize 以便精确布局。
// ArkUI 中字体的点大小直接以 TypographyTokens 的 Size 字段表达（如 bodySize = 14），
// 故无需额外的 pointSize 扩展。
