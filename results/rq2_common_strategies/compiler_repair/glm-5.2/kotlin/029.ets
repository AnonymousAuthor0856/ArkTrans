// 030FileManageren - Productivity - Monochrome - en - 720x1280

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

@Entry
@Component
struct FileManagerApp {
  private files: FileItem[] = [
    new FileItem("Report.pdf", "PDF", "2.1 MB"),
    new FileItem("Budget.xlsx", "Spreadsheet", "1.2 MB"),
    new FileItem("Design.psd", "Image", "4.7 MB"),
    new FileItem("Presentation.pptx", "Slides", "5.4 MB"),
    new FileItem("MeetingNotes.txt", "Text", "64 KB")
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("File Manager")
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor("#111111")
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor("#FFFFFF");

      // Content Area
      Column() {
        Text("Recent Files")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor("#111111")
          .margin({ bottom: 16 });

        // Grid Layout
        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              Column() {
                // File Type Box
                Row() {
                  Text(file.type)
                    .fontSize(14)
                    .fontColor("#111111")
                }
                .width('100%')
                .height(60)
                .justifyContent(FlexAlign.Center)
                .backgroundColor("#EAEAEA")
                .borderRadius(10);

                // File Details
                Column() {
                  Text(file.name)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor("#111111")
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis });
                  Text(file.size)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor("#555555")
                    .margin({ top: 4 });
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ top: 12 });
              }
              .padding(12)
              .backgroundColor("#F9F9F9")
              .borderRadius(14)
              .shadow({ radius: 4, color: 'rgba(0,0,0,0.12)', offsetX: 0, offsetY: 2 })
            }
            .height(120)
          })
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(12)
        .columnsGap(12)
        .layoutWeight(1)
        .width('100%');
      }
      .padding(16)
      .width('100%')
      .layoutWeight(1)
      .backgroundColor("#FFFFFF");
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#FFFFFF");
  }
}