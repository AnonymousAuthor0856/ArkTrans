@Entry
@Component
struct Index {
  @State of: string = "0"
  @State documentReader: string = "0"
  @State it: number = 0
  @State glassDocReader: string = "0"

  build() {
    Stack() {
      // === Offset ===
      // Note: Offset is a modifier in ArkTS, not a component. 
      // The skeleton implies an offset effect, but since there's no target component specified for the offset prop in the skeleton structure clearly,
      // and Offset() as a standalone component doesn't exist in standard ArkTS UI library in this context,
      // we will interpret the "Offset" block as potentially misplaced metadata or apply it to the main container if applicable.
      // However, looking at the skeleton, it seems to be a separate node. Since we cannot create a void component, 
      // and the next sibling is Scaffold (Stack), we will proceed with the Stack.
      
      // === Scaffold ===
      Stack({ alignContent: Alignment.Top }) {
        // === Box ===
        Stack({ alignContent: Alignment.Center }) {
          // === Surface ===
          Column() {
            // === Column ===
            Column({ space: 12 }) {
              // === Text ===
              Text('Document Reader')
                .fontColor('#38BDF8')
              
              // === Text ===
              Text(`This is a sample line of text content number ${this.it + 1}.`)
                .fontColor('#1E1E1E')
            }
            .width('100%')
            .height('100%')
            .padding(16)
          }
          .backgroundColor('#FFFFFF')
          .shadow({ radius: 4, color: '#1A000000' })
          .width('90%') // fillMaxWidth 0.9f
          .height(400)
        }
        .width('100%')
        .height('100%')
        .padding(16) // Approximation for 'pad'
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#F1F5F9', 0], ['#F1F5F9', 0.5], ['#F1F5F9', 1]] // Simplified gradient approximation as AppTokens are not available
        })

        // === CenterAlignedTopAppBar ===
        Row() {
          // === Text ===
          Text('Glass Doc Reader')
            .fontColor('#1E1E1E')
            .fontSize(24) // Approximation for displayLarge
        }
        .width('100%')
        .height(56)
        .backgroundColor('#F1F5F9') // Approximation for background color
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}