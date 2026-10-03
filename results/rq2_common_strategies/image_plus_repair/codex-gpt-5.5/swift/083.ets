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
              .margin({ top: 16, bottom: 32 })

            Text('Control Panel')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .width('100%')
              .margin({ bottom: 16 })

            Row() {
              ActionButton({ icon: '▶', label: 'Start', bgColor: '#E3F2FD', iconColor: '#2196F3' })
              ActionButton({ icon: '↻', label: 'Reboot', bgColor: '#FFF3E0', iconColor: '#FF9800' })
              ActionButton({ icon: '🔒', label: 'Lock', bgColor: '#FFEBEE', iconColor: '#F44336' })
              ActionButton({ icon: '⚙', label: 'Config', bgColor: '#F3E5F5', iconColor: '#9C27B0' })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ bottom: 32 })

            Row() {
              Text('Recent Logs')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)

              Blank()

              Text('View All')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#2196F3')
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .margin({ bottom: 8 })

            Column() {
              LogItem({
                icon: '!',
                title: 'High Memory Usage',
                time: '10:42 AM',
                bgColor: '#FFF3E0',
                iconColor: '#FF9800'
              })
              LogItem({
                icon: '●',
                title: 'Admin Login: root',
                time: '09:15 AM',
                bgColor: '#E3F2FD',
                iconColor: '#2196F3'
              })
              LogItem({
                icon: 'i',
                title: 'Backup Completed',
                time: '04:00 AM',
                bgColor: '#E8F5E9',
                iconColor: '#4CAF50'
              })
            }
            .width('100%')
            .margin({ bottom: 16 })
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
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
      Button({ type: ButtonType.Normal }) {
        Text('☰')
          .fontSize(30)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Regular)
          .lineHeight(30)
      }
      .width(42)
      .height(42)
      .padding(0)
      .backgroundColor(Color.Transparent)
      .stateEffect(false)

      Blank()

      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Blank()

      Stack({ alignContent: Alignment.TopEnd }) {
        Button({ type: ButtonType.Normal }) {
          Text('♟')
            .fontSize(34)
            .fontColor(Color.Black)
            .rotate({ angle: 180 })
            .lineHeight(36)
        }
        .width(42)
        .height(42)
        .padding(0)
        .backgroundColor(Color.Transparent)
        .stateEffect(false)

        Circle()
          .width(10)
          .height(10)
          .fill('#FF3B30')
          .margin({ top: 2, right: 0 })
      }
      .width(42)
      .height(42)
    }
    .width('100%')
    .height(42)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct HeroStatusCard {
  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(100)
          .height(100)
          .fill(Color.White)

        Circle()
          .width(84)
          .height(84)
          .fill('#E8F5E9')

        Text('✓')
          .fontSize(54)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4CAF50')
          .translate({ x: 0, y: -2 })
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
        .fontColor('#8E8E93')
        .margin({ top: 4 })

      Row() {
        StatBadge({ label: 'CPU', value: '12%' })
          .layoutWeight(1)
        StatBadge({ label: 'RAM', value: '4.2GB' })
          .layoutWeight(1)
        StatBadge({ label: 'NET', value: '1Gbps' })
          .layoutWeight(1)
      }
      .width('100%')
      .margin({ top: 24 })
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F5F7FA')
    .borderRadius(24)
  }
}

@Component
struct StatBadge {
  label: string = ''
  value: string = ''

  build() {
    Column() {
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text(this.label)
        .fontSize(12)
        .fontColor('#8E8E93')
        .margin({ top: 2 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActionButton {
  icon: string = ''
  label: string = ''
  bgColor: string = '#FFFFFF'
  iconColor: string = '#000000'

  build() {
    Column() {
      Button({ type: ButtonType.Normal }) {
        Stack({ alignContent: Alignment.Center }) {
          Text(this.icon)
            .fontSize(this.label === 'Start' ? 32 : 28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.iconColor)
            .lineHeight(32)
        }
        .width('100%')
        .height(64)
        .backgroundColor(this.bgColor)
        .borderRadius(16)
      }
      .width('100%')
      .height(64)
      .padding(0)
      .backgroundColor(Color.Transparent)
      .stateEffect(false)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 8 })
    }
    .width(70)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct LogItem {
  icon: string = ''
  title: string = ''
  time: string = ''
  bgColor: string = '#FFFFFF'
  iconColor: string = '#000000'

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(40)
          .height(40)
          .fill(this.bgColor)

        Text(this.icon)
          .fontSize(this.icon === '!' ? 22 : 16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.iconColor)
      }
      .width(40)
      .height(40)

      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ left: 16 })

      Blank()

      Text(this.time)
        .fontSize(12)
        .fontColor('#8E8E93')
    }
    .width('100%')
    .height(52)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .margin({ bottom: 12 })
  }
}
