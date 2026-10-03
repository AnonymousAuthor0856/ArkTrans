import { router } from '@kit.ArkUI';

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

const AppSpacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
};

const AppRadius = {
  small: 6,
  medium: 10,
  large: 14,
};

interface FileItem {
  name: string;
  type: string;
  size: string;
}

const files: FileItem[] = [
  { name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
  { name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
  { name: 'Design.psd', type: 'Image', size: '4.7 MB' },
  { name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
  { name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' },
];

@Component
struct FileCard {
  file: FileItem = { name: '', type: '', size: '' };

  build() {
    Column() {
      // Type icon area
      Row() {
        Text(this.file.type)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(60)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppRadius.medium)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // File info
      Column() {
        Text(this.file.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')

        Text(this.file.size)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.tertiary)
          .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(120)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2,
    })
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('File Manager')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.background)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Content
      Column() {
        // Section title
        Text('Recent Files')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .width('100%')
          .margin({ bottom: AppSpacing.lg })

        // Grid of files
        Grid() {
          ForEach(files, (file: FileItem) => {
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
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}