@Entry
@Component
struct ServerStatusApp {
  build() {
    Column() {
      // Top Bar
      Row() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
        
        Blank()
        
        Text('NodeLink')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        
        Blank()
        
        Stack({ alignContent: Alignment.TopEnd }) {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
          
          Circle()
            .fill('#FF0000')
            .width(10)
            .height(10)
            .margin({ top: 2, right: 2 })
        }
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 48, bottom: 16 })

      // Scrollable Content
      Scroll() {
        Column() {
          // Hero Status Section
          Column() {
            Column() {
              // Status Icon
              Stack() {
                Circle()
                  .fill('#FFFFFF')
                  .width(100)
                  .height(100)
                
                Stack() {
                  Circle()
                    .fill('#E8F5E9')
                    .width(84)
                    .height(84)
                  
                  Image($r('app.media.startIcon'))
                    .width(40)
                    .height(40)
                    .objectFit(ImageFit.Contain)
                    .fillColor('#4CAF50')
                }
              }
              
              Column() {
                Text('System Operational')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#000000')
                  .textAlign(TextAlign.Center)
                  .margin({ top: 16 })
                
                Text('Uptime: 14d 2h 15m')
                  .fontSize(14)
                  .fontColor('#999999')
                  .textAlign(TextAlign.Center)
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Center)
              
              // Stats Row
              Row() {
                this.StatBadgeItem('CPU', '12%')
                this.StatBadgeItem('RAM', '4.2GB')
                this.StatBadgeItem('NET', '1Gbps')
              }
              .margin({ top: 24 })
            }
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.SpaceBetween)
            .padding(24)
          }
          .backgroundColor('#F5F7FA')
          .borderRadius(24)
          .width('100%')
          .margin({ top: 16, bottom: 16 })

          // Control Panel
          Column() {
            Text('Control Panel')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            
            Row() {
              this.ActionButton('Start', '#E3F2FD', '#2196F3')
              this.ActionButton('Reboot', '#FFF3E0', '#FF9800')
              this.ActionButton('Lock', '#FFEBEE', '#F44336')
              this.ActionButton('Config', '#F3E5F5', '#9C27B0')
            }
            .margin({ top: 16 })
          }
          .width('100%')
          .margin({ bottom: 32 })

          // Recent Logs Header
          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            
            Blank()
            
            Text('View All')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2196F3')
          }
          .width('100%')
          
          // Recent Logs List
          Column({ space: 12 }) {
            this.LogItem('High Memory Usage', '10:42 AM', '#FFF3E0', '#FF9800')
            this.LogItem('Admin Login: root', '09:15 AM', '#E3F2FD', '#2196F3')
            this.LogItem('Backup Completed', '04:00 AM', '#E8F5E9', '#4CAF50')
          }
          .width('100%')
          .margin({ top: 8, bottom: 16 })
        }
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  StatBadgeItem(label: string, value: string) {
    Column() {
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
      Text(label)
        .fontSize(12)
        .fontColor('#999999')
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActionButton(label: string, bgColor: string, iconColor: string) {
    Column() {
      Button() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor(iconColor)
      }
      .type(ButtonType.Normal)
      .backgroundColor(bgColor)
      .borderRadius(16)
      .height(64)
      .width('100%')
      
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
  LogItem(title: string, time: string, bgColor: string, iconColor: string) {
    Row() {
      Stack() {
        Circle()
          .fill(bgColor)
          .width(40)
          .height(40)
        
        Image($r('app.media.startIcon'))
          .width(16)
          .height(16)
          .objectFit(ImageFit.Contain)
          .fillColor(iconColor)
      }
      
      Column() {
        Text(title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })
      
      Text(time)
        .fontSize(12)
        .fontColor('#999999')
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor('#FFFFFF')
  }
}