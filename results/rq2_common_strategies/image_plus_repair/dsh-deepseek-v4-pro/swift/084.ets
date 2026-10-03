// MARK: - Component: Parameter Item
@Component
struct ParameterItem {
  icon: string = '';
  value: string = '';
  label: string = '';

  build() {
    Column({ space: 12 }) {
      // Circular Icon Button
      Stack() {
        Circle()
          .width(64)
          .height(64)
          .fill(Color.Transparent)
          .stroke('#E5E5EA') // systemGray5
          .strokeWidth(1.5)

        Text(this.icon)
          .fontSize(24)
          .fontColor('#8E8E93') // systemGray
      }

      // Text Values
      Column({ space: 4 }) {
        Text(this.value)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93') // systemGray
      }
    }
    .width(80) // Fixed width to ensure alignment
  }
}

// MARK: - App Entry Point / Main Content View
@Entry
@Component
struct V60GuideApp {
  build() {
    Column() {
      // MARK: Header Section
      Row() {
        Column({ space: 4 }) {
          Text('V60 Guide')
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Text('Ethiopia Yirgacheffe')
            .fontSize(16)
            .fontColor('#8E8E93') // systemGray
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button() {
          Text('⚙')
            .fontSize(24)
            .fontColor('#000000')
        }
        .onClick(() => {})
      }
      .alignItems(VerticalAlign.Top)
      .padding({ left: 24, right: 24, top: 30, bottom: 30 }) // Top margin since status bar is hidden

      Blank()

      // MARK: Timer Section
      Column({ space: 10 }) {
        Text('00:45')
          .fontSize(90)
          .fontWeight(FontWeight.Regular)
          .fontColor('#000000')
          // monospacedDigit(): ensures fixed width for numbers
          .minFontSize(72) // minimumScaleFactor(0.8): adjusts for smaller SE screens if needed
          .maxLines(1) // lineLimit(1)

        Text('Target: 300g')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8E8E93') // systemGray
      }

      Blank()

      // MARK: Parameters Grid
      Row() {
        // Left: Ratio
        ParameterItem({ icon: '+', value: '1:15', label: 'Ratio' })

        Blank()

        // Center: Beans
        ParameterItem({ icon: '♥', value: '20g', label: 'Beans' })

        Blank()

        // Right: Temperature
        ParameterItem({ icon: '↻', value: '93°C', label: 'Temp' })
      }
      .padding({ left: 30, right: 30 })

      Blank()

      // Divider Line
      Divider()
        .padding({ left: 24, right: 24, bottom: 20 })

      // MARK: Brewing Steps Section
      Column({ space: 15 }) {
        Text('Brewing Steps')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .padding({ left: 24, right: 24 })

        // Step Item Row
        Row({ space: 16 }) {
          // Checkmark Icon
          Stack() {
            Circle()
              .width(28)
              .height(28)
              .fill('#FFFFFF') // background(Color.white)

            Text('✓')
              .fontSize(28)
              .fontColor('#000000')
          }

          // Step Content Background
          Row() {
            Blank()
          }
          .width('100%')
          .height(52)
          .borderRadius(10)
          .backgroundColor('#F2F2F7') // systemGray6: very light gray
          // overlay placeholder for step content (e.g., "Pour water")
        }
        .padding({ left: 24, right: 24 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      // MARK: Start Button
      Button() {
        Row({ space: 8 }) {
          Text('▶')
            .fontSize(18)
            .fontColor('#FFFFFF')
          Text('Start Brewing')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height(60)
        .backgroundColor('#000000')
        .borderRadius(18)
      }
      .onClick(() => {})
      .padding({ left: 24, right: 24, bottom: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    // edgesIgnoringSafeArea(.all)
    // statusBar(hidden: true)
  }
}
