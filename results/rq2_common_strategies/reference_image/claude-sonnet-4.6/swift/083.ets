// Index.ets
// NodeLink – server status dashboard (SwiftUI ➜ ArkTS)

const COLOR_CARD_BG: string = '#F5F7FA';
const COLOR_GREEN_BG: string = '#E8F5E9';
const COLOR_GREEN: string = '#4CAF50';
const COLOR_BLUE_BG: string = '#E3F2FD';
const COLOR_BLUE: string = '#2196F3';
const COLOR_ORANGE_BG: string = '#FFF3E0';
const COLOR_ORANGE: string = '#FF9800';
const COLOR_RED_BG: string = '#FFEBEE';
const COLOR_RED: string = '#F44336';
const COLOR_PURPLE_BG: string = '#F3E5F5';
const COLOR_PURPLE: string = '#9C27B0';
const COLOR_TEXT_GRAY: string = '#9E9E9E';

/* ------------------------------- StatBadge ------------------------------- */

@Component
struct StatBadge {
  label: string = '';
  value: string = '';

  build() {
    Column({ space: 2 }) {
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text(this.label)
        .fontSize(12)
        .fontColor(COLOR_TEXT_GRAY)
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }
}

/* ------------------------------ ActionButton ----------------------------- */

@Component
struct ActionButton {
  icon: string = '';
  label: string = '';
  boxColor: string = '#FFFFFF';
  tint: string = '#000000';

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text(this.icon)
          .fontSize(24)
          .fontColor(this.tint)
      }
      .width('100%')
      .height(64)
      .backgroundColor(this.boxColor)
      .borderRadius(16)
      .onClick(() => {
      })

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 8 })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }
}

/* --------------------------------- LogItem ------------------------------- */

@Component
struct LogItem {
  icon: string = '';
  title: string = '';
  time: string = '';
  boxColor: string = '#FFFFFF';
  tint: string = '#000000';

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(40)
          .height(40)
          .fill(this.boxColor)

        Text(this.icon)
          .fontSize(16)
          .fontColor(this.tint)
      }
      .width(40)
      .height(40)

      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .layoutWeight(1)
        .margin({ left: 16 })

      Text(this.time)
        .fontSize(12)
        .fontColor(COLOR_TEXT_GRAY)
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 12 })
  }
}

/* ---------------------------------- TopBar ------------------------------- */

@Component
struct TopBar {
  build() {
    Row() {
      // Hamburger menu (three strokes)
      Column({ space: 5 }) {
        Row() {
        }
        .width(22)
        .height(2.5)
        .backgroundColor(Color.Black)
        .borderRadius(1.25)

        Row() {
        }
        .width(22)
        .height(2.5)
        .backgroundColor(Color.Black)
        .borderRadius(1.25)

        Row() {
        }
        .width(22)
        .height(2.5)
        .backgroundColor(Color.Black)
        .borderRadius(1.25)
      }
      .onClick(() => {
      })

      Blank()

      Text('NodeLink')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Blank()

      Stack({ alignContent: Alignment.TopEnd }) {
        Text('🔔')
          .fontSize(22)
          .fontColor(Color.Black)
          .onClick(() => {
          })

        Circle()
          .width(10)
          .height(10)
          .fill(COLOR_RED)
          .margin({ top: -2, right: -2 })
      }
      .width(28)
      .height(28)
    }
    .width('100%')
    .padding({ top: 48, bottom: 16, left: 24, right: 24 })
    .alignItems(VerticalAlign.Center)
  }
}

/* ------------------------------ HeroStatusCard --------------------------- */

@Component
struct HeroStatusCard {
  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(100)
          .height(100)
          .fill(Color.White)

        Circle()
          .width(84)
          .height(84)
          .fill(COLOR_GREEN_BG)

        Text('✓')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_GREEN)
      }
      .width(100)
      .height(100)

      Text('System Operational')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 16 })

      Text('Uptime: 14d 2h 15m')
        .fontSize(14)
        .fontColor(COLOR_TEXT_GRAY)
        .margin({ top: 4 })

      Row() {
        StatBadge({ label: 'CPU', value: '12%' })
        StatBadge({ label: 'RAM', value: '4.2GB' })
        StatBadge({ label: 'NET', value: '1Gbps' })
      }
      .width('100%')
      .margin({ top: 24 })
    }
    .width('100%')
    .padding(24)
    .backgroundColor(COLOR_CARD_BG)
    .borderRadius(24)
    .alignItems(HorizontalAlign.Center)
    .margin({ top: 16, bottom: 16 })
  }
}

/* ------------------------------ Screen / Entry --------------------------- */

@Entry
@Component
struct Index {
  build() {
    Column() {
      TopBar()

      Scroll() {
        Column() {
          HeroStatusCard()

          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ bottom: 16 })

          Row({ space: 16 }) {
            ActionButton({ icon: '▶', label: 'Start', boxColor: COLOR_BLUE_BG, tint: COLOR_BLUE })
            ActionButton({ icon: '↻', label: 'Reboot', boxColor: COLOR_ORANGE_BG, tint: COLOR_ORANGE })
            ActionButton({ icon: '🔒', label: 'Lock', boxColor: COLOR_RED_BG, tint: COLOR_RED })
            ActionButton({ icon: '⚙', label: 'Config', boxColor: COLOR_PURPLE_BG, tint: COLOR_PURPLE })
          }
          .width('100%')
          .margin({ bottom: 32 })

          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)

            Blank()

            Text('View All')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_BLUE)
              .onClick(() => {
              })
          }
          .width('100%')
          .margin({ bottom: 8 })

          LogItem({
            icon: '⚠',
            title: 'High Memory Usage',
            time: '10:42 AM',
            boxColor: COLOR_ORANGE_BG,
            tint: COLOR_ORANGE
          })

          LogItem({
            icon: '👤',
            title: 'Admin Login: root',
            time: '09:15 AM',
            boxColor: COLOR_BLUE_BG,
            tint: COLOR_BLUE
          })

          LogItem({
            icon: 'ⓘ',
            title: 'Backup Completed',
            time: '04:00 AM',
            boxColor: COLOR_GREEN_BG,
            tint: COLOR_GREEN
          })
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 16 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}