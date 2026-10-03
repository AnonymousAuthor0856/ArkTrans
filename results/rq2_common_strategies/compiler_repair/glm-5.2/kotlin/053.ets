// Index.ets

class CodeMarker {
  id: number = 0;
  name: string = '';
  desc: string = '';
  constructor(id: number, name: string, desc: string) {
    this.id = id;
    this.name = name;
    this.desc = desc;
  }
}

@Entry
@Component
struct RootScreen {
  private markers: CodeMarker[] = [
    new CodeMarker(1, "Main.kt", "Entry point for Compose app"),
    new CodeMarker(2, "Utils.kt", "Helper functions"),
    new CodeMarker(3, "Theme.kt", "Color & Typography setup"),
    new CodeMarker(4, "Data.kt", "Repository and model classes")
  ];

  build() {
    Column() {
      // TopAppBar
      Text("CodeIDE Terminal")
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor("#E2E8F0")
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(16)

      // Content
      Scroll() {
        Column() {
          Text("Project Files")
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor("#E2E8F0")
            .margin({ bottom: 16 })

          ForEach(this.markers, (m: CodeMarker) => {
            Row() {
              Text(m.id.toString())
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor("#FFFFFF")
                .backgroundColor("#0EA5E9")
                .width(32)
                .height(32)
                .textAlign(TextAlign.Center)
                .borderRadius(4)
                .margin({ right: 12 })

              Column() {
                Text(m.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#E2E8F0")
                Text(m.desc)
                  .fontSize(14)
                  .fontColor("#E2E8F0")
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding(12)
            .backgroundColor("#334155")
            .borderRadius(8)
            .margin({ bottom: 8 })
          })

          Text("Live Terminal")
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor("#E2E8F0")
            .margin({ top: 16, bottom: 8 })

          Text('> println("Hello, Kotlin!")')
            .fontSize(14)
            .fontColor("#E2E8F0")
            .width('100%')
            .height(240)
            .padding(12)
            .backgroundColor("#334155")
            .borderRadius(8)
            .border({ width: 1, color: "#475569" })

          Button("Run Code")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor("#FFFFFF")
            .backgroundColor("#0EA5E9")
            .width('60%')
            .height(48)
            .borderRadius(12)
            .margin({ top: 16 })
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .backgroundColor("#1E293B")
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#111827")
  }
}