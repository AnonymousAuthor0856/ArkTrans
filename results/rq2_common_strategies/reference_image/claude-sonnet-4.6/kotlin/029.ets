/*
 * 030FileManageren — Productivity
 * Style: Monochrome | Lang: en | Baseline: 720x1280
 *
 * Edge-to-edge parity with the Compose source (system bars hidden) is done in
 * EntryAbility.onWindowStageCreate:
 *   const win = windowStage.getMainWindowSync();
 *   win.setWindowLayoutFullScreen(true);
 *   win.setWindowSystemBarEnable([]);
 */

const NAME: string = '030FileManageren';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Monochrome';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

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

class AppTypographyTokens {
  static readonly displaySize: number = 26;   // sp
  static readonly titleSize: number = 18;     // sp
  static readonly bodySize: number = 14;      // sp
  static readonly labelSize: number = 12;     // sp

  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 6;   // vp
  static readonly medium: number = 10; // vp
  static readonly large: number = 14;  // vp
}

class AppSpacing {
  static readonly sm: number = 8;   // vp
  static readonly md: number = 12;  // vp
  static readonly lg: number = 16;  // vp
  static readonly xl: number = 24;  // vp
}

class ShadowSpec {
  readonly elevation: number;
  readonly radius: number;
  readonly dy: number;
  readonly opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }

  color(): string {
    return `rgba(0, 0, 0, ${this.opacity})`;
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16);
}

class FileItem {
  readonly name: string;
  readonly type: string;
  readonly size: string;

  constructor(name: string, type: string, size: string) {
    this.name = name;
    this.type = type;
    this.size = size;
  }
}

@Entry
@Component
struct RootScreen {
  private files: FileItem[] = [
    new FileItem('Report.pdf', 'PDF', '2.1 MB'),
    new FileItem('Budget.xlsx', 'Spreadsheet', '1.2 MB'),
    new FileItem('Design.psd', 'Image', '4.7 MB'),
    new FileItem('Presentation.pptx', 'Slides', '5.4 MB'),
    new FileItem('MeetingNotes.txt', 'Text', '64 KB')
  ];

  @Builder
  FileCard(file: FileItem) {
    Column() {
      // Preview / type chip
      Row() {
        Text(file.type)
          .fontSize(AppTypographyTokens.bodySize)
          .fontWeight(AppTypographyTokens.bodyWeight)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)

      // Name + size
      Column() {
        Text(file.name)
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(AppTypographyTokens.titleWeight)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Start)

        Text(file.size)
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(AppTypographyTokens.labelWeight)
          .fontColor(AppColors.tertiary)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: 2 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(120)
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevationMapping.level1.radius,
      color: AppElevationMapping.level1.color(),
      offsetX: 0,
      offsetY: AppElevationMapping.level1.dy
    })
  }

  build() {
    Column() {
      // Top app bar — "File Manager"
      Row() {
        Text('File Manager')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(AppTypographyTokens.displayWeight)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      // Body
      Column({ space: AppSpacing.lg }) {
        Text('Recent Files')
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(AppTypographyTokens.titleWeight)
          .fontColor(AppColors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              this.FileCard(file)
            }
          }, (file: FileItem) => file.name)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.md)
        .rowsGap(AppSpacing.md)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}