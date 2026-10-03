class FileItem {
  name: string = '';
  type: string = '';
  size: string = '';

  constructor(name: string, type: string, size: string) {
    this.name = name;
    this.type = type;
    this.size = size;
  }
}

@Entry
@Component
struct FileManagerPage {
  @State files: FileItem[] = [
    new FileItem('Report.pdf', 'PDF', '2.1 MB'),
    new FileItem('Budget.xlsx', 'Spreadsheet', '1.2 MB'),
    new FileItem('Design.psd', 'Image', '4.7 MB'),
    new FileItem('Presentation.pptx', 'Slides', '5.4 MB'),
    new FileItem('MeetingNotes.txt', 'Text', '64 KB')
  ];

  @Builder
  FileCard(file: FileItem) {
    Column() {
      Stack() {
        Text(file.type)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#111111')
      }
      .width('100%')
      .height(60)
      .backgroundColor('#EAEAEA')
      .borderRadius(10)

      Column() {
        Text(file.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
        Text(file.size)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#555555')
      }
    }
    .width('100%')
    .height(120)
    .padding(12)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#F9F9F9')
    .borderRadius(14)
  }

  build() {
    Column() {
      Row() {
        Text('File Manager')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFFFF')

      Column() {
        Text('Recent Files')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
          .width('100%')
          .margin({ bottom: 16 })

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
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
