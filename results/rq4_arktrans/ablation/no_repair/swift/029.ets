@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Stack() {
          Text('File Manager').fontColor('#111111').fontSize(26)
        }.height(80)

        Column() {
          Text('Recent Files').fontColor('#111111').fontSize(18)

          Grid() {
            ForEach([
              { type: 'PDF', name: 'Report.pdf', size: '2.1 MB' },
              { type: 'Spreadsheet', name: 'Budget.xlsx', size: '1.2 MB' },
              { type: 'Image', name: 'Design.psd', size: '4.7 MB' },
              { type: 'Slides', name: 'Presentation.pptx', size: '5.4 MB' },
              { type: 'Text', name: 'MeetingNotes.txt', size: '64 KB' }
            ], (item: FileItem) => {
              GridItem() {
                Column() {
                  BoxView({ text: item.type })
                  Blank()
                  Column({ space: 2 }) {
                    Text(item.name).fontColor('#111111').fontSize(18)
                    Text(item.size).fontColor('#999999').fontSize(14)
                  }
                }.padding(16).height(120).backgroundColor('#F5F5F5').borderRadius(16).shadow({ radius: 4, color: '#1F000000' })
              }
            })
          }.columnsTemplate('1fr 1fr').columnsGap(16).rowsGap(16).width('100%')
        }.width('100%').layoutWeight(1).padding(16).backgroundColor('#FFFFFF')
      }.width('100%').height('100%').backgroundColor('#FFFFFF')
    }.width('100%').height('100%')
  }
}

interface FileItem {
  type: string
  name: string
  size: string
}

@Component
struct BoxView {
  private text: string = ''

  build() {
    Text(this.text)
      .textAlign(TextAlign.Center)
      .width('100%')
      .height(32)
      .backgroundColor('#EAEAEA')
      .borderRadius(16)
      .fontSize(16)
      .fontColor('#333333')
  }
}