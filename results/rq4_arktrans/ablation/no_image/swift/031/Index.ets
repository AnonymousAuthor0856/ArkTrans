@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Scroll() {
          Column() {
            ForEach([], (item: string) => {
              Text(item)
            })
          }.padding({ top: 8, bottom: 8 }).padding({ left: 16, right: 16 })
        }.scrollBar(BarState.Off).padding({ bottom: 4 })
      }
    }.width('100%').height('100%')
  }
}