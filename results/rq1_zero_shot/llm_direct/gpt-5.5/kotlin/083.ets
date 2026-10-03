interface LogModel {
  icon: string
  title: string
  time: string
  typeColor: string
  iconTint: string
}

@Entry
@Component
struct ServerStatusScreen {
  private logs: LogModel[] = [
    {
      icon: '!',
      title: 'High Memory Usage',
      time: '10:42 AM',
      typeColor: '#FFF3E0',
      iconTint: '#FF9800'
    },
    {
      icon: '👤',
      title: 'Admin Login: root',
      time: '09:15 AM',
      typeColor: '#E3F2FD',
      iconTint: '#2196F3'
    },
    {
      icon: 'i',
      title: 'Backup Completed',
      time: '04:00 AM',
      typeColor: '#E8F5E9',
      iconTint: '#4CAF50'
    }
  ]

  build() {
    Column() {
      Row() {
        Text('☰')
          .fontSize(28)
          .fontColor('#000000')
          .width(48)
          .height(48)
          .textAlign(TextAlign.Center)
          .onClick(() => {
          })

        Text('NodeLink')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Stack({ alignContent: Alignment.TopEnd }) {
          Text('🔔')
            .fontSize(24)
            .fontColor('#000000')
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .onClick(() => {
            })

          Blank()
            .width(10)
            .height(10)
            .backgroundColor('#F44336')
            .borderRadius(5)
            .margin({ top: 7, right: 7 })
        }
        .width(48)
        .height(48)
      }
      .width('100%')
      .padding({ top: 48, bottom: 16, left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Stack({ alignContent: Alignment.Center }) {
                Text('✓')
                  .fontSize(48)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#4CAF50')
              }
              .width(84)
              .height(84)
              .backgroundColor('#E8F5E9')
              .borderRadius(42)
            }
            .width(100)
            .height(100)
            .backgroundColor('#FFFFFF')
            .borderRadius(50)
            .padding(8)

            Blank().height(16)

            Text('System Operational')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')

            Text('Uptime: 14d 2h 15m')
              .fontSize(14)
              .fontColor('#808080')
              .margin({ top: 4 })

            Blank().height(24)

            Row() {
              StatBadge({ label: 'CPU', value: '12%' })
              StatBadge({ label: 'RAM', value: '4.2GB' })
              StatBadge({ label: 'NET', value: '1Gbps' })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#F5F7FA')
          .borderRadius(24)
          .alignItems(HorizontalAlign.Center)
          .margin({ top: 16, bottom: 16 })

          Blank().height(16)

          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
            .margin({ bottom: 16 })

          Row({ space: 16 }) {
            ActionButton({
              icon: '▶',
              label: 'Start',
              color: '#E3F2FD',
              iconColor: '#2196F3'
            })
              .layoutWeight(1)

            ActionButton({
              icon: '↻',
              label: 'Reboot',
              color: '#FFF3E0',
              iconColor: '#FF9800'
            })
              .layoutWeight(1)

            ActionButton({
              icon: '🔒',
              label: 'Lock',
              color: '#FFEBEE',
              iconColor: '#F44336'
            })
              .layoutWeight(1)

            ActionButton({
              icon: '⚙',
              label: 'Config',
              color: '#F3E5F5',
              iconColor: '#9C27B0'
            })
              .layoutWeight(1)
          }
          .width('100%')

          Blank().height(32)

          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')

            Text('View All')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2196F3')
              .onClick(() => {
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          Blank().height(8)

          Column({ space: 12 }) {
            ForEach(this.logs, (item: LogModel) => {
              LogItem({
                icon: item.icon,
                title: item.title,
                time: item.time,
                typeColor: item.typeColor,
                iconTint: item.iconTint
              })
            })
          }
          .width('100%')
          .padding({ bottom: 16 })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct StatBadge {
  label: string = ''
  value: string = ''

  build() {
    Column() {
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Text(this.label)
        .fontSize(12)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActionButton {
  icon: string = ''
  label: string = ''
  color: string = '#FFFFFF'
  iconColor: string = '#000000'

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text(this.icon)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.iconColor)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(64)
      .backgroundColor(this.color)
      .borderRadius(16)
      .onClick(() => {
      })

      Blank().height(8)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct LogItem {
  icon: string = ''
  title: string = ''
  time: string = ''
  typeColor: string = '#FFFFFF'
  iconTint: string = '#000000'

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text(this.icon)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.iconTint)
          .textAlign(TextAlign.Center)
      }
      .width(40)
      .height(40)
      .backgroundColor(this.typeColor)
      .borderRadius(20)

      Blank().width(16)

      Column() {
        Text(this.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text(this.time)
        .fontSize(12)
        .fontColor('#808080')
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor('#FFFFFF')
    .alignItems(VerticalAlign.Center)
  }
}