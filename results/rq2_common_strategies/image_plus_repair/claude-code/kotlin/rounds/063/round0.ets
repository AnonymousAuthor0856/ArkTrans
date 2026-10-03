@Entry
@Component
struct ChargingProgressPage {
  @State progress: number = 0.45

  private readonly primaryColor: string = '#FF3B82F6'
  private readonly secondaryColor: string = '#FF22C55E'
  private readonly backgroundColor: string = '#FFF5F5F4'
  private readonly surfaceColor: string = '#FFFFFFFF'
  private readonly outlineColor: string = '#FFD4D4D8'
  private readonly onPrimaryColor: string = '#FFFFFFFF'
  private readonly onBackgroundColor: string = '#FF111827'
  private readonly accentColor: string = '#FFF59E0B'

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Navigation icon - electric car
        Column() {
          Text('🚗')
            .fontSize(40)
            .fontColor(this.primaryColor)
        }
        .width(56)
        .justifyContent(FlexAlign.Center)

        // Title
        Text('Charging Progress')
          .layoutWeight(1)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onBackgroundColor)
          .textAlign(TextAlign.Center)

        // Action icon - settings
        Column() {
          Text('⚙')
            .fontSize(40)
            .fontColor(this.accentColor)
        }
        .width(56)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {})
      }
      .width('100%')
      .height(112)
      .backgroundColor(this.surfaceColor)
      .padding({ left: 8, right: 8 })

      // Main content
      Column() {
        // Battery charging icon
        Column() {
          // Battery body with lightning bolt
          Stack({ alignContent: Alignment.Center }) {
            // Battery shape - drawn with shapes
            Column() {
              // Battery top nub
              Row()
                .width(24)
                .height(10)
                .backgroundColor(this.primaryColor)
                .borderRadius({ topLeft: 4, topRight: 4 })
                .margin({ bottom: -2 })

              // Battery body
              Row()
                .width(72)
                .height(96)
                .backgroundColor(this.primaryColor)
                .borderRadius(10)
            }
            .alignItems(HorizontalAlign.Center)

            // Lightning bolt symbol
            Text('⚡')
              .fontSize(48)
              .fontColor('#FFFFFFFF')
          }
        }
        .margin({ top: 60, bottom: 32 })

        // Percentage text
        Text(`${Math.floor(this.progress * 100)}%`)
          .fontSize(96)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onBackgroundColor)
          .margin({ bottom: 48 })

        // Progress bar
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Row()
            .width('80%')
            .height(28)
            .backgroundColor(this.surfaceColor)
            .border({ width: 2, color: this.outlineColor })
            .borderRadius(14)

          // Progress fill
          Row()
            .width(`${this.progress * 80}%`)
            .height(28)
            .backgroundColor(this.primaryColor)
            .borderRadius(14)
            .margin({ left: 2 })

          // Small dot at end of track (decorative)
          Circle({ width: 8, height: 8 })
            .fill(this.primaryColor)
            .translate({ x: `calc(80% - 20vp)` })
            .margin({ top: 10 })
        }
        .width('100%')
        .height(28)
        .margin({ bottom: 48 })

        // Simulate Charge button
        Button('Simulate Charge')
          .fontSize(36)
          .fontColor(this.onPrimaryColor)
          .backgroundColor(this.secondaryColor)
          .borderRadius(50)
          .height(80)
          .padding({ left: 48, right: 48 })
          .onClick(() => {
            this.progress += 0.1
            if (this.progress > 1.0) {
              this.progress = 0.0
            }
          })
          .margin({ bottom: 48 })

        // Status text
        Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
          .fontSize(40)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.progress < 1.0 ? this.primaryColor : this.secondaryColor)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(this.backgroundColor)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}
