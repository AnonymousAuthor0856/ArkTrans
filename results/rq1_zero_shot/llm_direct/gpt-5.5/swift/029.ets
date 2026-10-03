import window from '@ohos.window';

class AppColors {
  static readonly primary: ResourceColor = '#111111';
  static readonly secondary: ResourceColor = '#333333';
  static readonly tertiary: ResourceColor = '#555555';
  static readonly background: ResourceColor = '#FFFFFF';
  static readonly surface: ResourceColor = '#F9F9F9';
  static readonly surfaceVariant: ResourceColor = '#EAEAEA';
  static readonly outline: ResourceColor = '#D0D0D0';
  static readonly success: ResourceColor = '#16A34A';
  static readonly warning: ResourceColor = '#F59E0B';
  static readonly error: ResourceColor = '#DC2626';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#FFFFFF';
  static readonly onTertiary: ResourceColor = '#FFFFFF';
  static readonly onBackground: ResourceColor = '#111111';
  static readonly onSurface: ResourceColor = '#111111';
}

class AppTypographyTokens {
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

  get arkShadowColor(): ResourceColor {
    return `rgba(0, 0, 0, ${this.opacity})`;
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16);
}

interface FileItem {
  id: string;
  name: string;
  type: string;
  size: string;
}

@Component
struct BoxView {
  text: string = '';

  build() {
    Text(this.text)
      .fontSize(AppTypographyTokens.bodySize)
      .fontWeight(AppTypographyTokens.bodyWeight)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)
      .textAlign(TextAlign.Center)
  }
}

@Component
struct FileCard {
  file: FileItem = {
    id: '',
    name: '',
    type: '',
    size: ''
  };

  build() {
    Column() {
      BoxView({ text: this.file.type })

      Blank()

      Column({ space: 2 }) {
        Text(this.file.name)
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(AppTypographyTokens.titleWeight)
          .fontColor(AppColors.onSurface)

        Text(this.file.size)
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(AppTypographyTokens.labelWeight)
          .fontColor(AppColors.tertiary)
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
      radius: AppElevationMapping.level1.radius,
      color: AppElevationMapping.level1.arkShadowColor,
      offsetX: 0,
      offsetY: AppElevationMapping.level1.dy
    })
  }
}

@Component
struct RootScreen {
  private files: FileItem[] = [
    { id: '1', name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
    { id: '2', name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
    { id: '3', name: 'Design.psd', type: 'Image', size: '4.7 MB' },
    { id: '4', name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
    { id: '5', name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' }
  ];

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text('File Manager')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(AppTypographyTokens.displayWeight)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(AppSpacing.totalAppBarHeight)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Text('Recent Files')
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(AppTypographyTokens.titleWeight)
          .fontColor(AppColors.primary)

        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              FileCard({ file: file })
            }
          }, (file: FileItem) => file.id)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.md)
        .rowsGap(AppSpacing.md)
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .padding(AppSpacing.lg)
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Entry
@Component
struct SingleFileUIApp {
  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    }).catch(() => {
    });
  }

  build() {
    RootScreen()
  }
}