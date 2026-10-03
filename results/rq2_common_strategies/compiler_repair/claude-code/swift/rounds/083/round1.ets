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
              .fontColor(Color.Black)
              .margin({ bottom: 16 })
              .width('100%')
              .textAlign(TextAlign.Start)

            Row() {
              ActionButton({
                iconName: '▶',
                label: 'Start',
                bgColor: '#E3F2FD',
                iconColor: '#2196F3'
              })
                .layoutWeight(1)
                .margin({ right: 8 })
              ActionButton({
                iconName: '↻',
                label: 'Reboot',
                bgColor: '#FFF3E0',
                iconColor: '#FF9800'
              })
                .layoutWeight(1)
                .margin({ left: 8, right: 8 })
              ActionButton({
                iconName: '\u{1F512}',
                label: 'Lock',
                bgColor: '#FFEBEE',
                iconColor: '#F44336'
              })
                .layoutWeight(1)
                .margin({ left: 8, right: 8 })
              ActionButton({
                iconName: '⚙',
                label: 'Config',
                bgColor: '#F3E5F5',
                iconColor: '#9C27B0'
              })
                .layoutWeight(1)
                .margin({ left: 8 })
            }
            .width('100%')

            Row() {
              Text('Recent Logs')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
              Blank()
              Text('View All')
                .fontSize(14)
                .fontWeight(FontWeight.SemiBold)
                .fontColor('#2196F3')
            }
            .width('100%')
            .margin({ top: 32, bottom: 8 })

            Column() {
              LogItem({
                iconName: '⚠',
                title: 'High Memory Usage',
                time: '10:42 AM',
                typeColor: '#FFF3E0',
                iconTint: '#FF9800'
              })
                .margin({ bottom: 12 })
              LogItem({
                iconName: '\u{1F464}',
                title: 'Admin Login: root',
                time: '09:15 AM',
                typeColor: '#E3F2FD',
                iconTint: '#2196F3'
              })
                .margin({ bottom: 12 })
              LogItem({
                iconName: 'ℹ',
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
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
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
      Text('☰')
        .fontSize(24)
        .fontColor(Color.Black)

      Blank()

      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Blank()

      Stack({ alignContent: Alignment.TopEnd }) {
        Text('\u{1F514}')
          .fontSize(24)
          .fontColor(Color.Black)

        Circle({ width: 10, height: 10 })
          .fill(Color.Red)
          .margin({ top: 2, right: 2 })
      }
    }
    .width('100%')
  }
}

@Component
struct HeroStatusCard {
  build() {
    Column() {
      Stack() {
        Circle({ width: 100, height: 100 })
          .fill(Color.White)

        Stack() {
          Circle({ width: 84, height: 84 })
            .fill('#E8F5E9')

          Text('✓')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor('#4CAF50')
        }
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
    .padding(24)
    .width('100%')
    .backgroundColor('#F5F7FA')
    .borderRadius(24)
  }
}

@Component
struct StatBadge {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Column() {
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Text(this.label)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActionButton {
  @Prop iconName: string = ''
  @Prop label: string = ''
  @Prop bgColor: string = ''
  @Prop iconColor: string = ''

  build() {
    Column() {
      Stack() {
        Text(this.iconName)
          .fontSize(24)
          .fontColor(this.iconColor)
      }
      .width('100%')
      .height(64)
      .backgroundColor(this.bgColor)
      .borderRadius(16)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 8 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct LogItem {
  @Prop iconName: string = ''
  @Prop title: string = ''
  @Prop time: string = ''
  @Prop typeColor: string = ''
  @Prop iconTint: string = ''

  build() {
    Row() {
      Stack() {
        Circle({ width: 40, height: 40 })
          .fill(this.typeColor)

        Text(this.iconName)
          .fontSize(16)
          .fontColor(this.iconTint)
      }

      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)
        .margin({ left: 16 })
        .layoutWeight(1)

      Text(this.time)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor(Color.White)
  }
}
