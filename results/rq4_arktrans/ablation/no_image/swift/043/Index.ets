@Entry
@Component
struct Index {
  @State promo: string = ''

  build() {
    Stack() {
      // Simulating WindowGroup/Scene context with a full-screen container
      Column() {
        Stack() {
          // Background Gradient
          // Mapping SwiftUI LinearGradient to ArkTS LinearGradient
          // Note: ArkTS LinearGradient is usually applied via .linearGradient modifier or inside Shape, 
          // but here we simulate the visual layer. Since LinearGradient isn't a direct component in ArkTS like SwiftUI,
          // we use a Column with a linear gradient background.
          Column() {
            // Placeholder for gradient content if needed, otherwise just the background
          }
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 90,
            colors: [
              ['rgba(26, 26, 26, 1)', 0],   // AppTokens.Colors.background (approximated dark)
              ['rgba(30, 30, 30, 1)', 1]     // AppTokens.Colors.surfaceVariant (approximated dark)
            ]
          })

          // Scrollable Content
          Scroll() {
            Column() {
              // Header Text
              Text('Your Cart')
                .fontSize(28)
                .fontColor('#00E5FF') // AppTokens.Colors.primary
                .textAlign(TextAlign.Start)
                .width('100%')
                .margin({ bottom: 16 }) // Spacing.lg approx

              // ForEach Items (Simulated with static items as no data source provided)
              // In a real app, this would iterate over an array of cart items
              Column() {
                Text('Item 1 - $10.00').fontColor('#FFFFFF').fontSize(14).margin({ bottom: 8 })
                Text('Item 2 - $20.00').fontColor('#FFFFFF').fontSize(14).margin({ bottom: 8 })
              }

              Blank().height(8) // Spacer md

              // Promo Code Input
              Row() {
                TextInput({ placeholder: 'Promo Code' })
                  .backgroundColor('#1E1E1E') // AppTokens.Colors.surfaceVariant
                  .borderRadius(12) // AppTokens.Shapes.medium
                  .padding(8)
                  .width('100%')
                  .height(44)
                  .fontColor('#FFFFFF')
                  .placeholderColor('#80FFFFFF') // 0xFFFFFFFF.opacity(0.5)
                  .border({ width: 1, color: '#2C2C2C', radius: 12 })
              }

              Blank().height(8) // Spacer md

              // Summary Card
              Column() {
                Row() {
                  Text('Items')
                    .fontColor('#FFFFFF') // AppTokens.Colors.onSurface
                    .fontSize(14)
                  Blank()
                  Text('2') // items.count simulated
                    .fontColor('#00E5FF') // AppTokens.Colors.primary
                    .fontSize(14)
                }.width('100%')

                Divider().color('#404040').margin({ top: 12, bottom: 12 })

                Row() {
                  Text('Total')
                    .fontColor('#FFFFFF') // AppTokens.Colors.onSurface
                    .fontSize(18) // Title size
                  Blank()
                  Text('$30.00') // Total simulated
                    .fontColor('#00E5FF') // AppTokens.Colors.primary
                    .fontSize(18)
                }.width('100%')
              }
              .width('100%')
              .backgroundColor('#1E1E1E') // AppTokens.Colors.surfaceVariant
              .borderRadius(16) // AppTokens.Shapes.large
              .padding(16)
              .shadow({ radius: 8, color: '#00000040' }) // Elevation shadow

              Blank().height(16) // Spacer lg

              // Checkout Button
              Button() {
                Text('Checkout')
                  .fontColor('#0A0A0A') // AppTokens.Colors.onSecondary
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
              }
              .width('100%')
              .height(56)
              .backgroundColor('#00BFA5') // AppTokens.Colors.secondary
              .borderRadius(16) // AppTokens.Shapes.large
            }
            .padding(16) // AppTokens.Spacing.lg
            .width('100%')
          }
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