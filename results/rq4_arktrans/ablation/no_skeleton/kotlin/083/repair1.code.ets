@Entry
@Component
struct ServerStatusScreen {
  build() {
    Column() {
      // Top Bar
      Row() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor(Color.Black)

        Text('NodeLink')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 16 })

        Blank()

        Stack() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor(Color.Black)

          Circle({ width: 10, height: 10 })
            .fill(Color.Red)
            .position({ x: 18, y: 2 })
        }
      }
      .width('100%')
      .padding({ top: 48, bottom: 16, left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Hero Status Section
      Column() {
        Stack() {
          Circle({ width: 100, height: 100 })
            .fill(Color.White)

          Circle({ width: 84, height: 84 })
            .fill('#E8F5E9')

          Image($r('app.media.startIcon'))
            .width(48)
            .height(48)
            .objectFit(ImageFit.Contain)
            .fillColor('#4CAF50')
        }

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
          this.StatBadgeComponent('CPU', '12%')
          this.StatBadgeComponent('RAM', '4.2GB')
          this.StatBadgeComponent('NET', '1Gbps')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 24 })
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#F5F7FA')
      .borderRadius(24)
      .margin({ left: 24, right: 24, top: 16, bottom: 16 })
      .alignItems(HorizontalAlign.Center)

      // Control Panel
      Text('Control Panel')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ left: 24, right: 24, bottom: 16 })

      Row() {
        this.ActionButtonComponent('Start', '#E3F2FD', '#2196F3')
        this.ActionButtonComponent('Reboot', '#FFF3E0', '#FF9800')
        this.ActionButtonComponent('Lock', '#FFEBEE', '#F44336')
        this.ActionButtonComponent('Config', '#F3E5F5', '#9C27B0')
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)

      // Recent Logs Header
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
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 32 })

      // Log Items
      Column() {
        this.LogItemComponent('High Memory Usage', '10:42 AM', '#FFF3E0', '#FF9800')
        this.LogItemComponent('Admin Login: root', '09:15 AM', '#E3F2FD', '#2196F3')
        this.LogItemComponent('Backup Completed', '04:00 AM', '#E8F5E9', '#4CAF50')
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 8, bottom: 16 })
      .spacing(12)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  StatBadgeComponent(label: string, value: string) {
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
  ActionButtonComponent(label: string, bgColor: string, iconColor: string) {
    Column() {
      Image($r('app.media.startIcon'))
        .width(28)
        .height(28)
        .objectFit(ImageFit.Contain)
        .fillColor(iconColor)
    }
    .width('23%')
    .height(64)
    .backgroundColor(bgColor)
    .borderRadius(16)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .margin({ bottom: 8 })

    Text(label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(Color.Black)
      .textAlign(TextAlign.Center)
  }

  @Builder
  LogItemComponent(title: string, time: string, typeColor: string, iconTint: string) {
    Row() {
      Stack() {
        Circle({ width: 40, height: 40 })
          .fill(typeColor)
        
        Image($r('app.media.startIcon'))
          .width(20)
          .height(20)
          .objectFit(ImageFit.Contain)
          .fillColor(iconTint)
      }

      Column() {
        Text(title)
          .fontWeight(FontWeight.Medium)
          .fontSize(14)
          .fontColor(Color.Black)
      }
      .layoutWeight(1)
      .margin({ left: 16 })

      Text(time)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .alignItems(VerticalAlign.Center)
  }
}