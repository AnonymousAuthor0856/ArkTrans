@Entry
@Component
struct Index {
  @State ProjectFiles: string = "0"
  @State mIdStr: string = "0"
  @State mName: string = "0"
  @State mDesc: string = "0"
  @State LiveTerminal: string = "0"
  @State printlnText: string = "> println(\"Hello, Kotlin!\")"
  @State RunCode: string = "0"
  @State CodeIDETerminal: string = "0"

  build() {
    Stack() {
      // === Scaffold ===
      Stack({ alignContent: Alignment.Top }) {
        // === Column ===
        Column({ space: 16 }) {
          // === Text ===
          Text('Project Files')
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')

          // === LazyColumn ===
          List({ space: 8 }) {
            ListItem() {
              // === Card ===
              Column() {
                // === Row ===
                Row({ space: 12 }) {
                  // === Box ===
                  Stack({ alignContent: Alignment.Center }) {
                    // === Text ===
                    Text(this.mIdStr)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#FFFFFF')
                  }
                  .width(32)
                  .height(32)
                  .backgroundColor('#0EA5E9')
                  .borderRadius(8)

                  // === Column ===
                  Column({ space: 0 }) {
                    // === Text ===
                    Text(this.mName)
                      .fontSize(18)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#E2E8F0')
                    // === Text ===
                    Text(this.mDesc)
                      .fontSize(16)
                      .fontColor('#E2E8F0')
                  }
                }
                .alignItems(VerticalAlign.Center)
                .width('100%')
                .padding(12)
              }
              .width('100%')
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000' })
            }
          }
          .width('100%')
          .layoutWeight(1)

          // === Text ===
          Text('Live Terminal')
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')

          // === Box ===
          Stack({ alignContent: Alignment.Center }) {
            // === Text ===
            Text(this.printlnText)
              .fontSize(16)
              .fontColor('#E2E8F0')
          }
          .width('100%')
          .height(240)
          .backgroundColor('#334155')
          .borderRadius(12)
          .border({ width: 1, color: '#475569', radius: 12 })
          .padding(12)

          // === Button ===
          Button() {
            // === Text ===
            Text('Run Code')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
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

        // === CenterAlignedTopAppBar ===
        Row() {
          // === Text ===
          Text('CodeIDE Terminal')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#E2E8F0')
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#111827')
      }
    }
    .width('100%')
    .height('100%')
  }
}