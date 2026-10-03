class SsColors {
  static readonly white: string = '#FFFFFFFF'
  static readonly black: string = '#FF000000'
  static readonly gray: string = '#FF808080'
  static readonly red: string = '#FFFF0000'
  static readonly heroBg: string = '#FFF5F7FA'
  static readonly checkBg: string = '#FFE8F5E9'
  static readonly checkColor: string = '#FF4CAF50'
  static readonly startBg: string = '#FFE3F2FD'
  static readonly startIcon: string = '#FF2196F3'
  static readonly rebootBg: string = '#FFFFF3E0'
  static readonly rebootIcon: string = '#FFFF9800'
  static readonly lockBg: string = '#FFFFEBEE'
  static readonly lockIcon: string = '#FFF44336'
  static readonly configBg: string = '#FFF3E5F5'
  static readonly configIcon: string = '#FF9C27B0'
  static readonly viewAllText: string = '#FF2196F3'
  static readonly logWarnBg: string = '#FFFFF3E0'
  static readonly logWarnIcon: string = '#FFFF9800'
  static readonly logLoginBg: string = '#FFE3F2FD'
  static readonly logLoginIcon: string = '#FF2196F3'
  static readonly logBackupBg: string = '#FFE8F5E9'
  static readonly logBackupIcon: string = '#FF4CAF50'
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row() {
          Text('☰')
            .fontSize(24)
            .fontColor(SsColors.black)
          Blank()
          Text('NodeLink')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(SsColors.black)
          Blank()
          Stack() {
            Text('🔔')
              .fontSize(24)
              .fontColor(SsColors.black)
            Circle({ width: 10, height: 10 })
              .fill(SsColors.red)
              .markAnchor({ x: 20, y: 0 })
          }
        }
        .padding({ left: 24, right: 24, top: 48, bottom: 16 })

        Scroll() {
          Column() {
            Column() {
              Stack() {
                Circle({ width: 100, height: 100 })
                  .fill(SsColors.white)

                Stack() {
                  Circle({ width: 84, height: 84 })
                    .fill(SsColors.checkBg)

                  Text('✓')
                    .fontSize(40)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(SsColors.checkColor)
                }
              }

              Blank().height(16)

              Text('System Operational')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(SsColors.black)

              Text('Uptime: 14d 2h 15m')
                .fontSize(14)
                .fontColor(SsColors.gray)
                .margin({ top: 4 })

              Blank().height(24)

              Row() {
                StatBadge({ label: 'CPU', value: '12%' })
                  .layoutWeight(1)
                StatBadge({ label: 'RAM', value: '4.2GB' })
                  .layoutWeight(1)
                StatBadge({ label: 'NET', value: '1Gbps' })
                  .layoutWeight(1)
              }
            }
            .padding(24)
            .backgroundColor(SsColors.heroBg)
            .borderRadius(24)
            .margin({ top: 16, bottom: 16 })

            Blank().height(16)

            Text('Control Panel')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(SsColors.black)
              .margin({ bottom: 16 })

            Row() {
              ActionButton({ iconName: '▶', label: 'Start', color: SsColors.startBg, iconColor: SsColors.startIcon })
              ActionButton({ iconName: '↻', label: 'Reboot', color: SsColors.rebootBg, iconColor: SsColors.rebootIcon })
              ActionButton({ iconName: '🔒', label: 'Lock', color: SsColors.lockBg, iconColor: SsColors.lockIcon })
              ActionButton({ iconName: '⚙', label: 'Config', color: SsColors.configBg, iconColor: SsColors.configIcon })
            }

            Blank().height(32)

            Row() {
              Text('Recent Logs')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(SsColors.black)
              Blank()
              Text('View All')
                .fontSize(14)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(SsColors.viewAllText)
            }

            Blank().height(8)

            LogItem({ iconName: '⚠', title: 'High Memory Usage', time: '10:42 AM', typeColor: SsColors.logWarnBg, iconTint: SsColors.logWarnIcon })
            LogItem({ iconName: '◉', title: 'Admin Login: root', time: '09:15 AM', typeColor: SsColors.logLoginBg, iconTint: SsColors.logLoginIcon })
            LogItem({ iconName: 'ⓘ', title: 'Backup Completed', time: '04:00 AM', typeColor: SsColors.logBackupBg, iconTint: SsColors.logBackupIcon })
          }
          .padding({ left: 24, right: 24, bottom: 16 })
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
    }
    .backgroundColor(SsColors.white)
    .width('100%')
    .height('100%')
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
        .fontColor(SsColors.black)
      Text(this.label)
        .fontSize(12)
        .fontColor(SsColors.gray)
        .margin({ top: 2 })
    }
  }
}

@Component
struct ActionButton {
  @Prop iconName: string = ''
  @Prop label: string = ''
  @Prop color: string = '#FFFFFF'
  @Prop iconColor: string = '#FFFFFF'

  build() {
    Column() {
      Stack() {
        Text(this.iconName)
          .fontSize(24)
          .fontColor(this.iconColor)
      }
      .width('100%')
      .height(64)
      .backgroundColor(this.color)
      .borderRadius(16)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(SsColors.black)
        .margin({ top: 8 })
    }
    .layoutWeight(1)
    .margin({ right: 16 })
  }
}

@Component
struct LogItem {
  @Prop iconName: string = ''
  @Prop title: string = ''
  @Prop time: string = ''
  @Prop typeColor: string = '#FFFFFF'
  @Prop iconTint: string = '#FFFFFF'

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
        .fontColor(SsColors.black)
        .margin({ left: 16 })
        .layoutWeight(1)

      Text(this.time)
        .fontSize(12)
        .fontColor(SsColors.gray)
    }
    .padding({ top: 4, bottom: 4 })
    .backgroundColor(SsColors.white)
    .margin({ top: 12 })
  }
}