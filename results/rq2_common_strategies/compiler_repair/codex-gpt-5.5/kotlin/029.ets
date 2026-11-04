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

class FileColors {
  static primary: string = '#111111';
  static secondary: string = '#333333';
  static tertiary: string = '#555555';
  static background: string = '#FFFFFF';
  static surface: string = '#F9F9F9';
  static surfaceVariant: string = '#EAEAEA';
  static outline: string = '#D0D0D0';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#111111';
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
  ];

  @Builder
  FileCard(file: FileItem) {
    Column() {
      Column() {
        Text(file.type)
          .fontSize(14)
          .fontColor(FileColors.onSurface)
          .lineHeight(20)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(FileColors.surfaceVariant)
      .borderRadius(10)

      Column() {
        Text(file.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(FileColors.onSurface)
          .lineHeight(24)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(file.size)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(FileColors.tertiary)
          .lineHeight(16)
      }
      .width('100%')
      .margin({ top: 8 })
    }
    .width('100%')
    .height(120)
    .padding(12)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(FileColors.surface)
    .borderRadius(14)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      Text('File Manager')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(FileColors.onSurface)
        .lineHeight(32)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Column() {
        Text('Recent Files')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(FileColors.primary)
          .lineHeight(24)
          .width('100%')

        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              this.FileCard(file)
            }
          }, (file: FileItem) => file.name)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .width('100%')
        .layoutWeight(1)
        .margin({ top: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(FileColors.background)
  }
}
