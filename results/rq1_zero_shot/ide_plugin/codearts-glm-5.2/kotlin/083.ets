class LogInfo {
  icon: string = ''
  title: string = ''
  time: string = ''
  bg: string = ''
  tint: string = ''
  constructor(icon: string, title: string, time: string, bg: string, tint: string) {
    this.icon = icon
    this.title = title
    this.time = time
    this.bg = bg
    this.tint = tint
  }
}

class ActionInfo {
  icon: string = ''
  label: string = ''
  bg: string = ''
  tint: string = ''
  constructor(icon: string, label: string, bg: string, tint: string) {
    this.icon = icon
    this.label = label
    this.bg = bg
    this.tint = tint
  }
}

@Entry
@Component
struct ServerStatusScreen {
  private actions: ActionInfo[] = [
    new ActionInfo('▶', 'Start', '#E3F2FD', '#2196F3'),
    new ActionInfo('↻', 'Reboot', '#FFF3E0', '#FF9800'),
    new ActionInfo('🔒', 'Lock', '#FFEBEE', '#F44336'),
    new ActionInfo('⚙', 'Config', '#F3E5F5', '#9C27B0'),
  ]
  private logs: LogInfo[] = [
    new LogInfo('⚠', 'High Memory Usage', '10:42 AM', '#FFF3E0', '#FF9800'),
    new LogInfo('👤', 'Admin Login: root', '09:15 AM', '#E3F2FD', '#2196F3'),
    new LogInfo('ℹ', 'Backup Completed', '04:00 AM', '#E8F5E9', '#4CAF50'),
  ]

  @Builder
  StatBadgeBuilder(label: string, value: string) {
    Column() {
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
      Text(label)
        .fontSize(12)
        .fontColor('#888888')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActionButtonBuilder(action: ActionInfo) {
    Column() {
      Column() {
        Text(action.icon)
          .fontSize(24)
          .fontColor(action.tint)
      }
      .width('100%')
      .height(64)
      .backgroundColor(action.bg)
      .borderRadius(16)
      .justifyContent(FlexAlign.Center)
      .' alignItems(HorizontalAlign.Center)

      Text(action.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 8 })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  LogItemBuilder(log: LogInfo) {
    Row() {
      Column() {
        Text(log.icon)
          .fontSize(18)
          .fontColor(log.tint)
      }
      .width(40)
      .height(40)
      .backgroundColor(log.bg)
      .borderRadius(20)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Text(log.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .layoutWeight(1)
        .margin({ left: 16 })

      Text(log.time)
        .fontSize(12)
        .fontColor('#888888')
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      Row() {
        Text('☰')
          .fontSize(22)
          .fontColor('#000000')
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)

        Text('NodeLink')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Stack() {
          Text('🔔')
            .fontSize(22)
            .fontColor('#000000')
          Column() {}
            .width(10)
            .height(10)
            .backgroundColor('#FF0000')
            .borderRadius(5)
            .position({ x: 28, y: 0 })
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
          Column() {
            Column() {
              Text('✓')
                .fontSize(40)
                .fontColor('#4CAF50')
            }
            .width(84)
            .height(84)
            .backgroundColor('#E8F5E9')
            .borderRadius(42)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)

            Text('System Operational')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .margin({ top: 16 })

            Text('Uptime: 14d 2h 15m')
              .fontSize(14)
              .fontColor('#888888')
              .margin({ top: 4 })

            Row() {
              this.StatBadgeBuilder('CPU', '12%')
              this.StatBadgeBuilder('RAM', '4.2GB')
              this.StatBadgeBuilder('NET', '1Gbps')
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
            .margin({ top: 24 })
          }
          .width('100%')
          .padding(24A24)
          .backgroundColor('#F5F7FA')
          .borderRadius(24)
          .alignItems(HorizontalAlign.Center)

          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .margin({ top: 16, bottom: 16 })

          Row() {
            ForEach(this.actions, (action: ActionInfo) => {
              this.ActionButtonBuilder(action)
            }, (action: ActionInfo) => action.label)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .layoutWeight(1)
            Text('View All')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2196F3')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: 32 })

          ForEach(this.logs, (log: LogInfo) => {
            this.LogItemBuilder(log)
          }, (log: LogInfo) => log.title)
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}