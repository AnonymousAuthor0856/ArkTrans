import { router } from '@kit.ArkUI';

interface FileItem {
  name: string;
  type: string;
  size: string;
}

const files: FileItem[] = [
  { name: "Report.pdf", type: "PDF", size: "2.1 MB" },
  { name: "Budget.xlsx", type: "Spreadsheet", size: "1.2 MB" },
  { name: "Design.psd", type: "Image", size: "4.7 MB" },
  { name: "Presentation.pptx", type: "Slides", size: "5.4 MB" },
  { name: "MeetingNotes.txt", type: "Text", size: "64 KB" },
];

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("File Manager")
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Content
      Column() {
        Text("Recent Files")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
          .margin({ bottom: 16 })
          .alignSelf(ItemAlign.Start)

        Grid() {
          ForEach(files, (file: FileItem) => {
            GridItem() {
              Column() {
                // File type box
                Row() {
                  Text(file.type)
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#111111')
                }
                .width('100%')
                .height(60)
                .backgroundColor('#EAEAEA')
                .borderRadius(10)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)

                // File info
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
                    .width('100%')
                }
                .alignItems(HorizontalAlign.Start)
                .width('100%')
              }
              .width('100%')
              .height(120)
              .padding(12)
              .backgroundColor('#F9F9F9')
              .borderRadius(14)
              .justifyContent(FlexAlign.SpaceBetween)
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