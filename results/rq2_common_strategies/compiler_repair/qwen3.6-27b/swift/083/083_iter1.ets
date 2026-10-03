import { window } from '@kit.ArkUI';

@Entry
@Component
struct ServerStatusApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ContentView {
  build() {
    Column() {
      ServerStatusScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ServerStatusScreen {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        // Top Bar
        TopBar()
          .padding({ top: 48, left: 24, right: 24, bottom: 16 })

        Scroll() {
          Column({ space: 0 }) {
            // Hero Status Section
            HeroStatusCard()
              .padding({ top: 16, bottom: 16 })

            Divider().margin({ bottom: 16 }).visibility(Visibility.Hidden) // Spacer equivalent

            // Quick Actions Grid
            Text("Control Panel")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .alignSelf(ItemAlign.Start)
              .margin({ bottom: 16 })

            Row({ space: 16 }) {
              ActionButton({
                iconName: "play.fill",
                label: "Start",
                color: Color('#E3F2FD'),
                iconColor: Color('#2196F3')
              })
              ActionButton({
                iconName: "arrow.clockwise",
                label: "Reboot",
                color: Color('#FFF3E0'),
                iconColor: Color('#FF9800')
              })
              ActionButton({
                iconName: "lock.fill",
                label: "Lock",
                color: Color('#FFEBEE'),
                iconColor: Color('#F44336')
              })
              ActionButton({
                iconName: "gearshape.fill",
                label: "Config",
                color: Color('#F3E5F5'),
                iconColor: Color('#9C27B0')
              })
            }
            .width('100%')

            Divider().margin({ top: 32, bottom: 0 }).visibility(Visibility.Hidden) // Spacer equivalent

            // Recent Logs Header
            Row() {
              Text("Recent Logs")
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
              Blank()
              Button("View All")
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color('#2196F3'))
                .backgroundColor(Color.Transparent)
                .borderWidth(0)
            }
            .width('100%')

            Divider().margin({ top: 8, bottom: 0 }).visibility(Visibility.Hidden) // Spacer equivalent

            // Recent Logs List
            Column({ space: 12 }) {
              LogItem({
                iconName: "exclamationmark.triangle.fill",
                title: "High Memory Usage",
                time: "10:42 AM",
                typeColor: Color('#FFF3E0'),
                iconTint: Color('#FF9800')
              })
              LogItem({
                iconName: "person.fill",
                title: "Admin Login: root",
                time: "09:15 AM",
                typeColor: Color('#E3F2FD'),
                iconTint: Color('#2196F3')
              })
              LogItem({
                iconName: "info.circle.fill",
                title: "Backup Completed",
                time: "04:00 AM",
                typeColor: Color('#E8F5E9'),
                iconTint: Color('#4CAF50')
              })
            }
            .padding({ bottom: 16 })
          }
          .padding({ left: 24, right: 24 })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct TopBar {
  build() {
    Row() {
      Button() {
        Image($r('app.media.menu_icon')) // Placeholder for systemName: "line.3.horizontal"
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .backgroundColor(Color.Transparent)
      
      Blank()
      
      Text("NodeLink")
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      
      Blank()
      
      Stack({ alignContent: Alignment.TopEnd }) {
        Button() {
          Image($r('app.media.bell_icon')) // Placeholder for systemName: "bell.fill"
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .backgroundColor(Color.Transparent)
        
        Circle()
          .fill(Color.Red)
          .width(10)
          .height(10)
          .offset({ x: -2, y: 2 })
      }
    }
    .width('100%')
  }
}

@Component
struct HeroStatusCard {
  build() {
    Column() {
      Column() {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .fill(Color.White)
            .width(100)
            .height(100)
          
          Stack({ alignContent: Alignment.Center }) {
            Circle()
              .fill(Color('#E8F5E9'))
              .width(84)
              .height(84)
            
            Image($r('app.media.checkmark_icon')) // Placeholder for systemName: "checkmark"
              .width(40)
              .height(40)
              .fillColor(Color('#4CAF50'))
          }
        }
        
        Divider().margin({ top: 16, bottom: 0 }).visibility(Visibility.Hidden)
        
        Text("System Operational")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        
        Text("Uptime: 14d 2h 15m")
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ top: 4 })
        
        Divider().margin({ top: 24, bottom: 0 }).visibility(Visibility.Hidden)
        
        Row({ space: 0 }) {
          StatBadge({ label: "CPU", value: "12%" })
            .layoutWeight(1)
          StatBadge({ label: "RAM", value: "4.2GB" })
            .layoutWeight(1)
          StatBadge({ label: "NET", value: "1Gbps" })
            .layoutWeight(1)
        }
        .width('100%')
      }
      .padding(24)
    }
    .backgroundColor(Color('#F5F7FA'))
    .borderRadius(24)
  }
}

@Component
struct StatBadge {
  @Prop label: string
  @Prop value: string

  build() {
    Column({ space: 2 }) {
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Text(this.label)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
  }
}

@Component
struct ActionButton {
  @Prop iconName: string
  @Prop label: string
  @Prop color: Color
  @Prop iconColor: Color

  build() {
    Column() {
      Button() {
        Stack({ alignContent: Alignment.Center }) {
          Rectangle()
            .width('100%')
            .height(64)
            .fill(this.color)
            .borderRadius(16)
          
          Image($r('app.media.action_icon')) // Placeholder for dynamic systemName
            .width(24)
            .height(24)
            .fillColor(this.iconColor)
        }
      }
      .backgroundColor(Color.Transparent)
      .borderWidth(0)
      
      Divider().margin({ top: 8, bottom: 0 }).visibility(Visibility.Hidden)
      
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .layoutWeight(1)
  }
}

@Component
struct LogItem {
  @Prop iconName: string
  @Prop title: string
  @Prop time: string
  @Prop typeColor: Color
  @Prop iconTint: Color

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .fill(this.typeColor)
          .width(40)
          .height(40)
        
        Image($r('app.media.log_icon')) // Placeholder for dynamic systemName
          .width(16)
          .height(16)
          .fillColor(this.iconTint)
      }
      
      Divider().margin({ left: 16, right: 0 }).visibility(Visibility.Hidden)
      
      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
      
      Blank()
      
      Text(this.time)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .backgroundColor(Color.White)
  }
}