@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack ===
      Stack() {
        // === LinearGradient ===
        // In ArkTS, we simulate the background gradient using a Shape with linearGradient
        // Since LinearGradient component in ArkTS is for drawing, we use a full-screen shape.
        // However, to match the structure strictly, we can use a Column/Row with width/height 100% and background gradient if supported, 
        // or simply a Shape. The skeleton shows nested LinearGradients which is SwiftUI specific.
        // We will render a full-screen rectangle with the gradient as the background layer.
        Rect()
          .width('100%')
          .height('100%')
          .fill(LinearGradient({
            angle: 90,
            colors: [
              { color: '#0EA4E9', position: 0 }, // Secondary approx
              { color: '#F8FAFC', position: 0.5 }, // Background approx
              { color: '#3B82F6', position: 1 }   // Primary approx
            ]
          }))

        // === ScrollView ===
        Scroll() {
          // === VStack ===
          Column({ space: 24 }) {
            // === Text ===
            Text('Cold Gradient Price Compare')
              .fontColor('#0F172A')
              .fontSize(26)
              .fontWeight(FontWeight.Bold)

            // === LazyVGrid ===
            Grid() {
              // Simulating ForEach with static items for compilation safety without external data source
              // Item 1
              GridItem() {
                Column({ space: 8 }) {
                  // === Rectangle ===
                  Rect()
                    .borderRadius(12)
                    .width(100)
                    .height(100)
                    .fill('#DFF1FD')
                  
                  // === Text (Name) ===
                  Text('Product Name')
                    .fontColor('#0F172A')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                  
                  // === Text (Price) ===
                  Text('$19.99')
                    .fontColor('#0EA4E9')
                    .fontSize(14)
                  
                  // === Text (Store) ===
                  Text('Store Name')
                    .fontColor('#64748B')
                    .fontSize(12)
                  
                  // === Button ===
                  Button() {
                    Text('Add')
                      .fontColor('#FFFFFF')
                  }
                  .backgroundColor('#0EA4E9')
                  .borderRadius(8)
                  .margin({ top: 8 })
                }
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .shadow({ radius: 10, color: '#1F000000', offsetY: 4 })
              }
              
              // Item 2
              GridItem() {
                Column({ space: 8 }) {
                  Rect()
                    .borderRadius(12)
                    .width(100)
                    .height(100)
                    .fill('#DFF1FD')
                  
                  Text('Another Product')
                    .fontColor('#0F172A')
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                  
                  Text('$29.99')
                    .fontColor('#0EA4E9')
                    .fontSize(14)
                  
                  Text('Other Store')
                    .fontColor('#64748B')
                    .fontSize(12)
                  
                  Button() {
                    Text('Add')
                      .fontColor('#FFFFFF')
                  }
                  .backgroundColor('#0EA4E9')
                  .borderRadius(8)
                  .margin({ top: 8 })
                }
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .shadow({ radius: 10, color: '#1F000000', offsetY: 4 })
              }
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(16)
            .rowsGap(16)
            .width('100%')
            .padding({ bottom: 24 })

            // === Text ===
            Text('Price Update Log')
              .fontColor('#0EA4E9')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)

            // === LazyVStack ===
            Column({ space: 12 }) {
              // Item 1
              Row() {
                Text('Product Name (Store Name)')
                  .fontColor('#0F172A')
                  .fontSize(14)
                
                Blank()
                
                Text('$19.99')
                  .fontColor('#64748B')
                  .fontSize(12)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(8)

              // Item 2
              Row() {
                Text('Another Product (Other Store)')
                  .fontColor('#0F172A')
                  .fontSize(14)
                
                Blank()
                
                Text('$29.99')
                  .fontColor('#64748B')
                  .fontSize(12)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
            }
            .width('100%')
            .padding({ bottom: 48 })

          }
          .width('100%')
          .padding(24)
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}