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
          .foregroundColor('#111111')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(100) // Matches SwiftUI's totalAppBarHeight
      .justifyContent(FlexAlign.End)
      .padding({ bottom: 20 })

      // Main Content Area
      Column() {
        Text('Recent Files')
          .font({ size: 18, weight: FontWeight.Medium, family: 'System' })
          .foregroundColor('#111111')
          .margin({ bottom: 16 })

        FileGridContainer({ files: this.files })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
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
  @Prop text: string;

  build() {
    Row() {
      Text(this.text)
        .font({ size: 14, weight: FontWeight.Normal, family: 'System' })
        .foregroundColor('#111111')
    }
    .width('100%')
    .height(30)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#EAEAEA')
    .borderRadius(10)
  }
}

@Component
struct FileCard {
  @ObjectLink file: FileItem;

  build() {
    Column() {
      BoxView({ text: this.file.type })
      
      Blank() // Spacer equivalent
      
      Column() {
        Text(this.file.name)
          .font({ size: 18, weight: FontWeight.Medium, family: 'System' })
          .foregroundColor('#111111')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        
        Text(this.file.size)
          .font({ size: 12, weight: FontWeight.Medium, family: 'System' })
          .foregroundColor('#555555')
          .margin({ top: 2 })
      }
    }
    .width('100%')
    .height(120)
    .padding(12)
    .backgroundColor('#F9F9F9')
    .borderRadius(14)
    .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.12)', offsetY: 2 })
  }
}

@Component
struct FileGridContainer {
  @State files: FileItem[] = [];

  build() {
    Grid() {
      ForEach(this.files, (item: FileItem) => {
        GridItem() {
          FileCard({ file: item })
        }
      }, (item: FileItem) => item.name)
    }
    .columnsTemplate('1fr 1fr')
    .rowsGap(12)
    .columnsGap(12)
    .width('100%')
  }
}