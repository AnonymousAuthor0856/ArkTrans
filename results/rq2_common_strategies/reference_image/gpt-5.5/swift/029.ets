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

class AppTypography {
  static readonly displaySize: number = 26
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly totalAppBarHeight: number = 100
}

class FileItem {
  readonly id: string
  readonly name: string
  readonly type: string
  readonly size: string

  constructor(name: string, type: string, size: string) {
    this.id = `${name}-${type}-${size}`
    this.name = name
    this.type = type
    this.size = size
  }
}

@Component
struct BoxView {
  text: string = ''

  build() {
    Text(this.text)
      .fontSize(AppTypography.bodySize)
      .fontWeight(FontWeight.Regular)
      .fontColor(AppColors.onSurface)
      .textAlign(TextAlign.Center)
      .width('100%')
      .height(18)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)
  }
}

@Component
struct FileCard {
  file: FileItem = new FileItem('', '', '')

  build() {
    Column() {
      BoxView({ text: this.file.type })

      Column({ space: 2 }) {
        Text(this.file.name)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Clip })

        Text(this.file.size)
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.tertiary)
          .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .width('100%')
    .height(120)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

@Entry
@Component
struct RootScreen {
  private readonly files: FileItem[] = [
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
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(AppSpacing.totalAppBarHeight)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Text('Recent Files')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
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
        .layoutWeight(1)
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
  }
}