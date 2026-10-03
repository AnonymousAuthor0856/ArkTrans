@Entry
@Component
struct RootScreen {
  // 示例文件数据
  @State files: FileItem[] = [
    new FileItem("Report.pdf", "PDF", "2.1 MB"),
    new FileItem("Budget.xlsx", "Spreadsheet", "1.2 MB"),
    new FileItem("Design.psd", "Image", "4.7 MB"),
    new FileItem("Presentation.pptx", "Slides", "5.4 MB"),
    new FileItem("MeetingNotes.txt", "Text", "64 KB")
  ];

  build() {
    Column() {
      // 自定义顶部应用栏
      Stack() {
        Text('File Manager')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
      }
      .width('100%')
      .height(100)
      .backgroundColor('#FFFFFF')

      // 主要内容区域
      Column() {
        Text('Recent Files')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
          .width('100%')
          .textAlign(TextAlign.Start)

        // 垂直网格布局，两列
        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              FileCard({ file: file })
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
      .alignItems(HorizontalAlign.Start)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

// 文件项数据模型
class FileItem {
  id: string = '';
  name: string;
  type: string;
  size: string;

  constructor(name: string, type: string, size: string) {
    this.id = `${Date.now()}_${Math.random()}`;
    this.name = name;
    this.type = type;
    this.size = size;
  }
}

// 文件类型 Box 组件
@Component
struct BoxView {
  text: string = '';

  build() {
    Text(this.text)
      .fontSize(14)
      .fontWeight(FontWeight.Regular)
      .fontColor('#111111')
      .width('100%')
      .padding(8)
      .backgroundColor('#EAEAEA')
      .borderRadius(10)
  }
}

// 文件卡片组件
@Component
struct FileCard {
  file: FileItem = new FileItem('', '', '');

  build() {
    Column() {
      BoxView({ text: this.file.type })

      Blank()

      Column() {
        Text(this.file.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
          .width('100%')
          .textAlign(TextAlign.Start)
        Text(this.file.size)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#555555')
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(120)
    .padding(12)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#F9F9F9')
    .borderRadius(14)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: 2
    })
  }
}