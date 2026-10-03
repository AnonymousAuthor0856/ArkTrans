@Entry
@Component
struct Index {
  @State isLocked: boolean = false

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        Blank().height(16)

        // SystemStatusBadge
        Row({ space: 0 }) {
          Image($r('app.media.startIcon')).width(16).height(16)
          Blank().width(8)
          Text('SYSTEM NOMINAL').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#4CAF50')
        }.alignItems(VerticalAlign.Center).padding({ left: 12, right: 12, top: 6, bottom: 6 }).borderRadius(50).border({ width: 1, color: '#4CAF50', radius: 50 })

        Blank().height(32)

        // MainTemperatureDisplay
        Column({ space: 0 }) {
          Text('CORE TEMPERATURE').fontSize(12).fontColor('#757575').fontWeight(FontWeight.Medium)
          Row({ space: 0 }) {
            Text('-184.2').fontSize(64).fontWeight(FontWeight.Normal).fontColor('#212121')
            Text('°C').fontSize(24).fontWeight(FontWeight.Normal).fontColor('#757575').margin({ bottom: 12, left: 4 })
          }.alignItems(VerticalAlign.Bottom)
        }.alignItems(HorizontalAlign.Start)

        Blank().height(32)

        // SensorGrid
        Column({ space: 12 }) {
          Row({ space: 12 }) {
            // SensorCard 1
            Column({ space: 0 }) {
              Column({ space: 0 }) {
                Row({ space: 0 }) {
                  Image($r('app.media.startIcon')).width(20).height(20)
                  Stack({ alignContent: Alignment.Center }) {
                    // Placeholder for warning dot if needed, currently just background
                  }.width(6).height(6).backgroundColor('#D32F2F').borderRadius(3)
                }.width('100%').justifyContent(FlexAlign.SpaceBetween)
                Blank().height(12)
                Column({ space: 0 }) {
                  Text('value').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#212121')
                  Text('$unit  $title').fontSize(10).fontWeight(FontWeight.Bold).fontColor('#757575')
                }
              }.padding(16)
            }.layoutWeight(1).backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })

            // SensorCard 2
            Column({ space: 0 }) {
              Column({ space: 0 }) {
                Row({ space: 0 }) {
                  Image($r('app.media.startIcon')).width(20).height(20)
                  Stack({ alignContent: Alignment.Center }) {
                  }.width(6).height(6).backgroundColor('#D32F2F').borderRadius(3)
                }.width('100%').justifyContent(FlexAlign.SpaceBetween)
                Blank().height(12)
                Column({ space: 0 }) {
                  Text('value').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#212121')
                  Text('$unit  $title').fontSize(10).fontWeight(FontWeight.Bold).fontColor('#757575')
                }
              }.padding(16)
            }.layoutWeight(1).backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })
          }.width('100%')

          Row({ space: 12 }) {
            // SensorCard 3
            Column({ space: 0 }) {
              Column({ space: 0 }) {
                Row({ space: 0 }) {
                  Image($r('app.media.startIcon')).width(20).height(20)
                  Stack({ alignContent: Alignment.Center }) {
                  }.width(6).height(6).backgroundColor('#D32F2F').borderRadius(3)
                }.width('100%').justifyContent(FlexAlign.SpaceBetween)
                Blank().height(12)
                Column({ space: 0 }) {
                  Text('value').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#212121')
                  Text('$unit  $title').fontSize(10).fontWeight(FontWeight.Bold).fontColor('#757575')
                }
              }.padding(16)
            }.layoutWeight(1).backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })

            // SensorCard 4
            Column({ space: 0 }) {
              Column({ space: 0 }) {
                Row({ space: 0 }) {
                  Image($r('app.media.startIcon')).width(20).height(20)
                  Stack({ alignContent: Alignment.Center }) {
                  }.width(6).height(6).backgroundColor('#D32F2F').borderRadius(3)
                }.width('100%').justifyContent(FlexAlign.SpaceBetween)
                Blank().height(12)
                Column({ space: 0 }) {
                  Text('value').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#212121')
                  Text('$unit  $title').fontSize(10).fontWeight(FontWeight.Bold).fontColor('#757575')
                }
              }.padding(16)
            }.layoutWeight(1).backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })
          }.width('100%')
        }

        Blank().height(24)

        Text('MAINTENANCE LOG').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#757575').letterSpacing(1.5)
        Blank().height(8)

        // ActivityLogList
        List({ space: 8 }) {
          ListItem() {
            Row({ space: 0 }) {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon')).width(16).height(16)
              }.width(32).height(32).backgroundColor('#F5F5F5').borderRadius(16)
              Blank().width(12)
              Column({ space: 0 }) {
                Text('log.message').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#212121')
                Text('log.time').fontSize(11).fontColor('#757575')
              }
            }.alignItems(VerticalAlign.Center).width('100%').padding({ top: 4, bottom: 4 })
          }
          ListItem() {
            Divider().vertical(false).color('#F5F5F5')
          }
        }.width('100%')
      }.width('100%').height('100%').padding({ left: 24, right: 24 })

      // SimpleTopBar
      Row({ space: 0 }) {
        Column({ space: 0 }) {
          Text('UNIT-04').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#757575')
          Text('CryoGen Monitor').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#212121')
        }
        Button() {
          Image($r('app.media.startIcon'))
        }
      }.alignItems(VerticalAlign.Center).width('100%').padding({ top: 24, bottom: 12, left: 24, right: 24 }).justifyContent(FlexAlign.SpaceBetween)

      // BottomControlBar
      Column() {
        Row({ space: 0 }) {
          Column({ space: 0 }) {
            Text('MANUAL OVERRIDE').fontSize(10).fontWeight(FontWeight.Bold).fontColor('#757575')
            Text(this.isLocked ? "LOCKED" : "ACTIVE").fontSize(14).fontWeight(FontWeight.Bold).fontColor(this.isLocked ? '#212121' : '#D32F2F')
          }
          Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
            .onChange((isOn: boolean) => {
              this.isLocked = !isOn
            })
        }.alignItems(VerticalAlign.Center).padding(24).width('100%').justifyContent(FlexAlign.SpaceBetween)
      }.backgroundColor('#FFFFFF').shadow({ radius: 4, color: '#1A000000' }).width('100%')
    }.width('100%').height('100%')
  }
}