@Entry
@Component
struct Index {
  @State isGridMode: boolean = true

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === HomeTopBar ===
      Row() {
        // Menu Icon
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .margin({ right: 16 })

        // Title
        Text('Notes')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#191D19')
          .layoutWeight(1)

        // Search Icon
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .margin({ right: 16 })

        // Grid/List Toggle Icon
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .margin({ right: 16 })

        // More Vert Icon
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#F8FBF1')
      .alignItems(VerticalAlign.Center)

      // === NotesList (Empty State) ===
      Stack({ alignContent: Alignment.Center }) {
        Column({ space: 8 }) {
          Text('No notes yet')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#424940')
          
          Text('Tap + to create your first note')
            .fontSize(16)
            .fontColor('#424940')
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8FBF1')

      // === FloatingActionButton ===
      Button() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor('#D7F5D9')
      .shadow({ radius: 6, color: '#3F000000', offsetY: 4 })
      .position({ x: 'calc(100% - 64px)', y: 'calc(100% - 64px)' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FBF1')
  }
}