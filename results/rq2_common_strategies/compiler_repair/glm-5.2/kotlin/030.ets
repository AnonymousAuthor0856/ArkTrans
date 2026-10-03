// Index.ets

interface ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number;
}

class AppTokens {
  static readonly primary: string = '#007BFF';
  static readonly secondary: string = '#6C757D';
  static readonly tertiary: string = '#17A2B8';
  static readonly background: string = '#F8F9FA';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E9ECEF';
  static readonly outline: string = '#DEE2E6';
  static readonly success: string = '#28A745';
  static readonly warning: string = '#FFC107';
  static readonly error: string = '#DC3545';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#212529';
  static readonly onSurface: string = '#212529';
}

@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24;
  private clipboardItems: ClipboardItem[] = [
    { id: 1, content: 'https://www.example.com/modern-design', type: 'Link', timestamp: '5 min ago', progress: 0.2 },
    { id: 2, content: 'Final project review notes have been updated.', type: 'Text', timestamp: '23 min ago', progress: 0.5 },
    { id: 3, content: '#007BFF', type: 'Color', timestamp: '1 hour ago', progress: 0.8 },
    { id: 4, content: 'Meeting at 3 PM with the design team.', type: 'Text', timestamp: '3 hours ago', progress: 0.9 },
    { id: 5, content: 'Shared file: \'Q3_Report.pdf\'', type: 'File', timestamp: 'Yesterday', progress: 1.0 }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Clipboard History')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);
        
        Button('Clear')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onSurface)
          .backgroundColor(AppTokens.surfaceVariant)
          .borderRadius(8)
          .height(36)
          .padding({ left: 12, right: 12 });
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 12 })
      .backgroundColor(AppTokens.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);

      // List
      Scroll() {
        Column() {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            ClipboardCard({ item: item })
              .margin({ bottom: 12 })
          }, (item: ClipboardItem) => item.id.toString())
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 });
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top);

      // Settings Pane
      Column() {
        Row() {
          Text('History Limit (Hours)')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.onSurface);
          
          Text(this.sliderValue.toFixed(0))
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.onSurface);
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
          .blockColor(AppTokens.primary)
          .selectedColor(AppTokens.primary)
          .trackColor(AppTokens.surfaceVariant)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.sliderValue = value;
          });
      }
      .width('100%')
      .padding(16)
      .backgroundColor(AppTokens.surface)
      .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -2 });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background);
  }
}

@Component
struct ClipboardCard {
  private item: ClipboardItem = { id: 0, content: '', type: '', timestamp: '', progress: 0 };

  build() {
    Column() {
      Row() {
        Row() {
          Text('')
            .width(12)
            .height(12)
            .backgroundColor(AppTokens.primary)
            .borderRadius(2);
        }
        .width(24)
        .height(24)
        .backgroundColor(AppTokens.surfaceVariant)
        .borderRadius(4)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center);

        Text(this.item.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.primary)
          .margin({ left: 8 });

        Blank();

        Text(this.item.timestamp)
          .fontSize(14)
          .fontColor(AppTokens.secondary);
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);

      Text(this.item.content)
        .fontSize(16)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .fontColor(AppTokens.onSurface)
        .margin({ top: 8, bottom: 12 })
        .width('100%');

      // Progress Indicator
      Stack({ alignContent: Alignment.Start }) {
        // Track
        Column()
          .width('100%')
          .height(4)
          .backgroundColor(AppTokens.surfaceVariant)
          .borderRadius(2);
        
        // Progress
        Column()
          .width(`${this.item.progress * 100}%`)
          .height(4)
          .backgroundColor(AppTokens.tertiary)
          .borderRadius(2);
      }
      .width('100%')
      .height(4);
    }
    .width('100%')
    .padding(12)
    .backgroundColor(AppTokens.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppTokens.surfaceVariant })
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 });
  }
}