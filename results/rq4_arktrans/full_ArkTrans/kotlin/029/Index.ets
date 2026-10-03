@Entry
@Component
struct Index {
  @State RecentFiles: string = 'Recent Files'
  @State fileManagerTitle: string = 'File Manager'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Text(this.fileManagerTitle)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
          .textAlign(TextAlign.Center)
          .width('100%')

        Column({ space: 16 }) {
          Text(this.RecentFiles)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111111')

          Grid() {
            // Card 1
            GridItem() {
              Column() {
                Stack({ alignContent: Alignment.Center }) {
                  Text('PDF').fontSize(16).fontColor('#111111')
                }
                .width('100%')
                .height(60)
                .backgroundColor('#EAEAEA')
                .borderRadius(8)

                Column({ space: 4 }) {
                  Text('Report.pdf').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#111111')
                  Text('2.1 MB').fontSize(14).fontColor('#555555')
                }
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            }

            // Card 2
            GridItem() {
              Column() {
                Stack({ alignContent: Alignment.Center }) {
                  Text('Spreadsheet').fontSize(16).fontColor('#111111')
                }
                .width('100%')
                .height(60)
                .backgroundColor('#EAEAEA')
                .borderRadius(8)

                Column({ space: 4 }) {
                  Text('Budget.xlsx').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#111111')
                  Text('1.2 MB').fontSize(14).fontColor('#555555')
                }
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            }

            // Card 3
            GridItem() {
              Column() {
                Stack({ alignContent: Alignment.Center }) {
                  Text('Image').fontSize(16).fontColor('#111111')
                }
                .width('100%')
                .height(60)
                .backgroundColor('#EAEAEA')
                .borderRadius(8)

                Column({ space: 4 }) {
                  Text('Design.psd').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#111111')
                  Text('4.7 MB').fontSize(14).fontColor('#555555')
                }
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            }

            // Card 4
            GridItem() {
              Column() {
                Stack({ alignContent: Alignment.Center }) {
                  Text('Slides').fontSize(16).fontColor('#111111')
                }
                .width('100%')
                .height(60)
                .backgroundColor('#EAEAEA')
                .borderRadius(8)

                Column({ space: 4 }) {
                  Text('Presentation.pptx').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#111111')
                  Text('1.2 MB').fontSize(14).fontColor('#555555')
                }
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            }

            // Card 5
            GridItem() {
              Column() {
                Stack({ alignContent: Alignment.Center }) {
                  Text('Text').fontSize(16).fontColor('#111111')
                }
                .width('100%')
                .height(60)
                .backgroundColor('#EAEAEA')
                .borderRadius(8)

                Column({ space: 4 }) {
                  Text('MeetingNotes.txt').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#111111')
                  Text('0.5 MB').fontSize(14).fontColor('#555555')
                }
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            }
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .width('100%')
        }
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}