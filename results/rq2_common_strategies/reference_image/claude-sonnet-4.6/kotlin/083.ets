// entry/src/main/ets/pages/Index.ets
interface LogEntry {
  symbol: Resource;
  title: string;
  time: string;
  bg: string;
  tint: string;
}

const COLOR_BLUE: string = '#2196F3';
const COLOR_GREEN: string = '#4CAF50';
const COLOR_ORANGE: string = '#FF9800';
const COLOR_RED: string = '#F44336';
const COLOR_PURPLE: string = '#9C27B0';
const COLOR_GREY: string = '#9E9E9E';
const COLOR_BLACK: string = '#000000';
const COLOR_WHITE: string = '#FFFFFF';
const COLOR_CARD: string = '#F5F7FA';

@Entry
@Component
struct ServerStatusPage {
  private logs: LogEntry[] = [
    {
      symbol: $r('sys.symbol.exclamationmark_triangle_fill'),
      title: 'High Memory Usage',
      time: '10:42 AM',
      bg: '#FFF3E0',
      tint: COLOR_ORANGE
    },
    {
      symbol: $r('sys.symbol.person_fill'),
      title: 'Admin Login: root',
      time: '09:15 AM',
      bg: '#E3F2FD',
      tint: COLOR_BLUE
    },
    {
      symbol: $r('sys.symbol.info_circle'),
      title: 'Backup Completed',
      time: '04:00 AM',
      bg: '#E8F5E9',
      tint: COLOR_GREEN
    }
  ];

  @Builder
  TopBar() {
    Row() {
      SymbolGlyph($r('sys.symbol.line_3_horizontal'))
        .fontSize(26)
        .fontColor([COLOR_BLACK])
        .onClick(() => {
        })

      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_BLACK)

      Stack({ alignContent: Alignment.TopEnd }) {
        SymbolGlyph($r('sys.symbol.bell'))
          .fontSize(24)
          .fontColor([COLOR_BLACK])
          .onClick(() => {
          })

        Circle({ width: 10, height: 10 })
          .fill(COLOR_RED)
          .margin({ top: 2, right: 2 })
      }
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 48, bottom: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  StatBadge(value: string, label: string) {
    Column() {
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_BLACK)

      Text(label)
        .fontSize(12)
        .fontColor(COLOR_GREY)
        .margin({ top: 2 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  HeroStatusCard() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Stack({ alignContent: Alignment.Center }) {
          SymbolGlyph($r('sys.symbol.checkmark'))
            .fontSize(44)
            .fontColor([COLOR_GREEN])
        }
        .width(84)
        .height(84)
        .borderRadius(42)
        .backgroundColor('#E8F5E9')
      }
      .width(100)
      .height(100)
      .borderRadius(50)
      .backgroundColor(COLOR_WHITE)

      Text('System Operational')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_BLACK)
        .margin({ top: 16 })

      Text('Uptime: 14d 2h 15m')
        .fontSize(14)
        .fontColor(COLOR_GREY)
        .margin({ top: 4 })

      Row() {
        this.StatBadge('12%', 'CPU')
        this.StatBadge('4.2GB', 'RAM')
        this.StatBadge('1Gbps', 'NET')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: 24 })
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(COLOR_CARD)
    .borderRadius(24)
    .margin({ top: 16, bottom: 16 })
  }

  @Builder
  ActionButton(symbol: Resource, label: string, bg: string, tint: string) {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        SymbolGlyph(symbol)
          .fontSize(26)
          .fontColor([tint])
      }
      .width('100%')
      .height(64)
      .borderRadius(16)
      .backgroundColor(bg)
      .onClick(() => {
      })

      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_BLACK)
        .margin({ top: 8 })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  LogItem(symbol: Resource, title: string, time: string, bg: string, tint: string) {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        SymbolGlyph(symbol)
          .fontSize(20)
          .fontColor([tint])
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(bg)

      Text(title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_BLACK)
        .layoutWeight(1)
        .margin({ left: 16 })

      Text(time)
        .fontSize(12)
        .fontColor(COLOR_GREY)
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          this.HeroStatusCard()

          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_BLACK)
            .margin({ bottom: 16 })

          Row({ space: 16 }) {
            this.ActionButton($r('sys.symbol.play_fill'), 'Start', '#E3F2FD', COLOR_BLUE)
            this.ActionButton($r('sys.symbol.arrow_clockwise'), 'Reboot', '#FFF3E0', COLOR_ORANGE)
            this.ActionButton($r('sys.symbol.lock_fill'), 'Lock', '#FFEBEE', COLOR_RED)
            this.ActionButton($r('sys.symbol.gearshape'), 'Config', '#F3E5F5', COLOR_PURPLE)
          }
          .width('100%')

          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLOR_BLACK)

            Text('View All')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_BLUE)
              .onClick(() => {
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: 32, bottom: 8 })

          Column({ space: 12 }) {
            ForEach(this.logs, (item: LogEntry) => {
              this.LogItem(item.symbol, item.title, item.time, item.bg, item.tint)
            }, (item: LogEntry) => item.title)
          }
          .width('100%')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_WHITE)
  }
}