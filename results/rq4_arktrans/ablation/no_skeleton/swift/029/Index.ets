@Entry
@Component
struct RootScreen {

  // === Data Model ===
  @State files: FileItem[] = [
    { name: "Report.pdf", type: "PDF", size: "2.1 MB" },
    { name: "Budget.xlsx", type: "Spreadsheet", size: "1.2 MB" },
    { name: "Design.psd", type: "Image", size: "4.7 MB" },
    { name: "Presentation.pptx", type: "Slides", size: "5.4 MB" },
    { name: "MeetingNotes.txt", type: "Text", size: "64 KB" }
  ]

  build() {
    // === Column (Root) ===
    // props: { space: 0 }
    // modifier: { width: '100%', height: '100%', backgroundColor: '#FFF' }
    // children: 2
    Column() {
      // === Row (App Bar) ===
      // props: { space: 0, verticalAlignment: VerticalAlign.Center }
      // modifier: { width: '100%', height: 100, justifyContent: FlexAlign.Center }
      // children: 1
      Row() {
        // === Text ===
        // props: { text: 'File Manager' }
        // modifier: { fontSize: 26, fontWeight: FontWeight.Bold, color: '#111111' }
        Text('File Manager')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
      }
      .width('100%')
      .height(100)
      .justifyContent(FlexAlign.Center)

      // === Column (Content) ===
      // props: { space: 16, alignment: HorizontalAlign.Start }
      // modifier: { width: '100%', layoutWeight: 1, padding: 16, backgroundColor: '#FFF' }
      // children: 2
      Column({ space: 16 }) {
        // === Text ===
        // props: { text: 'Recent Files' }
        // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#111111' }
        Text('Recent Files')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')

        // === Grid ===
        // props: { columnsTemplate: '1fr 1fr', columnsGap: 12, rowsGap: 12 }
        // modifier: { width: '100%' }
        // children: 5
        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              // === Column (Card) ===
              // props: { space: 12, alignment: HorizontalAlign.Start }
              // modifier: { width: '100%', height: 120, padding: 12, backgroundColor: '#F9F9F9', borderRadius: 14, shadow: { radius: 4, color: '#1F000000', offsetY: 2 } }
              // children: 3
              Column({ space: 12 }) {
                // === Row (BoxView) ===
                // props: { space: 0, verticalAlignment: VerticalAlign.Center, justifyContent: FlexAlign.Center }
                // modifier: { width: '100%', height: 24, backgroundColor: '#EAEAEA', borderRadius: 10 }
                // children: 1
                Row() {
                  // === Text ===
                  // props: { text: file.type }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#111111' }
                  Text(file.type)
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#111111')
                }
                .width('100%')
                .height(24)
                .backgroundColor('#EAEAEA')
                .borderRadius(10)
                .justifyContent(FlexAlign.Center)

                // === Blank ===
                Blank()

                // === Column (Info) ===
                // props: { space: 2, alignment: HorizontalAlign.Start }
                // children: 2
                Column({ space: 2 }) {
                  // === Text ===
                  // props: { text: file.name }
                  // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#111111', maxWidth: '100%' }
                  Text(file.name)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111111')
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })

                  // === Text ===
                  // props: { text: file.size }
                  // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#555555' }
                  Text(file.size)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#555555')
                }
              }
              .width('100%')
              .height(120)
              .padding(12)
              .backgroundColor('#F9F9F9')
              .borderRadius(14)
              .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor('#FFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF')
  }
}

interface FileItem {
  name: string;
  type: string;
  size: string;
}