// MARK: - AppTokens
// 集中管理应用程序的颜色、字体、形状、间距和阴影定义
// ArkTS 不支持 struct 嵌套与 namespace，Swift 中 AppTokens 下的嵌套类型
// 在 ArkTS 中转换为顶层类：Colors / TypographyTokens / Shapes / Spacing / ShadowSpec / ElevationMapping

// 颜色定义，从 Kotlin 的 ARGB (0xFF...) 转换为 ArkUI 的颜色字符串
class Colors {
  static readonly primary: string = '#111111';
  static readonly secondary: string = '#333333';
  static readonly tertiary: string = '#555555';
  static readonly background: string = '#FFFFFF';
  static readonly surface: string = '#F9F9F9';
  static readonly surfaceVariant: string = '#EAEAEA';
  static readonly outline: string = '#D0D0D0';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#DC2626';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#111111';
  static readonly onSurface: string = '#111111';
}

// 字体样式定义，从 Kotlin 的 TextStyle 转换为 ArkUI 的 fontSize / fontWeight
class TypographyTokens {
  static readonly display: number = 26;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly title: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly body: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal; // FontWeight.Normal 对应 SwiftUI 的 .regular
  static readonly label: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

// 圆角形状定义，从 Kotlin 的 Dp 转换为 ArkUI 的 number
class Shapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

// 间距定义，从 Kotlin 的 Dp 转换为 ArkUI 的 number
class Spacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;

  // 自定义顶部应用栏高度，包括状态栏区域，以确保全屏显示时内容不被状态栏遮挡
  // 假设状态栏高度约为 44pt (iPhone X/XS/XR/11/12/13/14系列) + 应用栏内容高度 56pt
  static readonly totalAppBarHeight: number = 100;
}

// 阴影规格定义，从 Kotlin 的 ShadowSpec 转换为 ArkUI 的 shadow 参数
class ShadowSpec {
  readonly elevation: number; // 在 SwiftUI 中通常映射为 y 偏移或与 radius 结合
  readonly radius: number;    // 在 ArkUI 中映射为模糊半径
  readonly dy: number;        // 在 ArkUI 中映射为 y 偏移
  readonly opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }

  // Color.black.opacity(Double(opacity)) 转换为带透明度的黑色颜色字符串
  swiftShadowColor(): string {
    const alpha: number = Math.round(this.opacity * 255);
    const alphaHex: string = alpha.toString(16).toUpperCase();
    const padded: string = alphaHex.length < 2 ? '0' + alphaHex : alphaHex;
    return '#' + padded + '000000';
  }
}

class ElevationMapping {
  // Kotlin: ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
  // SwiftUI: shadow(color: ..., radius: blurRadius, x: xOffset, y: yOffset)
  // 这里的 radius (4.dp) 映射到 ArkUI 的 blur radius，dy (2.dp) 映射到 ArkUI 的 y 偏移
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16);
}

// MARK: - Data Model
// 文件项数据模型，遵循 Identifiable 协议以便在 ForEach 中使用
class FileItem {
  readonly id: string; // 唯一标识符
  readonly name: string;
  readonly type: string;
  readonly size: string;
  private static nextId: number = 0;

  constructor(name: string, type: string, size: string) {
    FileItem.nextId += 1;
    this.id = FileItem.nextId.toString();
    this.name = name;
    this.type = type;
    this.size = size;
  }
}

// MARK: - Components
// 模拟 Kotlin Compose 中的 Box 控件，用于显示文件类型
@Component
struct BoxView {
  text: string = '';

  build() {
    Text(this.text)
      .fontSize(TypographyTokens.body)
      .fontWeight(TypographyTokens.bodyWeight)
      .fontColor(Colors.onSurface)
      .width('100%') // 填充宽度，固定高度
      .backgroundColor(Colors.surfaceVariant)
      .borderRadius(Shapes.medium)
  }
}

// 模拟 Kotlin Compose 中的 Card 控件，用于显示单个文件信息
@Component
struct FileCard {
  file: FileItem = new FileItem('', '', '');

  build() {
    Column() { // 垂直布局，内容左对齐
      BoxView({ text: this.file.type })

      Blank() // 模拟 Arrangement.SpaceBetween，将上方 Box 和下方文本推开

      Column({ space: 2 }) { // 文件名和大小的垂直布局，小间距
        Text(this.file.name)
          .fontSize(TypographyTokens.title)
          .fontWeight(TypographyTokens.titleWeight)
          .fontColor(Colors.onSurface)
        Text(this.file.size)
          .fontSize(TypographyTokens.label)
          .fontWeight(TypographyTokens.labelWeight)
          .fontColor(Colors.tertiary)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(Spacing.md) // 卡片内部填充
    .height(120) // 卡片固定高度
    .backgroundColor(Colors.surface) // 卡片背景色
    .borderRadius(Shapes.large) // 卡片圆角
    .shadow({
      radius: ElevationMapping.level1.radius, // 阴影模糊半径
      color: ElevationMapping.level1.swiftShadowColor(),
      offsetX: 0,
      offsetY: ElevationMapping.level1.dy // 阴影 Y 轴偏移
    })
  }
}

// MARK: - Root Screen
// 应用程序的主屏幕视图
@Entry
@Component
struct RootScreen {
  // 示例文件数据
  files: FileItem[] = [
    new FileItem('Report.pdf', 'PDF', '2.1 MB'),
    new FileItem('Budget.xlsx', 'Spreadsheet', '1.2 MB'),
    new FileItem('Design.psd', 'Image', '4.7 MB'),
    new FileItem('Presentation.pptx', 'Slides', '5.4 MB'),
    new FileItem('MeetingNotes.txt', 'Text', '64 KB')
  ];

  build() {
    Column() { // 根垂直布局，无默认间距
      // 自定义顶部应用栏，模拟 CenterAlignedTopAppBar
      Stack() {
        Text('File Manager')
          .fontSize(TypographyTokens.display)
          .fontWeight(TypographyTokens.displayWeight)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(Spacing.totalAppBarHeight) // 固定顶部栏高度，覆盖状态栏区域
      .backgroundColor(Colors.background) // 顶部栏背景色

      // 主要内容区域
      Column({ space: Spacing.lg }) { // 垂直布局，内容左对齐，大间距
        Text('Recent Files')
          .fontSize(TypographyTokens.title)
          .fontWeight(TypographyTokens.titleWeight)
          .fontColor(Colors.primary)

        // 垂直网格布局，两列，水平和垂直间距均为中等
        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              FileCard({ file: file })
            }
          }, (file: FileItem) => file.id)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(Spacing.md)
        .rowsGap(Spacing.md)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(Spacing.lg) // 整个内容区域的内边距
      .width('100%')
      .layoutWeight(1) // 填充剩余空间，内容顶部左对齐
      .backgroundColor(Colors.background) // 内容区域背景色
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]) // 使整个视图忽略安全区域，实现全屏显示
    .backgroundColor(Colors.background) // 整个屏幕的背景色
  }
}

// MARK: - App Entry Point
// 应用程序的入口点
// Swift 中的 @main App / WindowGroup / statusBar(hidden:true) 在 ArkTS 中
// 由 @Entry 组件 RootScreen 承担入口职责，状态栏隐藏需通过窗口系统栏 API 配置。

// MARK: - Preview
// SwiftUI 预览提供器 (PreviewProvider) 是 Xcode 开发期功能，ArkTS 无对应物，省略。
