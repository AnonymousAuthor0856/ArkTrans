const Colors = {
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
};

const Spacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
};

interface FileItem {
  name: string;
  type: string;
  size: string;
}

@Entry
@Component
struct Index {
  @State files: FileItem[] = [
    { name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
    { name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
    { name: 'Design.psd', type: 'Image', size: '4.7 MB' },
    { name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
    { name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' }
  ];

  build() {
    Column() {
      Row() {
        Text('File Manager')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Colors.background)

      Column() {
        Text('Recent Files')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.primary)

        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              Column() {
                Column() {
                  Text(file.type)
                    .fontSize(14)
                    .fontColor(Colors.onSurface)
                }
                .width('100%')
                .height(60)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(10)

                Column() {
                  Text(file.name)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text(file.size)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.tertiary)
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .height('100%')
              .padding(Spacing.md)
              .justifyContent(FlexAlign.SpaceBetween)
            }
            .height(120)
            .backgroundColor(Colors.surface)
            .borderRadius(14)
            .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.12)', offsetY: 2 })
          }, (file: FileItem) => file.name)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(Spacing.md)
        .rowsGap(Spacing.md)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.lg)
      .space(Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
