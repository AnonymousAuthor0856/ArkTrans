// AppTokens.ets
// 集中管理应用程序的颜色、字体、形状、间距和阴影定义
export class AppTokens {
  // 颜色定义，从 Kotlin 的 ARGB (0xFF...) 转换为 ArkUI 的 ResourceColor
  static readonly Colors = {
    primary: '#FF111111',
    secondary: '#FF333333',
    tertiary: '#FF555555',
    background: '#FFFFFFFF',
    surface: '#FFF9F9F9',
    surfaceVariant: '#FFEAEAEA',
    outline: '#FFD0D0D0',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFDC2626',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF111111',
    onSurface: '#FF111111'
  }

  // 字体样式定义，从 Kotlin 的 TextStyle 转换为 ArkUI 的 Font
  static readonly TypographyTokens = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  // 圆角形状定义，从 Kotlin 的 Dp 转换为 ArkUI 的 number
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  }

  // 间距定义，从 Kotlin 的 Dp 转换为 ArkUI 的 number
  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    // 自定义顶部应用栏高度，包括状态栏区域，以确保全屏显示时内容不被状态栏遮挡
    totalAppBarHeight: 100
  }

  // 阴影规格定义，从 Kotlin 的 ShadowSpec 转换为 ArkUI 的 shadow 参数
  static readonly ElevationMapping = {
    // Kotlin: ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
    // ArkUI: shadow({ radius, color, offsetX, offsetY })
    level1: {
      radius: 4,
      color: `#1F000000`, // 0.12 opacity black
      offsetX: 0,
      offsetY: 2
    },
    level2: {
      radius: 8,
      color: `#29000000`, // 0.16 opacity black
      offsetX: 0,
      offsetY: 4
    }
  }
}

// 文件项数据模型
export class FileItem {
  name: string;
  type: string;
  size: string;

  constructor(name: string, type: string, size: string) {
    this.name = name;
    this.type = type;
    this.size = size;
  }
}

// Components.ets
// 模拟 Kotlin Compose 中的 Box 控件，用于显示文件类型
@Component
export struct BoxView {
  private text: string = '';

  build() {
    Text(this.text)
      .fontSize(AppTokens.TypographyTokens.body.size)
      .fontWeight(AppTokens.TypographyTokens.body.weight)
      .fontColor(AppTokens.Colors.onSurface)
      .width('100%')
      .height(40)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium);
  }
}

// 模拟 Kotlin Compose 中的 Card 控件，用于显示单个文件信息
@Component
export struct FileCard {
  private file: FileItem = new FileItem('', '', '');

  build() {
    Column() {
      BoxView({ text: this.file.type })

      // 模拟 Arrangement.SpaceBetween，将上方 Box 和下方文本推开
      Blank()

      // 文件名和大小的垂直布局，小间距
      Column() {
        Text(this.file.name)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          
        Text(this.file.size)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.tertiary)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .height(120)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow(AppTokens.ElevationMapping.level1)
  }
}

// Pages/RootScreen.ets
// 应用程序的主屏幕视图
@Entry
@Component
struct RootScreen {
  private files: Array<FileItem> = [
    new FileItem('Report.pdf', 'PDF', '2.1 MB'),
    new FileItem('Budget.xlsx', 'Spreadsheet', '1.2 MB'),
    new FileItem('Design.psd', 'Image', '4.7 MB'),
    new FileItem('Presentation.pptx', 'Slides', '5.4 MB'),
    new FileItem('MeetingNotes.txt', 'Text', '64 KB')
  ];

  build() {
    Column() {
      // 自定义顶部应用栏，模拟 CenterAlignedTopAppBar
      Stack({ alignContent: Alignment.Center }) {
        // 顶部栏背景色
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(AppTokens.Colors.background)

        Text('File Manager')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(AppTokens.Spacing.totalAppBarHeight)
      .alignContent(Alignment.Center)

      // 主要内容区域
      Column() {
        Text('Recent Files')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.lg })

        // 垂直网格布局，两列，水平和垂直间距均为中等
        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              FileCard({ file: file })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppTokens.Spacing.md)
        .rowsGap(AppTokens.Spacing.md)
        .padding(0)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(AppTokens.Spacing.lg)
      .layoutWeight(1) // 填充剩余空间
      .width('100%')
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}