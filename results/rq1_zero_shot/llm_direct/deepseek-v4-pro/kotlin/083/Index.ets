import { router } from '@kit.ArkUI';

@Entry
@Component
struct ServerStatusScreen {
  @State uptime: string = 'Uptime: 14d 2h 15m';
  @State cpuValue: string = '12%';
  @State ramValue: string = '4.2GB';
  @State netValue: string = '1Gbps';

  private logs: Array<LogItemData> = [
    {
      icon: '⚠',
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
      icon: 'ℹ',
      title: 'Backup Completed',
      time: '04:00 AM',
      typeColor: '#E8F5E9',
      iconTint: '#4CAF50'
    }
  ];

  @Builder
  TopBar() {
    Row() {
      Row({ space: 16 }) {
        Text('☰')
          .fontSize(24)
          .fontColor(Color.Black)
          .onClick(() => {})
        Text('NodeLink')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Blank()
        Stack() {
          Text('🔔')
            .fontSize(24)
            .fontColor(Color.Black)
            .onClick(() => {})
          Circle()
            .width(10)
            .height(10)
            .fill(Color.Red)
            .position({ x: 18, y: 0 })
        }
      }
      .width('100%')
      .padding({ top: 48, bottom: 16, left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }

  @Builder
  StatBadge(label: string, value: string) {
    Column({ space: 4 }) {
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Text(label)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActionButton(icon: string, label: string, bgColor: string, iconColor: string) {
    Column({ space: 8 }) {
      Row() {
        Text(icon)
          .fontSize(28)
          .fontColor(iconColor)
      }
      .width('100%')
      .height(64)
      .borderRadius(16)
      .backgroundColor(bgColor)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .onClick(() => {})

      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
  }

  @Builder
  LogItem(log: LogItemData) {
    Row({ space: 16 }) {
      Row() {
        Text(log.icon)
          .fontSize(20)
          .fontColor(log.iconTint)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(log.typeColor)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(log.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text(log.time)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .padding({ vertical: 4 })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: 16 }) {
          // Hero Status Section
          Column({ space: 16 }) {
            Row() {
              Column({ space: 16 }) {
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
                }
                .width(100)
                .height(100)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)

                Text('System Operational')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)

                Text(this.uptime)
                  .fontSize(14)
                  .fontColor(Color.Gray)

                Row() {
                  this.StatBadge('CPU', this.cpuValue)
                  this.StatBadge('RAM', this.ramValue)
                  this.StatBadge('NET', this.netValue)
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
          }

          // Control Panel
          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          Row({ space: 16 }) {
            this.ActionButton('▶', 'Start', '#E3F2FD', '#2196F3')
            this.ActionButton('↻', 'Reboot', '#FFF3E0', '#FF9800')
            this.ActionButton('🔒', 'Lock', '#FFEBEE', '#F44336')
            this.ActionButton('⚙', 'Config', '#F3E5F5', '#9C27B0')
          }
          .width('100%')

          // Recent Logs
          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
            Blank()
            Text('View All')
              .fontSize(14)
              .fontColor('#2196F3')
              .fontWeight(FontWeight.Medium)
              .onClick(() => {})
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Logs List
          Column({ space: 12 }) {
            ForEach(this.logs, (log: LogItemData) => {
              this.LogItem(log)
            })
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

interface LogItemData {
  icon: string;
  title: string;
  time: string;
  typeColor: string;
  iconTint: string;
}