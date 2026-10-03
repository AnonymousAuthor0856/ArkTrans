// 031_ClipboardHistory_en.ets
import { Length, ResourceColor } from '@ohos.arkui.arkui';

interface ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number;
}

@Entry
@Component
struct RootScreen {
  private clipboardItems: ClipboardItem[] = [
    { id: 1, content: "https://www.example.com/modern-design", type: "Link", timestamp: "5 min ago", progress: 0.2 },
    { id: 2, content: "Final project review notes have been updated.", type: "Text", timestamp: "23 min ago", progress: 0.5 },
    { id: 3, content: "#007BFF", type: "Color", timestamp: "1 hour ago", progress: 0.8 },
    { id: 4, content: "Meeting at 3 PM with the design team.", type: "Text", timestamp: "3 hours ago", progress: 0.9 },
    { id: 5, content: "Shared file: 'Q3_Report.pdf'", type: "File", timestamp: "Yesterday", progress: 1.0 }
  ];

  @State sliderValue: number = 24;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Clipboard History")
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#212529')
          .layoutWeight(1)
          .textAlign(TextAlign.Center);
        
        Button("Clear") {
          Text("Clear")
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#212529');
        }
        .type(ButtonType.Normal)
        .borderRadius(8)
        .backgroundColor('#E9ECEF')
        .margin({ right: 12 });
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .alignItems(VerticalAlign.Center);

      // List
      Scroll() {
        Column() {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            ClipboardCard({ item: item })
          }, (item: ClipboardItem) => item.id.toString());
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 });
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off);

      // Settings Pane
      Column() {
        Row() {
          Text("History Limit (Hours)")
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#212529');
          
          Text(this.sliderValue.toFixed(0))
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#212529');
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center);

        Slider({
          value: this.sliderValue,
          min: 1,
          max: 72,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor('#007BFF')
          .trackColor({
            background: '#E9ECEF',
            selected: '#007BFF'
          })
          .onChange((value: number, mode: SliderChangeMode) => {
            this.sliderValue = value;
          });
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#DEE2E6', side: BorderSide.Top });
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F9FA');
  }
}

@Component
struct ClipboardCard {
  @Prop item: ClipboardItem;

  build() {
    Column() {
      // Header Row
      Row() {
        Row() {
          Text("");
        }
        .width(24)
        .height(24)
        .borderRadius(4)
        .backgroundColor('#007BFF');

        Text(this.item.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007BFF')
          .margin({ left: 8 });

        Text(this.item.timestamp)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#6C757D')
          .layoutWeight(1)
          .textAlign(TextAlign.Right);
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);

      // Content
      Text(this.item.content)
        .fontSize(16)
        .fontColor('#212529')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 8 });

      // Progress Bar
      Row() {
        Row() {
          Text("");
        }
        .width((this.item.progress * 100) + '%')
        .height(4)
        .backgroundColor('#17A2B8');
      }
      .width('100%')
      .height(4)
      .borderRadius(4)
      .backgroundColor('#E9ECEF')
      .margin({ top: 12 });
    }
    .width('100%')
    .padding(12)
    .borderRadius(12)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#E9ECEF' })
    .margin({ bottom: 12 });
  }
}