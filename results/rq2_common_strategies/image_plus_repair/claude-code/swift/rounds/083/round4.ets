@Entry
@Component
struct ServerStatusScreen {
  build() {
    Stack() {
      Column() {
        TopBar()
          .margin({ top: 48, left: 24, right: 24, bottom: 16 })

        Scroll() {
          Column() {
            HeroStatusCard()
              .margin({ top: 16, bottom: 16 })

            Text('Control Panel')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .width('100%')
              .margin({ bottom: 16 })

            Row() {
              ActionButton({
                icon: '▶',
                label: 'Start',
                bgColor: '#E3F2FD',
                iconColor: '#2196F3'
              })
              ActionButton({
                icon: '↻',
                label: 'Reboot',
                bgColor: '#FFF3E0',
                iconColor: '#FF9800'
              })
              ActionButton({
                icon: '\u{1F512}',
                label: 'Lock',
                bgColor: '#FFEBEE',
                iconColor: '#F44336'
              })
              ActionButton({
                icon: '⚙',
                label: 'Config',
                bgColor: '#F3E5F5',
                iconColor: '#9C27B0'
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            Row() {
              Text('Recent Logs')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
                .layoutWeight(1)
              Text('View All')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#2196F3')
            }
            .width('100%')
            .margin({ top: 32, bottom: 8 })

            Column() {
              LogItem({
                icon: '⚠',
                title: 'High Memory Usage',
                time: '10:42 AM',
                typeColor: '#FFF3E0',
                iconTint: '#FF9800'
              })
              LogItem({
                icon: '\u{1F464}',
                title: 'Admin Login: root',
                time: '09:15 AM',
                typeColor: '#E3F2FD',
                iconTint: '#2196F3'
              })
              LogItem({
                icon: 'ⓘ',
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
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct TopBar {
  build() {
    Row() {
      Text('☰')
        .fontSize(28)
        .fontColor('#000000')

      Blank()

      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Blank()

      Stack() {
        Text('\u{1F514}')
          .fontSize(24)
          .fontColor('#000000')
        Circle()
          .width(10)
          .height(10)
          .fill('#FF3B30')
          .margin({ top: 2, right: 2 })
      }
      .alignContent(Alignment.TopEnd)
    }
    .width('100%')
  }
}

@Component
struct HeroStatusCard {
  build() {
    Column() {
      Stack() {
        Circle()
          .width(100)
          .height(100)
          .fill('#FFFFFF')
        Stack() {
          Circle()
            .width(84)
            .height(84)
            .fill('#E8F5E9')
          Text('✓')
            .fontSize(44)
            .fontWeight(FontWeight.Bold)
            .fontColor('#4CAF50')
        }
      }

      Text('System Operational')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .margin({ top: 16 })

      Text('Uptime: 14d 2h 15m')
        .fontSize(14)
        .fontColor('#9E9E9E')
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
    .backgroundColor('#F5F7FA')
    .borderRadius(24)
  }
}

@Component
struct StatBadge {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Column({ space: 2 }) {
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
      Text(this.label)
        .fontSize(12)
        .fontColor('#9E9E9E')
    }
  }
}

@Component
struct ActionButton {
  @Prop icon: string = ''
  @Prop label: string = ''
  @Prop bgColor: string = ''
  @Prop iconColor: string = ''

  build() {
    Column() {
      Stack() {
        Text(this.icon)
          .fontSize(26)
          .fontColor(this.iconColor)
      }
      .width('100%')
      .height(64)
      .backgroundColor(this.bgColor)
      .borderRadius(16)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 8 })
    }
    .layoutWeight(1)
  }
}

@Component
struct LogItem {
  @Prop icon: string = ''
  @Prop title: string = ''
  @Prop time: string = ''
  @Prop typeColor: string = ''
  @Prop iconTint: string = ''

  build() {
    Row() {
      Stack() {
        Circle()
          .width(40)
          .height(40)
          .fill(this.typeColor)
        Text(this.icon)
          .fontSize(18)
          .fontColor(this.iconTint)
      }

      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ left: 16 })
        .layoutWeight(1)

      Text(this.time)
        .fontSize(12)
        .fontColor('#9E9E9E')
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor('#FFFFFF')
  }
}
