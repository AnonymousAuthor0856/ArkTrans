import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct SmartHomeDashboard {
  @State private scrollOffset: number = 0;

  build() {
    Column() {
      Scroll() {
        Column({ space: 32 }) {
          // Header Section
          this.HeaderSection();

          // Energy Usage Card
          this.EnergyUsageCard();

          // Scenes Section
          this.ScenesSection();

          // Devices Section
          this.DevicesSection();
        }
        .padding({ left: 24, right: 24, top: 16, bottom: 24 })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .height('100%')
      .backgroundColor('#F4F6F8')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text("Good Morning,")
          .fontSize(16)
          .fontColor('#9E9E9E')
          .fontWeight(FontWeight.Medium)
        Text("Alex Johnson")
          .fontSize(24)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Image($r('app.media.ic_person')) // Placeholder for person icon
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.White)
      .borderRadius(24)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  EnergyUsageCard() {
    Row() {
      Column() {
        Text("Energy Usage")
          .fontSize(14)
          .fontColor('#CCFFFFFF') // White with 80% opacity
        Text("28.5 kWh")
          .fontSize(32)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
        Text("Today")
          .fontSize(12)
          .fontColor('#99FFFFFF') // White with 60% opacity
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Image($r('app.media.ic_notifications')) // Placeholder for notification icon
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor(Color.White)
      }
      .width(56)
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#33FFFFFF') // White with 20% opacity
      .borderRadius(28)
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#5E60CE')
    .borderRadius(24)
    .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
  }

  @Builder
  ScenesSection() {
    Column() {
      Text("Scenes")
        .fontSize(20)
        .fontColor('#000000')
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
        SceneButton({ text: "Home", iconResource: $r('app.media.ic_home'), isSelected: true })
        SceneButton({ text: "Away", iconResource: $r('app.media.ic_lock'), isSelected: false })
        SceneButton({ text: "Sleep", iconResource: $r('app.media.ic_star'), isSelected: false })
      }
      .rowGap(12)
      .columnGap(12)
    }
  }

  @Builder
  DevicesSection() {
    Column() {
      Text("Devices")
        .fontSize(20)
        .fontColor('#000000')
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      GridContainer() {
        DeviceCard({ name: "Smart Lamp", iconResource: $r('app.media.ic_star'), isActive: true, accentColor: '#FFC107' })
        DeviceCard({ name: "Main Lock", iconResource: $r('app.media.ic_lock'), isActive: false, accentColor: '#4CAF50' })
        DeviceCard({ name: "Thermostat", iconResource: $r('app.media.ic_menu'), isActive: true, accentColor: '#FF7043' })
        DeviceCard({ name: "Wi-Fi Router", iconResource: $r('app.media.ic_settings'), isActive: true, accentColor: '#2196F3' })
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('auto auto')
      .gap(16)
    }
  }
}

@Component
struct SceneButton {
  @Prop text: string;
  @Prop iconResource: Resource;
  @Prop isSelected: boolean;

  build() {
    Row() {
      Image(this.iconResource)
        .width(18)
        .height(18)
        .objectFit(ImageFit.Contain)
        .fillColor(this.isSelected ? Color.White : Color.Black)
      
      Text(this.text)
        .fontSize(14)
        .fontColor(this.isSelected ? Color.White : Color.Black)
        .fontWeight(FontWeight.Medium)
        .margin({ left: 8 })
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(this.isSelected ? '#212121' : Color.White)
    .borderRadius(30)
    .onClick(() => {
      // Handle click if needed
    })
  }
}

@Component
struct DeviceCard {
  @Prop name: string;
  @Prop iconResource: Resource;
  @Prop isActive: boolean;
  @Prop accentColor: string;
  @State switchState: boolean = this.isActive;

  build() {
    Column() {
      Row() {
        Row() {
          Image(this.iconResource)
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor(this.switchState ? this.accentColor : '#9E9E9E')
        }
        .width(40)
        .height(40)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(this.switchState ? `${this.accentColor}1A` : '#F0F0F0') // 10% opacity
        .borderRadius(20)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Column() {
        Text(this.name)
          .fontSize(16)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
        
        Text(this.switchState ? "On" : "Off")
          .fontSize(14)
          .fontColor(this.switchState ? this.accentColor : '#9E9E9E')
          .fontWeight(FontWeight.Medium)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .onChange((isOn: boolean) => {
            this.switchState = isOn;
          })
          .selectedColor(this.accentColor)
          .width(52 * 0.8) // Scaled width
          .height(32 * 0.8) // Scaled height
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .aspectRatio(0.85)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .shadow({ radius: 2, color: '#33000000', offsetY: 2 })
  }
}