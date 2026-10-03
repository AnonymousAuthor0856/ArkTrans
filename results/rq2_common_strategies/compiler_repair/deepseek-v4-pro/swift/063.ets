@Entry
@Component
struct ChargingProgressApp {
  @State progress: number = 0.45

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F4')

      // Main content
      Column({ space: 0 }) {
        // Top Bar
        Row({ space: 0 }) {
          // Electric car icon
          Text('🚗')
            .fontSize(24)
            .foregroundColor('#3B82F6')
            .padding({ left: 8 })
          Blank()
          // Title
          Text('Charging Progress')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#111827')
          Blank()
          // Settings icon
          Button() {
            Text('⚙️')
              .fontSize(24)
              .foregroundColor('#F59E0B')
          }
          .alignSelf(ItemAlign.Center) // fixed: ItemAlign instead of VerticalAlign
          .padding({ right: 8 })
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .backgroundColor('#FFFFFF')

        // Content
        Column({ space: 14 }) {
          // Battery icon and percentage
          Column({ space: 10 }) {
            // Battery icon (approximated)
            Stack({ alignContent: Alignment.Center }) {
              // Battery body
              Column()
                .width(50)
                .height(90)
                .backgroundColor('#3B82F6')
                .borderRadius(8)
              // Battery top cap
              Column()
                .width(20)
                .height(10)
                .backgroundColor('#3B82F6')
                .borderRadius(3)
                .margin({ top: -50 })
              // Lightning bolt symbol
              Text('⚡')
                .fontSize(30)
                .foregroundColor('#FFFFFF')
            }
            .width(60)
            .height(100)

            // Percentage text
            Text((this.progress * 100).toFixed(0) + '%')
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .foregroundColor('#111827')
          }
          .alignSelf(ItemAlign.Center)
          .padding({ top: 10 })

          // Progress bar
          Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
            .height(12)
            .width('70%')
            .color('#3B82F6')
            .backgroundColor('#FFFFFF')
            .borderRadius(6)
            .border({ width: 1, color: '#D4D4D8' })
            .alignSelf(ItemAlign.Center)
            .padding({ top: 14 })

          // Simulate button
          Button() {
            Text('Simulate Charge')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FFFFFF')
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
              .textAlign(TextAlign.Center)
          }
          .backgroundColor('#22C55E')
          .borderRadius(20)
          .alignSelf(ItemAlign.Center)
          .padding({ top: 14 })
          .onClick(() => {
            this.progress = (this.progress + 0.1 > 1.0) ? 0.0 : this.progress + 0.1
          })

          // Status text
          Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor(this.progress < 1.0 ? '#3B82F6' : '#22C55E')
            .alignSelf(ItemAlign.Center)
            .padding({ top: 10 })

          Blank() // Push content to top
        }
        .width('100%')
        .layoutWeight(1)
        .padding(14)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}