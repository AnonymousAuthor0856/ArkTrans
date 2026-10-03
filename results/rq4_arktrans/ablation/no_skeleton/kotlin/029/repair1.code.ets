@Entry
@Component
struct FileManager {
  build() {
    Stack() {
      Column() {
        .width('100%')
        .height('100%')
        .padding(16)
        .backgroundColor('#FFF')
        .space(16)

        Text('File Manager')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111')
          .textAlign(TextAlign.Center)

        Column() {
          .width('100%')
          .layoutWeight(1)
          .space(16)

          Text('Recent Files')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111')

          Grid() {
            .columnsTemplate('1fr 1fr')
            .columnsGap(12)
            .rowsGap(12)
            .width('100%')

            GridItem() {
              Column() {
                .width('100%')
                .height(120)
                .padding(12)
                .backgroundColor('#F9F9F9')
                .borderRadius(14)
                .shadow({ radius: 4, color: '#1F000000' })
                .space(4)

                Row() {
                  .width('100%')
                  .height(60)
                  .backgroundColor('#EAEAEA')
                  .borderRadius(10)
                  .justifyContent(FlexAlign.Center)
                  .alignItems(ItemAlign.Center)
                  .space(8)

                  Text('PDF')
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#111')
                }

                Column() {
                  .width('100%')
                  .space(2)

                  Text('Report.pdf')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111')

                  Text('2.1 MB')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#555')
                }
              }
            }

            GridItem() {
              Column() {
                .width('100%')
                .height(120)
                .padding(12)
                .backgroundColor('#F9F9F9')
                .borderRadius(14)
                .shadow({ radius: 4, color: '#1F000000' })
                .space(4)

                Row() {
                  .width('100%')
                  .height(60)
                  .backgroundColor('#EAEAEA')
                  .borderRadius(10)
                  .justifyContent(FlexAlign.Center)
                  .alignItems(ItemAlign.Center)
                  .space(8)

                  Text('Spreadsheet')
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#111')
                }

                Column() {
                  .width('100%')
                  .space(2)

                  Text('Budget.xlsx')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111')

                  Text('1.2 MB')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#555')
                }
              }
            }

            GridItem() {
              Column() {
                .width('100%')
                .height(120)
                .padding(12)
                .backgroundColor('#F9F9F9')
                .borderRadius(14)
                .shadow({ radius: 4, color: '#1F000000' })
                .space(4)

                Row() {
                  .width('100%')
                  .height(60)
                  .backgroundColor('#EAEAEA')
                  .borderRadius(10)
                  .justifyContent(FlexAlign.Center)
                  .alignItems(ItemAlign.Center)
                  .space(8)

                  Text('Image')
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#111')
                }

                Column() {
                  .width('100%')
                  .space(2)

                  Text('Design.psd')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111')

                  Text('4.7 MB')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#555')
                }
              }
            }

            GridItem() {
              Column() {
                .width('100%')
                .height(120)
                .padding(12)
                .backgroundColor('#F9F9F9')
                .borderRadius(14)
                .shadow({ radius: 4, color: '#1F000000' })
                .space(4)

                Row() {
                  .width('100%')
                  .height(60)
                  .backgroundColor('#EAEAEA')
                  .borderRadius(10)
                  .justifyContent(FlexAlign.Center)
                  .alignItems(ItemAlign.Center)
                  .space(8)

                  Text('Slides')
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#111')
                }

                Column() {
                  .width('100%')
                  .space(2)

                  Text('Presentation.pptx')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111')

                  Text('5.4 MB')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#555')
                }
              }
            }

            GridItem() {
              Column() {
                .width('100%')
                .height(120)
                .padding(12)
                .backgroundColor('#F9F9F9')
                .borderRadius(14)
                .shadow({ radius: 4, color: '#1F000000' })
                .space(4)

                Row() {
                  .width('100%')
                  .height(60)
                  .backgroundColor('#EAEAEA')
                  .borderRadius(10)
                  .justifyContent(FlexAlign.Center)
                  .alignItems(ItemAlign.Center)
                  .space(8)

                  Text('Text')
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#111')
                }

                Column() {
                  .width('100%')
                  .space(2)

                  Text('MeetingNotes.txt')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111')

                  Text('64 KB')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#555')
                }
              }
            }
          }
        }

        Blank()
      }

      Button('Button')
        .width(56)
        .height(56)
        .backgroundColor('#EADDFF')
        .fontColor('#FFF')
        .borderRadius(16)
        .shadow({ radius: 6, color: '#3F000000' })
        .margin(24)
    }
    .width('100%')
    .height('100%')
  }
}