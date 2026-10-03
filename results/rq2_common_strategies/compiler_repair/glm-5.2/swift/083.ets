// ServerStatusApp.ets

// --- Icon Component ---
// A custom component to render SVG paths similar to SF Symbols
@Component
export struct SFSymbol {
  @Prop name: string = ''
  @Prop fillColor: string = '#000000'
  @Prop iconSize: number = 24

  build() {
    Image(this.getIconPath())
      .width(this.iconSize)
      .height(this.iconSize)
      .fillColor(this.fillColor)
      .objectFit(ImageFit.Contain)
  }

  private getIconPath(): Resource {
    // Mapping SF Symbols names to local SVG resources
    // You would need to include these SVG files in your `resources/rawfile/icons/` directory
    // For demonstration, we return a placeholder resource string
    return { "id": 0, "type": 10003, params: [`icons/${this.name}.svg`], "bundleName": "", "moduleName": "" }
  }
}

// --- Top Bar ---
@Component
export struct TopBar {
  build() {
    Row() {
      Button() {
        SFSymbol({ name: 'line.3.horizontal', fillColor: '#000000', iconSize: 24 })
      }
      .backgroundColor(Color.Transparent)

      Blank()

      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Blank()

      Stack({ alignContent: Alignment.TopEnd }) {
        Button() {
          SFSymbol({ name: 'bell.fill', fillColor: '#000000', iconSize: 24 })
        }
        .backgroundColor(Color.Transparent)

        Circle()
          .fill(Color.Red)
          .width(10)
          .height(10)
          .margin({ top: 2, right: 2 })
      }
      .width(40)
      .height(40)
    }
    .width('100%')
    .padding({ top: 48, left: 24, right: 24, bottom: 16 })
  }
}

// --- Stat Badge ---
@Component
export struct StatBadge {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Column() {
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Text(this.label)
        .fontSize(12)
        .fontColor('#808080')
        .margin({ top: 2 })
    }
    .layoutWeight(1)
  }
}

// --- Hero Status Card ---
@Component
export struct HeroStatusCard {
  build() {
    Column() {
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

          SFSymbol({ name: 'checkmark', fillColor: '#4CAF50', iconSize: 40 })
        }
      }

      Text('System Operational')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .margin({ top: 16 })

      Text('Uptime: 14d 2h 15m')
        .fontSize(14)
        .fontColor('#808080')
        .margin({ top: 4 })

      Row() {
        StatBadge({ label: 'CPU', value: '12%' })
        StatBadge({ label: 'RAM', value: '4.2GB' })
        StatBadge({ label: 'NET', value: '1Gbps' })
      }
      .width('100%')
      .margin({ top: 24 })
    }
    .padding(24)
    .backgroundColor('#F5F7FA')
    .borderRadius(24)
    .margin({ top: 16, bottom: 16 })
  }
}

// --- Action Button ---
@Component
export struct ActionButton {
  @Prop iconName: string = ''
  @Prop label: string = ''
  @Prop color: string = '#FFFFFF'
  @Prop iconColor: string = '#000000'

  build() {
    Column() {
      Button() {
        Stack() {
          Column()
            .width('100%')
            .height(64)
            .backgroundColor(this.color)
            .borderRadius(16)

          SFSymbol({ name: this.iconName, fillColor: this.iconColor, iconSize: 24 })
        }
      }
      .backgroundColor(Color.Transparent)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 8 })
    }
    .layoutWeight(1)
  }
}

// --- Log Item ---
@Component
export struct LogItem {
  @Prop iconName: string = ''
  @Prop title: string = ''
  @Prop time: string = ''
  @Prop typeColor: string = '#FFFFFF'
  @Prop iconTint: string = '#000000'

  build() {
    Row() {
      Stack() {
        Circle()
          .fill(this.typeColor)
          .width(40)
          .height(40)

        SFSymbol({ name: this.iconName, fillColor: this.iconTint, iconSize: 16 })
      }

      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .margin({ left: 16 })
        .layoutWeight(1)

      Text(this.time)
        .fontSize(12)
        .fontColor('#808080')
    }
    .padding({ top: 4, bottom: 4 })
    .backgroundColor(Color.White)
  }
}

// --- Main Screen ---
@Entry
@Component
struct ServerStatusScreen {
  build() {
    Stack() {
      Column() {
        // Top Bar
        TopBar()

        // Scrollable Content
        Scroll() {
          Column() {
            // Hero Status Section
            HeroStatusCard()

            // Quick Actions Header
            Text('Control Panel')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .margin({ top: 16, bottom: 16, left: 24 })

            // Quick Actions Grid
            Row() {
              ActionButton({
                iconName: 'play.fill',
                label: 'Start',
                color: '#E3F2FD',
                iconColor: '#2196F3'
              })
              ActionButton({
                iconName: 'arrow.clockwise',
                label: 'Reboot',
                color: '#FFF3E0',
                iconColor: '#FF9800'
              })
              ActionButton({
                iconName: 'lock.fill',
                label: 'Lock',
                color: '#FFEBEE',
                iconColor: '#F44336'
              })
              ActionButton({
                iconName: 'gearshape.fill',
                label: 'Config',
                color: '#F3E5F5',
                iconColor: '#9C27B0'
              })
            }
            .width('100%')
            .padding({ left: 24, right: 24 })

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
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#2196F3')
              }
              .backgroundColor(Color.Transparent)
            }
            .width('100%')
            .padding({ left: 24, right: 24, top: 32, bottom: 8 })

            // Recent Logs List
            Column({ space: 12 }) {
              LogItem({
                iconName: 'exclamationmark.triangle.fill',
                title: 'High Memory Usage',
                time: '10:42 AM',
                typeColor: '#FFF3E0',
                iconTint: '#FF9800'
              })
              LogItem({
                iconName: 'person.fill',
                title: 'Admin Login: root',
                time: '09:15 AM',
                typeColor: '#E3F2FD',
                iconTint: '#2196F3'
              })
              LogItem({
                iconName: 'info.circle.fill',
                title: 'Backup Completed',
                time: '04:00 AM',
                typeColor: '#E8F5E9',
                iconTint: '#4CAF50'
              })
            }
            .width('100%')
            .padding({ left: 24, right: 24, bottom: 16 })
          }
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}