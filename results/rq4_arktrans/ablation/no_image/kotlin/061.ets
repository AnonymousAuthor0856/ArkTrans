@Entry
@Component
struct Index {
  @State parcelTracker: number = 0
  @State randomFloat: number = 0
  @State dragToLocateParcel: number = 0
  @State visualizeParcelMovements: number = 0

  build() {
    Stack() {
      Column({ space: 22 }) {
        Text('Parcel Tracker')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')

        ParcelCanvas()

        Text('Visualize parcel movements and positions.')
          .fontSize(14)
          .fontColor('#1F2937')
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .backgroundColor('#F3F4F6')
      .padding(14)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ParcelCanvas {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context).width('100%').height('100%')
      
      Text('Drag to locate parcel')
        .fontSize(14)
        .fontColor('#1F2937')
    }
    .width('100%')
    .height(300)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#E5E7EB', radius: 16 })
  }
}