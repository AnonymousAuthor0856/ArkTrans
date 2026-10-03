@Entry
@Component
struct RootScreen {
  private files: FileItem[] = [
    { name: "Report.pdf", type: "PDF", size: "2.1 MB" },
    { name: "Budget.xlsx", type: "Spreadsheet", size: "1.2 MB" },
    { name: "Design.psd", type: "Image", size: "4.7 MB" },
    { name: "Presentation.pptx", type: "Slides", size: "5.4 MB" },
    { name: "MeetingNotes.txt", type: "Text", size: "64 KB" }
  ]

  build() {
    Column({ space: 0 }) {
      // Top bar
      Stack({ alignContent: Alignment.Center }) {
        Text("File Manager")
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .foregroundColor("#FF111111")
      }
      .width("100%")
      .height(100)
      .backgroundColor("#FFFFFFFF")

      // Main content
      Column({ space: 16 }) {
        Text("Recent Files")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .foregroundColor("#FF111111")

        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              Column({ space: 0 }) {
                // File type box
                Text(file.type)
                  .fontSize(14)
                  .fontWeight(FontWeight.Regular)
                  .foregroundColor("#FF111111")
                  .width("100%")
                  .backgroundColor("#FFEAEAEA")
                  .borderRadius(10)
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })

                // Spacer to push name/size to bottom
                Blank().layoutWeight(1)

                // File name and size
                Column({ space: 2 }) {
                  Text(file.name)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor("#FF111111")
                  Text(file.size)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor("#FF555555")
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width("100%")
              .height(120)
              .padding(12)
              .backgroundColor("#FFF9F9F9")
              .borderRadius(14)
              .shadow({
                radius: 4,
                color: "rgba(0,0,0,0.12)",
                offsetX: 0,
                offsetY: 2
              })
            }
          })
        }
        .columnsTemplate("1fr 1fr")
        .columnsGap(12)
        .rowsGap(12)
        .width("100%")
      }
      .width("100%")
      .height("100%")
      .padding(16)
      .backgroundColor("#FFF9F9F9")
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#FFFFFFFF")
  }
}

interface FileItem {
  name: string
  type: string
  size: string
}