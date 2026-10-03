// SmartHomeApp.ets
import { EntryComponent, Component, State, Column, Row, Text, Image, Stack, ScrollView, Grid, GridItem, ForEach, Toggle, Circle, Rect, Color, FontWeight, AppStorage, Length, px, vp } from '@ohos/arkui';

// MARK: - Models
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

// MARK: - Main Entry
@Entry
@Component
struct SmartHomeApp {
  build() {
    Column() {
      SmartHomeScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }
}

// MARK: - Main Screen
@Component
struct SmartHomeScreen {
  private primaryColor: string = '#4A6572';
  private backgroundColor: string = '#F5F6F8';

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.backgroundColor)

      // Main Content
      Column() {
        ScrollView() {
          Column() {
            // Top Spacing
            Column().height(24)

            // Header
            HeaderSection({ primaryColor: this.primaryColor })
              .padding({ left: 24, right: 24 })

            Column().height(32)

            // Environment Summary
            EnvironmentSummary()
              .padding({ left: 24, right: 24 })

            Column().height(32)

            // Devices Grid
            DevicesGrid({ primaryColor: this.primaryColor })
              .padding({ left: 24, right: 24 })

            // Extra padding for bottom bar
            Column().height(100)
          }
        }
        .scrollBar(BarState.Off)
      }

      // Bottom Bar
      SmartHomeBottomBar({ primaryColor: this.primaryColor })
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

@Component
struct HeaderSection {
  private primaryColor: string;

  build() {
    Row() {
      Column() {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor(Color.Gray)
        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Circle({ width: 48, height: 48 })
          .fillColor(this.primaryColor)
          .opacity(0.1)
        Image($r('sys.symbol.person_circle_fill')) // Placeholder for SF Symbol
          .width(32)
          .height(32)
          .fillColor(this.primaryColor)
      }
    }
    .width('100%')
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
      .layoutWeight(1)

      Column().width(16)

      EnvironmentCard({
        title: 'Humidity',
        value: '45%',
        subtitle: 'Normal',
        bgColor: '#E8F5E9',
        textColor: '#2E7D32'
      })
      .layoutWeight(1)
    }
    .width('100%')
  }
}

@Component
struct EnvironmentCard {
  private title: string;
  private value: string;
  private subtitle: string;
  private bgColor: string;
  private textColor: string;

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor)
        .opacity(0.8)

      Blank()

      Column() {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
        Text(this.subtitle)
          .fontSize(11)
          .fontColor(this.textColor)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(100)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
  }
}

@Component
struct DevicesGrid {
  private primaryColor: string;
  @State devices: DeviceItem[] = [
    new DeviceItem('Living Room', '2 Lights On', $r('sys.symbol.house_fill'), true),
    new DeviceItem('Smart Lock', 'Locked', $r('sys.symbol.lock_fill'), true),
    new DeviceItem('Bedroom AC', '22°C', $r('sys.symbol.star_fill'), false),
    new DeviceItem('Router', 'Online', $r('sys.symbol.location_circle_fill'), true),
    new DeviceItem('Kitchen', 'All Off', $r('sys.symbol.info_circle_fill'), false),
    new DeviceItem('Corridor', 'Motion Detected', $r('sys.symbol.bell_fill'), true)
  ];

  build() {
    Column() {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ bottom: 16 })

      Grid() {
        ForEach(this.devices, (device: DeviceItem) => {
          GridItem() {
            DeviceCard({ device: device, primaryColor: this.primaryColor })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsGap(16)
      .columnsGap(16)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct DeviceCard {
  private device: DeviceItem;
  private primaryColor: string;
  @State isChecked: boolean;

  build() {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 36, height: 36 })
            .fillColor(this.isChecked ? '#FFFFFF' : '#F0F0F0')
            .opacity(this.isChecked ? 0.2 : 1)
          Image(this.device.icon)
            .width(14)
            .height(14)
            .fillColor(this.isChecked ? Color.White : Color.Gray)
        }

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .selectedColor('#FFFFFF')
          .opacity(this.isChecked ? 0.4 : 1)
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
      }

      Blank()

      Column() {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? Color.White : Color.Black)

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? Color.White : Color.Gray)
          .opacity(this.isChecked ? 0.7 : 1)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(140)
    .backgroundColor(this.isChecked ? this.primaryColor : Color.White)
    .borderRadius(20)
    .shadow({ radius: 8, color: this.isChecked ? this.primaryColor : '#000000', offsetX: 0, offsetY: 4 })
  }
}

@Component
struct SmartHomeBottomBar {
  private primaryColor: string;

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Shadow layer
      Column()
        .width('100%')
        .height(80)
        .backgroundColor(Color.White)
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 4, color: '#000000', offsetX: 0, offsetY: -2 })

      Row() {
        NavBarItem({ icon: $r('sys.symbol.house_fill'), label: 'Home', isSelected: true, primaryColor: this.primaryColor })
        NavBarItem({ icon: $r('sys.symbol.star_fill'), label: 'Scenes', isSelected: false, primaryColor: this.primaryColor })
        NavBarItem({ icon: $r('sys.symbol.gearshape_fill'), label: 'Settings', isSelected: false, primaryColor: this.primaryColor })
      }
      .width('100%')
      .padding({ top: 16 })
    }
    .width('100%')
    .height(80)
  }
}

@Component
struct NavBarItem {
  private icon: Resource;
  private label: string;
  private isSelected: boolean;
  private primaryColor: string;

  build() {
    Column() {
      Stack() {
        if (this.isSelected) {
          // Capsule approximation
          Row()
            .width(64)
            .height(32)
            .backgroundColor(this.primaryColor)
            .opacity(0.1)
            .borderRadius(16)
        }
        Image(this.icon)
          .width(24)
          .height(24)
          .fillColor(this.isSelected ? this.primaryColor : Color.Gray)
      }
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor : Color.Gray)
        .margin({ top: 4 })
    }
  }
}