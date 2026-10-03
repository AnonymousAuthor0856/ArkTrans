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
      Row() {
        Text('File Manager')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFFFF')

      Column() {
        Text('Recent Files')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
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
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  FileCard(file: FileItem) {
    Column() {
      Column() {
        Text(file.type)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#111111')
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#EAEAEA')
      .borderRadius(10)

      Column({ space: 2 }) {
        Text(file.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(file.size)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#555555')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 8 })
    }
    .width('100%')
    .height(120)
    .padding(12)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#F9F9F9')
    .borderRadius(14)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetY: 2
    })
  }
}

interface FileItem {
  name: string
  type: string
  size: string
}
