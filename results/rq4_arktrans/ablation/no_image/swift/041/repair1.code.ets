@Entry
@Component
struct Index {
  build() {
    Stack() {
      // WindowGroup is a SwiftUI concept, in ArkTS we just render the content directly inside the Entry component's build.
      // The skeleton implies a single screen view.
      Stack() {
        Column({ space: 12 }) {
          Text('Product Detail')
            .fontColor('#FF111111')
            .fontSize(28)

          Column() {
            Rect()
              .fill('#FFE5E5E5')
              .height(160)
              .width('100%')

            Text('Monochrome Bag')
              .fontColor('#FF111111')
              .fontSize(18)

            Text('A minimalist and timeless design piece.')
              .fontColor('#FF777777')
              .fontSize(14)

            Text('$79.00')
              .fontColor('#FF111111')
              .fontSize(18)

            Button() {
              Text('Add to Cart')
                .borderRadius(8)
                .fontColor('#FFFFFFFF')
                .backgroundColor('#FF111111')
                .height(48)
                .width('100%')
                .fontSize(18)
            }
          }
          .shadow({ radius: 6, color: '#1F000000' })
          .borderRadius(16)
          .backgroundColor('#FFF9F9F9')
          .padding(12)

          Stack() {
            Rect()
              .fill('#FFF9F9F9')
            
            // Canvas in SwiftUI is complex. In ArkTS, for a simple placeholder or drawing area, 
            // we might use a Shape or a custom component. Since no specific drawing logic is provided 
            // other than padding, we represent it as a container.
            // Note: ArkTS Canvas requires a context and draw function. Without specific draw instructions,
            // we treat this as a visual block.
            Column() {
              // Placeholder for Canvas content if any
            }.padding(12)
          }
          .height(240)
          .width('100%')

          Row({ space: 12 }) {
            Button() {
              // Marker is a custom SwiftUI view. We represent it with a Text or Image placeholder.
              // Since no image resource is specified for Marker, we use Text.
              // Fix: Button can only have one child. Wrap multiple texts in a Column.
              Column() {
                Text('New')
                Text('Add Marker')
                  .borderRadius(8)
                  .fontColor('#FFFFFFFF')
                  .backgroundColor('#FF333333')
                  .height(44)
                  .width('100%')
                  .fontSize(12)
              }
            }

            Button() {
              Text('Clear')
                .borderRadius(8)
                .fontColor('#FF111111')
                .backgroundColor('#FF777777')
                .height(44)
                .width('100%')
                .fontSize(12)
            }
          }
        }
        .alignItems(HorizontalAlign.Start)
        .padding(12)
      }
    }
    .width('100%')
    .height('100%')
  }
}