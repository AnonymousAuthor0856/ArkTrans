@Entry
@Component
struct Index {
  @State RecentFiles: string = '0'
  @State fileType: string = '0'
  @State fileName: string = '0'
  @State fileSize: string = '0'
  @State FileManager: string = '0'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Text('Recent Files')
          .fontColor('#111111')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        Grid() {
          GridItem() {
            Column() {
              Column({ space: 0 }) {
                Stack({ alignContent: Alignment.Center }) {
                  Text(this.fileType)
                    .fontColor('#111111')
                    .fontSize(14)
                }
                .width('100%')
                .height(60)
                .backgroundColor('#EAEAEA')

                Column({ space: 0 }) {
                  Text(this.fileName)
                    .fontColor('#111111')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                  Text(this.fileSize)
                    .fontColor('#555555')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                }
              }
              .width('100%')
              .height('100%')
              .padding(12)
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
            .height(120)
          }
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')

      Row() {
        Text('File Manager')
          .fontColor('#111111')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}