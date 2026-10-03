// ServerStatusScreen.ets
interface StatBadgeData {
  label: string;
  value: string;
}

interface ActionButtonData {
  icon: Resource;
  label: string;
  color: ResourceColor;
  iconColor: ResourceColor;
}

interface LogItemData {
  icon: Resource;
  title: string;
  time: string;
  typeColor: ResourceColor;
  iconTint: ResourceColor;
}

@Entry
@Component
struct ServerStatusScreen {
  private logs: LogItemData[] = [
    {
      icon: $r('app.media.ic_warning'),
      title: 'High Memory Usage',
      time: '10:42 AM',
      typeColor: '#FFF3E0',
      iconTint: '#FF9800'
    },
    {
      icon: $r('app.media.ic_person'),
      title: 'Admin Login: root',
      time: '09:15 AM',
      typeColor: '#E3F2FD',
      iconTint: '#2196F3'
    },
    {
      icon: $r('app.media.ic_info'),
      title: 'Backup Completed',
      time: '04:00 AM',
      typeColor: '#E8F5E9',
      iconTint: '#4CAF50'
    }
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
        .fontColor('#808080')
        .margin({ top: 2 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActionButton(icon: Resource, label: string, color: ResourceColor, iconColor: ResourceColor) {
    Column() {
      Row() {
        Image(icon)
          .width(28)
          .height(28)
          .fillColor(iconColor)
      }
      .width('100%')
      .height(64)
      .borderRadius(16)
      .backgroundColor(color)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 8 })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  LogItem(icon: Resource, title: string, time: string, typeColor: ResourceColor, iconTint: ResourceColor) {
    Row() {
      Row() {
        Image(icon)
          .width(20)
          .height(20)
          .fillColor(iconTint)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(typeColor)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text(title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ left: 16 })
        .layoutWeight(1)

      Text(time)
        .fontSize(12)
        .fontColor('#808080')
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Image($r('app.media.ic_menu'))
          .width(24)
          .height(24)
          .fillColor('#000000')

        Text('NodeLink')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Stack({ alignContent: Alignment.TopEnd }) {
          Image($r('app.media.ic_notifications'))
            .width(24)
            .height(24)
            .fillColor('#000000')
          // Red dot for notifications
          Row()
            .width(10)
            .height(10)
            .borderRadius(5)
            .backgroundColor('#FF0000')
            .margin({ top: -2, right: -2 })
        }
      }
      .width('100%')
      .padding({ top: 48, bottom: 16, left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content Scroll
      Scroll() {
        Column() {
          // Hero Status Section
          Column() {
            // Status Icon
            Stack() {
              Row()
                .width(100)
                .height(100)
                .borderRadius(50)
                .backgroundColor('#E8F5E9')
              Image($r('app.media.ic_check'))
                .width(48)
                .height(48)
                .fillColor('#4CAF50')
            }
            .width(100)
            .height(100)
            .borderRadius(50)
            .backgroundColor('#FFFFFF')
            .padding(8)
            .alignContent(Alignment.Center)

            Text('System Operational')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .margin({ top: 16 })

            Text('Uptime: 14d 2h 15m')
              .fontSize(14)
              .fontColor('#808080')
              .margin({ top: 4 })

            // Stats Row
            Row() {
              this.StatBadge('CPU', '12%')
              this.StatBadge('RAM', '4.2GB')
              this.StatBadge('NET', '1Gbps')
            }
            .width('100%')
            .margin({ top: 24 })
            .justifyContent(FlexAlign.SpaceEvenly)
          }
          .width('100%')
          .padding(24)
          .borderRadius(24)
          .backgroundColor('#F5F7FA')
          .alignItems(HorizontalAlign.Center)

          // Control Panel Title
          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .margin({ top: 32, bottom: 16 })

          // Quick Actions Grid
          Row() {
            this.ActionButton($r('app.media.ic_play_arrow'), 'Start', '#E3F2FD', '#2196F3')
            this.ActionButton($r('app.media.ic_refresh'), 'Reboot', '#FFF3E0', '#FF9800')
            this.ActionButton($r('app.media.ic_lock'), 'Lock', '#FFEBEE', '#F44336')
            this.ActionButton($r('app.media.ic_settings'), 'Config', '#F3E5F5', '#9C27B0')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          // Recent Logs Header
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
          .margin({ top: 32, bottom: 8 })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Logs List
          Column() {
            ForEach(this.logs, (log: LogItemData) => {
              this.LogItem(log.icon, log.title, log.time, log.typeColor, log.iconTint)
            })
          }
          .width('100%')
          .padding({ bottom: 16 })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}