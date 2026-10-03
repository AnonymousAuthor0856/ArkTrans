@Entry
@Component
struct Index {
  private markers: Array<{ id: number, name: string, desc: string }> = [
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
      .backgroundColor('#1E293B')

      // Main Content
      Scroll() {
        Column({ space: 16 }) {
          // Project Files Header
          Text('Project Files')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
            .alignSelf(ItemAlign.Start)

          // File Cards
          Column({ space: 8 }) {
            ForEach(this.markers, (item: { id: number, name: string, desc: string }) => {
              Row({ space: 12 }) {
                // ID Badge
                Stack() {
                  Text(item.id.toString())
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#FFFFFF')
                }
                .width(32)
                .height(32)
                .backgroundColor('#0EA5E9')
                .borderRadius(4)

                // File Info
                Column({ space: 2 }) {
                  Text(item.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#E2E8F0')
                  Text(item.desc)
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
            })
          }
          .width('100%')

          // Live Terminal Header
          Text('Live Terminal')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
            .alignSelf(ItemAlign.Start)

          // Terminal Box
          Column() {
            Text('> println("Hello, Kotlin!")')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor('#E2E8F0')
              .alignSelf(ItemAlign.Start)
          }
          .width('100%')
          .height(240)
          .backgroundColor('#334155')
          .borderRadius(8)
          .border({ width: 1, color: '#475569' })
          .padding(12)
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Start)

          // Run Code Button
          Button('Run Code')
            .width('60%')
            .height(48)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#0EA5E9')
            .borderRadius(12)
            .alignSelf(ItemAlign.Center)

          // Bottom spacing
          Blank().height(24)
        }
        .width('100%')
        .padding(16)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#CC1E293B', 0.0], ['#E61E293B', 1.0]]
    })
    .backgroundColor('#111827')
  }
}