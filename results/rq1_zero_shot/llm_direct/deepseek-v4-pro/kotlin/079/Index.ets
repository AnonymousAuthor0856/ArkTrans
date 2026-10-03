import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct SmartHomeScreen {
  @State selectedTab: number = 0;
  @State devices: DeviceItem[] = [
    new DeviceItem('Living Room', '2 Lights On', '🏠', true),
    new DeviceItem('Smart Lock', 'Locked', '🔒', true),
    new DeviceItem('Bedroom AC', '22°C', '⭐', false),
    new DeviceItem('Router', 'Online', '📍', true),
    new DeviceItem('Kitchen', 'All Off', 'ℹ️', false),
    new DeviceItem('Corridor', 'Motion Detected', '🔔', true)
  ];

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor('#888888')
        Text('Alex Johnson')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('#1A4A6572')
        Text('👤')
          .fontSize(24)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  EnvironmentCard(title: string, value: string, subtitle: string, bgColor: string, textColor: string) {
    Column() {
      Text(title)
        .fontSize(12)
        .fontColor(textColor)
        .opacity(0.8)
      Blank()
      Text(value)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(textColor)
      Text(subtitle)
        .fontSize(11)
        .fontColor(textColor)
        .opacity(0.7)
    }
    .width('48%')
    .height(100)
    .padding(16)
    .backgroundColor(bgColor)
    .borderRadius(16)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  EnvironmentSummary() {
    Row() {
      this.EnvironmentCard('Temperature', '24°C', 'Comfortable', '#E3F2FD', '#1565C0')
      Blank().width(16)
      this.EnvironmentCard('Humidity', '45%', 'Normal', '#E8F5E9', '#2E7D32')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  DeviceCard(device: DeviceItem, index: number) {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(36)
            .height(36)
            .fill(device.isActive ? '#334A6572' : '#F0F0F0')
          Text(device.icon)
            .fontSize(18)
        }
        .width(36)
        .height(36)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: device.isActive })
          .selectedColor('#4A6572')
          .onChange((isOn: boolean) => {
            this.devices[index].isActive = isOn;
          })
          .width(40)
          .height(20)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank()

      Column() {
        Text(device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(device.isActive ? '#FFFFFF' : '#333333')
        Text(device.isActive ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(device.isActive ? '#B3FFFFFF' : '#B3333333')
          .margin({ top: 4 })
      }
    }
    .width('48%')
    .height(140)
    .padding(16)
    .backgroundColor(device.isActive ? '#4A6572' : '#FFFFFF')
    .borderRadius(20)
    .shadow(device.isActive ? 8 : 2)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  DevicesGrid() {
    Column() {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
      Blank().height(16)

      Grid() {
        ForEach(this.devices, (device: DeviceItem, index: number) => {
          GridItem() {
            this.DeviceCard(device, index)
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('🏠')
          .fontSize(22)
          .fontColor(this.selectedTab === 0 ? '#4A6572' : '#999999')
        Text('Home')
          .fontSize(11)
          .fontColor(this.selectedTab === 0 ? '#4A6572' : '#999999')
      }
      .layoutWeight(1)
      .onClick(() => {
        this.selectedTab = 0;
      })

      Column() {
        Text('⭐')
          .fontSize(22)
          .fontColor(this.selectedTab === 1 ? '#4A6572' : '#999999')
        Text('Scenes')
          .fontSize(11)
          .fontColor(this.selectedTab === 1 ? '#4A6572' : '#999999')
      }
      .layoutWeight(1)
      .onClick(() => {
        this.selectedTab = 1;
      })

      Column() {
        Text('⚙️')
          .fontSize(22)
          .fontColor(this.selectedTab === 2 ? '#4A6572' : '#999999')
        Text('Settings')
          .fontSize(11)
          .fontColor(this.selectedTab === 2 ? '#4A6572' : '#999999')
      }
      .layoutWeight(1)
      .onClick(() => {
        this.selectedTab = 2;
      })
    }
    .width('100%')
    .height(64)
    .backgroundColor('#FFFFFF')
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow(8)
    .padding({ top: 8, bottom: 8 })
  }

  build() {
    Column() {
      Column() {
        Blank().height(24)
        this.HeaderSection()
        Blank().height(32)
        this.EnvironmentSummary()
        Blank().height(32)
        this.DevicesGrid()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24 })
      .backgroundColor('#F5F6F8')

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }
}

class DeviceItem {
  name: string;
  status: string;
  icon: string;
  isActive: boolean;

  constructor(name: string, status: string, icon: string, isActive: boolean) {
    this.name = name;
    this.status = status;
    this.icon = icon;
    this.isActive = isActive;
  }
}