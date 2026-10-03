class LogEntry {
  icon: string;
  title: string;
  time: string;
  typeColor: string;
  iconTint: string;

  constructor(icon: string, title: string, time: string, typeColor: string, iconTint: string) {
    this.icon = icon;
    this.title = title;
    this.time = time;
    this.typeColor = typeColor;
    this.iconTint = iconTint;
  }
}

@Entry
@Component
struct ServerStatusScreen {
  private logItems: LogEntry[] = [
    new LogEntry('⚠', 'High Memory Usage', '10:42 AM', '#FFF3E0', '#FF9800'),
    new LogEntry('👤', 'Admin Login: root', '09:15 AM', '#E3F2FD', '#2196F3'),
    new LogEntry('ℹ', 'Backup Completed', '04:00 AM', '#E8F5E9', '#4CAF50')
  ];

  @Builder
  StatBadge(label: string, value: string) {
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
  ActionButton(icon: string, label: string, color: string, iconColor: string) {
    Column() {
      Stack() {
        Text(icon)
          .fontSize(28)
          .fontColor(iconColor)
      }
      .width('100%')
      .height(64)
      .backgroundColor(color)
      .borderRadius(16)
      .alignContent(Alignment.Center)

      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
  }

  @Builder
  LogItemView(item: LogEntry) {
    Row() {
      Stack() {
        Text(item.icon)
          .fontSize(20)
          .fontColor(item.iconTint)
      }
      .width(40)
      .height(40)
      .backgroundColor(item.typeColor)
      .borderRadius(20)
      .alignContent(Alignment.Center)

      Text(item.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .layoutWeight(1)
        .margin({ left: 16 })

      Text(item.time)
        .fontSize(12)
        .fontColor('#888888')
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({ top: 4, bottom: 4 })
  }

  build() {
    Column() {
      Row() {
        Text('☰')
          .fontSize(24)
          .fontColor('#000000')
        Text('NodeLink')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Stack() {
          Text('🔔')
            .fontSize(24)
            .fontColor('#000000')
          Circle()
            .width(10)
            .height(10)
            .fill('#FF0000')
            .position({ x: 16, y: 0 })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ top: 48, bottom: 16, left: 24, right: 24 })

      Scroll() {
        Column() {
          Column() {
            Stack() {
              Stack() {
                Text('✓')
                  .fontSize(48)
                  .fontColor('#4CAF50')
              }
              .width(84)
              .height(84)
              .backgroundColor('#E8F5E9')
              .borderRadius(42)
              .alignContent(Alignment.Center)
            }
            .width(100)
            .height(100)
            .backgroundColor('#FFFFFF')
            .borderRadius(50)
            .alignContent(Alignment.Center)

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
          .backgroundColor('#F5F7FA')
          .borderRadius(24)
          .alignItems(HorizontalAlign.Center)
          .margin({ top: 16, bottom: 16 })

          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .margin({ bottom: 16 })

          Row({ space: 16 }) {
            this.ActionButton('▶', 'Start', '#E3F2FD', '#2196F3')
            this.ActionButton('↻', 'Reboot', '#FFF3E0', '#FF9800')
            this.ActionButton('🔒', 'Lock', '#FFEBEE', '#F44336')
            this.ActionButton('⚙', 'Config', '#F3E5F5', '#9C27B0')
          }
          .width('100%')

          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Text('View All')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2196F3')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: 32 })

          Column({ space: 12 }) {
            ForEach(this.logItems, (item: LogEntry) => {
              this.LogItemView(item)
            }, (item: LogEntry) => item.title)
          }
          .width('100%')
          .margin({ top: 8, bottom: 16 })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .align(Alignment.Top)
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
      .align(Alignment.Top)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
