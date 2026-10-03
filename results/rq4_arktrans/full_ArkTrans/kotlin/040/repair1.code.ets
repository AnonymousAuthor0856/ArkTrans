@Entry
@Component
struct Index {
  @State query: string = ""

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 12 }) {
        Text('Retro Filter Search')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')

        TextInput({ placeholder: 'Search products' })
          .placeholderColor('#A08C7D')
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .height(56)
          .padding({ left: 16, right: 16 })
          .onChange((value: string) => {
            this.query = value
          })

        Row({ space: 8 }) {
          Button('Popular').backgroundColor('#FFCA4F').fontColor('#3E2723').borderRadius(8).height(36)
          Button('New').backgroundColor('#FFCA4F').fontColor('#3E2723').borderRadius(8).height(36)
          Button('Discount').backgroundColor('#FFCA4F').fontColor('#3E2723').borderRadius(8).height(36)
          Button('').backgroundColor('#FFCA4F').borderRadius(8).height(36).width(80)
        }.alignItems(VerticalAlign.Center)

        // Canvas Area
        Stack({ alignContent: Alignment.Center }) {
          Stack({ alignContent: Alignment.Center }) {
            Circle().width(120).height(120).fill(Color.Orange)
            Circle().width(24).height(24).fill(Color.Red).offset({ x: -20, y: -20 })
          }
        }
        .width('100%')
        .height(180)
        .backgroundColor('#FFF0C1')
        .borderRadius(24)
        .margin({ top: 8 })

        // Grid
        Grid() {
          GridItem() {
            Column({ space: 12 }) {
              Stack({ alignContent: Alignment.Center }) {
                Rect().width(96).height(96).fill('#FFEAA7').borderRadius(16)
              }.width('100%').height(120)
              
              Text('Result 1').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#3E2723')
              
              Button('Add')
                .backgroundColor('#FF7B00')
                .fontColor('#FFFFFF')
                .borderRadius(12)
                .height(48)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .shadow({ radius: 10, color: '#1A000000', offsetY: 4 })
          }

          GridItem() {
            Column({ space: 12 }) {
              Stack({ alignContent: Alignment.Center }) {
                Rect().width(96).height(96).fill('#FFEAA7').borderRadius(16)
              }.width('100%').height(120)
              
              Text('Result 2').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#3E2723')
              
              Button('Add')
                .backgroundColor('#FF7B00')
                .fontColor('#FFFFFF')
                .borderRadius(12)
                .height(48)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .shadow({ radius: 10, color: '#1A000000', offsetY: 4 })
          }
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        .width('100%')
        .layoutWeight(1)

      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFF6E5')
    }
    .width('100%')
    .height('100%')
  }
}