@Entry
@Component
struct FileManagerPage {
  private files: FileItem[] = [
    new FileItem('Report.pdf', 'PDF', '2.1 MB'),
    new FileItem('Budget.xlsx', 'Spreadsheet', '1.2 MB'),
    new FileItem('Design.psd', 'Image', '4.7 MB'),
    new FileItem('Presentation.pptx', 'Slides', '5.4 MB'),
    new FileItem('MeetingNotes.txt', 'Text', '64 KB')
  ]

  build() {
    Column() {
      Text('File Manager')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF111111')
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 16, bottom: 24 })

      Column() {
        Text('Recent Files')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF111111')
          .width('100%')
          .margin({ bottom: 16 })

        Grid() {
          ForEach(this.files, (item: FileItem) => {
            GridItem() {
              this.FileCard(item)
            }
          }, (item: FileItem) => item.name)
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(12)
        .columnsGap(12)
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFFFF')
  }

  @Builder
  FileCard(item: FileItem) {
    Column() {
      Column() {
        Text(item.type)
          .fontSize(14)
          .fontColor('#FF111111')
      }
      .width('100%')
      .height(60)
      .backgroundColor('#FFEAEAEA')
      .borderRadius(10)
      .justifyContent(FlexAlign.Center)

      Column() {
        Text(item.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF111111')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
        Text(item.size)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF555555')
          .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 8 })
    }
    .width('100%')
    .height(120)
    .padding(12)
    .backgroundColor('#FFF9F9F9')
    .borderRadius(14)
    .justifyContent(FlexAlign.SpaceBetween)
    .shadow({
      radius: 4,
      color: '#1E000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

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
