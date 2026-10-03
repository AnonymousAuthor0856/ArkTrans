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
      // Main content
      Column() {
        // Header
        this.HeaderSection()

        // Environment Summary
        this.EnvironmentSummary()

        // Devices Grid
        this.DevicesGrid()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24, top: 24 })
      .backgroundColor('#F5F6F8')

      // Bottom Navigation
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Welcome Home,')
          .fontSize(14)
          .fontColor('#888888')
          .margin({ bottom: 4 })
        Text('Alex Johnson')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('#1A4A6572')

        Image($r('app.media.startIcon'))
          .width(32)
          .height(32)
          .fillColor('#4A6572')
      }
      .width(48)
      .height(48)
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 32 })
  }

  @Builder
  EnvironmentSummary() {
    Row() {
      // Temperature Card
      Column() {
        Text('Temperature')
          .fontSize(11)
          .fontColor('#1A1565C0')
          .margin({ bottom: 8 })
        Text('24°C')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1565C0')
        Text('Comfortable')
          .fontSize(10)
          .fontColor('#991565C0')
      }
      .width('47%')
      .height(100)
      .padding(16)
      .backgroundColor('#E3F2FD')
      .borderRadius(16)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceBetween)

      // Humidity Card
      Column() {
        Text('Humidity')
          .fontSize(11)
          .fontColor('#1A2E7D32')
          .margin({ bottom: 8 })
        Text('45%')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E7D32')
        Text('Normal')
          .fontSize(10)
          .fontColor('#992E7D32')
      }
      .width('47%')
      .height(100)
      .padding(16)
      .backgroundColor('#E8F5E9')
      .borderRadius(16)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({ bottom: 32 })
  }

  @Builder
  DevicesGrid() {
    Column() {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .margin({ bottom: 16 })

      Grid() {
        GridItem() {
          DeviceCard({
            device: {
              name: 'Living Room',
              status: '2 Lights On',
              icon: $r('app.media.startIcon'),
              isActive: true
            }
          })
        }
        GridItem() {
          DeviceCard({
            device: {
              name: 'Smart Lock',
              status: 'Locked',
              icon: $r('app.media.startIcon'),
              isActive: true
            }
          })
        }
        GridItem() {
          DeviceCard({
            device: {
              name: 'Bedroom AC',
              status: '22°C',
              icon: $r('app.media.startIcon'),
              isActive: false
            }
          })
        }
        GridItem() {
          DeviceCard({
            device: {
              name: 'Router',
              status: 'Online',
              icon: $r('app.media.startIcon'),
              isActive: true
            }
          })
        }
        GridItem() {
          DeviceCard({
            device: {
              name: 'Kitchen',
              status: 'All Off',
              icon: $r('app.media.startIcon'),
              isActive: false
            }
          })
        }
        GridItem() {
          DeviceCard({
            device: {
              name: 'Corridor',
              status: 'Motion Detected',
              icon: $r('app.media.startIcon'),
              isActive: true
            }
          })
        }
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  BottomBar() {
    Row() {
      // Home
      Column() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(this.selectedTab === 0 ? '#4A6572' : '#888888')
        Text('Home')
          .fontSize(12)
          .fontColor(this.selectedTab === 0 ? '#4A6572' : '#888888')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .padding({ top: 8, bottom: 8 })
      .backgroundColor(this.selectedTab === 0 ? '#1A4A6572' : Color.Transparent)
      .borderRadius(12)
      .onClick(() => {
        this.selectedTab = 0;
      })

      // Scenes
      Column() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(this.selectedTab === 1 ? '#4A6572' : '#888888')
        Text('Scenes')
          .fontSize(12)
          .fontColor(this.selectedTab === 1 ? '#4A6572' : '#888888')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .padding({ top: 8, bottom: 8 })
      .onClick(() => {
        this.selectedTab = 1;
      })

      // Settings
      Column() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(this.selectedTab === 2 ? '#4A6572' : '#888888')
        Text('Settings')
          .fontSize(12)
          .fontColor(this.selectedTab === 2 ? '#4A6572' : '#888888')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .padding({ top: 8, bottom: 8 })
      .onClick(() => {
        this.selectedTab = 2;
      })
    }
    .width('100%')
    .height(70)
    .backgroundColor(Color.White)
    .borderRadius({ topLeft: 24, topRight: 24 })
    .padding({ left: 16, right: 16 })
    .shadow({ radius: 8, color: '#1A000000', offsetY: -2 })
  }
}

@Component
struct DeviceCard {
  device: DeviceItem = {
    name: '',
    status: '',
    icon: $r('app.media.startIcon'),
    isActive: false
  };
  @State isChecked: boolean = false;

  aboutToAppear() {
    this.isChecked = this.device.isActive;
  }

  build() {
    Column() {
      // Top row with icon and switch
      Row() {
        Stack() {
          Circle()
            .width(36)
            .height(36)
            .fill(this.isChecked ? '#334A6572' : '#F0F0F0')

          Image(this.device.icon)
            .width(20)
            .height(20)
            .fillColor(this.isChecked ? Color.White : '#888888')
        }
        .width(36)
        .height(36)
        .alignContent(Alignment.Center)

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .width(44)
          .height(22)
          .selectedColor(this.isChecked ? '#80FFFFFF' : '#CCCCCC')
          .switchPointColor(this.isChecked ? Color.White : '#888888')
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 16 })

      // Device info
      Column() {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? Color.White : '#333333')
          .margin({ bottom: 4 })
        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? '#B3FFFFFF' : '#888888')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .padding(16)
    .backgroundColor(this.isChecked ? '#4A6572' : Color.White)
    .borderRadius(20)
    .shadow({
      radius: this.isChecked ? 12 : 4,
      color: this.isChecked ? '#334A6572' : '#1A000000',
      offsetY: this.isChecked ? 4 : 2
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}