import { window } from '@kit.ArkUI';
import { common, UIAbility, Want } from '@kit.AbilityKit';

@Entry
@Component
struct SmartHomeApp {
  @State isDarkMode: boolean = false;

  build() {
    Column() {
      SmartHomeScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }
}

// Data Model
interface DeviceItem {
  name: string;
  status: string;
  iconType: IconType;
  isActive: boolean;
}

enum IconType {
  HOME,
  LOCK,
  STAR,
  LOCATION,
  INFO,
  NOTIFICATIONS,
  ACCOUNT
}

// Theme Constants
const COLORS: Record<string, string> = {
  primary: '#4A6572',
  onPrimary: '#FFFFFF',
  background: '#F5F6F8',
  surface: '#FFFFFF',
  onSurface: '#333333',
  grayText: '#999999',
  tempBg: '#E3F2FD',
  tempText: '#1565C0',
  humBg: '#E8F5E9',
  humText: '#2E7D32'
};

@Builder
function HeaderSectionBuilder() {
  Row() {
    Column() {
      Text("Welcome Home,")
        .fontColor(Color.Gray)
        .fontSize(16)
        .fontWeight(FontWeight.Normal)
      
      Text("Alex Johnson")
        .fontColor(COLORS.onSurface)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
    }
    
    Blank()

    Row() {
      Image($r('sys.symbol.person')) 
        .width(32)
        .height(32)
        .fillColor(COLORS.primary)
    }
    .width(48)
    .height(48)
    .borderRadius(24)
    .backgroundColor(`${COLORS.primary}1A`) // 10% opacity approx
    .justifyContent(FlexAlign.Center)
  }
  .width('100%')
  .alignItems(VerticalAlign.Center)
}

@Builder
function EnvironmentCardBuilder(title: string, value: string, subtitle: string, bgColor: string, textColor: string) {
  Column() {
    Text(title)
      .fontColor(textColor)
      .opacity(0.8)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
    
    Blank()
    
    Column() {
      Text(value)
        .fontColor(textColor)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      
      Text(subtitle)
        .fontColor(textColor)
        .opacity(0.7)
        .fontSize(12)
    }
  }
  .width('48%')
  .height(100)
  .padding(16)
  .backgroundColor(bgColor)
  .borderRadius(16)
  .justifyContent(FlexAlign.SpaceBetween)
}

@Builder
function EnvironmentSummaryBuilder() {
  Row() {
    EnvironmentCardBuilder("Temperature", "24°C", "Comfortable", COLORS.tempBg, COLORS.tempText)
    Column().width(16).height(0)
    EnvironmentCardBuilder("Humidity", "45%", "Normal", COLORS.humBg, COLORS.humText)
  }
  .width('100%')
}

@Builder
function DeviceCardBuilder(device: DeviceItem, isChecked: boolean, onChange: (val: boolean) => void) {
  Column() {
    Row() {
      Row() {
        // Simulating Icon based on type
        if (device.iconType === IconType.HOME) {
          Image($r('sys.symbol.house')).width(20).height(20).fillColor(isChecked ? Color.White : Color.Gray)
        } else if (device.iconType === IconType.LOCK) {
          Image($r('sys.symbol.lock')).width(20).height(20).fillColor(isChecked ? Color.White : Color.Gray)
        } else if (device.iconType === IconType.STAR) {
          Image($r('sys.symbol.star')).width(20).height(20).fillColor(isChecked ? Color.White : Color.Gray)
        } else if (device.iconType === IconType.LOCATION) {
          Image($r('sys.symbol.location')).width(20).height(20).fillColor(isChecked ? Color.White : Color.Gray)
        } else if (device.iconType === IconType.INFO) {
          Image($r('sys.symbol.info_circle')).width(20).height(20).fillColor(isChecked ? Color.White : Color.Gray)
        } else if (device.iconType === IconType.NOTIFICATIONS) {
          Image($r('sys.symbol.bell')).width(20).height(20).fillColor(isChecked ? Color.White : Color.Gray)
        }
      }
      .width(36)
      .height(36)
      .borderRadius(18)
      .backgroundColor(isChecked ? 'rgba(255,255,255,0.2)' : '#F0F0F0')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Blank()

      Toggle({
        type: ToggleType.Switch,
        isOn: isChecked
      })
      .width(32)
      .height(16)
      .selectedColor(Color.White)
      .onChange((isOn: boolean) => {
        onChange(isOn);
      })
    }
    .width('100%')

    Blank()

    Column() {
      Text(device.name)
        .fontColor(isChecked ? Color.White : Color.Black)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
      
      Text(isChecked ? "On" : "Off")
        .fontColor(isChecked ? Color.White : Color.Black)
        .opacity(0.7)
        .fontSize(12)
    }
  }
  .width('100%')
  .height(140)
  .padding(16)
  .backgroundColor(isChecked ? COLORS.primary : Color.White)
  .borderRadius(20)
  .shadow({
    radius: 10,
    color: isChecked ? 'rgba(0,0,0,0.1)' : 'rgba(0,0,0,0.05)',
    offsetX: 0,
    offsetY: isChecked ? 4 : 1
  })
  .justifyContent(FlexAlign.SpaceBetween)
}

@Builder
function BottomBarBuilder() {
  Row() {
    Column() {
      Image($r('sys.symbol.house'))
        .width(24)
        .height(24)
        .fillColor(COLORS.primary)
      Text("Home")
        .fontColor(COLORS.primary)
        .fontSize(12)
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(`${COLORS.primary}1A`)
    .borderRadius({ topLeft: 24, topRight: 24 })

    Column() {
      Image($r('sys.symbol.star'))
        .width(24)
        .height(24)
        .fillColor(Color.Gray)
      Text("Scenes")
        .fontColor(Color.Gray)
        .fontSize(12)
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)

    Column() {
      Image($r('sys.symbol.gearshape'))
        .width(24)
        .height(24)
        .fillColor(Color.Gray)
      Text("Settings")
        .fontColor(Color.Gray)
        .fontSize(12)
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
  }
  .width('100%')
  .height(60)
  .backgroundColor(Color.White)
  .shadow({
    radius: 10,
    color: 'rgba(0,0,0,0.1)',
    offsetX: 0,
    offsetY: -2
  })
}

@Component
struct SmartHomeScreen {
  @State devices: DeviceItem[] = [
    { name: "Living Room", status: "2 Lights On", iconType: IconType.HOME, isActive: true },
    { name: "Smart Lock", status: "Locked", iconType: IconType.LOCK, isActive: true },
    { name: "Bedroom AC", status: "22°C", iconType: IconType.STAR, isActive: false },
    { name: "Router", status: "Online", iconType: IconType.LOCATION, isActive: true },
    { name: "Kitchen", status: "All Off", iconType: IconType.INFO, isActive: false },
    { name: "Corridor", status: "Motion Detected", iconType: IconType.NOTIFICATIONS, isActive: true }
  ];

  build() {
    Column() {
      Column() {
        Column().width('100%').height(24)
        
        HeaderSectionBuilder()
        
        Column().width('100%').height(32)
        
        EnvironmentSummaryBuilder()
        
        Column().width('100%').height(32)
        
        Text("My Devices")
          .fontColor(COLORS.onSurface)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        
        Grid() {
          ForEach(this.devices, (item: DeviceItem, index: number) => {
            GridItem() {
              DeviceCardBuilder(item, this.devices[index].isActive, (val: boolean) => {
                this.devices[index].isActive = val;
              })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(16)
        .columnsGap(16)
        .width('100%')
        .margin({ top: 16, bottom: 80 }) // Bottom margin for navbar
        
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      
      // Absolute positioning for bottom bar to mimic Scaffold behavior
      Stack({ alignContent: Alignment.Bottom }) {
        BottomBarBuilder()
      }
      .width('100%')
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}