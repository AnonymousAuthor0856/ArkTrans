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
      // Top App Bar
      Row() {
        Text('CodeIDE Terminal')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#E2E8F0')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#111827')

      // Main content
      Scroll() {
        Column() {
          Column({ space: 16 }) {
            Text('Project Files')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#E2E8F0')

            Column({ space: 8 }) {
              ForEach(this.markers, (item: CodeMarker) => {
                Row({ space: 12 }) {
                  // File number badge
                  Text(item.id.toString())
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#FFFFFF')
                    .width(32)
                    .height(32)
                    .textAlign(TextAlign.Center)
                    .backgroundColor('#0EA5E9')
                    .borderRadius(4)

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
                  .layoutWeight(1)
                }
                .width('100%')
                .padding(12)
                .backgroundColor('#334155')
                .borderRadius(8)
                .alignItems(VerticalAlign.Center)
              }, (item: CodeMarker) => item.id.toString())
            }
            .width('100%')

            Text('Live Terminal')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#E2E8F0')

            // Terminal box
            Column() {
              Text('> println("Hello, Kotlin!")')
                .fontSize(14)
                .fontColor('#E2E8F0')
            }
            .width('100%')
            .height(240)
            .padding(12)
            .backgroundColor('#334155')
            .borderRadius(8)
            .border({ width: 1, color: '#475569', radius: 8 })
            .alignItems(HorizontalAlign.Start)

            // Run Code button
            Button('Run Code')
              .width('60%')
              .height(48)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#0EA5E9')
              .borderRadius(12)
              .margin({ top: 8 })
          }
          .width('100%')
          .padding(16)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [['#1E293BCC', 0.0], ['#1E293BE6', 1.0]]
          })
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#111827')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
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
