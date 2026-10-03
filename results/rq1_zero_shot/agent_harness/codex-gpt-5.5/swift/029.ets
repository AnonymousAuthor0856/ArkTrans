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
struct RootScreen {
  private files: FileItem[] = [
    new FileItem('Report.pdf', 'PDF', '2.1 MB'),
    new FileItem('Budget.xlsx', 'Spreadsheet', '1.2 MB'),
    new FileItem('Design.psd', 'Image', '4.7 MB'),
    new FileItem('Presentation.pptx', 'Slides', '5.4 MB'),
    new FileItem('MeetingNotes.txt', 'Text', '64 KB')
  ];

  @Builder
  BoxView(textValue: string) {
    Text(textValue)
      .fontSize(14)
      .fontColor('#111111')
      .width('100%')
      .height(38)
      .textAlign(TextAlign.Center)
      .backgroundColor('#EAEAEA')
      .borderRadius(10)
  }

  @Builder
  FileCard(file: FileItem) {
    Column() {
      this.BoxView(file.type)
      Blank()
      Column() {
        Text(file.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
        Text(file.size)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#555555')
          .margin({ top: 2 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .height(120)
    .padding(12)
    .backgroundColor('#F9F9F9')
    .borderRadius(14)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      Stack() {
        Rect()
          .width('100%')
          .height(100)
          .fill('#FFFFFF')
        Text('File Manager')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
      }
      .height(100)

      Column() {
        Text('Recent Files')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
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
        .margin({ top: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
