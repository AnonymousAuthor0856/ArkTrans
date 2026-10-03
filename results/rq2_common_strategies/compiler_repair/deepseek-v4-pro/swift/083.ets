@Entry
@Component
struct ServerStatusApp {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')

      // Main content column
      Column({ space: 0 }) {
        // Top bar
        Row({ space: 0 }) {
          Button() {
            Text('☰')
              .fontSize(24)
              .foregroundColor('#000000')
          }
          Blank()
          Text('NodeLink')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#000000')
          Blank()
          Stack({ alignContent: Alignment.TopEnd }) {
            Button() {
              Text('🔔')
                .fontSize(24)
                .foregroundColor('#000000')
            }
            Column()
              .width(10)
              .height(10)
              .backgroundColor('#FF0000')
              .borderRadius(5)
              .margin({ top: 2, right: 2 })
          }
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 48, bottom: 16 })

        // Scrollable content using List
        List({ space: 0 }) {
          // Hero status card
          ListItem() {
            Column({ space: 16 }) {
              // Centered checkmark circle
              Stack({ alignContent: Alignment.Center }) {
                Column()
                  .width(100)
                  .height(100)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(50)
                Column()
                  .width(84)
                  .height(84)
                  .backgroundColor('#E8F5E9')
                  .borderRadius(42)
                Text('✓')
                  .fontSize(40)
                  .fontWeight(FontWeight.Bold)
                  .foregroundColor('#4CAF50')
              }
              .width(100)
              .height(100)
              .alignSelf(ItemAlign.Center)

              Text('System Operational')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .foregroundColor('#000000')
                .alignSelf(ItemAlign.Center)

              Text('Uptime: 14d 2h 15m')
                .fontSize(14)
                .foregroundColor('#808080')
                .alignSelf(ItemAlign.Center)

              // Stat badges
              Row({ space: 0 }) {
                this.buildStatBadge('12%', 'CPU')
                this.buildStatBadge('4.2GB', 'RAM')
                this.buildStatBadge('1Gbps', 'NET')
              }
              .width('100%')
            }
            .padding(24)
            .width('100%')
            .backgroundColor('#F5F7FA')
            .borderRadius(24)
          }

          // Control Panel header
          ListItem() {
            Text('Control Panel')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .foregroundColor('#000000')
              .width('100%')
          }

          // Quick actions grid (4 items in one row)
          ListItem() {
            Grid() {
              GridItem() {
                this.buildActionButton('▶', 'Start', '#E3F2FD', '#2196F3')
              }
              GridItem() {
                this.buildActionButton('🔄', 'Reboot', '#FFF3E0', '#FF9800')
              }
              GridItem() {
                this.buildActionButton('🔒', 'Lock', '#FFEBEE', '#F44336')
              }
              GridItem() {
                this.buildActionButton('⚙️', 'Config', '#F3E5F5', '#9C27B0')
              }
            }
            .columnsTemplate('1fr 1fr 1fr 1fr')
            .columnsGap(16)
            .width('100%')
          }

          // Recent Logs header with View All
          ListItem() {
            Row({ space: 0 }) {
              Text('Recent Logs')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .foregroundColor('#000000')
              Blank()
              Button() {
                Text('View All')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#2196F3')
              }
            }
            .width('100%')
          }

          // Log items
          ListItem() {
            this.buildLogItem('⚠️', 'High Memory Usage', '10:42 AM', '#FFF3E0', '#FF9800')
          }
          ListItem() {
            this.buildLogItem('👤', 'Admin Login: root', '09:15 AM', '#E3F2FD', '#2196F3')
          }
          ListItem() {
            this.buildLogItem('ℹ️', 'Backup Completed', '04:00 AM', '#E8F5E9', '#4CAF50')
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildStatBadge(value: string, label: string) {
    Column({ space: 2 }) {
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .foregroundColor('#000000')
      Text(label)
        .fontSize(12)
        .foregroundColor('#808080')
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  buildActionButton(icon: string, label: string, bg: string, iconColor: string) {
    Column({ space: 8 }) {
      Button() {
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width('100%')
            .height(64)
            .backgroundColor(bg)
            .borderRadius(16)
          Text(icon)
            .fontSize(24)
            .foregroundColor(iconColor)
        }
        .width('100%')
        .height(64)
      }
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .foregroundColor('#000000')
        .alignSelf(ItemAlign.Center)
    }
    .width('100%')
  }

  @Builder
  buildLogItem(icon: string, title: string, time: string, bg: string, iconColor: string) {
    Row({ space: 16 }) {
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width(40)
          .height(40)
          .backgroundColor(bg)
          .borderRadius(20)
        Text(icon)
          .fontSize(16)
          .foregroundColor(iconColor)
      }
      .width(40)
      .height(40)

      Text(title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .foregroundColor('#000000')
        .layoutWeight(1)

      Text(time)
        .fontSize(12)
        .foregroundColor('#808080')
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
  }
}