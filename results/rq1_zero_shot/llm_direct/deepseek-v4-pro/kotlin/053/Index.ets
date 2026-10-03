import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State markers: Array<CodeMarker> = [
    new CodeMarker(1, "Main.kt", "Entry point for Compose app"),
    new CodeMarker(2, "Utils.kt", "Helper functions"),
    new CodeMarker(3, "Theme.kt", "Color & Typography setup"),
    new CodeMarker(4, "Data.kt", "Repository and model classes")
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('CodeIDE Terminal')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#E2E8F0')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 16, bottom: 16 })
      }
      .width('100%')
      .backgroundColor('#1E293B')

      // Main content
      Column() {
        Text('Project Files')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
          .margin({ bottom: 12 })

        // File list
        List({ space: 8 }) {
          ForEach(this.markers, (item: CodeMarker) => {
            ListItem() {
              Row({ space: 12 }) {
                // ID badge
                Text(item.id.toString())
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
                  .textAlign(TextAlign.Center)
                  .width(32)
                  .height(32)
                  .borderRadius(4)
                  .backgroundColor('#0EA5E9')

                // File info
                Column({ space: 2 }) {
                  Text(item.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#E2E8F0')
                  Text(item.desc)
                    .fontSize(14)
                    .fontColor('#E2E8F0')
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .padding(12)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .borderRadius(8)
            .backgroundColor('#334155')
          }, (item: CodeMarker) => item.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Auto)

        Text('Live Terminal')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
          .margin({ top: 16, bottom: 12 })

        // Terminal box
        Column() {
          Text('> println("Hello, Kotlin!")')
            .fontSize(14)
            .fontColor('#E2E8F0')
        }
        .width('100%')
        .height(240)
        .padding(12)
        .borderRadius(8)
        .backgroundColor('#334155')
        .border({ width: 1, color: '#475569' })
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Start)

        // Run button
        Button('Run Code')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .width('60%')
          .height(48)
          .borderRadius(12)
          .backgroundColor('#0EA5E9')
          .margin({ top: 16 })
          .alignSelf(ItemAlign.Center)
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [['#1E293B', 0.8], ['#1E293B', 0.9]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#111827')
  }
}

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