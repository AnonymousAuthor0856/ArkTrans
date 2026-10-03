import { router } from '@kit.ArkUI';

@Entry
@Component
struct SmartHomeDashboard {
  @State lampOn: boolean = true
  @State thermostatOn: boolean = true
  @State lockOn: boolean = false
  @State routerOn: boolean = true

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F4F6F8')

      Scroll() {
        Column({ space: 0 }) {
          // Top spacer
          Column().height(16)

          // Header
          Row() {
            Column({ space: 2 }) {
              Text('Good Morning,')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#888888')
              Text('Alex Johnson')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Stack() {
              Circle()
                .fill(Color.White)
                .width(48)
                .height(48)
              Text('👤')
                .fontSize(22)
                .fontColor('#000000')
            }
            .width(48)
            .height(48)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(VerticalAlign.Center)

          Column().height(32)

          // Energy Usage Card
          Row() {
            Column({ space: 4 }) {
              Text('Energy Usage')
                .fontSize(14)
                .fontColor('rgba(255,255,255,0.8)')
              Text('28.5 kWh')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
              Text('Today')
                .fontSize(12)
                .fontColor('rgba(255,255,255,0.6)')
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Stack() {
              Circle()
                .fill('rgba(255,255,255,0.2)')
                .width(56)
                .height(56)
              Text('🔔')
                .fontSize(22)
                .fontColor('#FFFFFF')
            }
            .width(56)
            .height(56)
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#5E60CE')
          .borderRadius(24)
          .margin({ left: 24, right: 24 })
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 4 })
          .alignItems(VerticalAlign.Center)

          Column().height(32)

          // Scenes Section Title
          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
            .padding({ left: 24, right: 24 })

          Column().height(16)

          // Scenes Scroll
          Scroll() {
            Row({ space: 12 }) {
              Column().width(12)

              // Home button - selected
              Row({ space: 8 }) {
                Text('🏠')
                  .fontSize(16)
                  .fontColor('#FFFFFF')
                Text('Home')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFFFFF')
              }
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
              .backgroundColor('#212121')
              .borderRadius(30)

              // Away button
              Row({ space: 8 }) {
                Text('🔒')
                  .fontSize(16)
                  .fontColor('#000000')
                Text('Away')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')
              }
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
              .backgroundColor('#FFFFFF')
              .borderRadius(30)

              // Sleep button
              Row({ space: 8 }) {
                Text('⭐')
                  .fontSize(16)
                  .fontColor('#000000')
                Text('Sleep')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')
              }
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
              .backgroundColor('#FFFFFF')
              .borderRadius(30)

              Column().width(12)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Column().height(32)

          // Devices Section Title
          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
            .padding({ left: 24, right: 24 })

          Column().height(16)

          // Devices Grid
          Row({ space: 16 }) {
            // Left column
            Column({ space: 16 }) {
              // Smart Lamp Card
              Column({ space: 0 }) {
                Row() {
                  Stack() {
                    Circle()
                      .fill(this.lampOn ? 'rgba(255,193,7,0.1)' : '#F0F0F0')
                      .width(40)
                      .height(40)
                    Text('⭐')
                      .fontSize(20)
                      .fontColor(this.lampOn ? '#FFC107' : '#888888')
                  }
                  .width(40)
                  .height(40)
                  Blank()
                }
                .width('100%')

                Column().height(16)
                Blank().layoutWeight(1)

                Column({ space: 4 }) {
                  Text('Smart Lamp')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#000000')
                  Text(this.lampOn ? 'On' : 'Off')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.lampOn ? '#FFC107' : '#888888')
                }
                .alignItems(HorizontalAlign.Start)
                .width('100%')

                Column().height(16)

                Row() {
                  Blank()
                  Toggle({ type: ToggleType.Switch, isOn: this.lampOn })
                    .selectedColor('#FFC107')
                    .onChange((isOn: boolean) => {
                      this.lampOn = isOn
                    })
                    .width(44)
                    .height(26)
                }
                .width('100%')
              }
              .padding(16)
              .width('100%')
              .aspectRatio(0.85)
              .backgroundColor('#FFFFFF')
              .borderRadius(20)
              .shadow({ radius: 2, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: 1 })
              .alignItems(HorizontalAlign.Start)

              // Thermostat Card
              Column({ space: 0 }) {
                Row() {
                  Stack() {
                    Circle()
                      .fill(this.thermostatOn ? 'rgba(255,112,67,0.1)' : '#F0F0F0')
                      .width(40)
                      .height(40)
                    Text('☰')
                      .fontSize(18)
                      .fontColor(this.thermostatOn ? '#FF7043' : '#888888')
                  }
                  .width(40)
                  .height(40)
                  Blank()
                }
                .width('100%')

                Column().height(16)
                Blank().layoutWeight(1)

                Column({ space: 4 }) {
                  Text('Thermostat')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#000000')
                  Text(this.thermostatOn ? 'On' : 'Off')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.thermostatOn ? '#FF7043' : '#888888')
                }
                .alignItems(HorizontalAlign.Start)
                .width('100%')

                Column().height(16)

                Row() {
                  Blank()
                  Toggle({ type: ToggleType.Switch, isOn: this.thermostatOn })
                    .selectedColor('#FF7043')
                    .onChange((isOn: boolean) => {
                      this.thermostatOn = isOn
                    })
                    .width(44)
                    .height(26)
                }
                .width('100%')
              }
              .padding(16)
              .width('100%')
              .aspectRatio(0.85)
              .backgroundColor('#FFFFFF')
              .borderRadius(20)
              .shadow({ radius: 2, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: 1 })
              .alignItems(HorizontalAlign.Start)
            }
            .layoutWeight(1)

            // Right column
            Column({ space: 16 }) {
              // Main Lock Card
              Column({ space: 0 }) {
                Row() {
                  Stack() {
                    Circle()
                      .fill(this.lockOn ? 'rgba(76,175,80,0.1)' : '#F0F0F0')
                      .width(40)
                      .height(40)
                    Text('🔒')
                      .fontSize(18)
                      .fontColor(this.lockOn ? '#4CAF50' : '#888888')
                  }
                  .width(40)
                  .height(40)
                  Blank()
                }
                .width('100%')

                Column().height(16)
                Blank().layoutWeight(1)

                Column({ space: 4 }) {
                  Text('Main Lock')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#000000')
                  Text(this.lockOn ? 'On' : 'Off')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.lockOn ? '#4CAF50' : '#888888')
                }
                .alignItems(HorizontalAlign.Start)
                .width('100%')

                Column().height(16)

                Row() {
                  Blank()
                  Toggle({ type: ToggleType.Switch, isOn: this.lockOn })
                    .selectedColor('#4CAF50')
                    .onChange((isOn: boolean) => {
                      this.lockOn = isOn
                    })
                    .width(44)
                    .height(26)
                }
                .width('100%')
              }
              .padding(16)
              .width('100%')
              .aspectRatio(0.85)
              .backgroundColor('#FFFFFF')
              .borderRadius(20)
              .shadow({ radius: 2, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: 1 })
              .alignItems(HorizontalAlign.Start)

              // Wi-Fi Router Card
              Column({ space: 0 }) {
                Row() {
                  Stack() {
                    Circle()
                      .fill(this.routerOn ? 'rgba(33,150,243,0.1)' : '#F0F0F0')
                      .width(40)
                      .height(40)
                    Text('⚙️')
                      .fontSize(18)
                      .fontColor(this.routerOn ? '#2196F3' : '#888888')
                  }
                  .width(40)
                  .height(40)
                  Blank()
                }
                .width('100%')

                Column().height(16)
                Blank().layoutWeight(1)

                Column({ space: 4 }) {
                  Text('Wi-Fi Router')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#000000')
                  Text(this.routerOn ? 'On' : 'Off')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.routerOn ? '#2196F3' : '#888888')
                }
                .alignItems(HorizontalAlign.Start)
                .width('100%')

                Column().height(16)

                Row() {
                  Blank()
                  Toggle({ type: ToggleType.Switch, isOn: this.routerOn })
                    .selectedColor('#2196F3')
                    .onChange((isOn: boolean) => {
                      this.routerOn = isOn
                    })
                    .width(44)
                    .height(26)
                }
                .width('100%')
              }
              .padding(16)
              .width('100%')
              .aspectRatio(0.85)
              .backgroundColor('#FFFFFF')
              .borderRadius(20)
              .shadow({ radius: 2, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: 1 })
              .alignItems(HorizontalAlign.Start)
            }
            .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(VerticalAlign.Top)

          Column().height(24)
        }
        .width('100%')
        .padding({ top: 24, bottom: 24 })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}