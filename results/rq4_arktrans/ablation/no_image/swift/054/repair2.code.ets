@Entry
@Component
struct Index {
  build() {
    Stack() {
      Stack() {
        Column({ space: 0 }) {
          Row() {
            Text('Homework Submit').fontColor('#1E293B').fontSize(26)
          }.backgroundColor('#FFFFFF').padding({ top: 12, bottom: 12 }).width('100%')

          Scroll() {
            Column() {
              Text('Assignments').fontColor('#1E293B').fontSize(18)

              Grid() {
                ForEach([0, 1], (item: number) => {
                  GridItem() {
                    Column() {
                      Rect().borderRadius(4).width(40).height(40).fill('#06B6D4')
                      Blank()
                      Text('Title').fontColor('#1E293B').fontSize(16)
                      Text('Status').fontColor('#1E293B').fontSize(12)
                    }.aspectRatio(1.0).borderRadius(8).backgroundColor('#FFFFFF')
                  }
                })
              }.columnsTemplate('1fr 1fr').columnsGap(8).rowsGap(8).padding({ bottom: 12 })

              Text('Progress Chart').fontColor('#1E293B').fontSize(18)

              Column() {
                ForEach([0, 1], (item: number) => {
                  Column() {
                    Row() {
                      Rect().borderRadius(4).width('50%').fill('#0EA5E9')
                      Blank()
                    }.borderRadius(4).backgroundColor('#F1F5F9').width('100%')
                    Text('Label: 50%').fontColor('#1E293B').fontSize(14)
                  }
                })
              }

              Button() {
                Text('Submit New HW')
              }.width('100%').height(40).margin({ top: 12 })
            }.padding(12)
          }.backgroundColor('#E0F2FE') // Simplified gradient representation for ArkTS compatibility without complex linear gradient builder in this context
        }
      }.safeAreaEdge(SafeAreaType.TOP | SafeAreaType.BOTTOM)
    }.width('100%').height('100%')
  }
}