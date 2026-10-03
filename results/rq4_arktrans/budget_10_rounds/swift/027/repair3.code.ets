@Entry
@Component
struct Index {
  @State selectedPage: number = 1

  build() {
    Stack() {
      Column() {
        // Header Row
        Row() {
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#1B1B1F')
          }
          .type(ButtonType.Circle)
          .backgroundColor('#E0E0E0')

          Blank()

          Text('Document.pdf')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1B1B1F')

          Blank()

          Button('Share')
            .backgroundColor('#A0C4FF')
            .borderRadius(8)
            .padding({ left: 16, right: 16 })
            .height(32)
            .fontColor('#FFFFFF')
            .fontSize(14)
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFFFFF')

        // Main Content Area
        Row() {
          // Left Sidebar (Grid)
          Grid() {
            ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], (page: number) => {
              GridItem() {
                Button(`${page}`)
                  .backgroundColor(this.selectedPage === page ? '#A0C4FF' : '#F0F0F5')
                  .borderRadius(12)
                  .height(100)
                  .width('100%')
                  .onClick(() => {
                    this.selectedPage = page
                  })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
          .columnsGap(8)
          .rowsGap(8)
          .padding(8)
          .width(150)
          .layoutWeight(1)

          // Right Content (Preview)
          Stack() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1B1B1F')
              .opacity(0.1) // Background watermark effect

            // Floating Action Panel
            Column() {
              Button('P')
                .backgroundColor('#B7E4C7')
                .borderRadius(20)
                .width(40)
                .height(40)
                .fontColor('#1B1B1F')
                .fontWeight(FontWeight.Bold)
              
              Button('H')
                .backgroundColor('#F0F0F5')
                .borderRadius(20)
                .width(40)
                .height(40)
                .fontColor('#1B1B1F')
                .fontWeight(FontWeight.Bold)
              
              Button('T')
                .backgroundColor('#F0F0F5')
                .borderRadius(20)
                .width(40)
                .height(40)
                .fontColor('#1B1B1F')
                .fontWeight(FontWeight.Bold)
              
              Button('S')
                .backgroundColor('#F0F0F5')
                .borderRadius(20)
                .width(40)
                .height(40)
                .fontColor('#1B1B1F')
                .fontWeight(FontWeight.Bold)
            }
            .itemSpacing(8)
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .shadow({ radius: 10, color: '#1F000000', offsetY: 4 })
            .alignSelf(ItemAlign.Center)
          }
          .layoutWeight(2)
          .backgroundColor('#FFFFFF')
          .borderRadius(24)
          .margin({ top: 16, bottom: 16, right: 16 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5FA')
    }.width('100%').height('100%')
  }
}