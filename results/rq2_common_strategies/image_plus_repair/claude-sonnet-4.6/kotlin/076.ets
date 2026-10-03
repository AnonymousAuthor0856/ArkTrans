@Entry
@Component
struct SmartHomeDashboard {
  @State smartLampOn: boolean = true
  @State thermostatOn: boolean = true
  @State mainLockOn: boolean = false
  @State wifiRouterOn: boolean = true

  build() {
    Scroll() {
      Column() {
        // Header
        Row() {
          Column() {
            Text('Good Morning,')
              .fontSize(16)
              .fontColor('#FF9E9E9E')
              .fontWeight(FontWeight.Medium)
            Text('Alex Johnson')
              .fontSize(24)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
          }
          .alignItems(HorizontalAlign.Start)

          Stack() {
            Circle()
              .width(48)
              .height(48)
              .fill(Color.White)
            Text('👤')
              .fontSize(24)
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Energy Card
        Column() {
          Row() {
            Column() {
              Text('Energy Usage')
                .fontColor('rgba(255,255,255,0.8)')
                .fontSize(14)
              Text('28.5 kWh')
                .fontColor(Color.White)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
              Text('Today')
                .fontColor('rgba(255,255,255,0.6)')
                .fontSize(12)
            }
            .alignItems(HorizontalAlign.Start)

            Stack() {
              Circle()
                .width(56)
                .height(56)
                .fill('rgba(255,255,255,0.2)')
              Text('🔔')
                .fontSize(24)
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .padding(24)
        }
        .width('100%')
        .backgroundColor('#FF5E60CE')
        .borderRadius(24)
        .margin({ top: 32 })

        // Scenes Section
        Text('Scenes')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width('100%')
          .margin({ top: 32, bottom: 16 })

        Row() {
          // Home button
          Row() {
            Text('🏠')
              .fontSize(16)
            Text('Home')
              .fontColor(Color.White)
              .fontWeight(FontWeight.Medium)
              .fontSize(14)
              .margin({ left: 8 })
          }
          .backgroundColor('#FF212121')
          .borderRadius(30)
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .alignItems(VerticalAlign.Center)

          // Away button
          Row() {
            Text('🔒')
              .fontSize(16)
            Text('Away')
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Medium)
              .fontSize(14)
              .margin({ left: 8 })
          }
          .backgroundColor(Color.White)
          .borderRadius(30)
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .alignItems(VerticalAlign.Center)
          .margin({ left: 12 })

          // Sleep button
          Row() {
            Text('⭐')
              .fontSize(16)
            Text('Sleep')
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Medium)
              .fontSize(14)
              .margin({ left: 8 })
          }
          .backgroundColor(Color.White)
          .borderRadius(30)
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .alignItems(VerticalAlign.Center)
          .margin({ left: 12 })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Devices Section
        Text('Devices')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width('100%')
          .margin({ top: 32, bottom: 16 })

        Row() {
          // Left column
          Column() {
            // Smart Lamp Card
            Column() {
              Row() {
                Stack() {
                  Circle()
                    .width(40)
                    .height(40)
                    .fill(this.smartLampOn ? 'rgba(255,193,7,0.1)' : '#FFF0F0F0')
                  Text('⭐')
                    .fontSize(20)
                    .fontColor(this.smartLampOn ? '#FFFFC107' : '#FF9E9E9E')
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)

              Column() {
                Text('Smart Lamp')
                  .fontWeight(FontWeight.Bold)
                  .fontSize(16)
                  .fontColor(Color.Black)
                Text(this.smartLampOn ? 'On' : 'Off')
                  .fontColor(this.smartLampOn ? '#FFFFC107' : '#FF9E9E9E')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ top: 8 })

              Row() {
                Toggle({ type: ToggleType.Switch, isOn: this.smartLampOn })
                  .onChange((isOn: boolean) => {
                    this.smartLampOn = isOn
                  })
                  .selectedColor('#FFFFC107')
                  .width(41.6)
                  .height(25.6)
              }
              .width('100%')
              .justifyContent(FlexAlign.End)
              .margin({ top: 8 })
            }
            .width('100%')
            .aspectRatio(0.85)
            .backgroundColor(Color.White)
            .borderRadius(20)
            .padding(16)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(HorizontalAlign.Start)
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 2 })

            // Thermostat Card
            Column() {
              Row() {
                Stack() {
                  Circle()
                    .width(40)
                    .height(40)
                    .fill(this.thermostatOn ? 'rgba(255,112,67,0.1)' : '#FFF0F0F0')
                  Text('☰')
                    .fontSize(20)
                    .fontColor(this.thermostatOn ? '#FFFF7043' : '#FF9E9E9E')
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)

              Column() {
                Text('Thermostat')
                  .fontWeight(FontWeight.Bold)
                  .fontSize(16)
                  .fontColor(Color.Black)
                Text(this.thermostatOn ? 'On' : 'Off')
                  .fontColor(this.thermostatOn ? '#FFFF7043' : '#FF9E9E9E')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ top: 8 })

              Row() {
                Toggle({ type: ToggleType.Switch, isOn: this.thermostatOn })
                  .onChange((isOn: boolean) => {
                    this.thermostatOn = isOn
                  })
                  .selectedColor('#FFFF7043')
                  .width(41.6)
                  .height(25.6)
              }
              .width('100%')
              .justifyContent(FlexAlign.End)
              .margin({ top: 8 })
            }
            .width('100%')
            .aspectRatio(0.85)
            .backgroundColor(Color.White)
            .borderRadius(20)
            .padding(16)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(HorizontalAlign.Start)
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 2 })
            .margin({ top: 16 })
          }
          .layoutWeight(1)

          // Right column
          Column() {
            // Main Lock Card
            Column() {
              Row() {
                Stack() {
                  Circle()
                    .width(40)
                    .height(40)
                    .fill(this.mainLockOn ? 'rgba(76,175,80,0.1)' : '#FFF0F0F0')
                  Text('🔒')
                    .fontSize(20)
                    .fontColor(this.mainLockOn ? '#FF4CAF50' : '#FF9E9E9E')
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)

              Column() {
                Text('Main Lock')
                  .fontWeight(FontWeight.Bold)
                  .fontSize(16)
                  .fontColor(Color.Black)
                Text(this.mainLockOn ? 'On' : 'Off')
                  .fontColor(this.mainLockOn ? '#FF4CAF50' : '#FF9E9E9E')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ top: 8 })

              Row() {
                Toggle({ type: ToggleType.Switch, isOn: this.mainLockOn })
                  .onChange((isOn: boolean) => {
                    this.mainLockOn = isOn
                  })
                  .selectedColor('#FF4CAF50')
                  .width(41.6)
                  .height(25.6)
              }
              .width('100%')
              .justifyContent(FlexAlign.End)
              .margin({ top: 8 })
            }
            .width('100%')
            .aspectRatio(0.85)
            .backgroundColor(Color.White)
            .borderRadius(20)
            .padding(16)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(HorizontalAlign.Start)
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 2 })

            // Wi-Fi Router Card
            Column() {
              Row() {
                Stack() {
                  Circle()
                    .width(40)
                    .height(40)
                    .fill(this.wifiRouterOn ? 'rgba(33,150,243,0.1)' : '#FFF0F0F0')
                  Text('⚙️')
                    .fontSize(20)
                    .fontColor(this.wifiRouterOn ? '#FF2196F3' : '#FF9E9E9E')
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)

              Column() {
                Text('Wi-Fi Router')
                  .fontWeight(FontWeight.Bold)
                  .fontSize(16)
                  .fontColor(Color.Black)
                Text(this.wifiRouterOn ? 'On' : 'Off')
                  .fontColor(this.wifiRouterOn ? '#FF2196F3' : '#FF9E9E9E')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ top: 8 })

              Row() {
                Toggle({ type: ToggleType.Switch, isOn: this.wifiRouterOn })
                  .onChange((isOn: boolean) => {
                    this.wifiRouterOn = isOn
                  })
                  .selectedColor('#FF2196F3')
                  .width(41.6)
                  .height(25.6)
              }
              .width('100%')
              .justifyContent(FlexAlign.End)
              .margin({ top: 8 })
            }
            .width('100%')
            .aspectRatio(0.85)
            .backgroundColor(Color.White)
            .borderRadius(20)
            .padding(16)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(HorizontalAlign.Start)
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 2 })
            .margin({ top: 16 })
          }
          .layoutWeight(1)
          .margin({ left: 16 })
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)

        Blank().height(24)
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF4F6F8')
    .scrollBar(BarState.Off)
  }
}