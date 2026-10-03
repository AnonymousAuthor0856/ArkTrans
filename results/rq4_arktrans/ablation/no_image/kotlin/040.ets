@Entry
@Component
struct Index {
  @State query: string = ""
  @State knobOffsetX: number = 160
  @State knobOffsetY: number = 120

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 12 }) {
        Text('Retro Filter Search')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')

        TextInput({ placeholder: 'Search products' })
          .width('100%')
          .height(48)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .border({ width: 1, color: '#D7CCC8' })
          .onChange((value: string) => {
            this.query = value
          })

        Row({ space: 8 }) {
          ForEach(['Popular', 'New', 'Discount', 'Premium'], (item: string) => {
            Button() {
              Text(item)
                .fontSize(14)
                .fontColor('#3E2723')
            }
            .height(36)
            .backgroundColor('#FFE0B2')
            .borderRadius(16)
            .onClick(() => {
              // onClick handler
            })
          })
        }.alignItems(VerticalAlign.Center)

        Stack({ alignContent: Alignment.Center }) {
          Canvas().width('100%').height('100%')
        }
        .width('100%')
        .height(180)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)

        Grid() {
          ForEach([1, 2], () => {
            GridItem() {
              Column({ space: 8 }) {
                Stack({ alignContent: Alignment.Center }) {
                  // Placeholder for image/icon
                  Text('Icon')
                    .fontColor('#FFF0C1')
                }
                .width(96)
                .height(96)
                .backgroundColor('#FFF0C1')
                .borderRadius(8)

                Text('Product Title')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#3E2723')

                Button() {
                  Text('Add')
                    .fontSize(14)
                    .fontColor('#FFFFFF')
                }
                .width('100%')
                .backgroundColor('#FFB74D')
                .borderRadius(8)
                .onClick(() => {
                  // onClick handler
                })
              }
              .alignItems(HorizontalAlign.Center)
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000' })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        .width('100%')
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