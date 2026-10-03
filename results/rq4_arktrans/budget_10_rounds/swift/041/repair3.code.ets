import { drawing } from '@kit.ArkGraphics';

@Entry
@Component
struct Index {
  private ctx: drawing.DrawingContext = new drawing.DrawingContext()

  build() {
    Stack() {
      Column({ space: 16 }) {
        Text('Product Detail')
          .fontColor('#111111')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)

        Column() {
          Rect()
            .fill('#E5E5E5')
            .height(160)
            .width('100%')

          Text('Monochrome Bag')
            .fontColor('#111111')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 16, bottom: 4 })

          Text('A minimalist and timeless design piece.')
            .fontColor('#777777')
            .fontSize(14)
            .margin({ bottom: 8 })

          Text('$79.00')
            .fontColor('#111111')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 16 })

          Button() {
            Text('Add to Cart')
              .fontColor('#FFFFFF')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
          }
          .backgroundColor('#111111')
          .borderRadius(12)
          .height(48)
          .width('100%')
        }
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .shadow({ radius: 10, color: '#1F000000', offsetY: 4 })

        Stack() {
          Rect()
            .fill('#F9F9F9')
            .width('100%')
            .height('100%')
            .borderRadius(24)

          Canvas(this.ctx).width('100%').height('100%')
        }
        .height(240)
        .width('100%')
        .padding(12)
        .borderRadius(24)
        .backgroundColor('#FFFFFF')

        Row({ space: 12 }) {
          Button() {
            Text('Add Marker')
              .fontColor('#FFFFFF')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
          }
          .backgroundColor('#333333')
          .borderRadius(12)
          .height(44)
          .layoutWeight(1)

          Button() {
            Text('Clear')
              .fontColor('#111111')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
          }
          .backgroundColor('#777777')
          .borderRadius(12)
          .height(44)
          .layoutWeight(1)
        }
      }
      .padding(16)
      .width('100%')
      .height('100%')
      .backgroundColor('#FAFAFA')
    }.width('100%').height('100%')
  }
}