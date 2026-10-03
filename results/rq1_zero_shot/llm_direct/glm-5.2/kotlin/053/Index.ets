// 078_CodeIDE_en - Education Terminal - Retro Flat
// ArkTS port of the provided Kotlin Compose code

interface CodeMarker {
  id: number;
  name: string;
  desc: string;
}

@Entry
@Component
struct RootScreen {
  private markers: CodeMarker[] = [
    { id: 1, name: "Main.kt", desc: "Entry point for Compose app" },
    { id: 2, name: "Utils.kt", desc: "Helper functions" },
    { id: 3, name: "Theme.kt", desc: "Color & Typography setup" },
    { id: 4, name: "Data.kt", desc: "Repository and model classes" }
  ];

  build() {
    Column() {
      // Top App Bar
      Text('CodeIDE Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#E2E8F0')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 12, bottom: 12 });

      // Content Area
      Column() {
        // Project Files Header
        Text('Project Files')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
          .margin({ bottom: 8 });

        // File List
        ForEach(this.markers, (m: CodeMarker) => {
          Row() {
            // ID Box
            Text(m.id.toString())
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#0EA5E9')
              .width(32)
              .height(32)
              .borderRadius(4)
              .textAlign(TextAlign.Center)
              .margin({ right: 12 });

            // File Info
            Column() {
              Text(m.name)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#E2E8F0');
              Text(m.desc)
                .fontSize(14)
                .fontColor('#E2E8F0')
                .margin({ top: 2 });
            }
            .alignItems(HorizontalAlign.Start);
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#334155')
          .borderRadius(8)
          .margin({ bottom: 8 });
        });

        // Live Terminal Header
        Text('Live Terminal')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
          .margin({ top: 16, bottom: 8 });

        // Terminal Box
        Text('> println("Hello, Kotlin!")')
          .fontSize(14)
          .fontColor('#E2E8F0')
          .width('100%')
          .height(240)
          .padding(12)
          .backgroundColor('#334155')
          .border({ width: 1, color: '#475569' })
          .borderRadius(8)
          .textAlign(TextAlign.Start);

        // Run Code Button
        Button('Run Code')
          .width('60%')
          .height(48)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#0EA5E9')
          .borderRadius(12)
          .margin({ top: 16 });
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [['#324050', 0.0], ['#1E293B', 1.0]]
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#111827');
  }
}