@Entry
@Component
struct Index {
  @State selectedCoin: string = 'BTC'
  @State isAutoUpdate: boolean = true

  build() {
    Stack() {
      Column() {
        // Header
        Text('Crypto Market')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1F1F1F')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 40, bottom: 20 })

        // Main Content Area with Gradient Background
        Column() {
          // Coin Selector Row
          Row() {
            ForEach(['BTC', 'ETH', 'SOL', 'ADA'], (coin: string) => {
              Button() {
                Text(coin)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedCoin === coin ? '#FFFFFF' : '#1F1F1F')
              }
              .type(ButtonType.Normal)
              .backgroundColor(this.selectedCoin === coin ? '#FFA5A5' : '#F3F4F6')
              .borderRadius(8)
              .width(70)
              .height(40)
              .onClick(() => {
                this.selectedCoin = coin
              })
            }, (item: string) => item)
          }
          .justifyContent(FlexAlign.SpaceEvenly)
          .width('100%')
          .margin({ bottom: 20 })

          // Chart Card
          Stack() {
            // White background card
            Rect().fill(Color.White).width('100%').height(260).borderRadius(24)
            
            // Simulated Chart Line using a custom shape or image placeholder
            // Since we can't draw complex paths easily without canvas logic, 
            // we use a simplified representation or an image if available.
            // Here we simulate the visual with a colored path-like structure or just the container.
            // To match the screenshot exactly, we'd need a Canvas drawing implementation.
            // For this skeleton conversion, we place a placeholder that mimics the chart area.
            Image($r('app.media.startIcon')) // Using required resource as placeholder for chart visualization
              .width('90%')
              .height('80%')
              .objectFit(ImageFit.Contain)
              .opacity(0.5) // Dimming to suggest it's a placeholder
            
            // Overlaying a simulated line graph using basic shapes for visual fidelity in code-only context
            // Note: A real app would use a library like eCharts or custom Canvas drawing.
            // We will leave the white card and assume the "Chart" is the content inside.
          }
          .width('100%')
          .height(260)
          .shadow({ radius: 10, color: '#00000020', offsetY: 5 })
          .margin({ bottom: 20 })

          // Price Variation Label
          Text('Price Variation')
            .fontSize(18)
            .fontColor('#FFA5A5')
            .textAlign(TextAlign.Center)
            .width('100%')
            .margin({ bottom: 15 })

          // Progress Bar
          Progress({ value: 65, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#FFA5A5')
            .backgroundColor('#F3F4F6')
            .margin({ bottom: 20 })

          // Auto Update Toggle
          Row() {
            Text('Auto Update')
              .fontSize(16)
              .fontColor('#1F1F1F')
            
            Blank()

            // Custom Toggle Switch Implementation
            Row() {
              Circle()
                .width(24)
                .height(24)
                .fill(this.isAutoUpdate ? '#FFE0B2' : '#D1D5DB')
                .offset({ x: this.isAutoUpdate ? 20 : 0 })
                .animation({ duration: 200 })
            }
            .width(48)
            .height(28)
            .backgroundColor(this.isAutoUpdate ? '#FFA5A5' : '#E5E7EB')
            .borderRadius(14)
            .onClick(() => {
              this.isAutoUpdate = !this.isAutoUpdate
            })
          }
          .width('100%')
          .padding({ left: 10, right: 10 })

        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 20, right: 20 })
        // Gradient Background Simulation
        .linearGradient({ angle: 180, colors: [['#FFF8E1', 0], ['#E0F2F1', 1]] })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFDF5') // Base background color
    }
    .width('100%')
    .height('100%')
  }
}