class AppColors {
  static readonly primary: string = '#111111'
  static readonly secondary: string = '#333333'
  static readonly tertiary: string = '#555555'
  static readonly background: string = '#FFFFFF'
  static readonly surface: string = '#F9F9F9'
  static readonly surfaceVariant: string = '#EAEAEA'
  static readonly outline: string = '#D0D0D0'
  static readonly success: string = '#16A34A'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#DC2626'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#111111'
  static readonly onSurface: string = '#111111'
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
}

class AppRadius {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

class FileItem {
  name: string
  type: string
  size: string

  constructor(name: string, type: string, size: string) {
    this.name = name
    this.type = type
    this.size = size
  }
}

@Entry
@Component
struct Index {
  private files: FileItem[] = [
    new FileItem('Report.pdf', 'PDF', '2.1 MB'),
    new FileItem('Budget.xlsx', 'Spreadsheet', '1.2 MB'),
    new FileItem('Design.psd', 'Image', '4.7 MB'),
    new FileItem('Presentation.pptx', 'Slides', '5.4 MB'),
    new FileItem('MeetingNotes.txt', 'Text', '64 KB')
  ]

  build() {
    Column() {
      Row() {
        Text('File Manager')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(96)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Text('Recent Files')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .width('100%')

        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              FileCard({ file: file })
            }
            .height(120)
          }, (file: FileItem) => file.name)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.md)
        .rowsGap(AppSpacing.md)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: AppSpacing.lg
      })
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Component
struct FileCard {
  file: FileItem

  build() {
    Column() {
      Column() {
        Text(this.file.type)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .maxLines(1)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppRadius.medium)

      Column() {
        Text(this.file.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Clip })

        Text(this.file.size)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.tertiary)
          .width('100%')
          .maxLines(1)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}