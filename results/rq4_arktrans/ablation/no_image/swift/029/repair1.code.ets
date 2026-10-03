@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        // === ZStack (AppBar) ===
        Stack() {
          Text('File Manager')
            .fontColor('#111111')
            .fontSize(26)
        }
        .height(56) // Approximation of AppTokens.Spacing.totalAppBarHeight

        // === VStack (Content) ===
        Column() {
          Text('Recent Files')
            .fontColor('#111111')
            .fontSize(18)

          Grid() {
            ForEach([0, 1], (item: number) => {
              GridItem() {
                Column() {
                  BoxView()
                  Blank()
                  Column({ space: 2 }) {
                    Text('file.name')
                      .fontColor('#111111')
                      .fontSize(14)
                    Text('file.size')
                      .fontColor('#999999')
                      .fontSize(12)
                  }.alignItems(HorizontalAlign.Start)
                }
                .width('100%')
                .height(120)
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .shadow({ radius: 4, color: '#1F000000' })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(16)
          .rowsGap(16)
          .layoutWeight(1)
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#F5F5F5')
        .alignItems(HorizontalAlign.Start)
      }
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct BoxView {
  build() {
    Image($r('app.media.startIcon'))
      .width(40)
      .height(40)
  }
}