// App.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct FileManagerApp {
  @State private files: FileItem[] = [
    new FileItem("Report.pdf", "PDF", "2.1 MB"),
    new FileItem("Budget.xlsx", "Spreadsheet", "1.2 MB"),
    new FileItem("Design.psd", "Image", "4.7 MB"),
    new FileItem("Presentation.pptx", "Slides", "5.4 MB"),
    new FileItem("MeetingNotes.txt", "Text", "64 KB")
  ];

  build() {
    Column() {
      // Top Bar
      Column() {
        Text('File Manager')
          .font({ size: 26, weight: FontWeight.Bold, family: 'System' })
          .foregroundColor(Color('#111111'))
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(100) // Matches SwiftUI's totalAppBarHeight
      .justifyContent(FlexAlign.End)
      .padding({ bottom: 20 })

      // Main Content Area
      Column({ space: 16 }) {
        Text('Recent Files')
          .font({ size: 18, weight: FontWeight.Medium, family: 'System' })
          .foregroundColor(Color('#111111'))
          .margin({ top: 16 })

        Grid() {
          ForEach(this.files, (file: FileItem) => {
            GridItem() {
              FileCard(file: file)
            }
          }, (item: FileItem) => item.name)
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(12)
        .columnsGap(12)
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor(Color('#FFFFFF'))
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color('#FFFFFF'))
  }
}

// Data Model
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

// Components
@Component
struct BoxView {
  text: string;

  build() {
    Row() {
      Text(this.text)
        .font({ size: 14, weight: FontWeight.Normal, family: 'System' })
        .foregroundColor(Color('#111111'))
    }
    .width('100%')
    .height(32)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color('#EAEAEA'))
    .borderRadius(10)
  }
}

@Component
struct FileCard {
  file: FileItem;

  build() {
    Column({ space: 0 }) {
      BoxView(text: this.file.type)
      
      Blank()
      
      Column({ space: 2 }) {
        Text(this.file.name)
          .font({ size: 18, weight: FontWeight.Medium, family: 'System' })
          .foregroundColor(Color('#111111'))
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        
        Text(this.file.size)
          .font({ size: 12, weight: FontWeight.Medium, family: 'System' })
          .foregroundColor(Color('#555555'))
      }
    }
    .width('100%')
    .height(120)
    .padding(12)
    .backgroundColor(Color('#F9F9F9'))
    .borderRadius(14)
    .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.12)', offsetY: 2 })
  }
}