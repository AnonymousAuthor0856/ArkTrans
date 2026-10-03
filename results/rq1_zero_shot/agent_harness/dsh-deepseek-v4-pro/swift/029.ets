// AppTokens
class AppColors {
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

class AppTypography {
  static readonly displaySize: number = 26;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly totalAppBarHeight: number = 100;
}

class AppShadows {
  static readonly level1Color: string = '#1F000000';
  static readonly level1Radius: number = 4;
  static readonly level1Dy: number = 2;
  static readonly level2Color: string = '#29000000';
  static readonly level2Radius: number = 8;
  static readonly level2Dy: number = 4;
}

class FileItem {
  id: number;
  name: string;
  type: string;
  size: string;
  constructor(id: number, name: string, type: string, size: string) {
    this.id = id;
    this.name = name;
    this.type = type;
    this.size = size;
  }
}

// 模拟 Box 控件，用于显示文件类型
@Component
struct BoxView {
  text: string = '';

  build() {
    Text(this.text)
      .fontSize(AppTypography.bodySize)
      .fontWeight(AppTypography.bodyWeight)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)
  }
}

// 模拟 Card 控件，用于显示单个文件信息
@Component
struct FileCard {
  file: FileItem = new FileItem(0, '', '', '');

  build() {
    Column() {
      BoxView({ text: this.file.type })

      Blank()

      Column() {
        Text(this.file.name)
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onSurface)
        Blank().height(2)
        Text(this.file.size)
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.tertiary)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .width('100%')
    .height(120)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({ radius: AppShadows.level1Radius, color: AppShadows.level1Color, offsetX: 0, offsetY: AppShadows.level1Dy })
  }
}

@Component
struct RootScreen {
  files: FileItem[] = [
    new FileItem(1, 'Report.pdf', 'PDF', '2.1 MB'),
    new FileItem(2, 'Budget.xlsx', 'Spreadsheet', '1.2 MB'),
    new FileItem(3, 'Design.psd', 'Image', '4.7 MB'),
    new FileItem(4, 'Presentation.pptx', 'Slides', '5.4 MB'),
    new FileItem(5, 'MeetingNotes.txt', 'Text', '64 KB')
  ];

  build() {
    Column() {
      // 自定义顶部应用栏，模拟 CenterAlignedTopAppBar
      Stack() {
        Text('File Manager')
          .fontSize(AppTypography.displaySize)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(AppSpacing.totalAppBarHeight)
      .backgroundColor(AppColors.background)

      // 主要内容区域
      Column() {
        Text('Recent Files')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.primary)

        // 垂直网格布局，两列
        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              FileCard({ file: file })
            }
          }, (file: FileItem) => '' + file.id)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.md)
        .rowsGap(AppSpacing.md)
        .width('100%')
        .layoutWeight(1)
      }
      .alignItems(HorizontalAlign.Start)
      .space(AppSpacing.lg)
      .padding(AppSpacing.lg)
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
