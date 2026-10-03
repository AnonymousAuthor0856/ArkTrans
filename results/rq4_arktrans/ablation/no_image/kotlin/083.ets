@Entry
@Component
struct Index {
  @State SystemOperational: string = 'System Operational'
  @State uptimeValue: number = 0
  @State UptimeText: string = 'Uptime: 14d 2h 15m'
  @State cpuValue: number = 12
  @State cpuLabel: string = 'CPU'
  @State ramValue: string = '4.2GB'
  @State ramLabel: string = 'RAM'
  @State netValue: string = '1Gbps'
  @State netLabel: string = 'NET'
  @State ControlPanelTitle: string = 'Control Panel'
  @State RecentLogsTitle: string = 'Recent Logs'
  @State ViewAllText: string = 'View All'
  @State logTitle1: string = 'High Memory Usage'
  @State logTime1: string = '10:42 AM'
  @State logTitle2: string = 'Admin Login: root'
  @State logTime2: string = '09:15 AM'
  @State logTitle3: string = 'Backup Completed'
  @State logTime3: string = '04:00 AM'
  @State MenuIcon: string = ''
  @State NodeLinkTitle: string = 'NodeLink'
  @State NotificationIcon: string = ''

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        // Card
        Column() {
          Column({ space: 0 }) {
            // Icon Box
            Stack({ alignContent: Alignment.Center }) {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon'))
                  .width(48)
                  .height(48)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#4CAF50')
              }
              .width('100%')
              .height('100%')
              .backgroundColor('#E8F5E9')
            }
            .width(100)
            .height(100)
            .borderRadius(50)
            .backgroundColor('#FFFFFF')
            .padding(8)

            Blank().height(16)

            Text(this.SystemOperational)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')

            Text(this.UptimeText)
              .fontSize(14)
              .fontColor('#808080')
              .padding({ top: 4 })

            Blank().height(24)

            Row({ space: 0 }) {
              // CPU Stat
              Column({ space: 0 }) {
                Text(`${this.cpuValue}%`)
                  .fontWeight(FontWeight.Bold)
                  .fontSize(16)
                  .fontColor('#000000')
                Text(this.cpuLabel)
                  .fontSize(12)
                  .fontColor('#808080')
              }
              .alignItems(HorizontalAlign.Center)

              // RAM Stat
              Column({ space: 0 }) {
                Text(this.ramValue)
                  .fontWeight(FontWeight.Bold)
                  .fontSize(16)
                  .fontColor('#000000')
                Text(this.ramLabel)
                  .fontSize(12)
                  .fontColor('#808080')
              }
              .alignItems(HorizontalAlign.Center)

              // NET Stat
              Column({ space: 0 }) {
                Text(this.netValue)
                  .fontWeight(FontWeight.Bold)
                  .fontSize(16)
                  .fontColor('#000000')
                Text(this.netLabel)
                  .fontSize(12)
                  .fontColor('#808080')
              }
              .alignItems(HorizontalAlign.Center)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
          }
          .alignItems(HorizontalAlign.Center)
          .padding(24)
        }
        .width('100%')
        .backgroundColor('#F5F7FA')
        .borderRadius(24)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })

        Blank().height(16)

        Text(this.ControlPanelTitle)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .padding({ bottom: 16 })

        Row({ space: 16 }) {
          // Start Button
          Column({ space: 0 }) {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
                .width(28)
                .height(28)
                .objectFit(ImageFit.Contain)
                .fillColor('#2196F3')
            }
            .width('100%')
            .height(64)
            .borderRadius(16)
            .backgroundColor('#E3F2FD')

            Blank().height(8)

            Text('Start')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .alignItems(HorizontalAlign.Center)
          .layoutWeight(1)

          // Reboot Button
          Column({ space: 0 }) {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
                .width(28)
                .height(28)
                .objectFit(ImageFit.Contain)
                .fillColor('#FF9800')
            }
            .width('100%')
            .height(64)
            .borderRadius(16)
            .backgroundColor('#FFF3E0')

            Blank().height(8)

            Text('Reboot')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .alignItems(HorizontalAlign.Center)
          .layoutWeight(1)

          // Lock Button
          Column({ space: 0 }) {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
                .width(28)
                .height(28)
                .objectFit(ImageFit.Contain)
                .fillColor('#F44336')
            }
            .width('100%')
            .height(64)
            .borderRadius(16)
            .backgroundColor('#FFEBEE')

            Blank().height(8)

            Text('Lock')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .alignItems(HorizontalAlign.Center)
          .layoutWeight(1)

          // Config Button
          Column({ space: 0 }) {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
                .width(28)
                .height(28)
                .objectFit(ImageFit.Contain)
                .fillColor('#9C27B0')
            }
            .width('100%')
            .height(64)
            .borderRadius(16)
            .backgroundColor('#F3E5F5')

            Blank().height(8)

            Text('Config')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .alignItems(HorizontalAlign.Center)
          .layoutWeight(1)
        }
        .width('100%')

        Blank().height(32)

        Row({ space: 0 }) {
          Text(this.RecentLogsTitle)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
          
          Blank()

          Text(this.ViewAllText)
            .fontSize(14)
            .fontColor('#2196F3')
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')

        Blank().height(8)

        List({ space: 12 }) {
          ListItem() {
            Row({ space: 0 }) {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon'))
                  .width(20)
                  .height(20)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#FF9800')
              }
              .width(40)
              .height(40)
              .borderRadius(20)
              .backgroundColor('#FFF3E0')

              Blank().width(16)

              Column({ space: 0 }) {
                Text(this.logTitle1)
                  .fontWeight(FontWeight.Medium)
                  .fontSize(14)
                  .fontColor('#000000')
              }
              .layoutWeight(1)

              Text(this.logTime1)
                .fontSize(12)
                .fontColor('#808080')
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .backgroundColor('#FFFFFF')
            .padding({ top: 4, bottom: 4 })
          }

          ListItem() {
            Row({ space: 0 }) {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon'))
                  .width(20)
                  .height(20)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#2196F3')
              }
              .width(40)
              .height(40)
              .borderRadius(20)
              .backgroundColor('#E3F2FD')

              Blank().width(16)

              Column({ space: 0 }) {
                Text(this.logTitle2)
                  .fontWeight(FontWeight.Medium)
                  .fontSize(14)
                  .fontColor('#000000')
              }
              .layoutWeight(1)

              Text(this.logTime2)
                .fontSize(12)
                .fontColor('#808080')
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .backgroundColor('#FFFFFF')
            .padding({ top: 4, bottom: 4 })
          }

          ListItem() {
            Row({ space: 0 }) {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon'))
                  .width(20)
                  .height(20)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#4CAF50')
              }
              .width(40)
              .height(40)
              .borderRadius(20)
              .backgroundColor('#E8F5E9')

              Blank().width(16)

              Column({ space: 0 }) {
                Text(this.logTitle3)
                  .fontWeight(FontWeight.Medium)
                  .fontSize(14)
                  .fontColor('#000000')
              }
              .layoutWeight(1)

              Text(this.logTime3)
                .fontSize(12)
                .fontColor('#808080')
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .backgroundColor('#FFFFFF')
            .padding({ top: 4, bottom: 4 })
          }
        }
        .width('100%')
        .padding({ bottom: 16 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })

      // Header Overlay
      Row({ space: 0 }) {
        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor('#000000')
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)

        Text(this.NodeLinkTitle)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Stack({ alignContent: Alignment.Center }) {
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
              .fillColor('#000000')
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)

          Stack({ alignContent: Alignment.Center }) {
          }
          .width(10)
          .height(10)
          .borderRadius(5)
          .backgroundColor('#FF0000')
          .position({ x: 12, y: -2 })
        }
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding({ top: 48, bottom: 16, left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
  }
}