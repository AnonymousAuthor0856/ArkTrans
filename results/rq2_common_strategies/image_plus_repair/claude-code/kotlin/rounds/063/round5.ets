@Entry
@Component
struct ChargingProgressPage {
  @State progress: number = 0.45

  private readonly primaryColor: string = '#FF3B82F6'
  private readonly secondaryColor: string = '#FF22C55E'
  private readonly bgColor: string = '#FFF5F5F4'
  private readonly surfaceColor: string = '#FFFFFFFF'
  private readonly dividerColor: string = '#FFD4D4D8'
  private readonly onPrimaryColor: string = '#FFFFFFFF'
  private readonly onBackgroundColor: string = '#FF111827'
  private readonly accentColor: string = '#FFF59E0B'

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Navigation icon - electric car
        Column() {
          // Car body
          Column() {
            Row() {
              // Car top
              Row()
                .width(24)
                .height(10)
                .backgroundColor(this.primaryColor)
                .borderRadius({ topLeft: 6, topRight: 6 })
            }
            .margin({ bottom: -2 })

            // Car main body
            Row()
              .width(40)
              .height(16)
              .backgroundColor(this.primaryColor)
              .borderRadius(4)

            // Wheels + plug
            Row() {
              Circle({ width: 10, height: 10 })
                .fill(this.primaryColor)
              Blank()
                .width(4)
              Circle({ width: 10, height: 10 })
                .fill(this.primaryColor)
            }
            .margin({ top: -4 })

            // Charging plug below
            Column() {
              Text('⚡')
                .fontSize(14)
                .fontColor(this.primaryColor)
            }
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(64)
        .justifyContent(FlexAlign.Center)

        // Title
        Text('Charging Progress')
          .layoutWeight(1)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onBackgroundColor)
          .textAlign(TextAlign.Center)

        // Action icon - settings gear
        Column() {
          Text('⚙')
            .fontSize(40)
            .fontColor(this.accentColor)
        }
        .width(64)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {})
      }
      .width('100%')
      .height(112)
      .backgroundColor(this.surfaceColor)
      .padding({ left: 12, right: 12 })

      // Main content area
      Column() {
        // Battery charging icon
        Stack({ alignContent: Alignment.Center }) {
          Column() {
            // Battery top nub
            Row()
              .width(28)
              .height(10)
              .backgroundColor(this.primaryColor)
              .borderRadius({ topLeft: 4, topRight: 4 })
              .margin({ bottom: -2 })

            // Battery body
            Row()
              .width(84)
              .height(116)
              .backgroundColor(this.primaryColor)
              .borderRadius(10)
          }
          .alignItems(HorizontalAlign.Center)

          // Lightning bolt
          Text('⚡')
            .fontSize(60)
            .fontColor('#FFFFFFFF')
            .fontWeight(FontWeight.Bold)
        }
        .margin({ top: 72, bottom: 40 })

        // Percentage text
        Text(`${Math.floor(this.progress * 100)}%`)
          .fontSize(96)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.onBackgroundColor)
          .margin({ bottom: 56 })

        // Progress bar
        Stack({ alignContent: Alignment.Start }) {
          // Track (background)
          Row()
            .width('80%')
            .height(28)
            .backgroundColor(this.surfaceColor)
            .border({ width: 2, color: this.dividerColor })
            .borderRadius(14)

          // Progress fill
          Row()
            .width(`${this.progress * 80}%`)
            .height(28)
            .backgroundColor(this.primaryColor)
            .borderRadius(14)
            .margin({ left: 2 })
        }
        .width('100%')
        .margin({ bottom: 56 })

        // Simulate Charge button
        Button('Simulate Charge')
          .fontSize(36)
          .fontColor(this.onPrimaryColor)
          .backgroundColor(this.secondaryColor)
          .borderRadius(50)
          .height(88)
          .padding({ left: 56, right: 56 })
          .onClick(() => {
            this.progress += 0.1
            if (this.progress > 1.0) {
              this.progress = 0.0
            }
          })
          .margin({ bottom: 56 })

        // Status text
        Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
          .fontSize(42)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 1.0 ? this.primaryColor : this.secondaryColor)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(this.bgColor)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.bgColor)
  }
}
