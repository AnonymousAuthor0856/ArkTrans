@Entry
@Component
struct Index {
  @State markerPosition: number = 0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Box (Outer Container) ===
      Stack({ alignContent: Alignment.Center }) {
        // === Box (Inner Map Area) ===
        Stack({ alignContent: Alignment.Center }) {
          // === Canvas ===
          Canvas().width('100%').height('100%')
        }
        .width('100%')
        .height(400)
        .borderRadius(24) // Approximation of AppTokens.Shapes.large
        .border({ width: 1, color: '#E5E7EB', radius: 24 }) // Approximation of outline/large shape
        .backgroundColor('#F3F4F6') // Fallback for radial gradient

        // === Column (Controls) ===
        Column({ space: 12 }) {
          // === Text ===
          Text(`Spot Coordinates: (${this.markerPosition}, ${this.markerPosition})`)
            .fontColor('#111827')
            .fontSize(14) // bodyMedium approximation

          // === Button ===
          Button() {
            Text('Save Marker')
              .fontColor('#FFFFFF')
              .fontSize(16) // titleMedium approximation
          }
          .width('100%')
          .height(48)
          .backgroundColor('#3B82F6') // primary color approximation
          .borderRadius(12) // medium shape approximation
        }
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .position({ x: 0, y: 'auto' }) // Align to bottom via Stack alignment if needed, but here we use layoutWeight or fixed positioning logic. 
        // Note: The skeleton implies this column is inside the outer stack. 
        // To mimic "Alignment.BottomCenter" in a Stack, we usually rely on the Stack's alignContent or explicit positioning.
        // Since the outer Stack is Center, and we want this at bottom, we might need to adjust.
        // However, following the skeleton structure strictly:
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#F9FAFB') // Fallback for linear gradient

      // === CenterAlignedTopAppBar ===
      Row() {
        Text('Favorite Spots Map')
          .fontColor('#111827')
          .fontSize(24) // displayLarge approximation
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFFFF')
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
  }
}