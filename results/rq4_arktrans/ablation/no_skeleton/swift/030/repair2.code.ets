// entry/src/main/ets/entryability/EntryAbility.ets
import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // Ability creation logic
  }

  onDestroy(): void {
    // Ability destruction logic
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        console.error('Failed to load the content. Cause:' + JSON.stringify(err));
        return;
      }
      console.info('Succeeded in loading the content. Data:' + JSON.stringify(data));
    });
  }
}

// entry/src/main/ets/pages/Index.ets
@Entry
@Component
struct Index {
  @State sliderValue: number = 24

  build() {
    Column() {
      // === Header ===
      Row() {
        Text("Clipboard History")
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#212529')
        
        Blank()
        
        Button({ type: ButtonType.Capsule }) {
          Text("Clear")
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#212529')
        }
        .backgroundColor('#E9ECEF')
        .borderRadius(8)
        .height(36)
        .margin({ right: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFF')
      .shadow({ radius: 2, color: '#0D000000', offsetY: 1 })

      // === List Content ===
      List({ space: 12 }) {
        ListItem() { ClipboardCard({ type: "Link", timestamp: "5 min ago", content: "https://www.example.com/modern-design", progress: 0.2 }) }
        ListItem() { ClipboardCard({ type: "Text", timestamp: "23 min ago", content: "Final project review notes have been updated.", progress: 0.5 }) }
        ListItem() { ClipboardCard({ type: "Color", timestamp: "1 hour ago", content: "#007BFF", progress: 0.8 }) }
        ListItem() { ClipboardCard({ type: "Text", timestamp: "3 hours ago", content: "Meeting at 3 PM with the design team.", progress: 0.9 }) }
        ListItem() { ClipboardCard({ type: "File", timestamp: "Yesterday", content: "Shared file: 'Q3_Report.pdf'", progress: 1.0 }) }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#F8F9FA')

      // === Settings Pane ===
      Column() {
        Row() {
          Text("History Limit (Hours)")
            .fontSize(16)
            .fontColor('#212529')
          
          Blank()
          
          Text(`${this.sliderValue}`)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#212529')
        }
        .width('100%')
        .margin({ bottom: 8 })

        Slider({ value: this.sliderValue, min: 1, max: 72, step: 1 })
          .width('100%')
          .trackColor(Color.Gray)
          .selectedColor('#007BFF')
          .blockColor('#FFF')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFF')
      .shadow({ radius: 10, color: '#1A000000', offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F9FA')
  }
}

@Component
struct ClipboardCard {
  @Prop type: string
  @Prop timestamp: string
  @Prop content: string
  @Prop progress: number

  build() {
    Column() {
      Row() {
        Rect()
          .width(24)
          .height(24)
          .fill('#007BFF')
          .borderRadius(4)
        
        Text(this.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007BFF')
          .margin({ left: 8 })
        
        Blank()
        
        Text(this.timestamp)
          .fontSize(14)
          .fontColor('#6C757D')
      }
      .width('100%')
      .margin({ bottom: 8 })

      Text(this.content)
        .fontSize(16)
        .fontColor('#212529')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: 12 })

      Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color('#17A2B8')
        .backgroundColor(Color.Gray)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFF')
    .borderRadius(12)
    .border({ width: 1, color: '#E9ECEF' })
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
  }
}