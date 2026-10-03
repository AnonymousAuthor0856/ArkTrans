import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        // Header Row
        Row() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .onClick(() => {
              router.back();
            })

          Blank()

          Text('Details')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')

          Blank()

          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })

        Scroll() {
          Column() {
            Blank().height(24)

            // Product Image Placeholder
            Stack() {
              Rect()
                .fill('#F5F5F5')
                .borderRadius(32)
              
              Image($r('app.media.startIcon'))
                .width(80)
                .height(80)
                .objectFit(ImageFit.Contain)
                .opacity(0.2)
            }
            .width('100%')
            .height(300)

            Blank().height(32)

            // Title and Price
            Row() {
              Column() {
                Text('Caramel Macchiato')
                  .fontSize(26)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#000000')
                  .lineHeight(32)
                
                Text('Minimalist Series')
                  .fontSize(16)
                  .fontColor('#999999')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Text('$4.50')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
            }
            .width('100%')

            Blank().height(24)

            // Rating
            Row() {
              Image($r('app.media.startIcon'))
                .width(20)
                .height(20)
                .objectFit(ImageFit.Contain)
                .fillColor('#FFC107')

              Blank().width(4)

              Text('4.8')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')

              Blank().width(8)

              Text('(230 reviews)')
                .fontSize(14)
                .fontColor('#999999')
            }

            Blank().height(24)

            // Description Section
            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
            
            Blank().height(12)

            Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffe...')
              .fontSize(16)
              .fontColor('#999999')
              .lineHeight(24)
              .maxLines(4)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            Blank().height(24)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .layoutWeight(1)

        // Bottom Action Bar
        Row() {
          Column() {
            Text('Price')
              .fontSize(14)
              .fontColor('#999999')
            
            Text('$ 4.50')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#6D4C41')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button('Add to Cart')
            .backgroundColor('#6D4C41')
            .fontColor('#FFFFFF')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .borderRadius(16)
            .height(56)
            .layoutWeight(1)
            .margin({ left: 16 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .shadow({ radius: 10, color: '#10000000', offsetY: -2 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}