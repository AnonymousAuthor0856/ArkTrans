@Entry
@Component
struct RootScreen {
  @State scrollOffsetY: number = 0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Background
      Column() {}.width('100%').height('100%').backgroundColor('#FFF1F5F9')

      // Main column
      Column({ space: 0 }) {
        // Top bar
        Text('Glass Doc Reader')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#FF1E1E1E')
          .padding({ top: 20, bottom: 16 })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor('#FFF1F5F9')

        // Main content area (simulates gradient background with solid color)
        Stack({ alignContent: Alignment.Center }) {
          // Background box with gradient-like appearance (solid color)
          Column() {}.width('100%').height('100%').backgroundColor('#FFE2E8F0')

          // Surface card
          Column({ space: 12 }) {
            Text('Document Reader')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FF38BDF8')

            // 8 lines of text using List
            List({ space: 8 }) {
              ListItem() { Text('This is a sample line of text content number 1.').fontSize(14).foregroundColor('#FF1E1E1E') }
              ListItem() { Text('This is a sample line of text content number 2.').fontSize(14).foregroundColor('#FF1E1E1E') }
              ListItem() { Text('This is a sample line of text content number 3.').fontSize(14).foregroundColor('#FF1E1E1E') }
              ListItem() { Text('This is a sample line of text content number 4.').fontSize(14).foregroundColor('#FF1E1E1E') }
              ListItem() { Text('This is a sample line of text content number 5.').fontSize(14).foregroundColor('#FF1E1E1E') }
              ListItem() { Text('This is a sample line of text content number 6.').fontSize(14).foregroundColor('#FF1E1E1E') }
              ListItem() { Text('This is a sample line of text content number 7.').fontSize(14).foregroundColor('#FF1E1E1E') }
              ListItem() { Text('This is a sample line of text content number 8.').fontSize(14).foregroundColor('#FF1E1E1E') }
            }
            .width('100%')
            .layoutWeight(1)

            Blank()
          }
          .padding(16)
          .width('90%')
          .height(400)
          .backgroundColor('#FFFFFFFF').opacity(0.7)
          .borderRadius(20)
          .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
          .offset({ y: this.scrollOffsetY / 5 })
        }
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}