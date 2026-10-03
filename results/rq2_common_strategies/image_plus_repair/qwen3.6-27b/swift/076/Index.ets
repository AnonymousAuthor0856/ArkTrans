import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct SmartHomeApp {
  build() {
    Column() {
      SmartHomeDashboard()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
  }
}

enum IconType {
  HOME, LOCK, STAR, GEAR, LINES
}

@Component
struct SmartHomeDashboard {
  build() {
    Column() {
      // Header
      Row() {
        Column({ alignItems: ItemAlign.Start }) {
          Text("Good Morning,")
            .fontColor('#9E9E9E')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          
          Text("Alex Johnson")
            .fontColor('#000000')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
        }
        
        Blank()
        
        Row() {
          Image($r('app.media.ic_person')) // Placeholder for person icon
            .width(24)
            .height(24)
            .fillColor('#000000')
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor(Color.White)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      
      Column() {
        // Energy Card
        Row() {
          Column({ alignItems: ItemAlign.Start }) {
            Text("Energy Usage")
              .fontColor('#FFFFFFCC') // White with opacity
              .fontSize(14)
            
            Text("28.5 kWh")
              .fontColor(Color.White)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
            
            Text("Today")
              .fontColor('#FFFFFF99') // White with opacity
              .fontSize(12)
          }
          
          Blank()
          
          Row() {
            Image($r('app.media.ic_bell')) // Placeholder for bell icon
              .width(24)
              .height(24)
              .fillColor(Color.White)
          }
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor('#FFFFFF33') // White with opacity
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#5E60CE')
        .borderRadius(24)
        .shadow({ radius: 8, color: '#0000001A', offsetY: 4 })
      }
      .margin({ top: 32, bottom: 32 })
      .padding({ left: 24, right: 24 })
      
      // Scenes Section
      Text("Scenes")
        .fontColor('#000000')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .alignSelf(ItemAlign.Start)
        .margin({ left: 24, bottom: 16 })
      
      Scroll() {
        Row() {
          SceneButton({ text: "Home", iconType: IconType.HOME, isSelected: true })
          SceneButton({ text: "Away", iconType: IconType.LOCK, isSelected: false })
          SceneButton({ text: "Sleep", iconType: IconType.STAR, isSelected: false })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .gap(12)
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
      
      // Devices Section
      Text("Devices")
        .fontColor('#000000')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .alignSelf(ItemAlign.Start)
        .margin({ top: 32, left: 24, bottom: 16 })
      
      DeviceGridContainer()
        .margin({ left: 24, right: 24 })
    }
    .width('100%')
    .padding({ top: 16, bottom: 24 })
  }
}

@Component
struct SceneButton {
  @Prop text: string
  @Prop iconType: IconType
  @Prop isSelected: boolean

  build() {
    Row() {
      Image(this.getIconResource())
        .width(18)
        .height(18)
        .fillColor(this.isSelected ? Color.White : Color.Black)
      
      Text(this.text)
        .fontColor(this.isSelected ? Color.White : Color.Black)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .borderRadius(30)
    .backgroundColor(this.isSelected ? '#212121' : Color.White)
  }

  getIconResource(): Resource {
    switch (this.iconType) {
      case IconType.HOME: return $r('app.media.ic_home');
      case IconType.LOCK: return $r('app.media.ic_lock');
      case IconType.STAR: return $r('app.media.ic_star');
      default: return $r('app.media.ic_home');
    }
  }
}

@Component
struct DeviceGridContainer {
  build() {
    GridRow() {
      GridCol() {
        Column() {
          DeviceCard({ name: "Smart Lamp", iconType: IconType.STAR, isActive: true, accentColor: '#FFC107' })
          DeviceCard({ name: "Thermostat", iconType: IconType.LINES, isActive: true, accentColor: '#FF7043' })
        }
      }
      GridCol() {
        Column() {
          DeviceCard({ name: "Main Lock", iconType: IconType.LOCK, isActive: false, accentColor: '#4CAF50' })
          DeviceCard({ name: "Wi-Fi Router", iconType: IconType.GEAR, isActive: true, accentColor: '#2196F3' })
        }
      }
    }
    .columnsTemplate('1fr 1fr')
    .rowsTemplate('auto auto')
    .gutters({ row: 16, column: 16 })
  }
}

@Component
struct DeviceCard {
  @Prop name: string
  @Prop iconType: IconType
  @Prop isActive: boolean
  @Prop accentColor: string
  
  @State switchState: boolean = this.isActive;

  build() {
    Column({ alignItems: ItemAlign.Start }) {
      Row() {
        Row() {
          Image(this.getIconResource())
            .width(24)
            .height(24)
            .fillColor(this.switchState ? this.accentColor : '#9E9E9E')
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.switchState ? `${this.accentColor}1A` : '#F0F0F0') // 10% opacity approx
        .justifyContent(FlexAlign.Center)
        
        Blank()
      }
      
      Blank()
      
      Column({ alignItems: ItemAlign.Start }) {
        Text(this.name)
          .fontColor('#000000')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
        
        Text(this.switchState ? "On" : "Off")
          .fontColor(this.switchState ? this.accentColor : '#9E9E9E')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
      }
      
      Blank()
      
      Row() {
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .onChange((isOn: boolean) => {
            this.switchState = isOn;
          })
          .selectedColor(this.accentColor)
          .width(40) // Scaled down effect
          .height(24)
      }
    }
    .padding(16)
    .width('100%')
    .aspectRatio(0.85)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .shadow({ radius: 2, color: '#0000000D', offsetY: 1 })
  }

  getIconResource(): Resource {
    switch (this.iconType) {
      case IconType.HOME: return $r('app.media.ic_home');
      case IconType.LOCK: return $r('app.media.ic_lock');
      case IconType.STAR: return $r('app.media.ic_star');
      case IconType.GEAR: return $r('app.media.ic_gear');
      case IconType.LINES: return $r('app.media.ic_lines');
      default: return $r('app.media.ic_home');
    }
  }
}