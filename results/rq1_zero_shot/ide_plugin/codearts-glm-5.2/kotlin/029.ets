const AppColors = {
  primary: '#111111',
  secondary: '#333333',
  tertiary: '#555555',
  background: '#FFFFFF',
  surface: '#F9F9F9',
  surfaceVariant: '#EAEAEA',
  outline: '#D0D0D0',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#DC2626',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#111111',
  onSurface: '#111111'
}

const AppSpacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
}

interface FileItem {
  name: string
  type: string
  size: string
}

@Component
struct FileCard {
  private file: FileItem = { name: '', type: '', size: '' }

  build() {
    Column() {
      Text(this.file.type)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .height(60)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(10)
        .textAlign(TextAlign.Center)

      Column() {
        Text(this.file.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(this.file.size)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.tertiary)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(120)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Entry
@Component
struct Index {
  private files: FileItem[] = [
    { name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
    { name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
    { name: 'Design.psd', type: 'Image', size: '4.7 MB' },
    { name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
    { name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' }
  ]

  build() {
    Column() {
      Text('File Manager')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Text('Recent Files')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        Grid() {
          ForEach(this.files, (file: FileItem, index: number) => {
            GridItem() {
              FileCard({ file: file })
            }
          }, (file: FileItem, index: number) => index.toString())
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