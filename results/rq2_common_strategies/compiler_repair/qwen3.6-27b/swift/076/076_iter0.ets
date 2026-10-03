import { router } from '@kit.ArkUI';
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
    .backgroundColor(Color.Transparent)
  }
}

@Component
struct SmartHomeDashboard {
  build() {
    Stack() {
      // Background Color #F4F6F8
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F4F6F8')

      Scroll() {
        Column({ align: Alignment.Start }) {
          // Top Header Spacer
          Blank().height(16)

          // Header
          Row() {
            Column({ align: Alignment.Start }) {
              Text("Good Morning,")
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Gray)
              
              Text("Alex Johnson")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
            }
            
            Blank()
            
            // Avatar Placeholder
            Stack() {
              Circle()
                .fill(Color.White)
                .frame({ width: 48, height: 48 })
              
              Image($r('app.media.ic_person')) // Assuming a default person icon or using system symbol if available in specific env
                .width(24)
                .height(24)
                .objectFit(ImageFit.Contain)
                .fill(Color.Black)
            }
          }
          .padding({ left: 24, right: 24 })
          
          Blank().height(32)
          
          // Energy Usage Card
          Column() {
            Row() {
              Column({ align: Alignment.Start }) {
                Text("Energy Usage")
                  .fontSize(14)
                  .fontColor(Color.White.opacity(0.8))
                
                Text("28.5 kWh")
                  .fontSize(32)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                
                Text("Today")
                  .fontSize(12)
                  .fontColor(Color.White.opacity(0.6))
              }
              
              Blank()
              
              // Bell Icon Placeholder
              Stack() {
                Circle()
                  .fill(Color.White.opacity(0.2))
                  .frame({ width: 56, height: 56 })
                
                Image($r('app.media.ic_bell')) 
                  .width(24)
                  .height(24)
                  .objectFit(ImageFit.Contain)
                  .fill(Color.White)
              }
            }
            .padding(24)
          }
          .backgroundColor('#5E60CE')
          .borderRadius(24)
          .shadow({ radius: 8, color: '#0000001A', offsetX: 0, offsetY: 4 })
          .margin({ left: 24, right: 24 })
          
          Blank().height(32)
          
          // Scenes Section
          Text("Scenes")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ left: 24, right: 24 })
          
          Blank().height(16)
          
          // Horizontal ScrollView for Scenes
          Scroll() {
            Row({ space: 12 }) {
              Blank().width(24).margin({ right: -12 })
              
              SceneButton(text: "Home", icon: $r('app.media.ic_home'), isSelected: true)
              SceneButton(text: "Away", icon: $r('app.media.ic_lock'), isSelected: false)
              SceneButton(text: "Sleep", icon: $r('app.media.ic_star'), isSelected: false)
              
              Blank().width(24).margin({ left: -12 })
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          
          Blank().height(32)
          
          // Devices Section
          Text("Devices")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ left: 24, right: 24 })
          
          Blank().height(16)
          
          // Devices Grid (2x2)
          Row({ space: 16 }) {
            Column({ space: 16 }) {
              DeviceCard(
                name: "Smart Lamp",
                icon: $r('app.media.ic_star'),
                isActive: true,
                accentColor: '#FFC107'
              )
              DeviceCard(
                name: "Thermostat",
                icon: $r('app.media.ic_lines'),
                isActive: true,
                accentColor: '#FF7043'
              )
            }
            
            Column({ space: 16 }) {
              DeviceCard(
                name: "Main Lock",
                icon: $r('app.media.ic_lock'),
                isActive: false,
                accentColor: '#4CAF50'
              )
              DeviceCard(
                name: "Wi-Fi Router",
                icon: $r('app.media.ic_gear'),
                isActive: true,
                accentColor: '#2196F3'
              )
            }
          }
          .margin({ left: 24, right: 24 })
          
          Blank().height(24)
        }
        .padding({ top: 24, bottom: 24 })
      }
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct SceneButton {
  @Prop text: string
  @Prop icon: Resource
  @Prop isSelected: boolean

  build() {
    Row({ space: 8 }) {
      Image(this.icon)
        .width(18)
        .height(18)
        .objectFit(ImageFit.Contain)
        .fill(this.isSelected ? Color.White : Color.Black)
      
      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? Color.White : Color.Black)
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(this.isSelected ? '#212121' : Color.White)
    .borderRadius(30)
  }
}

@Component
struct DeviceCard {
  @Prop name: string
  @Prop icon: Resource
  @Prop isActive: boolean
  @Prop accentColor: string
  
  @State switchState: boolean = this.isActive

  build() {
    Column({ align: Alignment.Start }) {
      Row() {
        Stack() {
          Circle()
            .fill(this.switchState ? new Color(this.accentColor).opacity(0.1) : '#F0F0F0')
            .frame({ width: 40, height: 40 })
          
          Image(this.icon)
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fill(this.switchState ? new Color(this.accentColor) : Color.Gray)
        }
        
        Blank()
      }
      
      Blank()
      
      Column({ align: Alignment.Start }) {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        
        Text(this.switchState ? "On" : "Off")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.switchState ? new Color(this.accentColor) : Color.Gray)
      }
      
      Blank()
      
      Row() {
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .onChange((isOn: boolean) => {
            this.switchState = isOn
          })
          .width(40) // Approximate scaled size
          .height(24)
          .color(new Color(this.accentColor))
      }
    }
    .padding(16)
    .width('100%')
    .aspectRatio(0.85)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .shadow({ radius: 2, color: '#0000000D', offsetX: 0, offsetY: 1 })
  }
}