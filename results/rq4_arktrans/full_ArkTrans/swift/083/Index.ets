@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Row() {
          Image($r('app.media.startIcon')).width(24).height(24)
          Blank()
          Text('NodeLink').fontSize(22).fontWeight(FontWeight.Bold).fontColor('#000000')
          Blank()
          Stack({ alignContent: Alignment.TopEnd }) {
            Image($r('app.media.startIcon')).width(24).height(24)
            Circle().width(10).height(10).fill(Color.Red).margin({ top: 2, right: 2 })
          }
        }.width('100%').padding({ left: 24, right: 24, top: 50, bottom: 20 })

        Scroll() {
          Column() {
            // Status Card
            Column() {
              Stack() {
                Circle().width(100).height(100).fill(Color.White)
                Stack() {
                  Circle().width(84).height(84).fill('#E8F5E9')
                  Image($r('app.media.startIcon')).width(40).height(40).objectFit(ImageFit.Contain)
                }
              }
              Blank().height(16)
              Text('System Operational').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#000000')
              Text('Uptime: 14d 2h 15m').fontSize(14).fontColor('#999999').margin({ top: 4 })
              Blank().height(24)
              
              Row() {
                this.StatBadgeItem('12%', 'CPU')
                this.StatBadgeItem('4.2GB', 'RAM')
                this.StatBadgeItem('1Gbps', 'NET')
              }
            }.width('100%').padding(24).borderRadius(24).backgroundColor('#F5F7FA')

            Blank().height(32)

            // Control Panel
            Text('Control Panel').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000').margin({ bottom: 16 })
            
            Row({ space: 16 }) {
              this.ControlButton('#E3F2FD', '#2196F3', 'Start')
              this.ControlButton('#FFF3E0', '#FF9800', 'Reboot')
              this.ControlButton('#FFEBEE', '#F44336', 'Lock')
              this.ControlButton('#F3E5F5', '#9C27B0', 'Config')
            }

            Blank().height(32)

            // Recent Logs
            Row() {
              Text('Recent Logs').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000')
              Blank()
              Text('View All').fontSize(16).fontColor('#2196F3')
            }
            Blank().height(8)

            Column({ space: 12 }) {
              this.LogItem('High Memory Usage', '10:42 AM', '#FFF3E0', '#FF9800')
              this.LogItem('Connection Established', '09:30 AM', '#E8F5E9', '#4CAF50')
              this.LogItem('Disk Space Warning', 'Yesterday', '#FFEBEE', '#F44336')
            }.padding({ bottom: 16 })
          }.width('100%').padding({ left: 24, right: 24 })
        }
      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }

  @Builder
  StatBadgeItem(value: string, label: string) {
    Column() {
      Text(value).fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000')
      Text(label).fontSize(14).fontColor('#999999')
    }.layoutWeight(1).alignItems(HorizontalAlign.Center)
  }

  @Builder
  ControlButton(bgColor: string, iconColor: string, label: string) {
    Column() {
      Column() {
        Image($r('app.media.startIcon')).width(32).height(32).objectFit(ImageFit.Contain)
      }.width('100%').height('100%').justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center).borderRadius(20).backgroundColor(bgColor)
      
      Blank().height(8)
      Text(label).fontSize(12).fontWeight(FontWeight.Medium).fontColor('#000000')
    }.layoutWeight(1).height(100)
  }

  @Builder
  LogItem(title: string, time: string, bgColor: string, iconColor: string) {
    Row() {
      Stack() {
        Circle().width(40).height(40).fill(bgColor)
        Image($r('app.media.startIcon')).width(16).height(16).objectFit(ImageFit.Contain)
      }
      Blank().width(16)
      Text(title).fontSize(14).fontWeight(FontWeight.Medium).fontColor('#000000')
      Blank()
      Text(time).fontSize(12).fontColor('#999999')
    }.width('100%').padding({ top: 4, bottom: 4 }).backgroundColor(Color.White)
  }
}