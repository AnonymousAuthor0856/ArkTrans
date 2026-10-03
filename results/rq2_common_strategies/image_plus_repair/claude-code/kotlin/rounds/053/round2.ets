@Entry
@Component
struct Index {
  private markers: CodeMarker[] = [
    { id: 1, name: 'Main.kt', desc: 'Entry point for Compose app' },
    { id: 2, name: 'Utils.kt', desc: 'Helper functions' },
    { id: 3, name: 'Theme.kt', desc: 'Color & Typography setup' },
    { id: 4, name: 'Data.kt', desc: 'Repository and model classes' }
  ]

  build() {
    Column() {
      Text('CodeIDE Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#E2E8F0')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 24 })

      Scroll() {
        Column({ space: 16 }) {
          Text('Project Files')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#E2E8F0')
            .width('100%')

          Column({ space: 8 }) {
            ForEach(this.markers, (m: CodeMarker) => {
              Row({ space: 12 }) {
                Text(m.id.toString())
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
                  .width(32)
                  .height(32)
                  .borderRadius(4)
                  .backgroundColor('#0EA5E9')
                  .textAlign(TextAlign.Center)

                Column() {
                  Text(m.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#E2E8F0')
                  Text(m.desc)
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#E2E8F0')
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#334155')
              .borderRadius(8)
              .alignItems(VerticalAlign.Center)
            }, (m: CodeMarker) => m.id.toString())
          }
          .width('100%')

          Text('Live Terminal')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#E2E8F0')
            .width('100%')
            .margin({ top: 8 })

          Text('> println("Hello, Kotlin!")')
            .fontSize(14)
            .fontColor('#E2E8F0')
            .width('100%')
            .height(240)
            .backgroundColor('#334155')
            .borderRadius(12)
            .border({ width: 1, color: '#475569' })
            .padding(12)
            .textAlign(TextAlign.Start)

          Button('Run Code')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .width('60%')
            .height(48)
            .backgroundColor('#0EA5E9')
            .borderRadius(12)
            .margin({ top: 8 })
        }
        .width('100%')
        .padding(16)
      }
      .width('100%')
      .flexGrow(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#111827')
  }
}

interface CodeMarker {
  id: number
  name: string
  desc: string
}
