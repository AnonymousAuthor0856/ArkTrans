@Entry
@Component
struct ServerStatusScreen {
  @Builder
  private TopBar() {
    Row() {
      Button('☰')
        .fontSize(24)
        .fontColor(Color.Black)
        .backgroundColor(Color.Transparent)
      Blank()
      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Blank()
      Stack({ alignContent: Alignment.TopEnd }) {
        Button('🔔')
          .fontSize(22)
          .fontColor(Color.Black)
          .backgroundColor(Color.Transparent)
        Circle()
          .width(10)
          .height(10)
          .fill(Color.Red)
          .margin(2)
      }
      .width(36)
      .height(36)
    }
    .width('100%')
  }

  @Builder
  private StatBadge(label: string, value: string) {
    Column({ space: 2 }) {
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Text(label)
        .fontSize(12)
        .fontColor('#808080')
    }
  }

  @Builder
  private HeroStatusCard() {
    Column() {
      Column() {
        Stack() {
          Circle()
            .width(100)
            .height(100)
            .fill(Color.White)
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
        .width(100)
        .height(100)

        Blank().height(16)

        Text('System Operational')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text('Uptime: 14d 2h 15m')
          .fontSize(14)
          .fontColor('#808080')
          .margin({ top: 4 })

        Blank().height(24)

        Row({ space: 0 }) {
          this.StatBadge('CPU', '12%').layoutWeight(1)
          this.StatBadge('RAM', '4.2GB').layoutWeight(1)
          this.StatBadge('NET', '1Gbps').layoutWeight(1)
        }
        .width('100%')
      }
      .padding(24)
      .width('100%')
    }
    .width('100%')
    .backgroundColor('#F5F7FA')
    .borderRadius(24)
  }

  @Builder
  private ActionButton(iconName: string, label: string, color: string, iconColor: string) {
    Column() {
      Stack() {
        Rect()
          .width('100%')
          .height(64)
          .fill(color)
          .radius(16)
        Text(iconName)
          .fontSize(24)
          .fontColor(iconColor)
      }
      .height(64)
      .width('100%')
      Blank().height(8)
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .layoutWeight(1)
  }

  @Builder
  private LogItem(iconName: string, title: string, time: string, typeColor: string, iconTint: string) {
    Row() {
      Stack() {
        Circle()
          .width(40)
          .height(40)
          .fill(typeColor)
        Text(iconName)
          .fontSize(16)
          .fontColor(iconTint)
      }
      .width(40)
      .height(40)
      Blank().width(16)
      Text(title)
        .fontSize(14)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)
      Blank()
      Text(time)
        .fontSize(12)
        .fontColor('#808080')
    }
    .padding({ top: 4, bottom: 4 })
    .width('100%')
    .backgroundColor(Color.White)
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.TopBar()
          .padding({ top: 48, left: 24, right: 24, bottom: 16 })

        Scroll() {
          Column({ space: 0 }) {
            this.HeroStatusCard()
              .padding({ top: 16, bottom: 16 })

            Blank().height(16)

            Text('Control Panel')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .padding({ bottom: 16 })
              .width('100%')
              .textAlign(TextAlign.Start)

            Row({ space: 16 }) {
              this.ActionButton('▶', 'Start', '#E3F2FD', '#2196F3')
              this.ActionButton('↻', 'Reboot', '#FFF3E0', '#FF9800')
              this.ActionButton('🔒', 'Lock', '#FFEBEE', '#F44336')
              this.ActionButton('⚙', 'Config', '#F3E5F5', '#9C27B0')
            }
            .width('100%')

            Blank().height(32)

            Row() {
              Text('Recent Logs')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
              Blank()
              Button('View All')
                .fontSize(14)
                .fontWeight(FontWeight.SemiBold)
                .fontColor('#2196F3')
                .backgroundColor(Color.Transparent)
            }
            .width('100%')

            Blank().height(8)

            Column({ space: 12 }) {
              this.LogItem('!', 'High Memory Usage', '10:42 AM', '#FFF3E0', '#FF9800')
              this.LogItem('👤', 'Admin Login: root', '09:15 AM', '#E3F2FD', '#2196F3')
              this.LogItem('i', 'Backup Completed', '04:00 AM', '#E8F5E9', '#4CAF50')
            }
            .padding({ bottom: 16 })
            .width('100%')
          }
          .padding({ left: 24, right: 24 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
