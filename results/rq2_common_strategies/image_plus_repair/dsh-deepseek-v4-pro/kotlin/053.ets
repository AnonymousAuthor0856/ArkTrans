interface CodeMarker {
  id: number;
  name: string;
  desc: string;
}

@Entry
@Component
struct RootScreen {
  private markers: CodeMarker[] = [
    { id: 1, name: 'Main.kt', desc: 'Entry point for Compose app' },
    { id: 2, name: 'Utils.kt', desc: 'Helper functions' },
    { id: 3, name: 'Theme.kt', desc: 'Color & Typography setup' },
    { id: 4, name: 'Data.kt', desc: 'Repository and model classes' }
  ];

  build() {
    Column() {
      Row() {
        Text('CodeIDE Terminal')
          .fontSize(26)
          .fontWeight(700)
          .fontColor('#E2E8F0')
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#1E293B')

      Scroll() {
        Column({ space: 16 }) {
          Text('Project Files')
            .fontSize(20)
            .fontWeight(600)
            .fontColor('#E2E8F0')

          Column({ space: 8 }) {
            ForEach(this.markers, (m: CodeMarker) => {
              Column() {
                Row({ space: 12 }) {
                  Stack() {
                    Text(m.id.toString())
                      .fontSize(12)
                      .fontWeight(500)
                      .fontColor('#FFFFFF')
                  }
                  .width(32)
                  .height(32)
                  .backgroundColor('#0EA5E9')
                  .borderRadius(4)

                  Column() {
                    Text(m.name)
                      .fontSize(16)
                      .fontWeight(500)
                      .fontColor('#E2E8F0')
                    Text(m.desc)
                      .fontSize(14)
                      .fontWeight(400)
                      .fontColor('#E2E8F0')
                  }
                }
                .width('100%')
                .padding(12)
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .backgroundColor('#334155')
              .borderRadius(8)
            }, (m: CodeMarker) => m.id.toString())
          }
          .width('100%')
          .padding({ bottom: 24 })

          Text('Live Terminal')
            .fontSize(20)
            .fontWeight(600)
            .fontColor('#E2E8F0')

          Stack() {
            Text('> println("Hello, Kotlin!")')
              .fontSize(14)
              .fontWeight(400)
              .fontColor('#E2E8F0')
          }
          .width('100%')
          .height(240)
          .backgroundColor('#334155')
          .borderRadius(8)
          .border({ width: 1, color: '#475569' })
          .padding(12)
          .alignContent(Alignment.TopStart)

          Button('Run Code', { type: ButtonType.Normal })
            .width('60%')
            .height(48)
            .borderRadius(12)
            .backgroundColor('#0EA5E9')
            .fontColor('#FFFFFF')
            .fontSize(16)
            .fontWeight(500)
            .alignSelf(ItemAlign.Center)
            .onClick(() => {})
        }
        .width('100%')
        .padding(16)
        .linearGradient({
          angle: 180,
          colors: [['#CC1E293B', 0.0], ['#E61E293B', 1.0]]
        })
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#111827')
  }
}
