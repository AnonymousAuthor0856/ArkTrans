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

  @Builder
  FileTypeBox(type: string) {
    Text(type)
      .fontSize(14)
      .fontColor('#111111')
      .textAlign(TextAlign.Center)
      .width('100%')
      .height(42)
      .backgroundColor('#EAEAEA')
      .borderRadius(10)
  }

  @Builder
  FileCard(file: FileItem) {
    Column() {
      this.FileTypeBox(file.type)

      Blank()

      Column() {
        Text(file.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')

        Text(file.size)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#555555')
          .margin({ top: 2 })
          .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .height(120)
    .width('100%')
    .padding(12)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#F9F9F9')
    .borderRadius(14)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }

  build() {
    Column() {
      Stack() {
        Text('File Manager')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
      }
      .width('100%')
      .height(100)
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
      }
      .layoutWeight(1)
      .width('100%')
      .padding(16)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
