class ServerColors {
  static white: string = '#FFFFFF'
  static black: string = '#000000'
  static gray: string = '#808080'
  static heroBg: string = '#F5F7FA'
  static greenBg: string = '#E8F5E9'
  static green: string = '#4CAF50'
  static blueBg: string = '#E3F2FD'
  static blue: string = '#2196F3'
  static orangeBg: string = '#FFF3E0'
  static orange: string = '#FF9800'
  static redBg: string = '#FFEBEE'
  static red: string = '#F44336'
  static purpleBg: string = '#F3E5F5'
  static purple: string = '#9C27B0'
}

class ActionData {
  icon: string
  label: string
  bg: string
  color: string

  constructor(icon: string, label: string, bg: string, color: string) {
    this.icon = icon
    this.label = label
    this.bg = bg
    this.color = color
  }
}

class LogData {
  icon: string
  title: string
  time: string
  bg: string
  color: string

  constructor(icon: string, title: string, time: string, bg: string, color: string) {
    this.icon = icon
    this.title = title
    this.time = time
    this.bg = bg
    this.color = color
  }
}

@Entry
@Component
struct Index {
  private actions: ActionData[] = [
    new ActionData('Play', 'Start', ServerColors.blueBg, ServerColors.blue),
    new ActionData('Reboot', 'Reboot', ServerColors.orangeBg, ServerColors.orange),
    new ActionData('Lock', 'Lock', ServerColors.redBg, ServerColors.red),
    new ActionData('Gear', 'Config', ServerColors.purpleBg, ServerColors.purple)
  ]
  private logs: LogData[] = [
    new LogData('Warn', 'High Memory Usage', '10:42 AM', ServerColors.orangeBg, ServerColors.orange),
    new LogData('User', 'Admin Login: root', '09:15 AM', ServerColors.blueBg, ServerColors.blue),
    new LogData('Info', 'Backup Completed', '04:00 AM', ServerColors.greenBg, ServerColors.green)
  ]

  @Builder
  TopBar() {
    Row() {
      Button('Menu')
        .fontSize(12)
        .fontColor(ServerColors.black)
        .backgroundColor('#00000000')

      Blank()
        .layoutWeight(1)

      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(ServerColors.black)

      Blank()
        .layoutWeight(1)

      Stack({ alignContent: Alignment.TopEnd }) {
        Button('Bell')
          .fontSize(12)
          .fontColor(ServerColors.black)
          .backgroundColor('#00000000')
        Circle()
          .width(10)
          .height(10)
          .fill('#FF0000')
          .margin(2)
      }
      .width(48)
      .height(32)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  StatBadge(label: string, value: string) {
    Column({ space: 2 }) {
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(ServerColors.black)
      Text(label)
        .fontSize(12)
        .fontColor(ServerColors.gray)
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  HeroStatusCard() {
    Column() {
      Stack() {
        Circle()
          .width(100)
          .height(100)
          .fill(ServerColors.white)
        Stack() {
          Circle()
            .width(84)
            .height(84)
            .fill(ServerColors.greenBg)
          Text('OK')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(ServerColors.green)
        }
        .width(84)
        .height(84)
      }
      .width(100)
      .height(100)

      Blank()
        .height(16)

      Text('System Operational')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(ServerColors.black)

      Text('Uptime: 14d 2h 15m')
        .fontSize(14)
        .fontColor(ServerColors.gray)
        .margin({ top: 4 })

      Blank()
        .height(24)

      Row() {
        this.StatBadge('CPU', '12%')
        this.StatBadge('RAM', '4.2GB')
        this.StatBadge('NET', '1Gbps')
      }
      .width('100%')
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(ServerColors.heroBg)
    .borderRadius(24)
  }

  @Builder
  ActionButton(item: ActionData) {
    Column() {
      Stack() {
        Text(item.icon)
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(item.color)
      }
      .width('100%')
      .height(64)
      .backgroundColor(item.bg)
      .borderRadius(16)

      Blank()
        .height(8)

      Text(item.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ServerColors.black)
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  LogItem(item: LogData) {
    Row() {
      Stack() {
        Circle()
          .width(40)
          .height(40)
          .fill(item.bg)
        Text(item.icon)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(item.color)
      }
      .width(40)
      .height(40)

      Blank()
        .width(16)

      Text(item.title)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(ServerColors.black)

      Blank()
        .layoutWeight(1)

      Text(item.time)
        .fontSize(12)
        .fontColor(ServerColors.gray)
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor(ServerColors.white)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Stack() {
      Column() {
        Column() {
          this.TopBar()
        }
        .width('100%')
        .padding({ top: 48, left: 24, right: 24, bottom: 16 })

        Scroll() {
          Column() {
            Column() {
              this.HeroStatusCard()
            }
            .width('100%')
            .padding({ top: 16, bottom: 16 })

            Blank()
              .height(16)

            Text('Control Panel')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(ServerColors.black)
              .width('100%')
              .margin({ bottom: 16 })

            Row({ space: 16 }) {
              ForEach(this.actions, (action: ActionData) => {
                this.ActionButton(action)
              })
            }
            .width('100%')

            Blank()
              .height(32)

            Row() {
              Text('Recent Logs')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(ServerColors.black)
              Blank()
                .layoutWeight(1)
              Button('View All')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor(ServerColors.blue)
                .backgroundColor('#00000000')
            }
            .width('100%')

            Blank()
              .height(8)

            Column({ space: 12 }) {
              ForEach(this.logs, (log: LogData) => {
                this.LogItem(log)
              })
            }
            .width('100%')
            .padding({ bottom: 16 })
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ServerColors.white)
  }
}
