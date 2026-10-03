@Entry
@Component
struct SmartHomeApp {
  @State switchStates: boolean[] = [true, true, false, true]

  private deviceNames: string[] = ['Smart Lamp', 'Thermostat', 'Main Lock', 'Wi-Fi Router']
  private deviceIcons: string[] = ['⭐', '≡', '🔒', '⚙️']
  private deviceColors: string[] = ['#FFC107', '#FF7043', '#4CAF50', '#2196F3']

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F4F6F8')

      Column({ space: 0 }) {
        Blank().height(16)

        // Header
        Row({ space: 0 }) {
          Column({ space: 0 }) {
            Text('Good Morning,')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#808080')
            Text('Alex Johnson')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .foregroundColor('#000000')
          }
          .alignItems(HorizontalAlign.Start)
          Blank()

          Stack({ alignContent: Alignment.Center }) {
            Column()
              .width(48)
              .height(48)
              .backgroundColor('#FFFFFF')
              .borderRadius(24)
            Text('👤')
              .fontSize(24)
          }
          .width(48)
          .height(48)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })

        Blank().height(32)

        // Energy Usage Card
        Stack({ alignContent: Alignment.TopStart }) {
          Column()
            .width('100%')
            .height(150)
            .backgroundColor('#5E60CE')
            .borderRadius(24)
            .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })

          Row({ space: 0 }) {
            Column({ space: 0 }) {
              Text('Energy Usage')
                .fontSize(14)
                .foregroundColor('#FFFFFF')
                .opacity(0.8)
              Text('28.5 kWh')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .foregroundColor('#FFFFFF')
              Text('Today')
                .fontSize(12)
                .foregroundColor('#FFFFFF')
                .opacity(0.6)
            }
            .alignItems(HorizontalAlign.Start)
            Blank()

            Stack({ alignContent: Alignment.Center }) {
              Column()
                .width(56)
                .height(56)
                .backgroundColor('#FFFFFF')
                .opacity(0.2)
                .borderRadius(28)
              Text('🔔')
                .fontSize(24)
            }
            .width(56)
            .height(56)
          }
          .padding(24)
          .width('100%')
        }
        .width('100%')
        .padding({ left: 24, right: 24 })

        Blank().height(32)

        // Scenes Section
        Text('Scenes')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#000000')
          .padding({ left: 24 })

        Blank().height(16)

        Row({ space: 12 }) {
          Blank().width(24)
          Row({ space: 8 }) {
            Text('🏠')
              .fontSize(18)
            Text('Home')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FFFFFF')
          }
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .backgroundColor('#212121')
          .borderRadius(30)

          Row({ space: 8 }) {
            Text('🔒')
              .fontSize(18)
            Text('Away')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#000000')
          }
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .backgroundColor('#FFFFFF')
          .borderRadius(30)

          Row({ space: 8 }) {
            Text('⭐')
              .fontSize(18)
            Text('Sleep')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#000000')
          }
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .backgroundColor('#FFFFFF')
          .borderRadius(30)
          Blank().width(24)
        }
        .width('100%')

        Blank().height(32)

        Text('Devices')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#000000')
          .padding({ left: 24 })

        Blank().height(16)

        // Devices Grid
        Grid() {
          GridItem() {
            this.buildDeviceCard(0)
          }
          GridItem() {
            this.buildDeviceCard(1)
          }
          GridItem() {
            this.buildDeviceCard(2)
          }
          GridItem() {
            this.buildDeviceCard(3)
          }
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        .padding({ left: 24, right: 24 })

        Blank().height(24)
      }
      .width('100%')
      .height('100%')
      .padding({ top: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildDeviceCard(index: number) {
    // Access arrays directly without intermediate variables
    Column({ space: 0 }) {
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width(40)
          .height(40)
          .backgroundColor(this.switchStates[index] ? this.deviceColors[index] + '1A' : '#F0F0F0')
          .borderRadius(20)
        Text(this.deviceIcons[index])
          .fontSize(24)
      }
      .alignSelf(ItemAlign.Start)

      Blank()

      Column({ space: 4 }) {
        Text(this.deviceNames[index])
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#000000')
        Text(this.switchStates[index] ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .foregroundColor(this.switchStates[index] ? this.deviceColors[index] : '#808080')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text(this.switchStates[index] ? 'ON' : 'OFF')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .foregroundColor(this.switchStates[index] ? '#FFFFFF' : '#000000')
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      }
      .backgroundColor(this.switchStates[index] ? this.deviceColors[index] : '#E0E0E0')
      .borderRadius(16)
      .alignSelf(ItemAlign.End)
      .onClick(() => {
        this.switchStates[index] = !this.switchStates[index]
      })
    }
    .padding(16)
    .width('100%')
    .aspectRatio(0.85)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 2, color: '#0D000000', offsetY: 1 })
  }
}