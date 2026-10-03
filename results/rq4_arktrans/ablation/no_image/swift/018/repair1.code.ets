@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Column({ space: 12 }) {
          Text('Filter Shop').fontColor(0x433E3A).fontSize(28)
          Row({ space: 8 }) {
            ForEach([], (item: string) => {
              Text(item)
            })
          }
        }.width('100%')

        Scroll() {
          Grid() {
            ForEach([], (item: string) => {
              GridItem() {
                Column() {
                  Column({ space: 8 }) {
                    Text('Name').fontWeight(FontWeight.Bold).fontSize(18).fontColor(0x433E3A)
                    Text('Author').fontSize(14).fontColor(0x6B6560)
                    Text('$10.00').fontWeight(FontWeight.Bold).fontSize(18).fontColor(0xD7BBA8)
                  }.padding(8)
                }.backgroundColor(0xF0EBE3).borderRadius(16).padding(8)
              }
            })
          }.columnsTemplate('1fr 1fr').columnsGap(12).rowsGap(12).padding(16)
        }.layoutWeight(1).backgroundColor(0xF0EBE3)

        Row() {
          Text('3 items in cart').fontColor(0x433E3A).lineSpacing(6).fontSize(14)
          Blank()
          Button() {
            Text('Checkout')
          }.buttonStyle(ButtonStateEffect.NONE).backgroundColor(0xD7BBA8).borderRadius(16)
        }.width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}