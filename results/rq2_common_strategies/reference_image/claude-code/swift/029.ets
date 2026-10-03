// Design tokens
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
  onSurface: '#111111',
};

const AppTypography = {
  display: { size: 26, weight: FontWeight.Bold },
  title: { size: 18, weight: FontWeight.Medium },
  body: { size: 14, weight: FontWeight.Regular },
  label: { size: 12, weight: FontWeight.Medium },
};

const AppShapes = {
  small: 6,
  medium: 10,
  large: 14,
};

const AppSpacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  totalAppBarHeight: 100,
};

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
      .fontSize(AppTypography.body.size)
      .fontWeight(AppTypography.body.weight)
      .fontColor(Color(AppColors.onSurface))
      .width('100%')
      .textAlign(TextAlign.Center)
      .backgroundColor(Color(AppColors.surfaceVariant))
      .borderRadius(AppShapes.medium)
  }
}

@Component
struct FileCard {
  file: FileItem = { id: '', name: '', type: '', size: '' };

  build() {
    Column() {
      BoxView({ text: this.file.type })

      Blank()

      Column({ space: 2 }) {
        Text(this.file.name)
          .fontSize(AppTypography.title.size)
          .fontWeight(AppTypography.title.weight)
          .fontColor(Color(AppColors.onSurface))
        Text(this.file.size)
          .fontSize(AppTypography.label.size)
          .fontWeight(AppTypography.label.weight)
          .fontColor(Color(AppColors.tertiary))
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(AppSpacing.md)
    .height(120)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color(AppColors.surface))
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: 2,
    })
  }
}

@Entry
@Component
struct RootScreen {
  private files: FileItem[] = [
    { id: '1', name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
    { id: '2', name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
    { id: '3', name: 'Design.psd', type: 'Image', size: '4.7 MB' },
    { id: '4', name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
    { id: '5', name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' },
  ];

  build() {
    Column() {
      Stack() {
        Text('File Manager')
          .fontSize(AppTypography.display.size)
          .fontWeight(AppTypography.display.weight)
          .fontColor(Color(AppColors.onSurface))
      }
      .width('100%')
      .height(AppSpacing.totalAppBarHeight)
      .backgroundColor(Color(AppColors.background))

      Column({ space: AppSpacing.lg }) {
        Text('Recent Files')
          .fontSize(AppTypography.title.size)
          .fontWeight(AppTypography.title.weight)
          .fontColor(Color(AppColors.primary))

        Grid() {
          ForEach(this.files, (item: FileItem) => {
            GridItem() {
              FileCard({ file: item })
            }
          }, (item: FileItem) => item.id)
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(AppSpacing.md)
        .columnsGap(AppSpacing.md)
        .width('100%')
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(Color(AppColors.background))
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color(AppColors.background))
  }
}
