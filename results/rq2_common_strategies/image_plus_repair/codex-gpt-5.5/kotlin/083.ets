const BLACK: string = '#000000';
const WHITE: string = '#FFFFFF';
const MUTED: string = '#8A8A8A';
const BLUE: string = '#2196F3';

interface LogEntry {
  icon: string;
  title: string;
  time: string;
  background: string;
  iconColor: string;
}

@Entry
@Component
struct Index {
  private logs: LogEntry[] = [
    {
      icon: '!',
      title: 'High Memory Usage',
      time: '10:42 AM',
      background: '#FFF3E0',
      iconColor: '#FF9800'
    },
    {
      icon: '●',
      title: 'Admin Login: root',
      time: '09:15 AM',
      background: '#E3F2FD',
      iconColor: '#2196F3'
    },
    {
      icon: 'i',
      title: 'Backup Completed',
      time: '04:00 AM',
      background: '#E8F5E9',
      iconColor: '#4CAF50'
    }
  ];

  @Builder
  header(): void {
    Row() {
      Text('☰')
        .fontSize(32)
        .fontColor(BLACK)
        .fontWeight(FontWeight.Bold)
        .width(52)
        .textAlign(TextAlign.Center)
        .onClick(() => {});

      Text('NodeLink')
        .fontSize(30)
        .fontColor(BLACK)
        .fontWeight(FontWeight.Bold);

      Stack() {
        Text('♟')
          .fontSize(32)
          .fontColor(BLACK)
          .width(52)
          .textAlign(TextAlign.Center);
        Text('●')
          .fontSize(25)
          .fontColor('#FF0000')
          .position({ x: 34, y: -12 });
      }
      .width(52)
      .height(52)
      .alignContent(Alignment.Center)
      .onClick(() => {});
    }
    .width('100%')
    .height(112)
    .padding({ left: 24, right: 24, top: 42, bottom: 18 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  statusCard(): void {
    Column() {
      Stack() {
        Circle()
          .width(100)
          .height(100)
          .fill(WHITE);
        Circle()
          .width(84)
          .height(84)
          .fill('#E8F5E9');
        Text('✓')
          .fontSize(62)
          .fontColor('#4CAF50')
          .fontWeight(FontWeight.Bold);
      }
      .width(100)
      .height(100)
      .margin({ top: 0, bottom: 16 });

      Text('System Operational')
        .fontSize(30)
        .fontColor(BLACK)
        .fontWeight(FontWeight.Bold);

      Text('Uptime: 14d 2h 15m')
        .fontSize(22)
        .fontColor(MUTED)
        .margin({ top: 4 });

      Row() {
        this.statBadge('12%', 'CPU');
        this.statBadge('4.2GB', 'RAM');
        this.statBadge('1Gbps', 'NET');
      }
      .width('100%')
      .margin({ top: 24 })
      .justifyContent(FlexAlign.SpaceEvenly);
    }
    .width('100%')
    .padding({ top: 48, bottom: 54, left: 24, right: 24 })
    .backgroundColor('#F5F7FA')
    .borderRadius(24)
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  statBadge(value: string, label: string): void {
    Column() {
      Text(value)
        .fontSize(24)
        .fontColor(BLACK)
        .fontWeight(FontWeight.Bold);
      Text(label)
        .fontSize(19)
        .fontColor(MUTED)
        .margin({ top: 14 });
    }
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  actionButton(icon: string, label: string, background: string, iconColor: string): void {
    Column() {
      Stack() {
        Text(icon)
          .fontSize(38)
          .fontColor(iconColor)
          .fontWeight(FontWeight.Bold);
      }
      .width('100%')
      .height(128)
      .backgroundColor(background)
      .borderRadius(18)
      .alignContent(Alignment.Center)
      .onClick(() => {});

      Text(label)
        .fontSize(21)
        .fontColor(BLACK)
        .margin({ top: 12 });
    }
    .layoutWeight(1)
    .margin({ right: label === 'Config' ? 0 : 8 })
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  logItem(entry: LogEntry): void {
    Row() {
      Stack() {
        Text(entry.icon)
          .fontSize(22)
          .fontColor(entry.iconColor)
          .fontWeight(FontWeight.Bold);
      }
      .width(48)
      .height(48)
      .backgroundColor(entry.background)
      .borderRadius(24)
      .alignContent(Alignment.Center);

      Column() {
        Text(entry.title)
          .fontSize(19)
          .fontColor(BLACK)
          .fontWeight(FontWeight.Medium);
      }
      .layoutWeight(1)
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start);

      Text(entry.time)
        .fontSize(16)
        .fontColor(MUTED);
    }
    .width('100%')
    .height(64)
    .alignItems(VerticalAlign.Center);
  }

  build(): void {
    Scroll() {
      Column() {
        this.header();

        Column() {
          this.statusCard();

          Text('Control Panel')
            .fontSize(30)
            .fontColor(BLACK)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .margin({ top: 64, bottom: 34 });

          Row() {
            this.actionButton('▶', 'Start', '#E3F2FD', '#2196F3');
            this.actionButton('↻', 'Reboot', '#FFF3E0', '#FF9800');
            this.actionButton('▣', 'Lock', '#FFEBEE', '#F44336');
            this.actionButton('⚙', 'Config', '#F3E5F5', '#9C27B0');
          }
          .width('100%');

          Row() {
            Text('Recent Logs')
              .fontSize(30)
              .fontColor(BLACK)
              .fontWeight(FontWeight.Bold);
            Text('View All')
              .fontSize(22)
              .fontColor(BLUE)
              .fontWeight(FontWeight.Bold)
              .onClick(() => {});
          }
          .width('100%')
          .margin({ top: 76, bottom: 18 })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center);

          ForEach(this.logs, (entry: LogEntry) => {
            this.logItem(entry);
          }, (entry: LogEntry) => entry.title);
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 32 });
      }
      .width('100%')
      .backgroundColor(WHITE);
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off);
  }
}
