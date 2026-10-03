import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';

// MARK: - Models
interface DeviceItem {
  id: number;
  name: string;
  status: string;
  icon: string; // Using system symbol names compatible with ArkTS or custom resources
  isActive: boolean;
}

@Entry
@Component
struct SmartHomeApp {
  @State private statusBarHeight: number = 0;

  aboutToAppear() {
    // Get status bar height to adjust layout if needed, though we hide it in the view
    try {
      const windowStage = AppStorage.get<number>('windowStage');
      // In a real app, you might fetch this dynamically. 
      // For this demo, we rely on the .statusBarMode setting below.
    } catch (e) {
      console.error('Failed to get window stage');
    }
  }

  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }
}

@Component
struct ContentView {
  build() {
    SmartHomeScreen()
  }
}

// MARK: - Main Screen
@Component
struct SmartHomeScreen {
  private primaryColor: Color = new Color('#4A6572');
  private backgroundColor: Color = new Color('#F5F6F8');

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            Column().height(24)
            
            HeaderSection({ primaryColor: this.primaryColor })
              .padding({ left: 24, right: 24 })
            
            Column().height(32)
            
            EnvironmentSummary()
              .padding({ left: 24, right: 24 })
            
            Column().height(32)
            
            DevicesGrid({ primaryColor: this.primaryColor })
              .padding({ left: 24, right: 24 })
            
            // Extra padding for bottom bar
            Column().height(100)
          }
        }
        .scrollBar(BarState.Off)
      }
      
      SmartHomeBottomBar({ primaryColor: this.primaryColor })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}

// MARK: - Components

@Component
struct HeaderSection {
  @Prop primaryColor: Color;

  build() {
    Row() {
      Column({ space: 4 }) {
        Text("Welcome Home,")
          .fontSize(16)
          .fontColor(Color.Gray)
        
        Text("Alex Johnson")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      
      Blank()
      
      Stack() {
        Circle()
          .fill(this.primaryColor.alpha(0.1))
          .width(48)
          .height(48)
        
        Image($r('sys.symbol.person_circle'))
          .width(32)
          .height(32)
          .objectFit(ImageFit.Contain)
          .fillColor(this.primaryColor)
      }
    }
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct EnvironmentSummary {
  build() {
    Row({ space: 16 }) {
      EnvironmentCard({
        title: "Temperature",
        value: "24°C",
        subtitle: "Comfortable",
        bgColor: new Color('#E3F2FD'),
        textColor: new Color('#1565C0')
      })
      
      EnvironmentCard({
        title: "Humidity",
        value: "45%",
        subtitle: "Normal",
        bgColor: new Color('#E8F5E9'),
        textColor: new Color('#2E7D32')
      })
    }
  }
}

@Component
struct EnvironmentCard {
  @Prop title: string;
  @Prop value: string;
  @Prop subtitle: string;
  @Prop bgColor: Color;
  @Prop textColor: Color;

  build() {
    Column({ space: 0 }) {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor.alpha(0.8))
      
      Blank()
      
      Column({ space: 0 }) {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
        
        Text(this.subtitle)
          .fontSize(11)
          .fontColor(this.textColor.alpha(0.7))
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    .height(100)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
  }
}

@Component
struct DevicesGrid {
  @Prop primaryColor: Color;

  private devices: DeviceItem[] = [
    { id: 1, name: "Living Room", status: "2 Lights On", icon: "house.fill", isActive: true },
    { id: 2, name: "Smart Lock", status: "Locked", icon: "lock.fill", isActive: true },
    { id: 3, name: "Bedroom AC", status: "22°C", icon: "star.fill", isActive: false },
    { id: 4, name: "Router", status: "Online", icon: "location.circle.fill", isActive: true },
    { id: 5, name: "Kitchen", status: "All Off", icon: "info.circle.fill", isActive: false },
    { id: 6, name: "Corridor", status: "Motion Detected", icon: "bell.fill", isActive: true }
  ];

  build() {
    Column({ space: 16 }) {
      Text("My Devices")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      
      GridContainer() {
        ForEach(this.devices, (device: DeviceItem) => {
          GridItem() {
            DeviceCard({ device: device, primaryColor: this.primaryColor })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('auto auto auto')
      .gridItemLayout({
        width: '100%',
        height: 'auto'
      })
      .itemSpacing({ row: 16, column: 16 })
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DeviceCard {
  @Prop device: DeviceItem;
  @Prop primaryColor: Color;
  
  @State isChecked: boolean = false;

  aboutToAppear() {
    this.isChecked = this.device.isActive;
  }

  build() {
    Column({ space: 0 }) {
      Row() {
        Stack() {
          Circle()
            .fill(this.isChecked ? Color.White.alpha(0.2) : new Color('#F0F0F0'))
            .width(36)
            .height(36)
          
          Image(this.getIconResource(this.device.icon))
            .width(20)
            .height(20)
            .objectFit(ImageFit.Contain)
            .fillColor(this.isChecked ? Color.White : Color.Gray)
        }
        
        Blank()
        
        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
          .width(40)
          .height(24)
          .selectedColor(this.primaryColor)
      }
      
      Blank()
      
      Column({ space: 4 }) {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? Color.White : Color.Black)
        
        Text(this.isChecked ? "On" : "Off")
          .fontSize(11)
          .fontColor(this.isChecked ? Color.White.alpha(0.7) : Color.Gray)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(140)
    .backgroundColor(this.isChecked ? this.primaryColor : Color.White)
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: this.isChecked ? this.primaryColor.alpha(0.3) : Color.Black.alpha(0.05),
      offsetX: 0,
      offsetY: 4
    })
  }

  getIconResource(iconName: string): ResourceStr {
    // Mapping common SF Symbols to ArkTS System Symbols where possible
    // Note: Exact mapping depends on available system symbols in the target OS version
    switch (iconName) {
      case 'house.fill': return $r('sys.symbol.house_fill');
      case 'lock.fill': return $r('sys.symbol.lock_fill');
      case 'star.fill': return $r('sys.symbol.star_fill');
      case 'location.circle.fill': return $r('sys.symbol.location_circle');
      case 'info.circle.fill': return $r('sys.symbol.info_circle');
      case 'bell.fill': return $r('sys.symbol.bell_fill');
      default: return $r('sys.symbol.questionmark_circle');
    }
  }
}

@Component
struct SmartHomeBottomBar {
  @Prop primaryColor: Color;

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Shadow/Background layer
      Column()
        .width('100%')
        .height(80)
        .backgroundColor(Color.White)
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({
          radius: 4,
          color: Color.Black.alpha(0.05),
          offsetX: 0,
          offsetY: -2
        })

      Row() {
        NavBarItem({ 
          icon: "house.fill", 
          label: "Home", 
          isSelected: true, 
          primaryColor: this.primaryColor 
        })
        
        NavBarItem({ 
          icon: "star.fill", 
          label: "Scenes", 
          isSelected: false, 
          primaryColor: this.primaryColor 
        })
        
        NavBarItem({ 
          icon: "gearshape.fill", 
          label: "Settings", 
          isSelected: false, 
          primaryColor: this.primaryColor 
        })
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ top: 16 })
    }
    .width('100%')
    .height(80)
  }
}

@Component
struct NavBarItem {
  @Prop icon: string;
  @Prop label: string;
  @Prop isSelected: boolean;
  @Prop primaryColor: Color;

  build() {
    Column({ space: 4 }) {
      Stack() {
        if (this.isSelected) {
          Capsule()
            .fill(this.primaryColor.alpha(0.1))
            .width(64)
            .height(32)
        }
        
        Image(this.getNavIconResource(this.icon))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor(this.isSelected ? this.primaryColor : Color.Gray)
      }
      
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor : Color.Gray)
    }
  }

  getNavIconResource(iconName: string): ResourceStr {
    switch (iconName) {
      case 'house.fill': return $r('sys.symbol.house_fill');
      case 'star.fill': return $r('sys.symbol.star_fill');
      case 'gearshape.fill': return $r('sys.symbol.gearshape_fill');
      default: return $r('sys.symbol.circle');
    }
  }
}