@Entry
@Component
struct SingleFileUIApp {
  @State private markers: CodeMarker[] = [
    { id: 1, name: "Main.kt", desc: "Entry point for Compose app" },
    { id: 2, name: "Utils.kt", desc: "Helper functions" },
    { id: 3, name: "Theme.kt", desc: "Color & Typography setup" },
    { id: 4, name: "Data.kt", desc: "Repository and model classes" }
  ]

  build() {
    Stack() {
      Column({ space: 0 }) {
        // CustomTopAppBar
        Row({ space: 0 }) {
          Text("CodeIDE Terminal")
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#E2E8F0')
            .width('100%')
            .textAlign(TextAlign.Center)
            .padding({ top: 12, bottom: 12 })
        }
        .width('100%')
        .backgroundColor('#1E293B')

        // Scrollable content
        Column({ space: 16 }) {
          // Project Files section
          Text("Project Files")
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#E2E8F0')
            .width('100%')

          List({ space: 8 }) {
            ForEach(this.markers, (marker: CodeMarker, index: number) => {
              ListItem() {
                this.buildCodeMarkerCard(marker)
              }
            })
          }
          .width('100%')
          .padding({ bottom: 24 })

          // Live Terminal section
          Text("Live Terminal")
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#E2E8F0')
            .width('100%')

          Stack({ alignContent: Alignment.TopStart }) {
            // Terminal background
            Column()
              .width('100%')
              .height(240)
              .backgroundColor('#334155')
              .borderRadius(8)
              .border({ width: 1, color: '#475569' })
            // Terminal text
            Text("> println(\"Hello, Kotlin!\")")
              .fontSize(14)
              .foregroundColor('#E2E8F0')
              .padding(12)
          }
          .width('100%')
          .height(240)

          // Run Code button
          Button() {
            Text("Run Code")
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FFFFFF')
              .textAlign(TextAlign.Center)
              .width('100%')
              .height(48)
          }
          .width('60%')
          .height(48)
          .backgroundColor('#0EA5E9')
          .borderRadius(12)
          .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 1 })
          .margin({ left: '20%' }) // to center
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .backgroundColor('#1E293B')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#1E293B')
  }

  @Builder
  buildCodeMarkerCard(marker: CodeMarker) {
    Row({ space: 12 }) {
      // Id badge
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width(32)
          .height(32)
          .backgroundColor('#0EA5E9')
          .borderRadius(4)
        Text(marker.id.toString())
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#FFFFFF')
      }
      .width(32)
      .height(32)

      // Name and description
      Column({ space: 4 }) {
        Text(marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#E2E8F0')
        Text(marker.desc)
          .fontSize(14)
          .foregroundColor('#E2E8F0')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .padding(12)
    .width('100%')
    .backgroundColor('#334155')
    .borderRadius(8)
    .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }
}

// Data model
interface CodeMarker {
  id: number
  name: string
  desc: string
}