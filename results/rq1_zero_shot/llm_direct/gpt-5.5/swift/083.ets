@Entry
@Component
struct ServerStatusScreen {
  build() {
    Stack() {
      Column() {
        TopBar()
          .padding({ top: 48, left: 24, right: 24, bottom: 16 })

        Scroll() {
          Column() {
            HeroStatusCard()
              .margin({ top: 16, bottom: 16 })

            Blank()
              .height(16)

            Text('Control Panel')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ bottom: 16 })

            Row({ space: 16 }) {
              ActionButton({
                icon: '▶',
                label: 'Start',
                color: '#E3F2FD',
                iconColor: '#2196F3'
              })
                .layoutWeight(1)

              ActionButton({
                icon: '↻',
                label: 'Reboot',
                color: '#FFF3E0',
                iconColor: '#FF9800'
              })
                .layoutWeight(1)

              ActionButton({
                icon: '🔒',
                label: 'Lock',
                color: '#FFEBEE',
                iconColor: '#F44336'
              })
                .layoutWeight(1)

              ActionButton({
                icon: '⚙',
                label: 'Config',
                color: '#F3E5F5',
                iconColor: '#9C27B0'
              })
                .layoutWeight(1)
            }
            .width('100%')

            Blank()
              .height(32)

            Row() {
              Text('Recent Logs')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)

              Blank()
                .layoutWeight(1)

              Button() {
                Text('View All')
                  .fontSize(14)
                  .fontWeight(FontWeight.SemiBold)
                  .fontColor('#2196F3')
              }
              .backgroundColor(Color.Transparent)
              .padding(0)
              .stateEffect(false)
            }
            .width('100%')

            Blank()
              .height(8)

            Column({ space: 12 }) {
              LogItem({
                icon: '!',
                title: 'High Memory Usage',
                time: '10:42 AM',
                typeColor: '#FFF3E0',
                iconTint: '#FF9800'
              })

              LogItem({
                icon: '👤',
                title: 'Admin Login: root',
                time: '09:15 AM',
                typeColor: '#E3F2FD',
                iconTint: '#2196F3'
              })

              LogItem({
                icon: 'i',
                title: 'Backup Completed',
                time: '04:00 AM',
                typeColor: '#E8F5E9',
                iconTint: '#4CAF50'
              })
            }
            .width('100%')
            .margin({ bottom: 16 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct TopBar {
  build() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)
      .padding(0)
      .stateEffect(false)

      Blank()
        .layoutWeight(1)

      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Blank()
        .layoutWeight(1)

      Stack({ alignContent: Alignment.TopEnd }) {
        Button() {
          Text('🔔')
            .fontSize(22)
            .fontColor(Color.Black)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)
        .padding(0)
        .stateEffect(false)

        Circle()
          .width(10)
          .height(10)
          .fill(Color.Red)
          .margin({ top: 2, right: 2 })
      }
      .width(40)
      .height(40)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct HeroStatusCard {
  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Stack()
          .width(100)
          .height(100)
          .backgroundColor(Color.White)
          .borderRadius(50)

        Stack({ alignContent: Alignment.Center }) {
          Stack()
            .width(84)
            .height(84)
            .backgroundColor('#E8F5E9')
            .borderRadius(42)

          Text('✓')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor('#4CAF50')
        }
        .width(84)
        .height(84)
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
        .fontColor('#808080')
        .margin({ top: 4 })

      Blank()
        .height(24)

      Row() {
        StatBadge({ label: 'CPU', value: '12%' })
          .layoutWeight(1)

        StatBadge({ label: 'RAM', value: '4.2GB' })
          .layoutWeight(1)

        StatBadge({ label: 'NET', value: '1Gbps' })
          .layoutWeight(1)
      }
      .width('100%')
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#F5F7FA')
    .borderRadius(24)
  }
}

@Component
struct StatBadge {
  label: string = ''
  value: string = ''

  build() {
    Column({ space: 2 }) {
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text(this.label)
        .fontSize(12)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActionButton {
  icon: string = ''
  label: string = ''
  color: ResourceColor = Color.White
  iconColor: ResourceColor = Color.Black

  build() {
    Column() {
      Button() {
        Stack({ alignContent: Alignment.Center }) {
          Text(this.icon)
            .fontSize(24)
            .fontColor(this.iconColor)
        }
        .width('100%')
        .height(64)
        .backgroundColor(this.color)
        .borderRadius(16)
      }
      .width('100%')
      .height(64)
      .backgroundColor(Color.Transparent)
      .padding(0)
      .stateEffect(false)

      Blank()
        .height(8)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct LogItem {
  icon: string = ''
  title: string = ''
  time: string = ''
  typeColor: ResourceColor = Color.White
  iconTint: ResourceColor = Color.Black

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Stack()
          .width(40)
          .height(40)
          .backgroundColor(this.typeColor)
          .borderRadius(20)

        Text(this.icon)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.iconTint)
      }
      .width(40)
      .height(40)

      Blank()
        .width(16)

      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)

      Blank()
        .layoutWeight(1)

      Text(this.time)
        .fontSize(12)
        .fontColor('#808080')
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
  }
}