import { LengthMetrics } from '@kit.ArkUI'

interface FileItem {
  name: string
  type: string
  size: string
}

const files: FileItem[] = [
  { name: 'Report.pdf', type: 'PDF', size: '2.1 MB' },
  { name: 'Budget.xlsx', type: 'Spreadsheet', size: '1.2 MB' },
  { name: 'Design.psd', type: 'Image', size: '4.7 MB' },
  { name: 'Presentation.pptx', type: 'Slides', size: '5.4 MB' },
  { name: 'MeetingNotes.txt', type: 'Text', size: '64 KB' },
]

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top App Bar
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

      // Content
      Column({ space: 16 }) {
        Text('Recent Files')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
          .width('100%')

        Grid() {
          ForEach(files, (file: FileItem) => {
            GridItem() {
              Column({ space: 0 }) {
                // Type badge area
                Row() {
                  Text(file.type)
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#111111')
                }
                .width('100%')
                .height(60)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
                .backgroundColor('#EAEAEA')
                .borderRadius(10)

                Column({ space: 2 }) {
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
                    .width('100%')
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
                color: '#1F000000',
                offsetX: 0,
                offsetY: 2
              })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .width('100%')
        .layoutWeight(1)
      }
      .padding(16)
      .layoutWeight(1)
      .backgroundColor('#FFFFFF')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}