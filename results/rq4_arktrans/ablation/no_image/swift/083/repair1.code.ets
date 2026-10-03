@Entry
@Component
struct Index {
  build() {
    Stack() {
      Stack() {
        Column({ space: 0 }) {
          Row() {
            Button('Menu')
            Blank()
            Text('NodeLink').fontColor(Color.Black).fontSize(22).fontWeight(FontWeight.Bold)
            Blank()
            Stack({ alignContent: Alignment.TopEnd }) {
              Button('Settings')
              Circle().width(10).height(10).fill(Color.Red).padding(2)
            }
          }

          Scroll() {
            Column({ space: 0 }) {
              .alignItems(HorizontalAlign.Start)
              Column() {
                Column({ space: 0 }) {
                  Stack() {
                    Circle().width(100).height(100).fill(Color.White)
                    Stack() {
                      Circle().width(84).height(84).fill('#E8F5E9') // Approximation of r:0.91, g:0.96, b:0.91
                      Image($r('app.media.startIcon')).color('#4CAF50').width(40).height(40)
                    }
                  }
                  Blank().height(16)
                  Text('System Operational').fontColor(Color.Black).fontSize(20).fontWeight(FontWeight.Bold)
                  Text('Uptime: 14d 2h 15m').fontColor(Color.Gray).fontSize(14).padding({ top: 4 })
                  Blank().height(24)
                  Row({ space: 0 }) {
                    StatBadge({ label: 'CPU', value: '12%' }).layoutWeight(1)
                    StatBadge({ label: 'RAM', value: '4.2GB' }).layoutWeight(1)
                    StatBadge({ label: 'NET', value: '1Gbps' }).layoutWeight(1)
                  }
                }.padding(24)
              }.borderRadius(24).backgroundColor('#F5F7FA') // Approximation of r:0.96, g:0.97, b:0.98

              Blank().height(16)

              Text('Control Panel').fontColor(Color.Black).fontSize(18).fontWeight(FontWeight.Bold).padding({ bottom: 16 })

              Row({ space: 16 }) {
                Column() {
                  Button('Restart')
                  Blank().height(8)
                  Text('label').fontColor(Color.Black).fontSize(12).fontWeight(FontWeight.Medium)
                }.layoutWeight(1)
                Column() {
                  Button('Shutdown')
                  Blank().height(8)
                  Text('label').fontColor(Color.Black).fontSize(12).fontWeight(FontWeight.Medium)
                }.layoutWeight(1)
                Column() {
                  Button('Reboot')
                  Blank().height(8)
                  Text('label').fontColor(Color.Black).fontSize(12).fontWeight(FontWeight.Medium)
                }.layoutWeight(1)
                Column() {
                  Button('Config')
                  Blank().height(8)
                  Text('label').fontColor(Color.Black).fontSize(12).fontWeight(FontWeight.Medium)
                }.layoutWeight(1)
              }

              Blank().height(32)

              Row() {
                Text('Recent Logs').fontColor(Color.Black).fontSize(18).fontWeight(FontWeight.Bold)
                Blank()
                Button('Clear')
              }

              Blank().height(8)

              Column({ space: 12 }) {
                LogItem({ typeColor: '#E3F2FD', iconTint: '#2196F3', iconName: $r('app.media.startIcon'), title: 'System Start', time: '10:00 AM' })
                LogItem({ typeColor: '#E8F5E9', iconTint: '#4CAF50', iconName: $r('app.media.startIcon'), title: 'Update Complete', time: '10:05 AM' })
                LogItem({ typeColor: '#FFF3E0', iconTint: '#FF9800', iconName: $r('app.media.startIcon'), title: 'Warning Alert', time: '10:10 AM' })
              }.padding({ bottom: 16 })
            }.padding({ left: 24, right: 24 })
          }.scrollBar(BarState.Off)
        }
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}

interface StatBadgeProps {
  label: string
  value: string
}

@Component
struct StatBadge {
  @Prop props: StatBadgeProps

  build() {
    Column() {
      Text(this.props.value).fontSize(16).fontWeight(FontWeight.Bold)
      Text(this.props.label).fontSize(12).fontColor(Color.Gray)
    }
  }
}

interface LogItemProps {
  typeColor: string
  iconTint: string
  iconName: Resource
  title: string
  time: string
}

@Component
struct LogItem {
  @Prop props: LogItemProps

  build() {
    Row() {
      Stack() {
        Circle().width(40).height(40).fill(this.props.typeColor)
        Image(this.props.iconName).color(this.props.iconTint).width(16).height(16)
      }
      Blank().width(16)
      Text(this.props.title).fontColor(Color.Black).fontSize(14).fontWeight(FontWeight.Medium)
      Blank()
      Text(this.props.time).fontColor(Color.Gray).fontSize(12)
    }.backgroundColor(Color.White).padding({ top: 4, bottom: 4 })
  }
}