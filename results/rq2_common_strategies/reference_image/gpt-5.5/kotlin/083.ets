@Entry
@Component
struct Index {
  build() {
    ServerStatusScreen()
  }
}

@Component
struct ServerStatusScreen {
  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          this.HeroStatusCard()

          Blank()
            .height(16)

          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .width('100%')
            .margin({ bottom: 16 })

          Row() {
            this.ActionButton('▶', 'Start', '#E3F2FD', '#2196F3', 16)
            this.ActionButton('⟳', 'Reboot', '#FFF3E0', '#FF9800', 16)
            this.ActionButton('🔒', 'Lock', '#FFEBEE', '#F44336', 16)
            this.ActionButton('⚙', 'Config', '#F3E5F5', '#9C27B0', 0)
          }
          .width('100%')

          Blank()
            .height(32)

          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)

            Text('View All')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2196F3')
              .onClick(() => {
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          Blank()
            .height(8)

          Column() {
            this.LogItem('⚠', 'High Memory Usage', '10:42 AM', '#FFF3E0', '#FF9800')

            Blank()
              .height(12)

            this.LogItem('👤', 'Admin Login: root', '09:15 AM', '#E3F2FD', '#2196F3')

            Blank()
              .height(12)

            this.LogItem('ℹ', 'Backup Completed', '04:00 AM', '#E8F5E9', '#4CAF50')
          }
          .width('100%')
          .padding({ bottom: 16 })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  TopBar() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text('☰')
          .fontSize(34)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
      }
      .width(48)
      .height(48)
      .onClick(() => {
      })

      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Stack({ alignContent: Alignment.Center }) {
        Text('🔔')
          .fontSize(28)
          .fontColor(Color.Black)

        Column()
          .width(10)
          .height(10)
          .borderRadius(5)
          .backgroundColor('#FF0000')
          .position({ x: 34, y: 4 })
      }
      .width(48)
      .height(48)
      .onClick(() => {
      })
    }
    .width('100%')
    .padding({ top: 48, bottom: 16, left: 24, right: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  HeroStatusCard() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width(100)
          .height(100)
          .borderRadius(50)
          .backgroundColor(Color.White)

        Column()
          .width(84)
          .height(84)
          .borderRadius(42)
          .backgroundColor('#E8F5E9')

        Text('✓')
          .fontSize(58)
          .fontColor('#4CAF50')
          .fontWeight(FontWeight.Medium)
      }
      .width(100)
      .height(100)

      Blank()
        .height(16)

      Text('System Operational')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text('Uptime: 14d 2h 15m')
        .fontSize(14)
        .fontColor('#888888')
        .margin({ top: 4 })

      Blank()
        .height(24)

      Row() {
        this.StatBadge('CPU', '12%')
        this.StatBadge('RAM', '4.2GB')
        this.StatBadge('NET', '1Gbps')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .padding(24)
    .margin({ top: 16, bottom: 16 })
    .borderRadius(24)
    .backgroundColor('#F5F7FA')
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StatBadge(label: string, value: string) {
    Column() {
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text(label)
        .fontSize(12)
        .fontColor('#888888')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActionButton(icon: string, label: string, bgColor: ResourceColor, iconColor: ResourceColor, rightMargin: number) {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text(icon)
          .fontSize(30)
          .fontColor(iconColor)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(64)
      .borderRadius(16)
      .backgroundColor(bgColor)
      .onClick(() => {
      })

      Blank()
        .height(8)

      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .layoutWeight(1)
    .margin({ right: rightMargin })
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  LogItem(icon: string, title: string, time: string, typeColor: ResourceColor, iconTint: ResourceColor) {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text(icon)
          .fontSize(20)
          .fontColor(iconTint)
          .fontWeight(FontWeight.Medium)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(typeColor)

      Blank()
        .width(16)

      Column() {
        Text(title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text(time)
        .fontSize(12)
        .fontColor('#888888')
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
  }
}