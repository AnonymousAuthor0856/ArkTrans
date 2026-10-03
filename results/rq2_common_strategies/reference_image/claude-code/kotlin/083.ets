@Entry
@Component
struct ServerStatusPage {
  private logItems: LogItemData[] = [
    { icon: $r('sys.media.ohos_ic_public_warning'), title: 'High Memory Usage', time: '10:42 AM', typeColor: '#FFFFF3E0', iconTint: '#FFFF9800' },
    { icon: $r('sys.media.ohos_ic_public_person'), title: 'Admin Login: root', time: '09:15 AM', typeColor: '#FFE3F2FD', iconTint: '#FF2196F3' },
    { icon: $r('sys.media.ohos_ic_public_info'), title: 'Backup Completed', time: '04:00 AM', typeColor: '#FFE8F5E9', iconTint: '#FF4CAF50' }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Image($r('sys.media.ohos_ic_public_menu'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)

        Text('NodeLink')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Stack() {
          Image($r('sys.media.ohos_ic_public_notification'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
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
              Image($r('sys.media.ohos_ic_public_selected'))
                .width(48)
                .height(48)
                .fillColor('#FF4CAF50')
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
            this.ActionButtonComp($r('sys.media.ohos_ic_public_play'), 'Start', '#FFE3F2FD', '#FF2196F3')
              .layoutWeight(1)
            this.ActionButtonComp($r('sys.media.ohos_ic_public_refresh'), 'Reboot', '#FFFFF3E0', '#FFFF9800')
              .layoutWeight(1)
            this.ActionButtonComp($r('sys.media.ohos_ic_public_lock'), 'Lock', '#FFFFEBEE', '#FFF44336')
              .layoutWeight(1)
            this.ActionButtonComp($r('sys.media.ohos_ic_public_settings'), 'Config', '#FFF3E5F5', '#FF9C27B0')
              .layoutWeight(1)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

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
  ActionButtonComp(icon: Resource, label: string, bgColor: string, iconColor: string) {
    Column() {
      Stack() {
        Image(icon)
          .width(28)
          .height(28)
          .fillColor(iconColor)
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
  }

  @Builder
  LogItemComp(item: LogItemData) {
    Row() {
      Stack() {
        Image(item.icon)
          .width(20)
          .height(20)
          .fillColor(item.iconTint)
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
  }
}

interface LogItemData {
  icon: Resource
  title: string
  time: string
  typeColor: string
  iconTint: string
}
