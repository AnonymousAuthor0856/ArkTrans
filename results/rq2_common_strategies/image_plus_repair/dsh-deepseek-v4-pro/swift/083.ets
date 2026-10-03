// Translated from SwiftUI (Swift) to ArkTS (HarmonyOS).
// SF Symbol icons are rendered as Unicode text glyphs (ArkUI has no SF Symbols).

@Entry
@Component
struct Index {
  // Top Bar
  @Builder
  TopBar() {
    Row() {
      Button() {
        // SF Symbol: line.3.horizontal
        Text('☰')
          .fontSize(24)
          .fontColor('#000000')
      }
      .backgroundColor(Color.Transparent)
      .onClick(() => {})

      Blank()

      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Blank()

      Stack({ alignContent: Alignment.TopEnd }) {
        Button() {
          // SF Symbol: bell.fill
          Text('🔔')
            .fontSize(24)
            .fontColor('#000000')
        }
        .backgroundColor(Color.Transparent)
        .onClick(() => {})

        Circle({ width: 10, height: 10 })
          .fill('#FF0000')
          .padding(2)
      }
    }
    .width('100%')
  }

  @Builder
  StatBadge(label: string, value: string) {
    Column({ space: 2 }) {
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
      Text(label)
        .fontSize(12)
        .fontColor('#808080')
    }
    .layoutWeight(1)
  }

  @Builder
  HeroStatusCard() {
    Column() {
      Column() {
        Stack() {
          Circle({ width: 100, height: 100 })
            .fill('#FFFFFF')

          Stack() {
            Circle({ width: 84, height: 84 }) // 100 - padding 8*2
              .fill('#E8F5E9') // #E8F5E9

            // SF Symbol: checkmark
            Text('✓')
              .fontSize(40) // Approx 48dp visual
              .fontWeight(FontWeight.Bold)
              .fontColor('#4CAF50') // #4CAF50
          }
        }

        Column().height(16)

        Text('System Operational')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Text('Uptime: 14d 2h 15m')
          .fontSize(14)
          .fontColor('#808080')
          .padding({ top: 4 })

        Column().height(24)

        Row() {
          this.StatBadge('CPU', '12%')
          this.StatBadge('RAM', '4.2GB')
          this.StatBadge('NET', '1Gbps')
        }
        .width('100%')
      }
      .padding(24)
    }
    .backgroundColor('#F5F7FA') // #F5F7FA
    .borderRadius(24)
    .width('100%')
  }

  @Builder
  ActionButton(icon: string, label: string, color: string, iconColor: string) {
    Column() {
      Button() {
        Stack() {
          Rect({ width: '100%', height: 64, radius: 16 })
            .fill(color)

          // SF Symbol icon
          Text(icon)
            .fontSize(24) // Approx 28dp visual
            .fontColor(iconColor)
        }
        .width('100%')
      }
      .width('100%')
      .height(64)
      .backgroundColor(Color.Transparent)
      .onClick(() => {})

      Column().height(8)

      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .width('100%')
    .layoutWeight(1)
  }

  @Builder
  LogItem(icon: string, title: string, time: string, typeColor: string, iconTint: string) {
    Row() {
      Stack() {
        Circle({ width: 40, height: 40 })
          .fill(typeColor)

        // SF Symbol icon
        Text(icon)
          .fontSize(16) // Approx 20dp visual
          .fontColor(iconTint)
      }

      Row().width(16)

      Text(title)
        .fontSize(14)
        .fontWeight(600)
        .fontColor('#000000')

      Blank()

      Text(time)
        .fontSize(12)
        .fontColor('#808080')
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor('#FFFFFF')
  }

  build() {
    Column() {
      // Top Bar
      Column() {
        this.TopBar()
      }
      .width('100%')
      .padding({ top: 48, left: 24, right: 24, bottom: 16 })

      Scroll() {
        Column() {
          // Hero Status Section
          Column() {
            this.HeroStatusCard()
          }
          .width('100%')
          .padding({ top: 16, bottom: 16 })

          Column().height(16)

          // Quick Actions Grid
          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .padding({ bottom: 16 })

          Row({ space: 16 }) {
            this.ActionButton('▶', 'Start', '#E3F2FD', '#2196F3')
            this.ActionButton('↻', 'Reboot', '#FFF3E0', '#FF9800')
            this.ActionButton('🔒', 'Lock', '#FFEBEE', '#F44336')
            this.ActionButton('⚙', 'Config', '#F3E5F5', '#9C27B0')
          }

          Column().height(32)

          // Recent Logs Header
          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Blank()
            Button() {
              Text('View All')
                .fontSize(14)
                .fontWeight(600)
                .fontColor('#2196F3') // #2196F3
            }
            .backgroundColor(Color.Transparent)
            .onClick(() => {})
          }
          .width('100%')

          Column().height(8)

          // Recent Logs List
          Column({ space: 12 }) {
            this.LogItem('⚠', 'High Memory Usage', '10:42 AM', '#FFF3E0', '#FF9800')
            this.LogItem('👤', 'Admin Login: root', '09:15 AM', '#E3F2FD', '#2196F3')
            this.LogItem('ℹ', 'Backup Completed', '04:00 AM', '#E8F5E9', '#4CAF50')
          }
          .padding({ bottom: 16 })
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 24, right: 24 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
