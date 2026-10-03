import { router } from '@kit.ArkUI';

interface DeviceItem {
  name: string;
  status: string;
  icon: Resource;
  isActive: boolean;
}

@Entry
@Component
struct SmartHomeScreen {
  @State selectedTab: number = 0;

  build() {
    Column() {
      // Main Content
      Column() {
        Scroll() {
          Column() {
            HeaderSection()
            Spacer({ height: 32 })
            EnvironmentSummary()
            Spacer({ height: 32 })
            DevicesGrid()
            Spacer({ height: 16 })
          }
          .padding({ left: 24, right: 24, top: 24 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .layoutWeight(1)

      // Bottom Navigation Bar
      SmartHomeBottomBar({ selectedTab: $selectedTab })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Welcome Home,')
          .fontSize(14)
          .fontColor('#888888')
          .margin({ bottom: 4 })
        Text('Alex Johnson')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .alignItems(HorizontalAlign.Start)

      Box() {
        Image($r('app.media.ic_user_portrait'))
          .width(32)
          .height(32)
          .fillColor('#4A6572')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#1A4A6572')
      .justifyContent(FlexAlign.Center)
      .alignItems(ItemAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct EnvironmentSummary {
  build() {
    Row() {
      EnvironmentCard({
        title: 'Temperature',
        value: '24°C',
        subtitle: 'Comfortable',
        bgColor: '#E3F2FD',
        textColor: '#1565C0'
      })
      Spacer({ width: 16 })
      EnvironmentCard({
        title: 'Humidity',
        value: '45%',
        subtitle: 'Normal',
        bgColor: '#E8F5E9',
        textColor: '#2E7D32'
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct EnvironmentCard {
  title: string = '';
  value: string = '';
  subtitle: string = '';
  bgColor: string = '#FFFFFF';
  textColor: string = '#000000';

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontColor(this.textColor)
        .opacity(0.8)

      Column() {
        Text(this.value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
        Text(this.subtitle)
          .fontSize(10)
          .fontColor(this.textColor)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .height(100)
    .padding(16)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct DevicesGrid {
  @State devices: DeviceItem[] = [
    { name: 'Living Room', status: '2 Lights On', icon: $r('app.media.ic_home'), isActive: true },
    { name: 'Smart Lock', status: 'Locked', icon: $r('app.media.ic_lock'), isActive: true },
    { name: 'Bedroom AC', status: '22°C', icon: $r('app.media.ic_star'), isActive: false },
    { name: 'Router', status: 'Online', icon: $r('app.media.ic_location'), isActive: true },
    { name: 'Kitchen', status: 'All Off', icon: $r('app.media.ic_info'), isActive: false },
    { name: 'Corridor', status: 'Motion Detected', icon: $r('app.media.ic_notification'), isActive: true }
  ];

  build() {
    Column() {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .margin({ bottom: 16 })

      Grid() {
        ForEach(this.devices, (device: DeviceItem, index: number) => {
          GridItem() {
            DeviceCard({ device: device })
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
}

@Component
struct DeviceCard {
  device: DeviceItem = {
    name: '',
    status: '',
    icon: $r('app.media.ic_home'),
    isActive: false
  };
  @State isChecked: boolean = false;

  aboutToAppear() {
    this.isChecked = this.device.isActive;
  }

  build() {
    Column() {
      Row() {
        Box() {
          Image(this.device.icon)
            .width(20)
            .height(20)
            .fillColor(this.isChecked ? '#FFFFFF' : '#888888')
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(this.isChecked ? '#334A6572' : '#F0F0F0')
        .justifyContent(FlexAlign.Center)
        .alignItems(ItemAlign.Center)

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
          .selectedColor('#4A6572')
          .switchPointColor('#FFFFFF')
          .width(40)
          .height(22)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')
          .margin({ bottom: 4 })
        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? '#CCFFFFFF' : '#AA000000')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .width('100%')
    .height(140)
    .padding(16)
    .backgroundColor(this.isChecked ? '#4A6572' : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: this.isChecked ? 12 : 4,
      color: '#22000000',
      offsetX: 0,
      offsetY: this.isChecked ? 4 : 1
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SmartHomeBottomBar {
  @Link selectedTab: number;

  build() {
    Row() {
      // Home Tab
      Column() {
        Image($r('app.media.ic_home'))
          .width(24)
          .height(24)
          .fillColor(this.selectedTab === 0 ? '#4A6572' : '#888888')
          .margin({ bottom: 4 })
        Text('Home')
          .fontSize(12)
          .fontColor(this.selectedTab === 0 ? '#4A6572' : '#888888')
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding({ top: 10, bottom: 10 })
      .onClick(() => {
        this.selectedTab = 0;
      })

      // Scenes Tab
      Column() {
        Image($r('app.media.ic_star'))
          .width(24)
          .height(24)
          .fillColor(this.selectedTab === 1 ? '#4A6572' : '#888888')
          .margin({ bottom: 4 })
        Text('Scenes')
          .fontSize(12)
          .fontColor(this.selectedTab === 1 ? '#4A6572' : '#888888')
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding({ top: 10, bottom: 10 })
      .onClick(() => {
        this.selectedTab = 1;
      })

      // Settings Tab
      Column() {
        Image($r('app.media.ic_settings'))
          .width(24)
          .height(24)
          .fillColor(this.selectedTab === 2 ? '#4A6572' : '#888888')
          .margin({ bottom: 4 })
        Text('Settings')
          .fontSize(12)
          .fontColor(this.selectedTab === 2 ? '#4A6572' : '#888888')
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding({ top: 10, bottom: 10 })
      .onClick(() => {
        this.selectedTab = 2;
      })
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({
      radius: 16,
      color: '#22000000',
      offsetX: 0,
      offsetY: -2
    })
  }
}