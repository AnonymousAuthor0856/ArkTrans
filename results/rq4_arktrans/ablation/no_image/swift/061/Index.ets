@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Text('Parcel Tracker').fontColor('#111827').fontSize(26)

        Stack() {
          Canvas().width('100%').height('100%').padding(8)
          Text('Drag to locate parcel').fontColor('#1F2937').fontSize(12)
        }.width('100%').height(300).backgroundColor('#FFFFFF')

        Text('Visualize parcel movements and positions.').fontColor('#1F2937').fontSize(12)
      }.width('100%').height('100%').padding(16)
    }.width('100%').height('100%')
  }
}