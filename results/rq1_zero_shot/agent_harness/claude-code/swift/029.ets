// MARK: - AppTokens
// 集中管理应用程序的颜色、字体、形状、间距和阴影定义
namespace AppTokens {
  // 颜色定义
  export class Colors {
    static readonly primary: Color = Color.Black; // 0x111111
    static readonly secondary: Color = Color.rgb(0x33, 0x33, 0x33);
    static readonly tertiary: Color = Color.rgb(0x55, 0x55, 0x55);
    static readonly background: Color = Color.White;
    static readonly surface: Color = Color.rgb(0xF9, 0xF9, 0xF9);
    static readonly surfaceVariant: Color = Color.rgb(0xEA, 0xEA, 0xEA);
    static readonly outline: Color = Color.rgb(0xD0, 0xD0, 0xD0);
    static readonly success: Color = Color.rgb(0x16, 0xA3, 0x4A);
    static readonly warning: Color = Color.rgb(0xF5, 0x9E, 0x0B);
    static readonly error: Color = Color.rgb(0xDC, 0x26, 0x26);
    static readonly onPrimary: Color = Color.White;
    static readonly onSecondary: Color = Color.White;
    static readonly onTertiary: Color = Color.White;
    static readonly onBackground: Color = Color.rgb(0x11, 0x11, 0x11);
    static readonly onSurface: Color = Color.rgb(0x11, 0x11, 0x11);
  }

  // 字体样式定义
  export class TypographyTokens {
    static readonly display: Font = Font.Size(26).Weight(FontWeight.Bold);
    static readonly title: Font = Font.Size(18).Weight(FontWeight.Medium);
    static readonly body: Font = Font.Size(14).Weight(FontWeight.Normal);
    static readonly label: Font = Font.Size(12).Weight(FontWeight.Medium);
  }

  // 圆角形状定义
  export class Shapes {
    static readonly small: number = 6;
    static readonly medium: number = 10;
    static readonly large: number = 14;
  }

  // 间距定义
  export class Spacing {
    static readonly sm: number = 8;
    static readonly md: number = 12;
    static readonly lg: number = 16;
    static readonly xl: number = 24;
    static readonly totalAppBarHeight: number = 100;
  }

  // 阴影规格定义
  export class ShadowSpec {
    elevation: number;
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

  export class ElevationMapping {
    static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
    static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16);
  }
}

// MARK: - Data Model
// 文件项数据模型
interface FileItem {
  id: string;
  name: string;
  type: string;
  size: string;
}

// MARK: - Components
// 模拟 Kotlin Compose 中的 Box 控件，用于显示文件类型
@Component
struct BoxView {
  text: string = '';

  build() {
    Text(this.text)
      .font(AppTokens.TypographyTokens.body)
      .fontColor(AppTokens.Colors.onSurface)
      .width('100%')
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
  }
}

// 模拟 Kotlin Compose 中的 Card 控件，用于显示单个文件信息
@Component
struct FileCard {
  file: FileItem = { id: '', name: '', type: '', size: '' };

  build() {
    Column() {
      BoxView({ text: this.file.type })

      Blank()

      Column() {
        Text(this.file.name)
          .font(AppTokens.TypographyTokens.title)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.file.size)
          .font(AppTokens.TypographyTokens.label)
          .fontColor(AppTokens.Colors.tertiary)
      }
      .alignItems(HorizontalAlign.Start)
      .space(2)
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(AppTokens.Spacing.md)
    .height(120)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
      radius: AppTokens.ElevationMapping.level1.radius,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

// MARK: - Root Screen
// 应用程序的主屏幕视图
@Entry
@Component
struct RootScreen {
  // 示例文件数据
  private files: FileItem[] = [
    { id: '1', name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
    { id: '2', name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
    { id: '3', name: 'Design.psd', type: 'Image', size: '4.7 MB' },
    { id: '4', name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
    { id: '5', name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' }
  ];

  build() {
    Column() {
      // 自定义顶部应用栏，模拟 CenterAlignedTopAppBar
      Stack() {
        Text('File Manager')
          .font(AppTokens.TypographyTokens.display)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(AppTokens.Spacing.totalAppBarHeight)
      .backgroundColor(AppTokens.Colors.background)

      // 主要内容区域
      Column() {
        Text('Recent Files')
          .font(AppTokens.TypographyTokens.title)
          .fontColor(AppTokens.Colors.primary)

        // 垂直网格布局，两列
        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              FileCard({ file: file })
            }
          }, (file: FileItem) => file.id)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppTokens.Spacing.md)
        .rowsGap(AppTokens.Spacing.md)
      }
      .alignItems(HorizontalAlign.Start)
      .space(AppTokens.Spacing.lg)
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
