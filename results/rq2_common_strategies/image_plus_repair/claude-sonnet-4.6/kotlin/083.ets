@Entry
@Component
struct ServerStatusScreen {
  build() {
    Column() {
      // Top Bar
      Row() {
        Column() {
          ForEach([0, 1, 2], () => {
            Row()
              .width(22)
              .height(2)
              .backgroundColor(Color.Black)
              .margin({ bottom: 4 })
          })
        }
        .justifyContent(FlexAlign.Center)
        .width(40)
        .height(40)

        Text('NodeLink')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Stack({ alignContent: Alignment.TopEnd }) {
          Column() {
            Text('🔔')
              .fontSize(22)
              .width(40)
              .height(40)
              .textAlign(TextAlign.Center)
          }

          Circle()
            .width(10)
            .height(10)
            .fill(Color.Red)
            .offset({ x: 2, y: -2 })
        }
        .width(40)
        .height(40)
      }
      .width('100%')
      .padding({ top: 48, bottom: 16, left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          // Hero Status Card
          Column() {
            Stack() {
              Circle()
                .width(100)
                .height(100)
                .fill(Color.White)

              Circle()
                .width(84)
                .height(84)
                .fill('#E8F5E9')

              Text('✓')
                .fontSize(40)
                .fontColor('#4CAF50')
                .fontWeight(FontWeight.Bold)
            }
            .width(100)
            .height(100)

            Blank().height(16)

            Text('System Operational')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)

            Text('Uptime: 14d 2h 15m')
              .fontSize(14)
              .fontColor(Color.Gray)
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
          .alignItems(HorizontalAlign.Center)
          .backgroundColor('#F5F7FA')
          .borderRadius(24)
          .margin({ top: 16, bottom: 16 })

          Blank().height(16)

          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ bottom: 16 })
            .alignSelf(ItemAlign.Start)

          Row() {
            ActionButton({
              iconText: '▶',
              label: 'Start',
              bgColor: '#E3F2FD',
              iconColor: '#2196F3'
            })
            Blank().width(16)
            ActionButton({
              iconText: '↺',
              label: 'Reboot',
              bgColor: '#FFF3E0',
              iconColor: '#FF9800'
            })
            Blank().width(16)
            ActionButton({
              iconText: '🔒',
              label: 'Lock',
              bgColor: '#FFEBEE',
              iconColor: '#F44336'
            })
            Blank().width(16)
            ActionButton({
              iconText: '⚙',
              label: 'Config',
              bgColor: '#F3E5F5',
              iconColor: '#9C27B0'
            })
          }
          .width('100%')

          Blank().height(32)

          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)

            Text('View All')
              .fontSize(14)
              .fontColor('#2196F3')
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          Blank().height(8)

          LogItem({
            iconText: '⚠',
            title: 'High Memory Usage',
            time: '10:42 AM',
            bgColor: '#FFF3E0',
            iconColor: '#FF9800'
          })
          Blank().height(12)
          LogItem({
            iconText: '👤',
            title: 'Admin Login: root',
            time: '09:15 AM',
            bgColor: '#E3F2FD',
            iconColor: '#2196F3'
          })
          Blank().height(12)
          LogItem({
            iconText: 'ℹ',
            title: 'Backup Completed',
            time: '04:00 AM',
            bgColor: '#E8F5E9',
            iconColor: '#4CAF50'
          })

          Blank().height(16)
        }
        .padding({ left: 24, right: 24 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct StatBadge {
  label: string = ''
  value: string = ''

  build() {
    Column() {
      Text(this.value)
        .fontWeight(FontWeight.Bold)
        .fontSize(16)
        .fontColor(Color.Black)
      Text(this.label)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActionButton {
  iconText: string = ''
  label: string = ''
  bgColor: string = '#FFFFFF'
  iconColor: string = '#000000'

  build() {
    Column() {
      Column() {
        Text(this.iconText)
          .fontSize(24)
          .fontColor(this.iconColor)
      }
      .width('100%')
      .height(64)
      .backgroundColor(this.bgColor)
      .borderRadius(16)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Blank().height(8)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct LogItem {
  iconText: string = ''
  title: string = ''
  time: string = ''
  bgColor: string = '#FFFFFF'
  iconColor: string = '#000000'

  build() {
    Row() {
      Stack() {
        Circle()
          .width(40)
          .height(40)
          .fill(this.bgColor)

        Text(this.iconText)
          .fontSize(18)
          .fontColor(this.iconColor)
      }
      .width(40)
      .height(40)

      Blank().width(16)

      Column() {
        Text(this.title)
          .fontWeight(FontWeight.Medium)
          .fontSize(14)
          .fontColor(Color.Black)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text(this.time)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .backgroundColor(Color.White)
    .padding({ top: 4, bottom: 4 })
    .alignItems(VerticalAlign.Center)
  }
}