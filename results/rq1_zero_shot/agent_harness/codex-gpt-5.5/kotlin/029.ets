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

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class FileItem {
  name: string;
  type: string;
  size: string;

  constructor(name: string, type: string, size: string) {
    this.name = name;
    this.type = type;
    this.size = size;
  }
}

@Entry
@Component
struct MainActivity {
  private files: FileItem[] = [
    new FileItem('Report.pdf', 'PDF', '2.1 MB'),
    new FileItem('Budget.xlsx', 'Spreadsheet', '1.2 MB'),
    new FileItem('Design.psd', 'Image', '4.7 MB'),
    new FileItem('Presentation.pptx', 'Slides', '5.4 MB'),
    new FileItem('MeetingNotes.txt', 'Text', '64 KB')
  ];

  @Builder
  Header(): void {
    Text('File Manager')
      .fontSize(26)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  FileCard(file: FileItem): void {
    Column() {
      Stack() {
        Text(file.type)
          .fontSize(14)
          .fontColor(AppColors.onSurface);
      }
      .width('100%')
      .height(60)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(10)
      .alignContent(Alignment.Center);
      Column() {
        Text(file.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Text(file.size)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.tertiary);
      }
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%')
    .height(120)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.lg }) {
        Text('Recent Files')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary);
        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              this.FileCard(file);
            }
          }, (file: FileItem) => file.name)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.md)
        .rowsGap(AppSpacing.md)
        .layoutWeight(1);
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
