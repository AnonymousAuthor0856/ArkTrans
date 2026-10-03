@Entry
@Component
struct Index {
  build() {
    Column() {
      Row() {
        Button({ type: ButtonType.Circle }) {
          Text('≡').fontSize(24).fontColor('#000000')
        }
        .width(48).height(48)
        .backgroundColor('#00000000')

        Text('NodeLink')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Stack() {
          Button({ type: ButtonType.Circle }) {
            Text('🔔').fontSize(24).fontColor('#000000')
          }
          .width(48).height(48)
          .backgroundColor('#00000000')

          Stack() {}
            .width(10).height(10)
            .borderRadius(5)
            .backgroundColor('#FF0000')
            .margin({ top: 2, right: 2 })
            .align(Alignment.TopEnd)
        }
      }
      .width('100%')
      .padding({ top: 48, bottom: 16, left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          Column() {
            Stack() {
              Stack() {
                Text('✓').fontSize(48).fontColor('#4CAF50')
              }
              .width('100%').height('100%')
              .backgroundColor('#E8F5E9')
              .borderRadius(50)
              .alignContent(Alignment.Center)
            }
            .width(100).height(100)
            .backgroundColor('#FFFFFF')
            .borderRadius(50)
            .padding(8)
            .alignContent(Alignment.Center)

            Blank().height(16)

            Text('System Operational')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Text('Uptime: 14d 2h 15m')
              .fontSize(14)
              .fontColor('#888888')
              .margin({ top: 4 })

            Blank().height(24)

            Row() {
              StatBadge({ label: 'CPU', value: '12%' })
              StatBadge({ label: 'RAM', value: '4.2GB' })
              StatBadge({ label: 'NET', value: '1Gbps' })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
          }
          .width('100%')
          .padding(24)
          .margin({ top: 16, bottom: 16 })
          .backgroundColor('#F5F7FA')
          .borderRadius(24)
          .alignItems(HorizontalAlign.Center)

          Blank().height(16)

          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .margin({ bottom: 16 })

          Row() {
            ActionButton({ icon: '▶', label: 'Start', color: '#E3F2FD', iconColor: '#2196F3' })
            ActionButton({ icon: '↻', label: 'Reboot', color: '#FFF3E0', iconColor: '#FF9800' })
            ActionButton({ icon: '🔒', label: 'Lock', color: '#FFEBEE', iconColor: '#F44336' })
            ActionButton({ icon: '⚙', label: 'Config', color: '#F3E5F5', iconColor: '#9C27B0' })
          }
          .width('100%')
          .space(16)

          Blank().height(32)

          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Text('View All')
              .fontSize(14)
              .fontColor('#2196F3')
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          Blank().height(8)

          Column() {
            LogItem({ icon: '⚠', title: 'High Memory Usage', time: '10:42 AM', typeColor: '#FFF3E0', iconTint: '#FF9800' })
            LogItem({ icon: '👤', title: 'Admin Login: root', time: '09:15 AM', typeColor: '#E3F2FD', iconTint: '#2196F3' })
            LogItem({ icon: 'ⓘ', title: 'Backup Completed', time: '04:00 AM', typeColor: '#E8F5E9', iconTint: '#4CAF50' })
          }
          .width('100%')
          .space(12)
          .padding({ bottom: 16 })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct StatBadge {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Column() {
      Text(this.value)
        .fontWeight(FontWeight.Bold)
        .fontSize(16)
        .fontColor('#000000')
      Text(this.label)
        .fontSize(12)
        .fontColor('#888888')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActionButton {
  @Prop icon: string = ''
  @Prop label: string = ''
  @Prop color: string = '#FFFFFF'
  @Prop iconColor: string = '#000000'

  build() {
    Column() {
      Stack() {
        Text(this.icon).fontSize(28).fontColor(this.iconColor)
      }
      .width('100%').height(64)
      .backgroundColor(this.color)
      .borderRadius(16)
      .alignContent(Alignment.Center)

      Blank().height(8)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct LogItem {
  @Prop icon: string = ''
  @Prop title: string = ''
  @Prop time: string = ''
  @Prop typeColor: string = '#FFFFFF'
  @Prop iconTint: string = '#000000'

  build() {
    Row() {
      Stack() {
        Text(this.icon).fontSize(20).fontColor(this.iconTint)
      }
      .width(40).height(40)
      .backgroundColor(this.typeColor)
      .borderRadius(20)
      .alignContent(Alignment.Center)

      Blank().width(16)

      Column() {
        Text(this.title)
          .fontWeight(FontWeight.Bold)
          .fontSize(14)
          .fontColor('#000000')
      }
      .layoutWeight(1)

      Text(this.time)
        .fontSize(12)
        .fontColor('#888888')
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .padding({ top: 4, bottom: 4 })
    .alignItems(VerticalAlign.Center)
  }
}
