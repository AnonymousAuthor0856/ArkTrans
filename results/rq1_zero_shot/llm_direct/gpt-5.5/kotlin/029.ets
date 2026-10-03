const NAME: string = '030FileManageren'
const UI_TYPE: string = 'Productivity'
const STYLE_THEME: string = 'Monochrome'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

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

class AppTypographyTokens {
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
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16)
}

interface FileItem {
  name: string
  type: string
  size: string
}

@Component
struct FileCard {
  @Prop file: FileItem

  build() {
    Column() {
      Stack() {
        Text(this.file.type)
          .fontSize(AppTypographyTokens.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(60)
      .borderRadius(AppShapes.medium)
      .backgroundColor(AppColors.surfaceVariant)

      Column() {
        Text(this.file.name)
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.file.size)
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.tertiary)
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
    .borderRadius(AppShapes.large)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: AppElevationMapping.level1.radius,
      color: '#1F000000',
      offsetX: 0,
      offsetY: AppElevationMapping.level1.dy
    })
  }
}

@Entry
@Component
struct RootScreen {
  private files: FileItem[] = [
    { name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
    { name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
    { name: 'Design.psd', type: 'Image', size: '4.7 MB' },
    { name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
    { name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' }
  ]

  build() {
    Column() {
      Row() {
        Text('File Manager')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Text('Recent Files')
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .width('100%')

        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              FileCard({ file: file })
            }
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
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}