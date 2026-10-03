// index.ets
import { EntryComponent, Component, VNode, ForEach, Column, Row, Text, Image, Stack, ScrollView, Button, Space } from '@ohos.arkui.ets';

@Entry
@Component
struct ServerStatusApp {
  build(): VNode {
    Column() {
      ServerStatusScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct ServerStatusScreen {
  build(): VNode {
    Column() {
      // Top Bar
      TopBar()
        .padding({ top: 48, left: 24, right: 24, bottom: 16 })

      // Scrollable Content
      ScrollView() {
        Column() {
          // Hero Status Section
          HeroStatusCard()
            .padding({ top: 16, bottom: 16 })

          // Control Panel Title
          Text("Control Panel")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .margin({ bottom: 16 })

          // Quick Actions Grid
          Row() {
            ActionButton({
              iconResource: $r('sys.media.ohos_ic_public_play'),
              label: "Start",
              color: '#E3F2FD',
              iconColor: '#2196F3'
            })
            ActionButton({
              iconResource: $r('sys.media.ohos_ic_public_reload'),
              label: "Reboot",
              color: '#FFF3E0',
              iconColor: '#FF9800'
            })
            ActionButton({
              iconResource: $r('sys.media.ohos_ic_public_lock'),
              label: "Lock",
              color: '#FFEBEE',
              iconColor: '#F44336'
            })
            ActionButton({
              iconResource: $r('sys.media.ohos_ic_public_settings'),
              label: "Config",
              color: '#F3E5F5',
              iconColor: '#9C27B0'
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          // Recent Logs Header
          Row() {
            Text("Recent Logs")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Blank()
            Button("View All")
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#2196F3')
              .backgroundColor(Color.Transparent)
              .padding(0)
          }
          .width('100%')
          .margin({ top: 32, bottom: 8 })

          // Recent Logs List
          Column() {
            LogItem({
              iconResource: $r('sys.media.ohos_ic_public_warn'),
              title: "High Memory Usage",
              time: "10:42 AM",
              typeColor: '#FFF3E0',
              iconTint: '#FF9800'
            })
            LogItem({
              iconResource: $r('sys.media.ohos_ic_user_public'),
              title: "Admin Login: root",
              time: "09:15 AM",
              typeColor: '#E3F2FD',
              iconTint: '#2196F3'
            })
            LogItem({
              iconResource: $r('sys.media.ohos_ic_public_info'),
              title: "Backup Completed",
              time: "04:00 AM",
              typeColor: '#E8F5E9',
              iconTint: '#4CAF50'
            })
          }
          .width('100%')
          .padding({ bottom: 16 })
        }
        .padding({ left: 24, right: 24 })
        .alignItems(HorizontalAlign.Start)
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
struct TopBar {
  build(): VNode {
    Row() {
      Button() {
        Image($r('sys.media.ohos_ic_public_sort'))
          .width(24)
          .height(24)
          .fillColor('#000000')
      }
      .backgroundColor(Color.Transparent)
      .padding(0)

      Blank()

      Text("NodeLink")
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Blank()

      Stack({ alignContent: Alignment.TopEnd }) {
        Button() {
          Image($r('sys.media.ohos_ic_public_notice'))
            .width(24)
            .height(24)
            .fillColor('#000000')
        }
        .backgroundColor(Color.Transparent)
        .padding(0)

        Circle()
          .fill(Color.Red)
          .width(10)
          .height(10)
          .margin({ top: -2, right: -2 })
      }
      .width(24)
      .height(24)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct HeroStatusCard {
  build(): VNode {
    Column() {
      Stack() {
        Circle()
          .fill('#FFFFFF')
          .width(100)
          .height(100)

        Circle()
          .fill('#E8F5E9')
          .width(84)
          .height(84)

        Text("✓")
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4CAF50')
      }
      .width(100)
      .height(100)

      Text("System Operational")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .margin({ top: 16 })

      Text("Uptime: 14d 2h 15m")
        .fontSize(14)
        .fontColor('#808080')
        .margin({ top: 4 })

      Row() {
        StatBadge({ label: "CPU", value: "12%" })
          .layoutWeight(1)
        StatBadge({ label: "RAM", value: "4.2GB" })
          .layoutWeight(1)
        StatBadge({ label: "NET", value: "1Gbps" })
          .layoutWeight(1)
      }
      .width('100%')
      .margin({ top: 24 })
    }
    .padding(24)
    .backgroundColor('#F5F7FA')
    .borderRadius(24)
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StatBadge {
  @Prop label: string;
  @Prop value: string;

  build(): VNode {
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
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActionButton {
  @Prop iconResource: Resource;
  @Prop label: string;
  @Prop color: string;
  @Prop iconColor: string;

  build(): VNode {
    Column() {
      Button() {
        Stack() {
          Column()
            .backgroundColor(this.color)
            .height(64)
            .borderRadius(16)
            .width('100%')

          Image(this.iconResource)
            .width(24)
            .height(24)
            .fillColor(this.iconColor)
        }
        .width('100%')
        .height(64)
      }
      .padding(0)
      .backgroundColor(Color.Transparent)
      .margin({ bottom: 8 })

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
  @Prop iconResource: Resource;
  @Prop title: string;
  @Prop time: string;
  @Prop typeColor: string;
  @Prop iconTint: string;

  build(): VNode {
    Row() {
      Stack() {
        Circle()
          .fill(this.typeColor)
          .width(40)
          .height(40)

        Image(this.iconResource)
          .width(16)
          .height(16)
          .fillColor(this.iconTint)
      }
      .width(40)
      .height(40)

      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ left: 16 })

      Blank()

      Text(this.time)
        .fontSize(12)
        .fontColor('#808080')
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor('#FFFFFF')
    .alignItems(VerticalAlign.Center)
  }
}