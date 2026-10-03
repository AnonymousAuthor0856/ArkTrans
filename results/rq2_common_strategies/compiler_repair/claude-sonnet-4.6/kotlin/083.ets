import { LengthMetrics } from '@kit.ArkUI';

@Entry
@Component
struct ServerStatusScreen {
  build() {
    Column() {
      // Top Bar
      Row() {
        Button({ type: ButtonType.Circle }) {
          Text('☰')
            .fontSize(20)
            .fontColor(Color.Black)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)

        Text('NodeLink')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Stack({ alignContent: Alignment.TopEnd }) {
          Button({ type: ButtonType.Circle }) {
            Text('🔔')
              .fontSize(20)
              .fontColor(Color.Black)
          }
          .width(40)
          .height(40)
          .backgroundColor(Color.Transparent)

          Circle()
            .width(10)
            .height(10)
            .fill(Color.Red)
            .offset({ x: 2, y: 2 })
        }
        .width(44)
        .height(44)
      }
      .width('100%')
      .padding({ top: 48, bottom: 16, left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          // Hero Status Card
          Column() {
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
              .alignContent(Alignment.Center)

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
          }
          .width('100%')
          .borderRadius(24)
          .backgroundColor('#F5F7FA')
          .margin({ top: 16, bottom: 16 })

          Blank().height(16)

          // Control Panel
          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ bottom: 16 })
            .alignSelf(ItemAlign.Start)

          Row() {
            ActionButton({
              icon: '▶',
              label: 'Start',
              bgColor: '#E3F2FD',
              iconColor: '#2196F3'
            })
            ActionButton({
              icon: '↺',
              label: 'Reboot',
              bgColor: '#FFF3E0',
              iconColor: '#FF9800'
            })
            ActionButton({
              icon: '🔒',
              label: 'Lock',
              bgColor: '#FFEBEE',
              iconColor: '#F44336'
            })
            ActionButton({
              icon: '⚙',
              label: 'Config',
              bgColor: '#F3E5F5',
              iconColor: '#9C27B0'
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Blank().height(32)

          // Recent Logs Header
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

          // Log Items
          Column({ space: 12 }) {
            LogItem({
              icon: '⚠',
              title: 'High Memory Usage',
              time: '10:42 AM',
              bgColor: '#FFF3E0',
              iconColor: '#FF9800'
            })
            LogItem({
              icon: '👤',
              title: 'Admin Login: root',
              time: '09:15 AM',
              bgColor: '#E3F2FD',
              iconColor: '#2196F3'
            })
            LogItem({
              icon: 'ℹ',
              title: 'Backup Completed',
              time: '04:00 AM',
              bgColor: '#E8F5E9',
              iconColor: '#4CAF50'
            })
          }
          .width('100%')
          .margin({ bottom: 16 })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
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
  icon: string = ''
  label: string = ''
  bgColor: string = '#FFFFFF'
  iconColor: string = '#000000'

  build() {
    Column() {
      Stack() {
        Text(this.icon)
          .fontSize(24)
          .fontColor(this.iconColor)
      }
      .width('100%')
      .height(64)
      .backgroundColor(this.bgColor)
      .borderRadius(16)
      .alignContent(Alignment.Center)

      Blank().height(8)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
    .margin({ left: 4, right: 4 })
  }
}

@Component
struct LogItem {
  icon: string = ''
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

        Text(this.icon)
          .fontSize(18)
          .fontColor(this.iconColor)
      }
      .width(40)
      .height(40)
      .alignContent(Alignment.Center)

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