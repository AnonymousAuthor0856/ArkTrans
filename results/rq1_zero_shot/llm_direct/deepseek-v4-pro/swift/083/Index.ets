@Entry
@Component
struct ServerStatusScreen {
  @State private var logs: Array<LogData> = [
    new LogData('⚠️', 'High Memory Usage', '10:42 AM', '#FFF3E0', '#FF9800'),
    new LogData('👤', 'Admin Login: root', '09:15 AM', '#E3F2FD', '#2196F3'),
    new LogData('ℹ️', 'Backup Completed', '04:00 AM', '#E8F5E9', '#4CAF50')
  ]

  build() {
    Column() {
      // Top Bar
      TopBar()
        .padding({ top: 48, left: 24, right: 24, bottom: 16 })

      Scroll() {
        Column({ space: 0 }) {
          // Hero Status Card
          HeroStatusCard()
            .padding({ top: 16, bottom: 16 })

          Blank().height(16)

          // Control Panel Section
          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .padding({ bottom: 16 })

          Row({ space: 16 }) {
            ActionButton('▶', 'Start', '#E3F2FD', '#2196F3')
            ActionButton('🔄', 'Reboot', '#FFF3E0', '#FF9800')
            ActionButton('🔒', 'Lock', '#FFEBEE', '#F44336')
            ActionButton('⚙️', 'Config', '#F3E5F5', '#9C27B0')
          }
          .width('100%')

          Blank().height(32)

          // Recent Logs Header
          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Blank()
            Text('View All')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2196F3')
          }
          .width('100%')

          Blank().height(8)

          // Recent Logs List
          Column({ space: 12 }) {
            ForEach(this.logs, (item: LogData) => {
              LogItem(item.icon, item.title, item.time, item.typeColor, item.iconTint)
            })
          }
          .padding({ bottom: 16 })
        }
        .padding({ left: 24, right: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct TopBar {
  build() {
    Row() {
      Text('☰')
        .fontSize(24)
        .fontColor('#000000')
      Blank()
      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
      Blank()
      Stack({ alignContent: Alignment.TopEnd }) {
        Text('🔔')
          .fontSize(24)
          .fontColor('#000000')
        Circle()
          .width(10)
          .height(10)
          .fill('#FF0000')
          .margin(2)
      }
    }
    .width('100%')
  }
}

@Component
struct HeroStatusCard {
  build() {
    Column() {
      Column() {
        Stack() {
          Circle()
            .width(100)
            .height(100)
            .fill('#FFFFFF')

          Stack() {
            Circle()
              .width(84)
              .height(84)
              .fill('#E8F5E9')

            Text('✓')
              .fontSize(40)
              .fontWeight(FontWeight.Bold)
              .fontColor('#4CAF50')
          }
        }

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
          StatBadge('12%', 'CPU')
            .layoutWeight(1)
          StatBadge('4.2GB', 'RAM')
            .layoutWeight(1)
          StatBadge('1Gbps', 'NET')
            .layoutWeight(1)
        }
        .width('100%')
      }
      .padding(24)
    }
    .width('100%')
    .backgroundColor('#F5F7FA')
    .borderRadius(24)
  }
}

@Component
struct StatBadge {
  private value: string
  private label: string

  build() {
    Column({ space: 2 }) {
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
      Text(this.label)
        .fontSize(12)
        .fontColor('#808080')
    }
  }
}

@Component
struct ActionButton {
  private icon: string
  private label: string
  private bgColor: string
  private iconColor: string

  build() {
    Column() {
      Button() {
        Stack() {
          Row()
            .width('100%')
            .height(64)
            .backgroundColor(this.bgColor)
            .borderRadius(16)
          Text(this.icon)
            .fontSize(24)
            .fontColor(this.iconColor)
        }
      }
      .width('100%')

      Blank().height(8)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .layoutWeight(1)
  }
}

@Component
struct LogItem {
  private icon: string
  private title: string
  private time: string
  private typeColor: string
  private iconTint: string

  build() {
    Row() {
      Stack() {
        Circle()
          .width(40)
          .height(40)
          .fill(this.typeColor)
        Text(this.icon)
          .fontSize(16)
          .fontColor(this.iconTint)
      }

      Blank().width(16)

      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')

      Blank()

      Text(this.time)
        .fontSize(12)
        .fontColor('#808080')
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor('#FFFFFF')
  }
}

class LogData {
  icon: string
  title: string
  time: string
  typeColor: string
  iconTint: string

  constructor(icon: string, title: string, time: string, typeColor: string, iconTint: string) {
    this.icon = icon
    this.title = title
    this.time = time
    this.typeColor = typeColor
    this.iconTint = iconTint
  }
}