import { drawing } from '@kit.ArkGraphics';

@Entry
@Component
struct Index {
  private ctx: drawing.DrawingContext = new drawing.DrawingContext()

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        Text('Parcel Tracker')
          .fontColor('#111827')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .width('100%')

        Stack() {
          Canvas(this.ctx).width('100%').height(300)
          Text('Drag to locate parcel')
            .fontColor('#1F2937')
            .fontSize(14)
        }
        .width('100%')
        .height(300)
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .margin({ top: 16, bottom: 16 })
        .shadow({ radius: 8, color: '#0D000000', offsetY: 4 })

        Blank()

        Text('Visualize parcel movements and positions.')
          .fontColor('#1F2937')
          .fontSize(14)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#E5E7EB', 0], ['#F3F4F6', 1]]
      })
    }.width('100%').height('100%')
  }
}