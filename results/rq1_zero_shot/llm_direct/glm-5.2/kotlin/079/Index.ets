// SmartHomeApp.ets
import { Length, ResourceStr } from '@ohos.arkui';

// Define the DeviceItem data structure
class DeviceItem {
  name: string;
  status: string;
  icon: Resource;
  isActive: boolean;

  constructor(name: string, status: string, icon: Resource, isActive: boolean) {
    this.name = name;
    this.status = status;
    this.icon = icon;
    this.isActive = isActive;
  }
}

// Theme Colors
const PRIMARY_COLOR = '#4A6572';
const BACKGROUND_COLOR = '#F5F6F8';
const SURFACE_COLOR = '#FFFFFF';
const ON_SURFACE_COLOR = '#333333';

@Entry
@Component
struct SmartHomeApp {
  private devices: DeviceItem[] = [
    new DeviceItem('Living Room', '2 Lights On', $r('sys.media.ohos_ic_public_home'), true),
    new DeviceItem('Smart Lock', 'Locked', $r('sys.media.ohos_ic_public_lock'), true),
    new DeviceItem('Bedroom AC', '22°C', $r('sys.media.ohos_ic_public_star'), false),
    new DeviceItem('Router', 'Online', $r('sys.media.ohos_ic_public_location'), true),
    new DeviceItem('Kitchen', 'All Off', $r('sys.media.ohos_ic_public_info'), false),
    new DeviceItem('Corridor', 'Motion Detected', $r('sys.media.ohos_ic_public_notifications'), true)
  ];

  build() {
    Column() {
      // Main Content Area
      Scroll() {
        Column() {
          Text('Welcome Home,')
            .fontSize(16)
            .fontColor('#888888')
            .margin({ top: 24 })

          Text('Alex Johnson')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(ON_SURFACE_COLOR)
            .margin({ top: 4 })

          // Environment Summary
          Row() {
            this.EnvironmentCard('Temperature', '24°C', 'Comfortable', '#E3F2FD', '#1565C0')
            this.EnvironmentCard('Humidity', '45%', 'Normal', '#E8F5E9', '#2E7D32')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ top: 32 })

          // Devices Section
          Text('My Devices')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(ON_SURFACE_COLOR)
            .margin({ top: 32, bottom: 16 })

          Grid() {
            ForEach(this.devices, (device: DeviceItem) => {
              GridItem() {
                DeviceCard({ device: device })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(16)
          .rowsGap(16)
          .padding({ bottom: 16 })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .backgroundColor(BACKGROUND_COLOR)
      .scrollBar(BarState.Off)

      // Bottom Navigation Bar
      this.SmartHomeBottomBar()
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  EnvironmentCard(title: string, value: string, subtitle: string, bgColor: string, textColor: string) {
    Column() {
      Text(title)
        .fontSize(12)
        .fontColor(textColor)
        .opacity(0.8)

      Column() {
        Text(value)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(textColor)
        Text(subtitle)
          .fontSize(10)
          .fontColor(textColor)
          .opacity(0.7)
          .margin({ top: 2 })
      }
      .margin({ top: 12 })
    }
    .width('48%')
    .height(100)
    .padding(16)
    .borderRadius(16)
    .backgroundColor(bgColor)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  SmartHomeBottomBar() {
    Row() {
      this.NavItem($r('sys.media.ohos_ic_public_home'), 'Home', true)
      this.NavItem($r('sys.media.ohos_ic_public_star'), 'Scenes', false)
      this.NavItem($r('sys.media.ohos_ic_public_settings'), 'Settings', false)
    }
    .width('100%')
    .height(64)
    .backgroundColor(SURFACE_COLOR)
    .borderRadius({ topLeft: 24, topRight: 24 })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.1)', offsetY: -2 })
  }

  @Builder
  NavItem(icon: Resource, label: string, selected: boolean) {
    Column() {
      Image(icon)
        .width(24)
        .height(24)
        .fillColor(selected ? PRIMARY_COLOR : '#888888')
      Text(label)
        .fontSize(12)
        .fontColor(selected ? PRIMARY_COLOR : '#888888')
        .margin({ top: 4 })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct DeviceCard {
  @Prop device: DeviceItem;
  @State isChecked: boolean = false;

  aboutToAppear() {
    this.isChecked = this.device.isActive;
  }

  build() {
    Column() {
      Row() {
        // Icon Container
        Row() {
          Image(this.device.icon)
            .width(20)
            .height(20)
            .fillColor(this.isChecked ? '#FFFFFF' : '#888888')
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(this.isChecked ? 'rgba(255,255,255,0.2)' : '#F0F0F0')
        .justifyContent(FlexAlign.Center)

        // Switch
        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .selectedColor('#FFFFFF')
          .switchPointColor('#888888')
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
          .scale({ x: 0.7, y: 0.7 }) // Scaled down to match size constraints
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // Text Content
      Column() {
        Text(this.device.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')
        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(10)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')
          .opacity(0.7)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 16 })
    }
    .width('100%')
    .height(140)
    .padding(16)
    .borderRadius(20)
    .backgroundColor(this.isChecked ? PRIMARY_COLOR : SURFACE_COLOR)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .shadow(this.isChecked ? { radius: 8, color: 'rgba(74,101,114,0.3)', offsetY: 4 } : { radius: 2, color: 'rgba(0,0,0,0.05)', offsetY: 2 })
  }
}