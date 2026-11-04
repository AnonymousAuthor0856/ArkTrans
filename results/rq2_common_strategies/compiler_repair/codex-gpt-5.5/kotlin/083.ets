class ActionItem {
  icon: string
  label: string
  bgColor: string
  iconColor: string

  constructor(icon: string, label: string, bgColor: string, iconColor: string) {
    this.icon = icon
    this.label = label
    this.bgColor = bgColor
    this.iconColor = iconColor
  }
}

class LogItemData {
  icon: string
  title: string
  time: string
  bgColor: string
  iconColor: string

  constructor(icon: string, title: string, time: string, bgColor: string, iconColor: string) {
    this.icon = icon
    this.title = title
    this.time = time
    this.bgColor = bgColor
    this.iconColor = iconColor
  }
}

@Entry
@Component
struct Index {
  private actions: ActionItem[] = [
    new ActionItem('▶', 'Start', '#E3F2FD', '#2196F3'),
    new ActionItem('↻', 'Reboot', '#FFF3E0', '#FF9800'),
    new ActionItem('●', 'Lock', '#FFEBEE', '#F44336'),
    new ActionItem('⚙', 'Config', '#F3E5F5', '#9C27B0')
  ]

  private logs: LogItemData[] = [
    new LogItemData('!', 'High Memory Usage', '10:42 AM', '#FFF3E0', '#FF9800'),
    new LogItemData('人', 'Admin Login: root', '09:15 AM', '#E3F2FD', '#2196F3'),
    new LogItemData('i', 'Backup Completed', '04:00 AM', '#E8F5E9', '#4CAF50')
  ]

  build() {
    Column() {
      this.TopBar()
      Scroll() {
        Column() {
          this.HeroStatus()
          Text('Control Panel')
            .width('100%')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ top: 16, bottom: 16 })
          Row() {
            ForEach(this.actions, (action: ActionItem) => {
              this.ActionButton(action)
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
            Text('View All')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#2196F3')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: 32 })

          ForEach(this.logs, (log: LogItemData) => {
            this.LogItem(log)
          })
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 16 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  TopBar() {
    Row() {
      Button('☰')
        .fontSize(22)
        .fontColor(Color.Black)
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
        .padding(0)
      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Stack({ alignContent: Alignment.TopEnd }) {
        Button('!')
          .fontSize(22)
          .fontColor(Color.Black)
          .backgroundColor(Color.Transparent)
          .width(48)
          .height(48)
          .padding(0)
        Circle()
          .width(10)
          .height(10)
          .fill(Color.Red)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .padding({ top: 48, bottom: 16, left: 24, right: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  HeroStatus() {
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
          .fontSize(48)
          .fontColor('#4CAF50')
          .fontWeight(FontWeight.Bold)
      }
      .width(100)
      .height(100)

      Text('System Operational')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 16 })
      Text('Uptime: 14d 2h 15m')
        .fontSize(14)
        .fontColor(Color.Gray)
        .margin({ top: 4 })

      Row() {
        this.StatBadge('CPU', '12%')
        this.StatBadge('RAM', '4.2GB')
        this.StatBadge('NET', '1Gbps')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: 24 })
    }
    .width('100%')
    .padding(24)
    .borderRadius(24)
    .backgroundColor('#F5F7FA')
    .alignItems(HorizontalAlign.Center)
    .margin({ top: 16 })
  }

  @Builder
  StatBadge(label: string, value: string) {
    Column() {
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Text(label)
        .fontSize(12)
        .fontColor(Color.Gray)
        .margin({ top: 2 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActionButton(action: ActionItem) {
    Column() {
      Stack() {
        Text(action.icon)
          .fontSize(28)
          .fontColor(action.iconColor)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(64)
      .borderRadius(16)
      .backgroundColor(action.bgColor)
      Text(action.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 8 })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
    .margin({ right: 8 })
  }

  @Builder
  LogItem(log: LogItemData) {
    Row() {
      Stack() {
        Circle()
          .width(40)
          .height(40)
          .fill(log.bgColor)
        Text(log.icon)
          .fontSize(20)
          .fontColor(log.iconColor)
          .fontWeight(FontWeight.Bold)
      }
      .width(40)
      .height(40)

      Text(log.title)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .layoutWeight(1)
        .margin({ left: 16 })

      Text(log.time)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .alignItems(VerticalAlign.Center)
    .margin({ top: 12 })
  }
}
