class ActionItem {
  label: string;
  icon: string;
  color: string;
  iconColor: string;

  constructor(label: string, icon: string, color: string, iconColor: string) {
    this.label = label;
    this.icon = icon;
    this.color = color;
    this.iconColor = iconColor;
  }
}

class LogItemModel {
  title: string;
  time: string;
  icon: string;
  typeColor: string;
  iconTint: string;

  constructor(title: string, time: string, icon: string, typeColor: string, iconTint: string) {
    this.title = title;
    this.time = time;
    this.icon = icon;
    this.typeColor = typeColor;
    this.iconTint = iconTint;
  }
}

@Entry
@Component
struct MainActivity {
  private actions: ActionItem[] = [
    new ActionItem('Start', '▶', '#E3F2FD', '#2196F3'),
    new ActionItem('Reboot', '↻', '#FFF3E0', '#FF9800'),
    new ActionItem('Lock', '⌘', '#FFEBEE', '#F44336'),
    new ActionItem('Config', '⚙', '#F3E5F5', '#9C27B0')
  ];
  private logs: LogItemModel[] = [
    new LogItemModel('High Memory Usage', '10:42 AM', '!', '#FFF3E0', '#FF9800'),
    new LogItemModel('Admin Login: root', '09:15 AM', '●', '#E3F2FD', '#2196F3'),
    new LogItemModel('Backup Completed', '04:00 AM', 'i', '#E8F5E9', '#4CAF50')
  ];

  @Builder
  TopBar() {
    Row() {
      Text('≡')
        .fontSize(24)
        .fontColor('#000000')
        .width(44)
        .textAlign(TextAlign.Center)
      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
      Stack({ alignContent: Alignment.TopEnd }) {
        Text('!')
          .fontSize(22)
          .fontColor('#000000')
          .width(44)
          .height(44)
          .textAlign(TextAlign.Center)
        Circle()
          .width(10)
          .height(10)
          .fill('#FF0000')
      }
      .width(44)
      .height(44)
    }
    .width('100%')
    .padding({ top: 48, bottom: 16, left: 24, right: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  StatBadge(label: string, value: string) {
    Column() {
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
      Text(label)
        .fontSize(12)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  HeroStatus() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Circle().width(100).height(100).fill('#FFFFFF')
        Circle().width(84).height(84).fill('#E8F5E9')
        Text('✓')
          .fontSize(48)
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
        .fontColor('#808080')
        .margin({ top: 4 })

      Row() {
        this.StatBadge('CPU', '12%')
        this.StatBadge('RAM', '4.2GB')
        this.StatBadge('NET', '1Gbps')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: 24 })
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F5F7FA')
    .borderRadius(24)
    .margin({ top: 16, bottom: 16 })
  }

  @Builder
  ActionButton(item: ActionItem) {
    Column() {
      Text(item.icon)
        .fontSize(28)
        .fontColor(item.iconColor)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(64)
        .lineHeight(64)
        .backgroundColor(item.color)
        .borderRadius(16)
      Text(item.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 8 })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  LogItem(log: LogItemModel) {
    Row() {
      Text(log.icon)
        .fontSize(20)
        .fontColor(log.iconTint)
        .textAlign(TextAlign.Center)
        .width(40)
        .height(40)
        .lineHeight(40)
        .backgroundColor(log.typeColor)
        .borderRadius(20)
      Text(log.title)
        .fontSize(14)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#000000')
        .layoutWeight(1)
        .margin({ left: 16 })
      Text(log.time)
        .fontSize(12)
        .fontColor('#808080')
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
  }

  build() {
    Column() {
      this.TopBar()
      Scroll() {
        Column() {
          this.HeroStatus()

          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
            .margin({ bottom: 16 })

          Row({ space: 16 }) {
            ForEach(this.actions, (item: ActionItem) => {
              this.ActionButton(item)
            })
          }
          .width('100%')

          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Text('View All')
              .fontSize(14)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#2196F3')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: 32, bottom: 8 })

          Column({ space: 12 }) {
            ForEach(this.logs, (log: LogItemModel) => {
              this.LogItem(log)
            })
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
