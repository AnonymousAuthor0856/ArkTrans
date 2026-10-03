// App.ets
import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

class CodeMarker {
  id: number;
  name: string;
  desc: string;

  constructor(id: number, name: string, desc: string) {
    this.id = id;
    this.name = name;
    this.desc = desc;
  }
}

@Entry
@Component
struct RootScreen {
  @State markers: CodeMarker[] = [
    new CodeMarker(1, "Main.kt", "Entry point for Compose app"),
    new CodeMarker(2, "Utils.kt", "Helper functions"),
    new CodeMarker(3, "Theme.kt", "Color & Typography setup"),
    new CodeMarker(4, "Data.kt", "Repository and model classes")
  ];

  build() {
    Column() {
      // Header
      Text('CodeIDE Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#E2E8F0')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 20, bottom: 20 })

      // Project Files Section
      Text('Project Files')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#E2E8F0')
        .margin({ left: 16, right: 16, bottom: 16 })

      // File List
      LazyColumn() {
        ForEach(this.markers, (marker: CodeMarker) => {
          FileCard({ marker: marker })
        }, (marker: CodeMarker) => marker.id.toString())
      }
      .padding({ left: 16, right: 16, bottom: 24 })
      .layoutWeight(1)

      // Live Terminal Section
      Text('Live Terminal')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#E2E8F0')
        .margin({ left: 16, right: 16, bottom: 16 })

      // Terminal Box
      TerminalBox()
        .margin({ left: 16, right: 16, bottom: 24 })

      // Run Button
      Button('Run Code')
        .type(ButtonType.Capsule)
        .backgroundColor('#0EA5E9')
        .fontColor('#FFFFFF')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .height(48)
        .width('60%')
        .borderRadius(12)
        .onClick(() => {
          // Handle button click
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#111827')
    .linearGradient({
      angle: 180,
      colors: [['#1E293B', 0], ['#1E293B', 1]]
    })
  }
}

@Component
struct FileCard {
  @Prop marker: CodeMarker;

  build() {
    Row() {
      // Number badge
      Text(this.marker.id.toString())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .width(32)
        .height(32)
        .textAlign(TextAlign.Center)
        .backgroundColor('#0EA5E9')
        .borderRadius(4)

      Column() {
        Text(this.marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
          .margin({ left: 12 })

        Text(this.marker.desc)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#E2E8F0')
          .opacity(0.8)
          .margin({ left: 12, top: 2 })
      }
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#334155')
    .borderRadius(8)
    .margin({ bottom: 8 })
  }
}

@Component
struct TerminalBox {
  build() {
    Column() {
      Text('> println("Hello, Kotlin!")')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor('#E2E8F0')
        .margin({ top: 12, left: 12 })
    }
    .width('100%')
    .height(240)
    .backgroundColor('#334155')
    .borderRadius(8)
    .border({ width: 1, color: '#475569' })
  }
}