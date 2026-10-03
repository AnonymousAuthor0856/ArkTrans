@Entry
@Component
struct ServerStatusPage {
  private logItems: LogItemData[] = [
    { iconSrc: '', title: 'High Memory Usage', time: '10:42 AM', typeColor: '#FFFFF3E0', iconTint: '#FFFF9800', iconUnicode: '⚠' },
    { iconSrc: '', title: 'Admin Login: root', time: '09:15 AM', typeColor: '#FFE3F2FD', iconTint: '#FF2196F3', iconUnicode: '\u{1F464}' },
    { iconSrc: '', title: 'Backup Completed', time: '04:00 AM', typeColor: '#FFE8F5E9', iconTint: '#FF4CAF50', iconUnicode: 'ℹ' }
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
          Text('\u{1F514}')
            .fontSize(24)
            .fontColor(Color.Black)
          Circle({ width: 10, height: 10 })
            .fill(Color.Red)
            .margin({ top: -8, right: -8 })
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
            Stack() {
              Circle({ width: 100, height: 100 })
                .fill(Color.White)
              Circle({ width: 84, height: 84 })
                .fill('#FFE8F5E9')
              Text('✓')
                .fontSize(48)
                .fontColor('#FF4CAF50')
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
              this.StatBadgeComp('CPU', '12%')
              this.StatBadgeComp('RAM', '4.2GB')
              this.StatBadgeComp('NET', '1Gbps')
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
            .margin({ top: 24 })
          }
          .width('100%')
          .padding(24)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor('#FFF5F7FA')
          .borderRadius(24)
          .margin({ top: 16, bottom: 16 })

          // Control Panel
          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .width('100%')
            .margin({ bottom: 16 })

          Row() {
            Column() {
              this.ActionButtonComp('▶', 'Start', '#FFE3F2FD', '#FF2196F3')
            }
            .layoutWeight(1)
            .margin({ right: 4 })

            Column() {
              this.ActionButtonComp('↻', 'Reboot', '#FFFFF3E0', '#FFFF9800')
            }
            .layoutWeight(1)
            .margin({ left: 4, right: 4 })

            Column() {
              this.ActionButtonComp('\u{1F512}', 'Lock', '#FFFFEBEE', '#FFF44336')
            }
            .layoutWeight(1)
            .margin({ left: 4, right: 4 })

            Column() {
              this.ActionButtonComp('⚙', 'Config', '#FFF3E5F5', '#FF9C27B0')
            }
            .layoutWeight(1)
            .margin({ left: 4 })
          }
          .width('100%')

          // Recent Logs
          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)

            Text('View All')
              .fontSize(14)
              .fontColor('#FF2196F3')
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: 32, bottom: 8 })

          Column() {
            ForEach(this.logItems, (item: LogItemData) => {
              this.LogItemComp(item)
            }, (item: LogItemData) => item.title)
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  StatBadgeComp(label: string, value: string) {
    Column() {
      Text(value)
        .fontWeight(FontWeight.Bold)
        .fontSize(16)
        .fontColor(Color.Black)
      Text(label)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActionButtonComp(iconText: string, label: string, bgColor: string, iconColor: string) {
    Column() {
      Stack() {
        Text(iconText)
          .fontSize(28)
          .fontColor(iconColor)
      }
      .width('100%')
      .height(64)
      .backgroundColor(bgColor)
      .borderRadius(16)

      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
  }

  @Builder
  LogItemComp(item: LogItemData) {
    Row() {
      Stack() {
        Text(item.iconUnicode)
          .fontSize(20)
          .fontColor(item.iconTint)
      }
      .width(40)
      .height(40)
      .backgroundColor(item.typeColor)
      .borderRadius(20)

      Text(item.title)
        .fontWeight(FontWeight.Medium)
        .fontSize(14)
        .fontColor(Color.Black)
        .layoutWeight(1)
        .margin({ left: 16 })

      Text(item.time)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({ top: 4, bottom: 4 })
    .margin({ bottom: 12 })
  }
}

interface LogItemData {
  iconSrc: string
  title: string
  time: string
  typeColor: string
  iconTint: string
  iconUnicode: string
}
