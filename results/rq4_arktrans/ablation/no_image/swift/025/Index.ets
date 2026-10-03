@Entry
@Component
struct Index {
  build() {
    Stack() {
      // WindowGroup is a SwiftUI concept, in ArkTS we just render the content directly inside the Entry component's build.
      // The skeleton shows a ZStack (mapped to Stack) with 4 children.
      Stack() {
        // === Canvas ===
        // In ArkTS, Canvas requires a draw event handler. We provide a minimal implementation.
        Canvas().width('100%').height('100%')

        // === VStack (Top) ===
        Column() {
          Text('Neon Mind Map')
            .backgroundColor('#FF0D0D0D')
            .width('100%')
            .padding({ top: 12, bottom: 12 })
            .fontColor('#FF00FFFF')
            .fontSize(28)
          
          Blank()
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .layoutWeight(1)

        // === VStack (Bottom Controls) ===
        Column() {
          Blank()
          
          Row() {
            // Button Cyan
            Button() {
              Text('Cyan')
                .padding({ top: 4, bottom: 4 })
                .padding({ left: 12, right: 12 })
                .fontColor('#FF000000')
                .fontSize(14)
            }
            .type(ButtonType.Normal)
            .borderRadius(15)
            .backgroundColor('#FF00FFFF')
            
            // Button Green
            Button() {
              Text('Green')
                .padding({ top: 4, bottom: 4 })
                .padding({ left: 12, right: 12 })
                .fontColor('#FF000000')
                .fontSize(14)
            }
            .type(ButtonType.Normal)
            .borderRadius(15)
            .backgroundColor('#FF00FF88')
            
            // Button Purple
            Button() {
              Text('Purple')
                .padding({ top: 4, bottom: 4 })
                .padding({ left: 12, right: 12 })
                .fontColor('#FF000000')
                .fontSize(14)
            }
            .type(ButtonType.Normal)
            .borderRadius(15)
            .backgroundColor('#FFBB86FC')
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          .padding(12)
          .shadow({ radius: 6, color: '#3F000000' }) // Approximating elevation shadow
          .backgroundColor('#FF303030') // Approximating surfaceVariant
        }
        .alignItems(HorizontalAlign.Center)
        .width('100%')
      }
    }.width('100%').height('100%')
  }
}