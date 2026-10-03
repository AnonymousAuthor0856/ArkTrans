@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        // Status Card
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
                .width(48).height(48)
                .objectFit(ImageFit.Contain)
                .fillColor('#4CAF50')
            }
            .width(100).height(100)
            .backgroundColor('#E8F5E9')
            .borderRadius(50)
          }
          .width(116).height(116)
          .backgroundColor('#FFFFFF')
          .borderRadius(58)

          Blank().height(16)

          Text('System Operational')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .textAlign(TextAlign.Center)

          Text('Uptime: 14d 2h 15m')
            .fontSize(14)
            .fontColor('#808080')
            .margin({ top: 4 })
            .textAlign(TextAlign.Center)

          Blank().height(24)

          Row({ space: 24 }) {
            Column({ space: 4 }) {
              Text('12%').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#000000')
              Text('CPU').fontSize(12).fontColor('#808080')
            }.alignItems(HorizontalAlign.Center)

            Column({ space: 4 }) {
              Text('4.2GB').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#000000')
              Text('RAM').fontSize(12).fontColor('#808080')
            }.alignItems(HorizontalAlign.Center)

            Column({ space: 4 }) {
              Text('1Gbps').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#000000')
              Text('NET').fontSize(12).fontColor('#808080')
            }.alignItems(HorizontalAlign.Center)
          }.justifyContent(FlexAlign.SpaceEvenly).width('100%')

        }
        .width('100%')
        .padding({ top: 24, bottom: 24, left: 24, right: 24 })
        .backgroundColor('#F5F7FA')
        .borderRadius(24)
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

        Blank().height(16)

        // Control Panel
        Text('Control Panel')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ bottom: 16 })

        Row({ space: 16 }) {
          // Start
          Column({ space: 8 }) {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon')).width(28).height(28).objectFit(ImageFit.Contain).fillColor('#2196F3')
            }
            .width('100%').height(64).backgroundColor('#E3F2FD').borderRadius(16)
            Text('Start').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#000000')
          }.layoutWeight(1).alignItems(HorizontalAlign.Center)

          // Reboot
          Column({ space: 8 }) {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon')).width(28).height(28).objectFit(ImageFit.Contain).fillColor('#FF9800')
            }
            .width('100%').height(64).backgroundColor('#FFF3E0').borderRadius(16)
            Text('Reboot').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#000000')
          }.layoutWeight(1).alignItems(HorizontalAlign.Center)

          // Lock
          Column({ space: 8 }) {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon')).width(28).height(28).objectFit(ImageFit.Contain).fillColor('#F44336')
            }
            .width('100%').height(64).backgroundColor('#FFEBEE').borderRadius(16)
            Text('Lock').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#000000')
          }.layoutWeight(1).alignItems(HorizontalAlign.Center)

          // Config
          Column({ space: 8 }) {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon')).width(28).height(28).objectFit(ImageFit.Contain).fillColor('#9C27B0')
            }
            .width('100%').height(64).backgroundColor('#F3E5F5').borderRadius(16)
            Text('Config').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#000000')
          }.layoutWeight(1).alignItems(HorizontalAlign.Center)
        }.width('100%')

        Blank().height(32)

        // Recent Logs Header
        Row() {
          Text('Recent Logs').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000')
          Blank()
          Text('View All').fontSize(14).fontColor('#2196F3').fontWeight(FontWeight.Medium)
        }.width('100%').alignItems(VerticalAlign.Center)

        Blank().height(8)

        // Log List
        List({ space: 12 }) {
          ListItem() {
            Row() {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain).fillColor('#FF9800')
              }.width(40).height(40).backgroundColor('#FFF3E0').borderRadius(20)

              Blank().width(16)

              Column() {
                Text('High Memory Usage').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
              }.layoutWeight(1)

              Text('10:42 AM').fontSize(12).fontColor('#808080')
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .backgroundColor('#FFFFFF')
            .padding({ top: 4, bottom: 4, left: 12, right: 12 })
            .borderRadius(12)
          }

          ListItem() {
            Row() {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain).fillColor('#2196F3')
              }.width(40).height(40).backgroundColor('#E3F2FD').borderRadius(20)

              Blank().width(16)

              Column() {
                Text('Admin Login: root').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
              }.layoutWeight(1)

              Text('09:15 AM').fontSize(12).fontColor('#808080')
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .backgroundColor('#FFFFFF')
            .padding({ top: 4, bottom: 4, left: 12, right: 12 })
            .borderRadius(12)
          }

          ListItem() {
            Row() {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain).fillColor('#4CAF50')
              }.width(40).height(40).backgroundColor('#E8F5E9').borderRadius(20)

              Blank().width(16)

              Column() {
                Text('Backup Completed').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
              }.layoutWeight(1)

              Text('04:00 AM').fontSize(12).fontColor('#808080')
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .backgroundColor('#FFFFFF')
            .padding({ top: 4, bottom: 4, left: 12, right: 12 })
            .borderRadius(12)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: 16 })

      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })

      // Top Bar
      Row() {
        Button() {
          Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain).fillColor('#000000')
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)

        Blank()

        Text('NodeLink').fontSize(22).fontWeight(FontWeight.Bold).fontColor('#000000')

        Blank()

        Stack({ alignContent: Alignment.Center }) {
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain).fillColor('#000000')
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)

          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 10, height: 10 }).fill(Color.Red)
          }
          .position({ x: 12, y: -4 })
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ top: 48, bottom: 16, left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}