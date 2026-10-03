@Entry
@Component
struct ServerStatusPage {
  private logs: LogItemData[] = [
    { iconChar: '!', title: 'High Memory Usage', time: '10:42 AM', typeColor: '#FFF3E0', iconTint: '#FF9800' },
    { iconChar: '👤', title: 'Admin Login: root', time: '09:15 AM', typeColor: '#E3F2FD', iconTint: '#2196F3' },
    { iconChar: 'i', title: 'Backup Completed', time: '04:00 AM', typeColor: '#E8F5E9', iconTint: '#4CAF50' }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('☰')
          .fontSize(24)
          .fontColor(Color.Black)

        Text('NodeLink')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Stack() {
          Text('🔔')
            .fontSize(24)
            .fontColor(Color.Black)

          Circle({ width: 10, height: 10 })
            .fill(Color.Red)
            .margin({ top: 2, right: 2 })
        }
        .alignContent(Alignment.TopEnd)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ top: 48, bottom: 16, left: 24, right: 24 })

      Scroll() {
        Column() {
          // Hero Status Card
          Column() {
            // Circular status icon
            Stack() {
              Circle({ width: 100, height: 100 })
                .fill(Color.White)
                .padding(8)

              Circle({ width: 84, height: 84 })
                .fill('#E8F5E9')

              Text('✓')
                .fontSize(48)
                .fontColor('#4CAF50')
                .fontWeight(FontWeight.Bold)
            }
            .width(100)
            .height(100)
            .alignContent(Alignment.Center)

            Text('System Operational')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ top: 16 })

            Text('Uptime: 14d 2h 15m')
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ top: 4 })

            // Stat badges row
            Row() {
              StatBadge({ label: 'CPU', value: '12%' })
              StatBadge({ label: 'RAM', value: '4.2GB' })
              StatBadge({ label: 'NET', value: '1Gbps' })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
            .margin({ top: 24 })
          }
          .width('100%')
          .padding(24)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor('#F5F7FA')
          .borderRadius(24)
          .margin({ top: 0, bottom: 16 })

          // Control Panel
          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ bottom: 16 })

          // Quick Actions Row
          Row() {
            ActionButton({ iconChar: '▶', label: 'Start', bgColor: '#E3F2FD', iconColor: '#2196F3' })
              .layoutWeight(1)
            ActionButton({ iconChar: '↻', label: 'Reboot', bgColor: '#FFF3E0', iconColor: '#FF9800' })
              .layoutWeight(1)
            ActionButton({ iconChar: '🔒', label: 'Lock', bgColor: '#FFEBEE', iconColor: '#F44336' })
              .layoutWeight(1)
            ActionButton({ iconChar: '⚙', label: 'Config', bgColor: '#F3E5F5', iconColor: '#9C27B0' })
              .layoutWeight(1)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          // Recent Logs header
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
          .margin({ top: 32, bottom: 8 })

          // Log list
          ForEach(this.logs, (item: LogItemData, index: number) => {
            LogItemView({ item: item })
              .margin({ bottom: index < this.logs.length - 1 ? 12 : 0 })
          }, (item: LogItemData) => item.title)
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 16 })
      }
      .width('100%')
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
  iconChar: string = ''
  label: string = ''
  bgColor: string = ''
  iconColor: string = ''

  build() {
    Column() {
      Stack() {
        Text(this.iconChar)
          .fontSize(28)
          .fontColor(this.iconColor)
      }
      .width('100%')
      .height(64)
      .backgroundColor(this.bgColor)
      .borderRadius(16)
      .alignContent(Alignment.Center)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

interface LogItemData {
  iconChar: string
  title: string
  time: string
  typeColor: string
  iconTint: string
}

@Component
struct LogItemView {
  item: LogItemData = {
    iconChar: 'i',
    title: '',
    time: '',
    typeColor: '#FFFFFF',
    iconTint: '#000000'
  }

  build() {
    Row() {
      Stack() {
        Circle({ width: 40, height: 40 })
          .fill(this.item.typeColor)

        Text(this.item.iconChar)
          .fontSize(20)
          .fontColor(this.item.iconTint)
          .fontWeight(FontWeight.Bold)
      }
      .width(40)
      .height(40)
      .alignContent(Alignment.Center)

      Column() {
        Text(this.item.title)
          .fontWeight(FontWeight.Medium)
          .fontSize(14)
          .fontColor(Color.Black)
      }
      .layoutWeight(1)
      .margin({ left: 16 })

      Text(this.item.time)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .padding({ top: 4, bottom: 4 })
  }
}
