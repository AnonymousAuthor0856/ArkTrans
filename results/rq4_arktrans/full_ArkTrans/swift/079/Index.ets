import { router } from '@kit.ArkUI';

interface Device {
  id: string;
  name: string;
  status: string;
  icon: Resource;
  isActive: boolean;
}

@Component
struct EnvironmentCard {
  @Prop title: string = '';
  @Prop value: string = '';
  @Prop subtitle: string = '';
  @Prop bgColor: string = '';
  @Prop textColor: string = '';

  build() {
    Column({ space: 8 }) {
      Text(this.title).fontColor(this.textColor).fontSize(16).opacity(0.8)
      Text(this.value).fontColor(this.textColor).fontSize(32).fontWeight(FontWeight.Bold)
      Text(this.subtitle).fontColor(this.textColor).fontSize(14).opacity(0.8)
    }.width('100%').height(120).padding(20).backgroundColor(this.bgColor).borderRadius(20).alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DeviceCard {
  @Prop device: Device = { id: '', name: '', status: '', icon: $r('app.media.startIcon'), isActive: false };

  build() {
    Column({ space: 12 }) {
      Row() {
        Stack() {
          Circle().width(40).height(40).fill(this.device.isActive ? '#90A4AE' : '#EEEEEE')
          Image(this.device.icon).width(20).height(20).objectFit(ImageFit.Contain)
        }
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: this.device.isActive })
          .onChange((isOn: boolean) => {
            // Logic to toggle state would go here
          })
      }
      
      Column({ space: 4 }) {
        Text(this.device.name).fontColor(this.device.isActive ? '#FFFFFF' : '#000000').fontSize(18).fontWeight(FontWeight.Medium)
        Text(this.device.status).fontColor(this.device.isActive ? '#B0BEC5' : '#9E9E9E').fontSize(14)
      }.alignItems(HorizontalAlign.Start)
    }.width('100%').height(160).padding(20).backgroundColor(this.device.isActive ? '#546E7A' : '#FFFFFF').borderRadius(24).shadow({ radius: 8, color: '#1A000000' }).alignItems(HorizontalAlign.Start)
  }
}

@Component
struct NavBarItem {
  @Prop icon: Resource = $r('app.media.startIcon');
  @Prop label: string = '';
  @Prop isSelected: boolean = false;

  build() {
    Column({ space: 4 }) {
      Stack() {
        if (this.isSelected) {
          Capsule().width(60).height(40).fill('#ECEFF1')
        }
        Image(this.icon).width(28).height(28).objectFit(ImageFit.Contain)
      }
      Text(this.label).fontColor(this.isSelected ? '#546E7A' : '#9E9E9E').fontSize(14).fontWeight(this.isSelected ? FontWeight.Medium : FontWeight.Normal)
    }
  }
}

@Entry
@Component
struct Index {
  @State devices: Device[] = [
    { id: '1', name: 'Living Room', status: 'On', icon: $r('app.media.startIcon'), isActive: true },
    { id: '2', name: 'Smart Lock', status: 'On', icon: $r('app.media.startIcon'), isActive: true },
    { id: '3', name: 'Bedroom AC', status: 'Off', icon: $r('app.media.startIcon'), isActive: false },
    { id: '4', name: 'Router', status: 'On', icon: $r('app.media.startIcon'), isActive: true }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            Blank().height(24)

            Row() {
              Column() {
                Text('Welcome Home,').fontColor('#9E9E9E').fontSize(16)
                Text('Alex Johnson').fontColor('#000000').fontSize(28).fontWeight(FontWeight.Bold)
              }
              Blank()
              Stack() {
                Circle().width(48).height(48).fill('#F0F4F8')
                Image($r('app.media.startIcon')).width(32).height(32).objectFit(ImageFit.Contain)
              }
            }.padding({ left: 24, right: 24 })

            Blank().height(32)

            Row({ space: 16 }) {
              EnvironmentCard({ title: 'Temperature', value: '24°C', subtitle: 'Comfortable', bgColor: '#E3F2FD', textColor: '#1976D2' })
              EnvironmentCard({ title: 'Humidity', value: '45%', subtitle: 'Normal', bgColor: '#E8F5E9', textColor: '#388E3C' })
            }.padding({ left: 24, right: 24 })

            Blank().height(32)

            Column({ space: 16 }) {
              Text('My Devices').fontColor('#000000').fontSize(20).fontWeight(FontWeight.Bold).alignSelf(ItemAlign.Start)
              
              Grid() {
                ForEach(this.devices, (device: Device) => {
                  GridItem() {
                    DeviceCard({ device: device })
                  }
                })
              }.columnsTemplate('1fr 1fr').columnsGap(16).rowsGap(16).padding({ left: 24, right: 24 })
            }

            Blank().height(100)
          }
        }
      }

      Stack({ alignContent: Alignment.Top }) {
        Row() {
          NavBarItem({ icon: $r('app.media.startIcon'), label: 'Home', isSelected: true })
          NavBarItem({ icon: $r('app.media.startIcon'), label: 'Scenes', isSelected: false })
          NavBarItem({ icon: $r('app.media.startIcon'), label: 'Settings', isSelected: false })
        }.justifyContent(FlexAlign.SpaceEvenly).padding({ top: 16, bottom: 16 }).width('100%')
      }.width('100%').height(80).backgroundColor('#FFFFFF').borderRadius({ topLeft: 24, topRight: 24 }).shadow({ radius: 10, color: '#1A000000' })
    }.width('100%').height('100%').backgroundColor('#FAFAFA')
  }
}