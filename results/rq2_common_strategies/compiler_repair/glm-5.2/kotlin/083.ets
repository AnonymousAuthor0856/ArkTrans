// Index.ets

interface LogItemData {
  icon: Resource;
  title: string;
  time: string;
  typeColor: ResourceColor;
  iconTint: ResourceColor;
}

interface ActionButtonData {
  icon: Resource;
  label: string;
  color: ResourceColor;
  iconColor: ResourceColor;
}

@Entry
@Component
struct ServerStatusScreen {
  private logs: LogItemData[] = [
    {
      icon: $r('sys.symbol.exclamationmark_triangle'),
      title: 'High Memory Usage',
      time: '10:42 AM',
      typeColor: '#FFF3E0',
      iconTint: '#FF9800'
    },
    {
      icon: $r('sys.symbol.person_fill'),
      title: 'Admin Login: root',
      time: '09:15 AM',
      typeColor: '#E3F2FD',
      iconTint: '#2196F3'
    },
    {
      icon: $r('sys.symbol.info_circle'),
      title: 'Backup Completed',
      time: '04:00 AM',
      typeColor: '#E8F5E9',
      iconTint: '#4CAF50'
    }
  ];

  private actions: ActionButtonData[] = [
    {
      icon: $r('sys.symbol.play_fill'),
      label: 'Start',
      color: '#E3F2FD',
      iconColor: '#2196F3'
    },
    {
      icon: $r('sys.symbol.arrow_clockwise'),
      label: 'Reboot',
      color: '#FFF3E0',
      iconColor: '#FF9800'
    },
    {
      icon: $r('sys.symbol.lock_fill'),
      label: 'Lock',
      color: '#FFEBEE',
      iconColor: '#F44336'
    },
    {
      icon: $r('sys.symbol.gearshape_fill'),
      label: 'Config',
      color: '#F3E5F5',
      iconColor: '#9C27B0'
    }
  ];

  @Builder
  StatBadge(label: string, value: string) {
    Column() {
      Text(value)
        .fontWeight(FontWeight.Bold)
        .fontSize(16)
        .fontColor('#000000')
      Text(label)
        .fontSize(12)
        .fontColor('#888888')
        .margin({ top: 2 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActionButton(action: ActionButtonData) {
    Column() {
      Stack() {
        Image(action.icon)
          .width(28)
          .height(28)
          .fillColor(action.iconColor)
      }
      .width('100%')
      .height(64)
      .borderRadius(16)
      .backgroundColor(action.color)
      .onClick(() => {})

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
  LogItemBuilder(log: LogItemData) {
    Row() {
      Stack() {
        Image(log.icon)
          .width(20)
          .height(20)
          .fillColor(log.iconTint)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(log.typeColor)

      Text(log.title)
        .fontWeight(FontWeight.Medium)
        .fontSize(14)
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
      // Top Bar
      Row() {
        Image($r('sys.symbol.line_horizontal_3'))
          .width(24)
          .height(24)
          .fillColor('#000000')

        Text('NodeLink')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Stack({ alignContent: Alignment.TopEnd }) {
          Image($r('sys.symbol.bell_fill'))
            .width(24)
            .height(24)
            .fillColor('#000000')
          Circle({ width: 10, height: 10 })
            .fill('#FF0000')
            .markAnchor({ x: 5, y: 5 })
            .position({ x: '100%', y: 0 })
        }
        .width(40)
        .height(40)
      }
      .width('100%')
      .padding({ top: 48, bottom: 16, left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Content
      Scroll() {
        Column() {
          // Hero Status Section
          Column() {
            Stack() {
              Stack() {
                Image($r('sys.symbol.checkmark_circle_fill'))
                  .width(48)
                  .height(48)
                  .fillColor('#4CAF50')
              }
              .width('100%')
              .height('100%')
              .backgroundColor('#E8F5E9')
              .borderRadius(50)
            }
            .width(100)
            .height(100)
            .backgroundColor('#FFFFFF')
            .borderRadius(50)
            .padding(8)

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
            .margin({ top: 24 })
            .justifyContent(FlexAlign.SpaceEvenly)
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#F5F7FA')
          .borderRadius(24)
          .margin({ top: 16, bottom: 16 })
          .alignItems(HorizontalAlign.Center)

          // Control Panel
          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .margin({ bottom: 16 })

          Row() {
            ForEach(this.actions, (action: ActionButtonData) => {
              this.ActionButton(action)
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          // Recent Logs
          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')

            Text('View All')
              .fontSize(14)
              .fontColor('#2196F3')
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .margin({ top: 32, bottom: 8 })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          Column() {
            ForEach(this.logs, (log: LogItemData) => {
              this.LogItemBuilder(log)
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