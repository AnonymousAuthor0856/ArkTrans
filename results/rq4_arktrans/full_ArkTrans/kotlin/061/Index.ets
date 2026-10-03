@Entry
@Component
struct Index {
  @State parcelTracker: string = 'Parcel Tracker'
  @State randomFloat: number = Math.random() * 300
  @State dragToLocate: string = 'Drag to locate parcel'
  @State visualizeText: string = 'Visualize parcel movements and positions.'

  build() {
    Stack() {
      Column({ space: 22 }) {
        Text(this.parcelTracker)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .textAlign(TextAlign.Center)

        // ParcelCanvas equivalent
        Stack({ alignContent: Alignment.Center }) {
          // Canvas simulation with dots
          Row() {
            ForEach([
              { x: 10, y: 10 }, { x: 50, y: 20 }, { x: 100, y: 15 },
              { x: 150, y: 25 }, { x: 200, y: 10 }, { x: 250, y: 30 },
              { x: 30, y: 60 }, { x: 80, y: 70 }, { x: 120, y: 65 },
              { x: 170, y: 80 }, { x: 220, y: 75 }, { x: 270, y: 90 },
              { x: 40, y: 110 }, { x: 90, y: 120 }, { x: 140, y: 115 },
              { x: 190, y: 130 }, { x: 240, y: 125 }, { x: 290, y: 140 },
              { x: 60, y: 160 }, { x: 110, y: 170 }, { x: 160, y: 165 },
              { x: 210, y: 180 }, { x: 260, y: 175 }
            ], (item: PointData) => {
              Circle({ width: 4, height: 4 })
                .fill('#374151')
                .position({ x: item.x, y: item.y })
            })
          }
          .width('100%')
          .height('100%')

          Text(this.dragToLocate)
            .fontSize(16)
            .fontColor('#1F2937')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(300)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .border({ width: 1, color: '#E5E7EB', radius: 16 })

        Text(this.visualizeText)
          .fontSize(16)
          .fontColor('#1F2937')
          .textAlign(TextAlign.Center)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [['#F3F4F6', 0], ['#FFFFFF', 1]]
      })
      .padding(14)
    }
    .width('100%')
    .height('100%')
  }
}

interface PointData {
  x: number;
  y: number;
}