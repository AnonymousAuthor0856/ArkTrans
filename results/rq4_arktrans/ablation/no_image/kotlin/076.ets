@Entry
@Component
struct Index {
  @State switchState: boolean = false

  build() {
    Stack() {
      Column({ space: 0 }) {
        Blank().height(16)

        Row({ space: 0 }) {
          Column({ space: 0 }) {
            Text('Good Morning,').fontSize(16).fontColor('#9E9E9E').fontWeight(FontWeight.Medium)
            Text('Alex Johnson').fontSize(24).fontColor('#000000').fontWeight(FontWeight.Bold)
          }
          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
          }.width(48).height(48).backgroundColor('#FFFFFF').borderRadius(24)
        }.alignItems(VerticalAlign.Center).justifyContent(FlexAlign.SpaceBetween).width('100%')

        Blank().height(32)

        // Energy Card
        Column() {
          Row({ space: 0 }) {
            Column({ space: 0 }) {
              Text('Energy Usage').fontSize(14).fontColor('#CCCCCC')
              Text('28.5 kWh').fontSize(32).fontColor('#FFFFFF').fontWeight(FontWeight.Bold)
              Text('Today').fontSize(12).fontColor('#999999')
            }
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
            }.width(56).height(56).backgroundColor('#33FFFFFF').borderRadius(28)
          }.alignItems(VerticalAlign.Center).justifyContent(FlexAlign.SpaceBetween).padding(24).width('100%')
        }.backgroundColor('#5E60CE').borderRadius(24).shadow({ radius: 8, color: '#1A000000' }).width('100%')

        Blank().height(32)

        Text('Scenes').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#000000')

        Blank().height(16)

        Row({ space: 12 }) {
          // Scene Button 1
          Stack({ alignContent: Alignment.Center }) {
            Row({ space: 0 }) {
              Image($r('app.media.startIcon')).width(18).height(18)
              Blank().width(8)
              Text('Living Room').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
            }.alignItems(VerticalAlign.Center)
          }.backgroundColor('#F0F0F0').borderRadius(30).padding({ left: 24, right: 24, top: 12, bottom: 12 })

          // Scene Button 2
          Stack({ alignContent: Alignment.Center }) {
            Row({ space: 0 }) {
              Image($r('app.media.startIcon')).width(18).height(18)
              Blank().width(8)
              Text('Bedroom').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
            }.alignItems(VerticalAlign.Center)
          }.backgroundColor('#F0F0F0').borderRadius(30).padding({ left: 24, right: 24, top: 12, bottom: 12 })

          // Scene Button 3
          Stack({ alignContent: Alignment.Center }) {
            Row({ space: 0 }) {
              Image($r('app.media.startIcon')).width(18).height(18)
              Blank().width(8)
              Text('Kitchen').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
            }.alignItems(VerticalAlign.Center)
          }.backgroundColor('#F0F0F0').borderRadius(30).padding({ left: 24, right: 24, top: 12, bottom: 12 })
        }.width('100%')

        Blank().height(32)

        Text('Devices').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#000000')

        Blank().height(16)

        Row({ space: 16 }) {
          // Left Column Devices
          Column({ space: 0 }) {
            // Device 1: Smart Lamp
            Column() {
              Column({ space: 0 }) {
                Row({ space: 0 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Image($r('app.media.startIcon')).width(24).height(24)
                  }.width(40).height(40).backgroundColor('#FFF3E0').borderRadius(20)
                }.width('100%')

                Column({ space: 0 }) {
                  Text('Smart Lamp').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#000000')
                  Blank().height(4)
                  Text(this.switchState ? 'On' : 'Off').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#FFC107')
                }

                Row({ space: 0 }) {
                  Toggle({ type: ToggleType.Switch, isOn: this.switchState })
                    .onChange((isOn: boolean) => {
                      this.switchState = isOn
                    })
                }.justifyContent(FlexAlign.End).width('100%')
              }.padding(16).width('100%').height('100%')
            }.backgroundColor('#FFFFFF').borderRadius(20).shadow({ radius: 2, color: '#1A000000' }).width('100%')

            Blank().height(16)

            // Device 2: Thermostat
            Column() {
              Column({ space: 0 }) {
                Row({ space: 0 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Image($r('app.media.startIcon')).width(24).height(24)
                  }.width(40).height(40).backgroundColor('#FBE9E7').borderRadius(20)
                }.width('100%')

                Column({ space: 0 }) {
                  Text('Thermostat').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#000000')
                  Blank().height(4)
                  Text(this.switchState ? 'On' : 'Off').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#FF7043')
                }

                Row({ space: 0 }) {
                  Toggle({ type: ToggleType.Switch, isOn: this.switchState })
                    .onChange((isOn: boolean) => {
                      this.switchState = isOn
                    })
                }.justifyContent(FlexAlign.End).width('100%')
              }.padding(16).width('100%').height('100%')
            }.backgroundColor('#FFFFFF').borderRadius(20).shadow({ radius: 2, color: '#1A000000' }).width('100%')
          }.layoutWeight(1)

          // Right Column Devices
          Column({ space: 0 }) {
            // Device 3: Main Lock
            Column() {
              Column({ space: 0 }) {
                Row({ space: 0 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Image($r('app.media.startIcon')).width(24).height(24)
                  }.width(40).height(40).backgroundColor('#E8F5E9').borderRadius(20)
                }.width('100%')

                Column({ space: 0 }) {
                  Text('Main Lock').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#000000')
                  Blank().height(4)
                  Text(this.switchState ? 'On' : 'Off').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#4CAF50')
                }

                Row({ space: 0 }) {
                  Toggle({ type: ToggleType.Switch, isOn: this.switchState })
                    .onChange((isOn: boolean) => {
                      this.switchState = isOn
                    })
                }.justifyContent(FlexAlign.End).width('100%')
              }.padding(16).width('100%').height('100%')
            }.backgroundColor('#FFFFFF').borderRadius(20).shadow({ radius: 2, color: '#1A000000' }).width('100%')

            Blank().height(16)

            // Device 4: Wi-Fi Router
            Column() {
              Column({ space: 0 }) {
                Row({ space: 0 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    Image($r('app.media.startIcon')).width(24).height(24)
                  }.width(40).height(40).backgroundColor('#E3F2FD').borderRadius(20)
                }.width('100%')

                Column({ space: 0 }) {
                  Text('Wi-Fi Router').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#000000')
                  Blank().height(4)
                  Text(this.switchState ? 'On' : 'Off').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#2196F3')
                }

                Row({ space: 0 }) {
                  Toggle({ type: ToggleType.Switch, isOn: this.switchState })
                    .onChange((isOn: boolean) => {
                      this.switchState = isOn
                    })
                }.justifyContent(FlexAlign.End).width('100%')
              }.padding(16).width('100%').height('100%')
            }.backgroundColor('#FFFFFF').borderRadius(20).shadow({ radius: 2, color: '#1A000000' }).width('100%')
          }.layoutWeight(1)
        }.width('100%')

        Blank().height(24)
      }.width('100%').height('100%').backgroundColor('#F4F6F8').padding(24)
    }.width('100%').height('100%')
  }
}