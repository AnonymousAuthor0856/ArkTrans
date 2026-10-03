import { router } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

// Define data structures for the UI components
interface LogItemData {
  title: string;
  time: string;
  typeColor: string;
  iconTint: string;
  iconType: IconType;
}

enum IconType {
  WARNING,
  PERSON,
  INFO,
  CHECK,
  MENU,
  NOTIFICATIONS,
  PLAY_ARROW,
  REFRESH,
  LOCK,
  SETTINGS
}

@Entry
@Component
struct ServerStatusPage {
  @State logs: LogItemData[] = [
    {
      title: 'High Memory Usage',
      time: '10:42 AM',
      typeColor: '#FFF3E0',
      iconTint: '#FF9800',
      iconType: IconType.WARNING
    },
    {
      title: 'Admin Login: root',
      time: '09:15 AM',
      typeColor: '#E3F2FD',
      iconTint: '#2196F3',
      iconType: IconType.PERSON
    },
    {
      title: 'Backup Completed',
      time: '04:00 AM',
      typeColor: '#E8F5E9',
      iconTint: '#4CAF50',
      iconType: IconType.INFO
    }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Button('', { type: ButtonType.Circle })
          .width(40)
          .height(40)
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            // Menu action
          })
          .stateEffect(false)
          .borderWidth(0)
          .margin({ right: 'auto' })
        
        Image($r('app.media.ic_menu')) // Placeholder for menu icon
          .width(24)
          .height(24)
          .fillColor(Color.Black)
        
        Text('NodeLink')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 16, right: 16 })
        
        Stack() {
          Button('', { type: ButtonType.Circle })
            .width(40)
            .height(40)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              // Notification action
            })
            .stateEffect(false)
            .borderWidth(0)
          
          Image($r('app.media.ic_notifications')) // Placeholder for notification icon
            .width(24)
            .height(24)
            .fillColor(Color.Black)
            
          Circle()
            .width(10)
            .height(10)
            .fill(Color.Red)
            .position({ x: 28, y: 6 })
        }
      }
      .width('100%')
      .padding({ top: 48, bottom: 16, left: 24, right: 24 })
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          // Hero Status Section
          Card() {
            Column() {
              // Status Indicator
              Stack() {
                Circle()
                  .width(100)
                  .height(100)
                  .fill(Color.White)
                
                Circle()
                  .width(84)
                  .height(84)
                  .fill('#E8F5E9')
                  
                Image($r('app.media.ic_check')) // Placeholder for check icon
                  .width(48)
                  .height(48)
                  .fillColor('#4CAF50')
              }
              
              Text('System Operational')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .margin({ top: 16 })
                
              Text('Uptime: 14d 2h 15m')
                .fontSize(14)
                .fontColor(Color.Gray)
                .margin({ top: 4 })
                
              Row() {
                StatBadgeComponent('CPU', '12%')
                StatBadgeComponent('RAM', '4.2GB')
                StatBadgeComponent('NET', '1Gbps')
              }
              .justifyContent(FlexAlign.SpaceEvenly)
              .width('100%')
              .margin({ top: 24 })
            }
            .padding(24)
            .alignItems(HorizontalAlign.Center)
          }
          .width('100%')
          .backgroundColor('#F5F7FA')
          .borderRadius(24)
          .margin({ vertical: 16 })

          // Control Panel
          Text('Control Panel')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ bottom: 16 })
            
          Row() {
            ActionButtonComponent(IconType.PLAY_ARROW, 'Start', '#E3F2FD', '#2196F3')
            ActionButtonComponent(IconType.REFRESH, 'Reboot', '#FFF3E0', '#FF9800')
            ActionButtonComponent(IconType.LOCK, 'Lock', '#FFEBEE', '#F44336')
            ActionButtonComponent(IconType.SETTINGS, 'Config', '#F3E5F5', '#9C27B0')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          
          // Recent Logs Header
          Row() {
            Text('Recent Logs')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
            
            Text('View All')
              .fontSize(14)
              .fontColor('#2196F3')
              .fontWeight(FontWeight.SemiBold)
              .onClick(() => {
                // View all logs action
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: 32, bottom: 8 })
          
          // Logs List
          List({ space: 12 }) {
            ForEach(this.logs, (log: LogItemData) => {
              ListItem() {
                LogItemComponent(log)
              }
            })
          }
          .width('100%')
          .layoutWeight(1)
        }
        .padding({ horizontal: 24 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct StatBadgeComponent {
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
struct ActionButtonComponent {
  @Prop iconType: IconType;
  @Prop label: string;
  @Prop bgColor: string;
  @Prop iconColor: string;

  build() {
    Column() {
      Button('', { type: ButtonType.Capsule })
        .width('100%')
        .height(64)
        .backgroundColor(this.bgColor)
        .borderRadius(16)
        .onClick(() => {
          // Action button click
        })
        .stateEffect(false)
        .borderWidth(0)
        .contentPosition({ align: HorizontalAlign.Center, verticalAlign: VerticalAlign.Center })
        .child(Image(this.getIconResource()))
          .width(28)
          .height(28)
          .fillColor(this.iconColor)
      
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 8 })
    }
    .width('22%')
  }

  getIconResource(): Resource {
    switch (this.iconType) {
      case IconType.PLAY_ARROW:
        return $r('app.media.ic_play_arrow');
      case IconType.REFRESH:
        return $r('app.media.ic_refresh');
      case IconType.LOCK:
        return $r('app.media.ic_lock');
      case IconType.SETTINGS:
        return $r('app.media.ic_settings');
      default:
        return $r('app.media.ic_play_arrow');
    }
  }
}

@Component
struct LogItemComponent {
  @Prop log: LogItemData;

  build() {
    Row() {
      Stack() {
        Circle()
          .width(40)
          .height(40)
          .fill(this.log.typeColor)
        
        Image(this.getLogIconResource())
          .width(20)
          .height(20)
          .fillColor(this.log.iconTint)
      }
      
      Text(this.log.title)
        .fontSize(14)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)
        .margin({ left: 16, right: 'auto' })
        
      Text(this.log.time)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .padding({ vertical: 4 })
    .alignItems(VerticalAlign.Center)
  }

  getLogIconResource(): Resource {
    switch (this.log.iconType) {
      case IconType.WARNING:
        return $r('app.media.ic_warning');
      case IconType.PERSON:
        return $r('app.media.ic_person');
      case IconType.INFO:
        return $r('app.media.ic_info');
      default:
        return $r('app.media.ic_info');
    }
  }
}