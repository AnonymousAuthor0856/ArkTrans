interface FileItem {
  name: string
  type: string
  size: string
}

@Entry
@Component
struct RootScreen {
  private files: FileItem[] = [
    { name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
    { name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
    { name: 'Design.psd', type: 'Image', size: '4.7 MB' },
    { name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
    { name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' }
  ]

  @Builder
  BoxView(text: string) {
    Text(text)
      .fontSize(14)
      .fontWeight(FontWeight.Normal)
      .fontColor('#111111')
      .width('100%')
      .textAlign(TextAlign.Center)
      .padding({ top: 6, bottom: 6, left: 8, right: 8 })
      .backgroundColor('#EAEAEA')
      .borderRadius(10)
  }

  @Builder
  FileCard(file: FileItem) {
    Column() {
      this.BoxView(file.type)
      Blank()
      Column({ space: 2 }) {
        Text(file.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
        Text(file.size)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#555555')
          .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .height(120)
    .width('100%')
    .backgroundColor('#F9F9F9')
    .borderRadius(14)
    .shadow({
      color: '#1F000000',
      radius: 4,
      offsetX: 0,
      offsetY: 2
    })
  }

  build() {
    Column({ space: 0 }) {
      Stack() {
        Text('File Manager')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
      }
      .width('100%')
      .height(100)
      .backgroundColor('#FFFFFF')
      .alignContent(Alignment.Center)

      Scroll() {
        Column({ space: 16 }) {
          Text('Recent Files')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111111')
            .width('100%')
            .textAlign(TextAlign.Start)

          Grid() {
            ForEach(this.files, (file: FileItem) => {
              GridItem() {
                this.FileCard(file)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .width('100%')
        }
        .alignItems(HorizontalAlign.Start)
        .padding(16)
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#FFFFFF')
      .align(Alignment.TopStart)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}