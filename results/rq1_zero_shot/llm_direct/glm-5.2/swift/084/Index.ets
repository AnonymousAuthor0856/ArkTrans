// V60Guide.ets
@Component
export struct V60Guide {
  build() {
    Column() {
      // MARK: Header Section
      Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Start }) {
        Column() {
          Text("V60 Guide")
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .margin({ bottom: 4 })

          Text("Ethiopia Yirgacheffe")
            .fontSize(16)
            .fontColor('#8A8A8E')
        }
        .alignItems(HorizontalAlign.Start)

        // Gear Icon Button
        Button() {
          Image($r('sys.media.ohos_ic_public_settings'))
            .width(24)
            .height(24)
            .fillColor('#000000')
        }
        .backgroundColor(Color.Transparent)
        .type(ButtonType.Normal)
        .stateEffect(false)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 30, bottom: 30 })

      Blank()

      // MARK: Timer Section
      Column() {
        Text("00:45")
          .fontSize(90)
          .fontColor('#000000')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ bottom: 10 })

        Text("Target: 300g")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8A8A8E')
      }

      Blank()

      // MARK: Parameters Grid
      Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
        // Left: Ratio
        ParameterItem({ iconValue: '1:15', label: 'Ratio' })

        // Center: Beans
        ParameterItem({ iconValue: '20g', label: 'Beans' })

        // Right: Temperature
        ParameterItem({ iconValue: '93°C', label: 'Temp' })
      }
      .width('100%')
      .padding({ left: 30, right: 30 })

      Blank()

      // Divider Line
      Divider()
        .color('#E5E5EA')
        .strokeWidth(1)
        .width('100%')
        .padding({ left: 24, right: 24 })
        .margin({ bottom: 20 })

      // MARK: Brewing Steps Section
      Column() {
        Text("Brewing Steps")
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .padding({ left: 24, right: 24 })
          .margin({ bottom: 15 })

        // Step Item Row
        Flex({ alignItems: ItemAlign.Center }) {
          // Checkmark Icon
          Text('✔')
            .fontSize(24)
            .fontColor('#000000')
            .width(28)
            .height(28)
            .textAlign(TextAlign.Center)
            .backgroundColor('#FFFFFF')
            .borderRadius(14)
            .shadow({ radius: 2, color: '#33000000', offsetX: 0, offsetY: 1 })

          // Step Content Background
          Column() {
            // Placeholder for step content
          }
          .width('100%')
          .height(52)
          .backgroundColor('#F2F2F7')
          .borderRadius(10)
          .margin({ left: 16 })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')

      Blank()

      // MARK: Start Button
      Button() {
        Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
          Text('▶')
            .fontSize(18)
            .fontColor('#FFFFFF')
            .margin({ right: 8 })

          Text("Start Brewing")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
        .width('100%')
        .height(60)
      }
      .backgroundColor('#000000')
      .borderRadius(18)
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .expandSafeArea([SafeAreaType.System], [SafeAreaEdge.All])
  }
}

// MARK: - Component: Parameter Item
@Component
struct ParameterItem {
  private iconValue: string = '';
  private label: string = '';

  build() {
    Column() {
      // Circular Icon Button
      Stack() {
        Circle({ width: 64, height: 64 })
          .fill(Color.Transparent)
          .stroke('#E5E5EA', 1.5)

        Text(this.iconValue.charAt(0)) // Using first character as a pseudo-icon representation
          .fontSize(24)
          .fontColor('#8A8A8E')
      }
      .margin({ bottom: 12 })

      // Text Values
      Column() {
        Text(this.iconValue)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ bottom: 4 })

        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8A8A8E')
      }
    }
    .width(80)
    .alignItems(HorizontalAlign.Center)
  }
}