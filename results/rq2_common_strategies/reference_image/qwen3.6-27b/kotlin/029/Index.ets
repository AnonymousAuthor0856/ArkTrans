@Entry
@Component
struct FileManager {
  // Data Model
  @State files: FileItem[] = [
    new FileItem("Report.pdf", "PDF", "2.1 MB"),
    new FileItem("Budget.xlsx", "Spreadsheet", "1.2 MB"),
    new FileItem("Design.psd", "Image", "4.7 MB"),
    new FileItem("Presentation.pptx", "Slides", "5.4 MB"),
    new FileItem("MeetingNotes.txt", "Text", "64 KB")
  ];

  build() {
    Column() {
      // Top Bar / Header
      Text('File Manager')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111111')
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 20, bottom: 20 })

      // Section Title
      Text('Recent Files')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#111111')
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 16 })

      // Grid Layout
      GridContainer({ items: this.files })
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .padding({ left: 16, right: 16 })
  }
}

// Helper Class for Data
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

// Reusable Component for the Grid
@Component
struct GridContainer {
  @Link items: FileItem[];

  build() {
    Grid() {
      ForEach(this.items, (item: FileItem) => {
        GridItem() {
          // Card Container
          Column() {
            // Type Badge Box
            Row() {
              Text(item.type)
                .fontSize(14)
                .fontColor('#111111')
            }
            .width('90%')
            .height(60)
            .backgroundColor('#EAEAEA')
            .borderRadius(10)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .margin({ bottom: 12 })

            // File Details
            Column() {
              Text(item.name)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#111111')
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
              
              Text(item.size)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#555555')
                .margin({ top: 4 })
            }
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .height(120)
          .padding(12)
          .backgroundColor('#F9F9F9')
          .borderRadius(14)
          .shadow({
            radius: 4,
            color: 'rgba(0, 0, 0, 0.12)',
            offsetX: 0,
            offsetY: 2
          })
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .rowsGap(12)
    .columnsGap(12)
    .width('100%')
  }
}