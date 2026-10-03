// MARK: - AppTokens
// 集中管理应用程序的颜色、字体、形状、间距和阴影定义
namespace AppTokens {
  // 颜色定义
  export class Colors {
    static readonly primary: string = '#FF111111';
    static readonly secondary: string = '#FF333333';
    static readonly tertiary: string = '#FF555555';
    static readonly background: string = '#FFFFFFFF';
    static readonly surface: string = '#FFF9F9F9';
    static readonly surfaceVariant: string = '#FFEAEAEA';
    static readonly outline: string = '#FFD0D0D0';
    static readonly success: string = '#FF16A34A';
    static readonly warning: string = '#FFF59E0B';
    static readonly error: string = '#FFDC2626';
    static readonly onPrimary: string = '#FFFFFFFF';
    static readonly onSecondary: string = '#FFFFFFFF';
    static readonly onTertiary: string = '#FFFFFFFF';
    static readonly onBackground: string = '#FF111111';
    static readonly onSurface: string = '#FF111111';
  }

  // 字体样式定义
  export class TypographyTokens {
    static readonly displaySize: number = 26;
    static readonly displayWeight: FontWeight = FontWeight.Bold;
    static readonly titleSize: number = 18;
    static readonly titleWeight: FontWeight = FontWeight.Medium;
    static readonly bodySize: number = 14;
    static readonly bodyWeight: FontWeight = FontWeight.Normal;
    static readonly labelSize: number = 12;
    static readonly labelWeight: FontWeight = FontWeight.Medium;
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
      .fontSize(AppTokens.TypographyTokens.bodySize)
      .fontWeight(AppTokens.TypographyTokens.bodyWeight)
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
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.file.size)
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(AppTokens.TypographyTokens.labelWeight)
          .fontColor(AppTokens.Colors.tertiary)
      }
      .alignItems(HorizontalAlign.Start)
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
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(AppTokens.Spacing.totalAppBarHeight)
      .backgroundColor(AppTokens.Colors.background)

      // 主要内容区域
      Column() {
        Text('Recent Files')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
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
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
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
