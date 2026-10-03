import { router } from '@kit.ArkUI';

@Entry
@Component
struct ServerStatusApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ContentView {
  build() {
    Column() {
      ServerStatusScreen()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ServerStatusScreen {
  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(Color.White)

      Column() {
        // Top Bar
        TopBar()
          .margin({ top: 48, left: 24, right: 24, bottom: 16 })

        // Scrollable Content
        Scroll() {
          Column() {
            // Hero Status Section
            HeroStatusCard()
              .margin({ top: 16, bottom: 16 })

            Blank().height(16)

            // Control Panel Title
            Text('Control Panel')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ bottom: 16 })
              .alignSelf(ItemAlign.Start)

            // Quick Actions Grid
            Row({ space: 16 }) {
              ActionButton({
                label: 'Start',
                color: '#E3F2FD',
                iconColor: '#2196F3',
                iconSymbol: '▶'
              })
              ActionButton({
                label: 'Reboot',
                color: '#FFF3E0',
                iconColor: '#FF9800',
                iconSymbol: '↻'
              })
              ActionButton({
                label: 'Lock',
                color: '#FFEBEE',
                iconColor: '#F44336',
                iconSymbol: '🔒'
              })
              ActionButton({
                label: 'Config',
                color: '#F3E5F5',
                iconColor: '#9C27B0',
                iconSymbol: '⚙'
              })
            }
            .width('100%')

            Blank().height(32)

            // Recent Logs Header
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
            .justifyContent(FlexAlign.SpaceBetween)

            Blank().height(8)

            // Recent Logs List
            Column({ space: 12 }) {
              LogItem({
                title: 'High Memory Usage',
                time: '10:42 AM',
                typeColor: '#FFF3E0',
                iconTint: '#FF9800',
                iconSymbol: '⚠'
              })
              LogItem({
                title: 'Admin Login: root',
                time: '09:15 AM',
                typeColor: '#E3F2FD',
                iconTint: '#2196F3',
                iconSymbol: '👤'
              })
              LogItem({
                title: 'Backup Completed',
                time: '04:00 AM',
                typeColor: '#E8F5E9',
                iconTint: '#4CAF50',
                iconSymbol: 'ℹ'
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
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct TopBar {
  build() {
    Row() {
      // Menu Button
      Text('☰')
        .fontSize(24)
        .fontColor(Color.Black)
        .onClick(() => {})

      Blank()

      // Title
      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Blank()

      // Notification Bell with Badge
      Stack({ alignContent: Alignment.TopEnd }) {
        Text('🔔')
          .fontSize(24)
          .fontColor(Color.Black)
          .onClick(() => {})
        Circle()
          .fill(Color.Red)
          .width(10)
          .height(10)
          .margin({ top: 0, right: 0 })
      }
      .width(32)
      .height(32)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct HeroStatusCard {
  build() {
    Column() {
      Column() {
        // Status Icon
        Stack() {
          Circle()
            .fill(Color.White)
            .width(100)
            .height(100)

          Stack() {
            Circle()
              .fill('#E8F5E9')
              .width(84)
              .height(84)

            Text('✓')
              .fontSize(40)
              .fontWeight(FontWeight.Bold)
              .fontColor('#4CAF50')
          }
        }

        Blank().height(16)

        Text('System Operational')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text('Uptime: 14d 2h 15m')
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ top: 4 })

        Blank().height(24)

        // Stats Row
        Row() {
          StatBadge({ label: 'CPU', value: '12%' })
          StatBadge({ label: 'RAM', value: '4.2GB' })
          StatBadge({ label: 'NET', value: '1Gbps' })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
      }
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .backgroundColor('#F5F7FA')
    .borderRadius(24)
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
        .fontColor(Color.Black)
      Text(this.label)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActionButton {
  label: string = '';
  color: string = '';
  iconColor: string = '';
  iconSymbol: string = '';

  build() {
    Column() {
      Stack() {
        Column()
          .width('100%')
          .height(64)
          .backgroundColor(this.color)
          .borderRadius(16)

        Text(this.iconSymbol)
          .fontSize(24)
          .fontColor(this.iconColor)
      }
      .width('100%')
      .height(64)
      .onClick(() => {})

      Blank().height(8)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct LogItem {
  title: string = '';
  time: string = '';
  typeColor: string = '';
  iconTint: string = '';
  iconSymbol: string = '';

  build() {
    Row() {
      // Icon Circle
      Stack() {
        Circle()
          .fill(this.typeColor)
          .width(40)
          .height(40)

        Text(this.iconSymbol)
          .fontSize(16)
          .fontColor(this.iconTint)
      }
      .width(40)
      .height(40)

      Blank().width(16)

      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .layoutWeight(1)

      Text(this.time)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
  }
}