@Entry
@Component
struct ServerStatusScreen {
  build() {
    Column() {
      // Top Bar
      TopBar()
        .margin({ top: 48, left: 24, right: 24, bottom: 16 })

      Scroll() {
        Column() {
          // Hero Status Card
          HeroStatusCard()
            .margin({ top: 16, bottom: 16 })

          // Control Panel
          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .margin({ bottom: 16 })
            .alignSelf(ItemAlign.Start)

          Row({ space: 16 }) {
            ActionButton({
              label: 'Start',
              bgColor: '#E3F2FD',
              iconColor: '#2196F3',
              iconText: '▶'
            })
            ActionButton({
              label: 'Reboot',
              bgColor: '#FFF3E0',
              iconColor: '#FF9800',
              iconText: '↻'
            })
            ActionButton({
              label: 'Lock',
              bgColor: '#FFEBEE',
              iconColor: '#F44336',
              iconText: '🔒'
            })
            ActionButton({
              label: 'Config',
              bgColor: '#F3E5F5',
              iconColor: '#9C27B0',
              iconText: '⚙'
            })
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
          .margin({ bottom: 8 })

          // Log Items
          Column({ space: 12 }) {
            LogItem({
              iconText: '⚠',
              title: 'High Memory Usage',
              time: '10:42 AM',
              bgColor: '#FFF3E0',
              iconColor: '#FF9800'
            })
            LogItem({
              iconText: '👤',
              title: 'Admin Login: root',
              time: '09:15 AM',
              bgColor: '#E3F2FD',
              iconColor: '#2196F3'
            })
            LogItem({
              iconText: 'ℹ',
              title: 'Backup Completed',
              time: '04:00 AM',
              bgColor: '#E8F5E9',
              iconColor: '#4CAF50'
            })
          }
          .width('100%')
          .margin({ bottom: 16 })
        }
        .padding({ left: 24, right: 24 })
        .alignItems(HorizontalAlign.Start)
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct TopBar {
  build() {
    Row() {
      Text('☰')
        .fontSize(24)
        .fontColor('#000000')

      Blank()

      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Blank()

      Stack({ alignContent: Alignment.TopEnd }) {
        Text('🔔')
          .fontSize(24)
          .fontColor('#000000')
        Circle()
          .fill('#FF0000')
          .width(10)
          .height(10)
      }
      .width(32)
      .height(32)
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
          .fill('#FFFFFF')
          .width(100)
          .height(100)
        Circle()
          .fill('#E8F5E9')
          .width(84)
          .height(84)
        Text('✓')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4CAF50')
      }
      .width(100)
      .height(100)

      Text('System Operational')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .margin({ top: 16 })

      Text('Uptime: 14d 2h 15m')
        .fontSize(14)
        .fontColor('#888888')
        .margin({ top: 4 })

      Row() {
        StatBadge({ label: 'CPU', value: '12%' })
        StatBadge({ label: 'RAM', value: '4.2GB' })
        StatBadge({ label: 'NET', value: '1Gbps' })
      }
      .width('100%')
      .margin({ top: 24 })
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#F5F7FA')
    .borderRadius(24)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StatBadge {
  label: string = '';
  value: string = '';

  build() {
    Column({ space: 2 }) {
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
      Text(this.label)
        .fontSize(12)
        .fontColor('#888888')
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActionButton {
  label: string = '';
  bgColor: string = '#E3F2FD';
  iconColor: string = '#2196F3';
  iconText: string = '';

  build() {
    Column() {
      Stack() {
        Column()
          .width('100%')
          .height(64)
          .backgroundColor(this.bgColor)
          .borderRadius(16)
        Text(this.iconText)
          .fontSize(24)
          .fontColor(this.iconColor)
      }
      .width('100%')
      .height(64)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 8 })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct LogItem {
  iconText: string = '';
  title: string = '';
  time: string = '';
  bgColor: string = '#FFF3E0';
  iconColor: string = '#FF9800';

  build() {
    Row() {
      Stack() {
        Circle()
          .fill(this.bgColor)
          .width(40)
          .height(40)
        Text(this.iconText)
          .fontSize(16)
          .fontColor(this.iconColor)
      }
      .width(40)
      .height(40)

      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ left: 16 })
        .layoutWeight(1)

      Text(this.time)
        .fontSize(12)
        .fontColor('#888888')
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor('#FFFFFF')
  }
}