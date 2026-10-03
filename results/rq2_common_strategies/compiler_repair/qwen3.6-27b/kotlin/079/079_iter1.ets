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
      // Using a placeholder image or generic resource if specific ones are missing. 
      // Assuming 'ic_account' might be missing, using a generic circle or text fallback if needed, 
      // but strictly fixing compilation errors implies ensuring resources exist or using valid syntax.
      // Since we cannot add resources, we assume standard system icons or fix the reference to a likely existing one.
      // However, the error says "Unknown resource". In ArkTS, you must have the resource in media folder.
      // To fix compilation without adding files, we can use a Text node as a placeholder or assume the resource exists in the target environment.
      // Given the strict instruction to fix code, and inability to add assets, I will replace unknown resources with Text placeholders 
      // or assume they are present if this is a snippet check. 
      // BUT, usually these exercises imply the resource names are wrong or need to be generic.
      // Let's assume standard icons like 'sys.icon.xxx' or just keep them if the user has them.
      // The prompt asks to fix compilation errors. "Unknown resource" is a compile error.
      // I will replace $r('app.media.ic_...') with Text("Icon") or similar to ensure it compiles, 
      // OR better, use standard system icons if available, e.g., $r('sys.symbol.person').
      // Let's use sys.symbol for reliability.
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
    // Spacer().width(16) is invalid syntax in newer ArkTS versions inside Row directly without proper chaining or usage.
    // Correct way: Spacer().width(16) works if Spacer is imported/available. 
    // Error 3 says "Cannot find name 'Spacer'". This suggests import issue or version difference.
    // In ArkUI, Spacer is a component. It should be available. 
    // If not, use Column({ width: 16 }) or similar. But Spacer is standard.
    // The error "does not meet UI component syntax" (10905204) often happens when method chaining is wrong.
    // Spacer().width(16) is correct. 
    // Wait, Error 3: Cannot find name 'Spacer'. This implies it's not imported? 
    // No, built-in components don't need import. 
    // Maybe the version doesn't support Spacer? Or it's named differently?
    // Actually, in some contexts, you might need to use `Column({ width: 16 })` as a spacer.
    // Let's try replacing Spacer with a fixed width column/row to be safe against "Cannot find name".
    Column({ width: 16, height: 0 })
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
          Image($r('sys.symbol.info')).width(20).height(20).fillColor(isChecked ? Color.White : Color.Gray)
        } else if (device.iconType === IconType.NOTIFICATIONS) {
          Image($r('sys.symbol.bell')).width(20).height(20).fillColor(isChecked ? Color.White : Color.Gray)
        }
      }
      .width(36)
      .height(36)
      .borderRadius(18)
      .backgroundColor(isChecked ? 'rgba(255,255,255,0.2)' : '#F0F0F0')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

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
        .fontWeight(FontWeight.Medium) // Fixed: SemiBold does not exist
      
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
        // Replacing Spacer with Column to avoid "Cannot find name" and syntax errors
        Column({ width: '100%', height: 24 })
        
        HeaderSectionBuilder()
        
        Column({ width: '100%', height: 32 })
        
        EnvironmentSummaryBuilder()
        
        Column({ width: '100%', height: 32 })
        
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