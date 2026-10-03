import { LengthMetrics } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: ResourceColor = '#FF111111';
  static readonly secondary: ResourceColor = '#FF333333';
  static readonly tertiary: ResourceColor = '#FF555555';
  static readonly background: ResourceColor = '#FFFFFFFF';
  static readonly surface: ResourceColor = '#FFF9F9F9';
  static readonly surfaceVariant: ResourceColor = '#FFEAEAEA';
  static readonly outline: ResourceColor = '#FFD0D0D0';
  static readonly success: ResourceColor = '#FF16A34A';
  static readonly warning: ResourceColor = '#FFF59E0B';
  static readonly error: ResourceColor = '#FFDC2626';
  static readonly onPrimary: ResourceColor = '#FFFFFFFF';
  static readonly onSecondary: ResourceColor = '#FFFFFFFF';
  static readonly onTertiary: ResourceColor = '#FFFFFFFF';
  static readonly onBackground: ResourceColor = '#FF111111';
  static readonly onSurface: ResourceColor = '#FF111111';
}

class AppTypography {
  static readonly display: number = 26;
  static readonly title: number = 18;
  static readonly body: number = 14;
  static readonly label: number = 12;
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

class ShadowSpec {
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

  get shadowColor(): ResourceColor {
    const alpha = Math.round(this.opacity * 255).toString(16).padStart(2, '0').toUpperCase();
    return `#${alpha}000000`;
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16);
}

// MARK: - Data Model
class FileItem {
  id: string;
  name: string;
  type: string;
  size: string;

  constructor(id: string, name: string, type: string, size: string) {
    this.id = id;
    this.name = name;
    this.type = type;
    this.size = size;
  }
}

// MARK: - Components
@Component
struct BoxView {
  text: string = '';

  build() {
    Text(this.text)
      .fontSize(AppTypography.body)
      .fontWeight(FontWeight.Normal)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)
      .textAlign(TextAlign.Center)
      .padding({
        top: AppSpacing.sm,
        bottom: AppSpacing.sm,
        left: AppSpacing.sm,
        right: AppSpacing.sm
      })
  }
}

@Component
struct FileCard {
  file: FileItem = new FileItem('', '', '', '');

  build() {
    Column({ space: 0 }) {
      BoxView({ text: this.file.type })

      Blank()
        .layoutWeight(1)

      Column({ space: 2 }) {
        Text(this.file.name)
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')

        Text(this.file.size)
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.tertiary)
          .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .height(120)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      color: AppElevation.level1.shadowColor,
      radius: AppElevation.level1.radius,
      offsetX: 0,
      offsetY: AppElevation.level1.dy
    })
  }
}

// MARK: - Root Screen
@Entry
@Component
struct RootScreen {
  private files: FileItem[] = [
    new FileItem('1', 'Report.pdf', 'PDF', '2.1 MB'),
    new FileItem('2', 'Budget.xlsx', 'Spreadsheet', '1.2 MB'),
    new FileItem('3', 'Design.psd', 'Image', '4.7 MB'),
    new FileItem('4', 'Presentation.pptx', 'Slides', '5.4 MB'),
    new FileItem('5', 'MeetingNotes.txt', 'Text', '64 KB'),
  ];

  build() {
    Column({ space: 0 }) {
      // Top App Bar
      Stack() {
        Text('File Manager')
          .fontSize(AppTypography.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(AppSpacing.totalAppBarHeight)
      .backgroundColor(AppColors.background)

      // Main Content
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Recent Files')
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // 2-column grid
          GridRow({ columns: 2, gutter: { x: LengthMetrics.vp(AppSpacing.md), y: LengthMetrics.vp(AppSpacing.md) } }) {
            ForEach(this.files, (file: FileItem) => {
              GridCol({ span: 1 }) {
                FileCard({ file: file })
              }
            }, (file: FileItem) => file.id)
          }
          .width('100%')
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppSpacing.lg)
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppColors.background)
      .align(Alignment.TopStart)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}