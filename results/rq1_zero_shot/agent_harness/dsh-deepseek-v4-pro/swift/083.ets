// Translated from SwiftUI (Swift) to ArkTS (ArkUI)
// Source: ServerStatusApp

@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    ServerStatusScreen()
  }
}

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
              .padding({ top: 16, bottom: 16 })

            Blank().height(16)

            Text('Control Panel')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .padding({ bottom: 16 })

            Row({ space: 16 }) {
              ActionButton({ iconName: '▶', label: 'Start', color: '#E3F2FD', iconColor: '#2196F3' })
              ActionButton({ iconName: '🔄', label: 'Reboot', color: '#FFF3E0', iconColor: '#FF9800' })
              ActionButton({ iconName: '🔒', label: 'Lock', color: '#FFEBEE', iconColor: '#F44336' })
              ActionButton({ iconName: '⚙', label: 'Config', color: '#F3E5F5', iconColor: '#9C27B0' })
            }

            Blank().height(32)

            Row() {
              Text('Recent Logs')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
              Blank()
              Button() {
                Text('View All')
                  .fontSize(14)
                  .fontWeight(FontWeight.Semibold)
                  .fontColor('#2196F3')
              }
              .onClick(() => {})
            }
            .width('100%')

            Blank().height(8)

            Column({ space: 12 }) {
              LogItem({ iconName: '⚠', title: 'High Memory Usage', time: '10:42 AM', typeColor: '#FFF3E0', iconTint: '#FF9800' })
              LogItem({ iconName: '👤', title: 'Admin Login: root', time: '09:15 AM', typeColor: '#E3F2FD', iconTint: '#2196F3' })
              LogItem({ iconName: 'ℹ', title: 'Backup Completed', time: '04:00 AM', typeColor: '#E8F5E9', iconTint: '#4CAF50' })
            }
            .padding({ bottom: 16 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24 })
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
      Button() {
        Text('☰')
          .fontColor('#000000')
          .fontSize(24)
      }
      .onClick(() => {})

      Blank()

      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Blank()

      Stack({ alignContent: Alignment.TopEnd }) {
        Button() {
          Text('🔔')
            .fontColor('#000000')
            .fontSize(24)
        }
        .onClick(() => {})

        Circle()
          .fill('#FF0000')
          .width(10)
          .height(10)
          .margin(2)
      }
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct HeroStatusCard {
  build() {
    Column() {
      Column() {
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
          .fontColor('#000000')

        Text('Uptime: 14d 2h 15m')
          .fontSize(14)
          .fontColor('#808080')
          .padding({ top: 4 })

        Blank().height(24)

        Row() {
          StatBadge({ label: 'CPU', value: '12%' }).layoutWeight(1)
          StatBadge({ label: 'RAM', value: '4.2GB' }).layoutWeight(1)
          StatBadge({ label: 'NET', value: '1Gbps' }).layoutWeight(1)
        }
        .width('100%')
      }
      .padding(24)
      .width('100%')
    }
    .width('100%')
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
        .fontColor('#000000')
      Text(this.label)
        .fontSize(12)
        .fontColor('#808080')
    }
  }
}

@Component
struct ActionButton {
  iconName: string = ''
  label: string = ''
  color: string = '#FFFFFF'
  iconColor: string = '#000000'

  build() {
    Column() {
      Button() {
        Stack() {
          Column()
            .width('100%')
            .height(64)
            .backgroundColor(this.color)
            .borderRadius(16)

          Text(this.iconName)
            .fontSize(24)
            .fontColor(this.iconColor)
        }
        .height(64)
      }
      .onClick(() => {})
      .width('100%')

      Blank().height(8)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .layoutWeight(1)
  }
}

@Component
struct LogItem {
  iconName: string = ''
  title: string = ''
  time: string = ''
  typeColor: string = '#FFFFFF'
  iconTint: string = '#000000'

  build() {
    Row() {
      Stack() {
        Circle()
          .fill(this.typeColor)
          .width(40)
          .height(40)

        Text(this.iconName)
          .fontSize(16)
          .fontColor(this.iconTint)
      }
      .width(40)
      .height(40)

      Blank().width(16)

      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.Semibold)
        .fontColor('#000000')

      Blank()

      Text(this.time)
        .fontSize(12)
        .fontColor('#808080')
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor('#FFFFFF')
    .alignItems(VerticalAlign.Center)
  }
}
