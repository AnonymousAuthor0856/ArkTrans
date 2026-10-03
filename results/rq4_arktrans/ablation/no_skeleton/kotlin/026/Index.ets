@Entry
@Component
struct RootScreen {
  @State scrollOffset: number = 0

  build() {
    // === Column ===
    // props: { space: 16 }
    // modifier: { width: '100%', height: '100%', padding: 16, backgroundColor: '#F1F5F9' }
    // children: 2
    Column({ space: 16 }) {
      // === Text ===
      // props: { text: 'Glass Doc Reader' }
      // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#1E1E1E', textAlign: TextAlign.Center }
      Text('Glass Doc Reader')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .textAlign(TextAlign.Center)

      // === Blank ===
      Blank()

      // === Stack ===
      // props: { alignContent: Alignment.Center }
      // modifier: { width: '100%', layoutWeight: 1 }
      // children: 1
      Stack({ alignContent: Alignment.Center }) {
        // === Column ===
        // props: { space: 12 }
        // modifier: { width: '90%', height: 400, borderRadius: 20, shadow: { radius: 8, color: '#2D000000', offsetY: 4 }, backgroundColor: '#FFFFFFB3' }
        // children: 9
        Column({ space: 12 }) {
          // === Text ===
          // props: { text: 'Document Reader' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#38BDF8', padding: 16 }
          Text('Document Reader')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#38BDF8')
            .padding(16)

          // === Text ===
          // props: { text: 'This is a sample line of text content number 1.' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#1E1E1E', padding: { left: 16, right: 16 } }
          Text('This is a sample line of text content number 1.')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#1E1E1E')
            .padding({ left: 16, right: 16 })

          // === Text ===
          // props: { text: 'This is a sample line of text content number 2.' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#1E1E1E', padding: { left: 16, right: 16 } }
          Text('This is a sample line of text content number 2.')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#1E1E1E')
            .padding({ left: 16, right: 16 })

          // === Text ===
          // props: { text: 'This is a sample line of text content number 3.' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#1E1E1E', padding: { left: 16, right: 16 } }
          Text('This is a sample line of text content number 3.')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#1E1E1E')
            .padding({ left: 16, right: 16 })

          // === Text ===
          // props: { text: 'This is a sample line of text content number 4.' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#1E1E1E', padding: { left: 16, right: 16 } }
          Text('This is a sample line of text content number 4.')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#1E1E1E')
            .padding({ left: 16, right: 16 })

          // === Text ===
          // props: { text: 'This is a sample line of text content number 5.' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#1E1E1E', padding: { left: 16, right: 16 } }
          Text('This is a sample line of text content number 5.')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#1E1E1E')
            .padding({ left: 16, right: 16 })

          // === Text ===
          // props: { text: 'This is a sample line of text content number 6.' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#1E1E1E', padding: { left: 16, right: 16 } }
          Text('This is a sample line of text content number 6.')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#1E1E1E')
            .padding({ left: 16, right: 16 })

          // === Text ===
          // props: { text: 'This is a sample line of text content number 7.' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#1E1E1E', padding: { left: 16, right: 16 } }
          Text('This is a sample line of text content number 7.')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#1E1E1E')
            .padding({ left: 16, right: 16 })

          // === Text ===
          // props: { text: 'This is a sample line of text content number 8.' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#1E1E1E', padding: { left: 16, right: 16 } }
          Text('This is a sample line of text content number 8.')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#1E1E1E')
            .padding({ left: 16, right: 16 })
        }
        .width('90%')
        .height(400)
        .borderRadius(20)
        .shadow({ radius: 8, color: '#2D000000', offsetY: 4 })
        .backgroundColor('#FFFFFFB3')
        .translate({ y: this.scrollOffset / 5 })
      }
      .width('100%')
      .layoutWeight(1)
      .gesture(
        PanGesture()
          .onActionUpdate((event?: GestureEvent) => {
            if (event) {
              this.scrollOffset += event.offsetY
            }
          })
      )
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F1F5F9')
  }
}