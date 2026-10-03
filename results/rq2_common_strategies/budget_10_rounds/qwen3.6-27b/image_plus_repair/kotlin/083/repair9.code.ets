import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

@Entry
@Component
struct ServerStatusScreen {
  @State statusBarHeight: number = 0;

  aboutToAppear() {
    // Get status bar height to adjust top padding
    let context = getContext(this) as common.UIAbilityContext;
    try {
      let windowManager: window.WindowManager = window.getDefaultWindowSync(context);
      let windowClass: window.WindowInfo = windowManager.getWindowInfo();
      this.statusBarHeight = windowClass.getStatusBarHeight();
    } catch (e) {
      console.error("Failed to get window info", e);
      this.statusBarHeight = 24; // Fallback
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        // Menu Icon (Placeholder)
        Image($r('app.media.ic_menu'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .onClick(() => {
            // Handle menu click
          })

        Text("NodeLink")
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 16 })

        Blank()

        // Notification Icon with Badge
        Stack() {
          Image($r('app.media.ic_notifications'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .onClick(() => {
              // Handle notification click
            })

          Circle({ width: 10, height: 10 })
            .fill(Color.Red)
            .position({ x: 18, y: 2 })
        }
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: this.statusBarHeight + 16, bottom: 16 })

      // Main Content
      Scroll() {
        Column() {
          // Hero Status Section
          Column() {
            // Status Icon
            Stack() {
              Circle({ width: 100, height: 100 })
                .fill(Color.White)

              Circle({ width: 84, height: 84 })
                .fill('#E8F5E9') // Light Green

              Image($r('app.media.ic_check'))
                .width(48)
                .height(48)
                .objectFit(ImageFit.Contain)
                .fillColor('#4CAF50')
            }

            Text("System Operational")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ top: 16 })

            Text("Uptime: 14d 2h 15m")
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ top: 4 })

            // Stats Row
            Row() {
              StatBadge({ label: "CPU", value: "12%" })
              StatBadge({ label: "RAM", value: "4.2GB" })
              StatBadge({ label: "NET", value: "1Gbps" })
            }
            .justifyContent(FlexAlign.SpaceEvenly)
            .width('100%')
            .margin({ top: 24 })
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#F5F7FA')
          .borderRadius(24)
          .margin({ top: 16, bottom: 16 })

          // Control Panel
          Text("Control Panel")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ bottom: 16 })

          Row() {
            ActionButton({ icon: $r('app.media.ic_play_arrow'), label: "Start", color: '#E3F2FD', iconColor: '#2196F3' })
            ActionButton({ icon: $r('app.media.ic_refresh'), label: "Reboot", color: '#FFF3E0', iconColor: '#FF9800' })
            ActionButton({ icon: $r('app.media.ic_lock'), label: "Lock", color: '#FFEBEE', iconColor: '#F44336' })
            ActionButton({ icon: $r('app.media.ic_settings'), label: "Config", color: '#F3E5F5', iconColor: '#9C27B0' })
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          .margin({ bottom: 32 })

          // Recent Logs Header
          Row() {
            Text("Recent Logs")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)

            Blank()

            Text("View All")
              .fontSize(14)
              .fontColor('#2196F3')
              .fontWeight(FontWeight.Medium)
              .onClick(() => {
                // Handle view all logs
              })
          }
          .width('100%')
          .margin({ bottom: 8 })

          // Recent Logs List
          LogItem({ icon: $r('app.media.ic_warning'), title: "High Memory Usage", time: "10:42 AM", typeColor: '#FFF3E0', iconTint: '#FF9800' })
          LogItem({ icon: $r('app.media.ic_person'), title: "Admin Login: root", time: "09:15 AM", typeColor: '#E3F2FD', iconTint: '#2196F3' })
          LogItem({ icon: $r('app.media.ic_info'), title: "Backup Completed", time: "04:00 AM", typeColor: '#E8F5E9', iconTint: '#4CAF50' })
        }
        .padding({ left: 24, right: 24, bottom: 16 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct StatBadge {
  @Prop label: string;
  @Prop value: string;

  build() {
    Column() {
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      Text(this.label)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ActionButton {
  @Prop icon: Resource;
  @Prop label: string;
  @Prop color: string;
  @Prop iconColor: string;

  build() {
    Column() {
      Image(this.icon)
        .width(28)
        .height(28)
        .objectFit(ImageFit.Contain)
        .fillColor(this.iconColor)
        .onClick(() => {
          // Handle action button click
        })
      
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
    .width('100%')
    .height(64)
    .backgroundColor(this.color)
    .borderRadius(16)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct LogItem {
  @Prop icon: Resource;
  @Prop title: string;
  @Prop time: string;
  @Prop typeColor: string;
  @Prop iconTint: string;

  build() {
    Row() {
      Stack() {
        Circle({ width: 40, height: 40 })
          .fill(this.typeColor)

        Image(this.icon)
          .width(20)
          .height(20)
          .objectFit(ImageFit.Contain)
          .fillColor(this.iconTint)
      }

      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ left: 16 })
        .layoutWeight(1)

      Text(this.time)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
    .margin({ bottom: 12 })
  }
}