import { window } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

export interface SceneData {
  text: string;
  iconResource: Resource;
  isSelected: boolean;
}

export interface DeviceData {
  name: string;
  iconResource: Resource;
  isActive: boolean;
  accentColor: string;
}

@Entry
@Component
struct SmartHomeDashboard {
  @State scenes: SceneData[] = [
    { text: 'Home', iconResource: $r('app.media.ic_home'), isSelected: true },
    { text: 'Away', iconResource: $r('app.media.ic_lock'), isSelected: false },
    { text: 'Sleep', iconResource: $r('app.media.ic_star'), isSelected: false }
  ];

  @State devices: DeviceData[] = [
    { name: 'Smart Lamp', iconResource: $r('app.media.ic_star'), isActive: true, accentColor: '#FFC107' },
    { name: 'Thermostat', iconResource: $r('app.media.ic_menu'), isActive: true, accentColor: '#FF7043' },
    { name: 'Main Lock', iconResource: $r('app.media.ic_lock'), isActive: false, accentColor: '#4CAF50' },
    { name: 'Wi-Fi Router', iconResource: $r('app.media.ic_settings'), isActive: true, accentColor: '#2196F3' }
  ];

  aboutToAppear() {
    // Hide system bars for immersive experience similar to the Kotlin code
    let windowClass: window.Window | undefined = undefined;
    try {
      windowClass = window.getWindowSync(this.getUIContext().getHostContext());
      if (windowClass) {
        windowClass.setWindowSystemBarEnable([], (err) => {
          if (err.code) {
            console.error(`Failed to set window system bar enable. Code is ${err.code}, message is ${err.message}`);
            return;
          }
        });
      }
    } catch (exception) {
      let error = exception as BusinessError;
      console.error(`Failed to get window. Code is ${error.code}, message is ${error.message}`);
    }
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          // Header Section
          Row() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontColor('#888888')
                .fontWeight(FontWeight.Medium)
              
              Text('Alex Johnson')
                .fontSize(24)
                .fontColor('#000000')
                .fontWeight(FontWeight.Bold)
            }
            
            Blank()

            Row() {
              Image($r('app.media.ic_person'))
                .width(24)
                .height(24)
                .fillColor('#000000')
            }
            .width(48)
            .height(48)
            .backgroundColor(Color.White)
            .borderRadius(24)
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .margin({ top: 16 })

          Column().height(32)

          // Energy Card
          Row() {
            Column() {
              Text('Energy Usage')
                .fontColor('#CCFFFFFF') // White with 0.8 alpha approx
                .fontSize(14)
              
              Text('28.5 kWh')
                .fontColor(Color.White)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                
              Text('Today')
                .fontColor('#99FFFFFF') // White with 0.6 alpha approx
                .fontSize(12)
            }
            
            Blank()

            Row() {
              Image($r('app.media.ic_notifications'))
                .width(24)
                .height(24)
                .fillColor(Color.White)
            }
            .width(56)
            .height(56)
            .backgroundColor('#33FFFFFF') // White with 0.2 alpha approx
            .borderRadius(28)
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#5E60CE')
          .borderRadius(24)
          .shadow({ radius: 8, color: '#33000000', offsetY: 4 })

          Column().height(32)

          // Scenes Section
          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Column().height(16)

          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
            ForEach(this.scenes, (scene: SceneData) => {
              this.SceneButton(scene)
            }, (item: SceneData) => item.text)
          }
          .width('100%')
          .itemMargin(12)

          Column().height(32)

          // Devices Section
          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Column().height(16)

          GridContainer()
            .columnsTemplate('1fr 1fr')
            .rowsTemplate('auto auto')
            .gap(16)
            .width('100%')
            .children(() => {
              ForEach(this.devices, (device: DeviceData) => {
                this.DeviceCard(device)
              }, (item: DeviceData) => item.name)
            })

          Column().height(24)
        }
        .width('100%')
        .padding(24)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
  }

  @Builder
  SceneButton(scene: SceneData) {
    Row() {
      Image(scene.iconResource)
        .width(18)
        .height(18)
        .fillColor(scene.isSelected ? Color.White : '#000000')
      
      Text(scene.text)
        .fontSize(14)
        .fontColor(scene.isSelected ? Color.White : '#000000')
        .fontWeight(FontWeight.Medium)
        .margin({ left: 8 })
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(scene.isSelected ? '#212121' : Color.White)
    .borderRadius(30)
    .onClick(() => {
      // Toggle selection logic could go here
    })
  }

  @Builder
  DeviceCard(device: DeviceData) {
    Column() {
      Row() {
        Row() {
          Image(device.iconResource)
            .width(24)
            .height(24)
            .fillColor(device.isActive ? device.accentColor : '#888888')
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(device.isActive ? `${device.accentColor}1A` : '#F0F0F0') // 1A hex is approx 0.1 alpha
        .justifyContent(FlexAlign.Center)
        
        Blank()
      }
      .width('100%')

      Column() {
        Text(device.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        
        Text(device.isActive ? 'On' : 'Off')
          .fontSize(14)
          .fontColor(device.isActive ? device.accentColor : '#888888')
          .fontWeight(FontWeight.Medium)
          .margin({ top: 4 })
      }

      Row() {
        Toggle({ type: ToggleType.Switch, isOn: device.isActive })
          .width(52 * 0.8)
          .height(32 * 0.8)
          .selectedColor(device.accentColor)
          .onChange((isOn: boolean) => {
            // Update state in real app
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .aspectRatio(0.85)
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .shadow({ radius: 2, color: '#1A000000', offsetY: 2 })
  }
}