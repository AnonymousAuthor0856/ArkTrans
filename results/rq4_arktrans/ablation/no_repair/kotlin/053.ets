@Entry
@Component
struct Index {
  @State projectFiles: string = "Project Files"
  @State liveTerminal: string = "Live Terminal"
  @State runCode: string = "Run Code"
  @State appTitle: string = "CodeIDE Terminal"

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Text(this.projectFiles)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')

        List({ space: 8 }) {
          ListItem() {
            Row({ space: 12 }) {
              Stack({ alignContent: Alignment.Center }) {
                Text('1')
                  .fontSize(14)
                  .fontColor('#FFFFFF')
              }
              .width(32)
              .height(32)
              .backgroundColor('#0EA5E9')
              .borderRadius(4)

              Column({ space: 0 }) {
                Text('Main.kt')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#E2E8F0')
                Text('Entry point for Compose app')
                  .fontSize(14)
                  .fontColor('#CBD5E1')
              }
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .padding(12)
          }
          .backgroundColor('#334155')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })

          ListItem() {
            Row({ space: 12 }) {
              Stack({ alignContent: Alignment.Center }) {
                Text('2')
                  .fontSize(14)
                  .fontColor('#FFFFFF')
              }
              .width(32)
              .height(32)
              .backgroundColor('#0EA5E9')
              .borderRadius(4)

              Column({ space: 0 }) {
                Text('Utils.kt')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#E2E8F0')
                Text('Helper functions')
                  .fontSize(14)
                  .fontColor('#CBD5E1')
              }
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .padding(12)
          }
          .backgroundColor('#334155')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })

          ListItem() {
            Row({ space: 12 }) {
              Stack({ alignContent: Alignment.Center }) {
                Text('3')
                  .fontSize(14)
                  .fontColor('#FFFFFF')
              }
              .width(32)
              .height(32)
              .backgroundColor('#0EA5E9')
              .borderRadius(4)

              Column({ space: 0 }) {
                Text('Theme.kt')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#E2E8F0')
                Text('Color & Typography setup')
                  .fontSize(14)
                  .fontColor('#CBD5E1')
              }
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .padding(12)
          }
          .backgroundColor('#334155')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })

          ListItem() {
            Row({ space: 12 }) {
              Stack({ alignContent: Alignment.Center }) {
                Text('4')
                  .fontSize(14)
                  .fontColor('#FFFFFF')
              }
              .width(32)
              .height(32)
              .backgroundColor('#0EA5E9')
              .borderRadius(4)

              Column({ space: 0 }) {
                Text('Data.kt')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#E2E8F0')
                Text('Repository and model classes')
                  .fontSize(14)
                  .fontColor('#CBD5E1')
              }
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .padding(12)
          }
          .backgroundColor('#334155')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })
        }
        .width('100%')

        Text(this.liveTerminal)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')

        Stack({ alignContent: Alignment.Center }) {
          Text('> println("Hello, Kotlin!")')
            .fontSize(16)
            .fontColor('#E2E8F0')
        }
        .width('100%')
        .height(240)
        .backgroundColor('#334155')
        .borderRadius(12)
        .border({ width: 1, color: '#475569', radius: 12 })
        .padding(12)

        Button() {
          Text(this.runCode)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .width('60%')
        .height(48)
        .backgroundColor('#0EA5E9')
        .borderRadius(24)
        .margin({ left: '20%', right: '20%' })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#111827')

      Text(this.appTitle)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#E2E8F0')
        .textAlign(TextAlign.Center)
        .position({ x: 0, y: 16 })
        .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}