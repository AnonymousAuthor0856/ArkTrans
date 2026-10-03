import { LengthMetrics } from '@kit.ArkUI';

interface LogItemData {
  icon: Resource;
  title: string;
  time: string;
  typeColor: string;
  iconTint: string;
}

interface ActionButtonData {
  icon: Resource;
  label: string;
  color: string;
  iconColor: string;
}

@Entry
@Component
struct ServerStatusScreen {
  private logItems: LogItemData[] = [
    {
      icon: $r('sys.symbol.exclamationmark_triangle'),
      title: 'High Memory Usage',
      time: '10:42 AM',
      typeColor: '#FFF3E0',
      iconTint: '#FF9800'
    },
    {
      icon: $r('sys.symbol.person'),
      title: 'Admin Login: root',
      time: '09:15 AM',
      typeColor: '#E3F2FD',
      iconTint: '#2196F3'
    },
    {
      icon: $r('sys.symbol.info_circle'),
      title: 'Backup Completed',
      time: '04:00 AM',
      typeColor: '#E8F5E9',
      iconTint: '#4CAF50'
    }
  ];

  private actionButtons: ActionButtonData[] = [
    {
      icon: $r('sys.symbol.play'),
      label: 'Start',
      color: '#E3F2FD',
      iconColor: '#2196F3'
    },
    {
      icon: $r('sys.symbol.arrow_clockwise'),
      label: 'Reboot',
      color: '#FFF3E0',
      iconColor: '#FF9800'
    },
    {
      icon: $r('sys.symbol.lock'),
      label: 'Lock',
      color: '#FFEBEE',
      iconColor: '#F44336'
    },
    {
      icon: $r('sys.symbol.gearshape'),
      label: 'Config',
      color: '#F3E5F5',
      iconColor: '#9C27B0'
    }
  ];

  @Builder
  TopBar() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        SymbolGlyph($r('sys.symbol.list_bullet'))
          .fontSize(22)
          .fontColor(['#000000'])
      }
      .backgroundColor(Color.Transparent)
      .width(44)
      .height(44)

      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Stack({ alignContent: Alignment.TopEnd }) {
        Button({ type: ButtonType.Circle }) {
          SymbolGlyph($r('sys.symbol.bell'))
            .fontSize(22)
            .fontColor(['#000000'])
        }
        .backgroundColor(Color.Transparent)
        .width(44)
        .height(44)

        Circle()
          .width(10)
          .height(10)
          .fill('#FF0000')
          .offset({ x: 2, y: 2 })
      }
      .width(44)
      .height(44)
    }
    .width('100%')
    .padding({
      top: 48,
      bottom: 16,
      left: 24,
      right: 24
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  HeroStatusSection() {
    Column() {
      Stack() {
        Circle()
          .width(100)
          .height(100)
          .fill('#FFFFFF')

        Circle()
          .width(84)
          .height(84)
          .fill('#E8F5E9')

        SymbolGlyph($r('sys.symbol.checkmark'))
          .fontSize(48)
          .fontColor(['#4CAF50'])
      }
      .width(100)
      .height(100)

      Blank().height(16)

      Text('System Operational')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Text('Uptime: 14d 2h 15m')
        .fontSize(14)
        .fontColor('#808080')
        .margin({ top: 4 })

      Blank().height(24)

      Row() {
        this.StatBadge('CPU', '12%')
        this.StatBadge('RAM', '4.2GB')
        this.StatBadge('NET', '1Gbps')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F5F7FA')
    .borderRadius(24)
    .margin({ top: 16, bottom: 16 })
  }

  @Builder
  StatBadge(label: string, value: string) {
    Column() {
      Text(value)
        .fontWeight(FontWeight.Bold)
        .fontSize(16)
        .fontColor('#000000')
      Text(label)
        .fontSize(12)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActionButtonItem(item: ActionButtonData) {
    Column() {
      Stack() {
        SymbolGlyph(item.icon)
          .fontSize(28)
          .fontColor([item.iconColor])
      }
      .width('100%')
      .height(64)
      .backgroundColor(item.color)
      .borderRadius(16)
      .onClick(() => {
      })

      Blank().height(8)

      Text(item.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ControlPanel() {
    Text('Control Panel')
      .fontSize(18)
      .fontWeight(FontWeight.Bold)
      .fontColor('#000000')
      .margin({ bottom: 16 })
      .width('100%')

    Row({ space: 16 }) {
      ForEach(this.actionButtons, (item: ActionButtonData) => {
        this.ActionButtonItem(item)
      })
    }
    .width('100%')
  }

  @Builder
  LogItemView(item: LogItemData) {
    Row() {
      Stack() {
        Circle()
          .width(40)
          .height(40)
          .fill(item.typeColor)
        SymbolGlyph(item.icon)
          .fontSize(20)
          .fontColor([item.iconTint])
      }
      .width(40)
      .height(40)

      Blank().width(16)

      Column() {
        Text(item.title)
          .fontWeight(FontWeight.Bold)
          .fontSize(14)
          .fontColor('#000000')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text(item.time)
        .fontSize(12)
        .fontColor('#808080')
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .padding({ top: 4, bottom: 4 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  RecentLogs() {
    Row() {
      Text('Recent Logs')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Text('View All')
        .fontSize(14)
        .fontColor('#2196F3')
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)

    Blank().height(8)

    List({ space: 12 }) {
      ForEach(this.logItems, (item: LogItemData) => {
        ListItem() {
          this.LogItemView(item)
        }
      })
    }
    .width('100%')
    .padding({ bottom: 16 })
    .scrollBar(BarState.Off)
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          this.HeroStatusSection()

          Blank().height(16)

          this.ControlPanel()

          Blank().height(32)

          this.RecentLogs()
        }
        .padding({ left: 24, right: 24 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}