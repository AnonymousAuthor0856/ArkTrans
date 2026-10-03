@Entry
@Component
struct Index {
  @State textOpacity: number = 1.0
  @State uploadProgress: number = 0.5

  build() {
    Stack() {
      // === ZStack (Outer) ===
      Stack({ alignContent: Alignment.Bottom }) {
        // Modifiers for outer stack
        .backgroundColor('#ECEFF1') // AppTokens.Colors.background
        .width('100%')
        .height('100%')

        // === VStack (Main Content) ===
        Column({ space: 0 }) {
          // === HStack (Top Bar) ===
          Row() {
            // Button 1
            Button()
              .padding({ left: 4, right: 4 }) // AppTokens.Spacing.sm horizontal
            
            Blank()
            
            Text('Story Editor')
              .fontColor('#263238') // AppTokens.Colors.onSurface
              .fontSize(18) // AppTokens.TypographyTokens.title
            
            Blank()
            
            // Button 2
            Button()
              .padding({ left: 4, right: 4 }) // AppTokens.Spacing.sm horizontal
              .clipShape(RoundedRectangle()) // Approximation of AppTokens.Shapes.medium
              .backgroundColor('#1976D2') // AppTokens.Colors.primary
          }
          .backgroundColor('#FFFFFF') // AppTokens.Colors.surface
          .height(56) // AppTokens.topBarHeight approximation

          // === ScrollView (Content) ===
          Scroll() {
            // === VStack (Scroll Content) ===
            Column({ space: 24 }) { // AppTokens.Spacing.lg
              // === ZStack (Preview Area) ===
              Stack() {
                Text('Your Story Preview')
                  .textAlign(TextAlign.Center)
                  .fontColor(Color.White.withAlpha(this.textOpacity)) // AppTokens.Colors.onTertiary approx
                  .fontSize(24) // AppTokens.TypographyTokens.headline
              }
              .padding({ left: 24, right: 24 }) // AppTokens.Spacing.lg horizontal
              .height(200)

              // === VStack (Upload Status) ===
              Column({ space: 8 }) { // AppTokens.Spacing.sm
                
                Text('Upload Status')
                  .fontColor('#607D8B') // AppTokens.Colors.secondary
                  .fontSize(12) // AppTokens.TypographyTokens.label
                
                // Progress Bar Stack
                Stack({ alignContent: Alignment.Start }) {
                  Rect()
                    .fill('#CFD8DC') // AppTokens.Colors.surfaceVariant
                    .height(4) // AppTokens.Spacing.sm height approx
                  
                  Rect()
                    .fill('#4CAF50') // AppTokens.Colors.success
                    .height(4)
                    .width(`${this.uploadProgress * 100}%`) // Simplified geometry.size.width logic
                }
              }
              .padding({ left: 24, right: 24 }) // AppTokens.Spacing.lg horizontal

              // === VStack (Story Layers) ===
              Column({ space: 8 }) { // AppTokens.Spacing.sm
                
                Text('Story Layers')
                  .padding({ left: 24, right: 24 }) // AppTokens.Spacing.lg horizontal
                  .fontColor('#607D8B') // AppTokens.Colors.secondary
                  .fontSize(12) // AppTokens.TypographyTokens.label

                // Horizontal ScrollView
                Scroll() {
                  Row({ space: 24 }) { // AppTokens.Spacing.lg spacing
                    
                    ForEach([1, 2, 3], (item: number) => {
                      Button() {
                        Column({ space: 8 }) { // AppTokens.Spacing.sm
                          Circle()
                            .width(32)
                            .height(32)
                            .fill('#CFD8DC') // AppTokens.Colors.surfaceVariant

                          Text('Layer Type')
                            .fontColor('#263238') // AppTokens.Colors.onSurface
                            .fontSize(12) // AppTokens.TypographyTokens.label

                          Text('Layer Content Description')
                            .maxLines(2)
                            .textAlign(TextAlign.Center)
                            .fontColor('#263238') // AppTokens.Colors.onSurface
                            .fontSize(14) // AppTokens.TypographyTokens.body
                        }
                        .width(130)
                        .padding({ top: 12, bottom: 12, left: 24, right: 24 }) // AppTokens.Spacing.xxl/vertical md
                        .backgroundColor('#FFFFFF') // AppTokens.Colors.surface
                        .borderRadius(8)
                        .border({ width: 1, color: '#E0E0E0' }) // Overlay stroke approximation
                      }
                      .type(ButtonType.Normal) // PlainButtonStyle equivalent
                    })
                  }
                  .padding({ left: 24, right: 24 }) // AppTokens.Spacing.lg horizontal
                  .padding({ top: 12, bottom: 12 }) // AppTokens.Spacing.md vertical
                }
                .scrollBar(BarState.Off) // showsIndicators: false
              }
            }
            .padding({ top: 24, bottom: 24 }) // AppTokens.Spacing.lg vertical
          }
          .backgroundColor('#ECEFF1') // AppTokens.Colors.background
        }

        // === VStack (Bottom Sheet / Layer Properties) ===
        Column({ space: 12 }) { // AppTokens.Spacing.md
          
          Text('Layer Properties')
            .fontColor('#607D8B') // AppTokens.Colors.secondary
            .fontSize(12) // AppTokens.TypographyTokens.label

          Row() {
            Text('Opacity')
              .width(80)
              .textAlign(TextAlign.Start)
              .fontSize(14) // AppTokens.TypographyTokens.body
            
            Slider({ value: this.textOpacity, min: 0, max: 1 })
              .trackColor('#1976D2') // AppTokens.Colors.primary
          }
        }
        .padding(24) // AppTokens.Spacing.lg
        .backgroundColor('#FFFFFF') // AppTokens.Colors.surface
        .shadow({ radius: 6, color: Color.Black.withAlpha(0.1), offsetY: -2 })
        .alignItems(HorizontalAlign.Start)
      }
    }
    .width('100%')
    .height('100%')
  }
}