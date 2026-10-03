@Entry
@Component
struct Index {
  @State isAutoUpdate: boolean = false

  build() {
    Stack() {
      // === ZStack ===
      Stack() {
        // === VStack ===
        Column({ space: 0 }) {
          // === Text ===
          Text('Crypto Market')
            .backgroundColor('#1E1B24') // AppTokens.Colors.background approximation
            .width('100%')
            .padding({ top: 12, bottom: 12 })
            .fontColor('#FFFFFF') // AppTokens.Colors.onSurface approximation
            .fontSize(28)

          // === VStack ===
          Column({ space: 12 }) {
            // === HStack ===
            Row({ space: 8 }) {
              // === ForEach ===
              ForEach(['BTC', 'ETH', 'SOL', 'ADA'], (item: string) => {
                // === Button ===
                Button() {
                  // === Text ===
                  Text(item)
                    .padding({ top: 4, bottom: 4 })
                    .padding({ left: 8, right: 8 })
                    .fontColor('#FFFFFF') // AppTokens.Colors.onPrimary approximation
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                }
                .type(ButtonType.Circle)
                .backgroundColor(this.isAutoUpdate ? '#D0BCFF' : '#49454F') // Approximation of primary/surfaceVariant logic
                .borderRadius(8)
              })
            }

            // === ZStack ===
            Stack() {
              // === RoundedRectangle ===
              Rect()
                .shadow({
                  color: Color.Black.withAlpha(0.1), // Approximation
                  radius: 8,
                  offsetX: 0,
                  offsetY: 4
                })
                .fill('#36343F') // AppTokens.Colors.surface approximation
                .width('100%')
                .height(260)
                .borderRadius(16)

              // === Canvas ===
              Canvas()
                .padding(12)
                .width('100%')
                .height('100%')
            }
            .width('100%')
            .height(260)

            // === Text ===
            Text('Price Variation')
              .fontColor('#D0BCFF') // AppTokens.Colors.primary approximation
              .fontSize(18)
              .fontWeight(FontWeight.Bold)

            // === ProgressView ===
            Progress({ value: 50, total: 100, type: ProgressType.Linear })
              .height(8)
              .width('100%')
              .color('#D0BCFF') // Tint
              .trackColor('#49454F') // Track

            // === HStack ===
            Row() {
              // === Text ===
              Text('Auto Update')
                .fontColor('#E6E1E5') // AppTokens.Colors.onSurface approximation
                .fontSize(14)

              // === Spacer ===
              Blank()

              // === Toggle ===
              Toggle({ type: ToggleType.Switch })
                .width(50)
                .height(30)
                .selectedColor('#D0BCFF') // CheckedThumbColor approximation
                .unSelectedColor('#79747E') // UncheckedThumbColor approximation
            }
          }
          .width('100%')
          .layoutWeight(1)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [['#D0BCFF', 0.3], ['#1E1B24', 1]] // Approximation of gradient
          })
          .padding(12)
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}