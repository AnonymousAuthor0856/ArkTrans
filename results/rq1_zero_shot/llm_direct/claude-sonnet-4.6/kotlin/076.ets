import { router } from '@kit.ArkUI';

@Entry
@Component
struct SmartHomeDashboard {
  @State scrollOffset: number = 0;

  build() {
    Scroll() {
      Column() {
        Spacer({ height: 16 })

        // Header Row
        Row() {
          Column() {
            Text('Good Morning,')
              .fontSize(16)
              .fontColor('#FF9E9E9E')
              .fontWeight(FontWeight.Medium)
            Text('Alex Johnson')
              .fontSize(24)
              .fontColor('#FF000000')
              .fontWeight(FontWeight.Bold)
          }
          .alignItems(HorizontalAlign.Start)

          Stack() {
            Circle()
              .width(48)
              .height(48)
              .fill('#FFFFFFFF')
            Text('👤')
              .fontSize(24)
          }
          .width(48)
          .height(48)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Spacer({ height: 32 })

        // Energy Card
        Column() {
          Row() {
            Column() {
              Text('Energy Usage')
                .fontColor('rgba(255,255,255,0.8)')
                .fontSize(14)
              Text('28.5 kWh')
                .fontColor('#FFFFFFFF')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
              Text('Today')
                .fontColor('rgba(255,255,255,0.6)')
                .fontSize(12)
            }
            .alignItems(HorizontalAlign.Start)

            Stack() {
              Circle()
                .width(56)
                .height(56)
                .fill('rgba(255,255,255,0.2)')
              Text('🔔')
                .fontSize(24)
            }
            .width(56)
            .height(56)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .padding(24)
        }
        .width('100%')
        .backgroundColor('#FF5E60CE')
        .borderRadius(24)
        .shadow({ radius: 8, color: '#33000000', offsetX: 0, offsetY: 4 })

        Spacer({ height: 32 })

        Text('Scenes')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF000000')

        Spacer({ height: 16 })

        // Scenes Row
        Row() {
          SceneButton({ text: 'Home', icon: '🏠', isSelected: true })
          SceneButton({ text: 'Away', icon: '🔒', isSelected: false })
          SceneButton({ text: 'Sleep', icon: '⭐', isSelected: false })
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .space(12)

        Spacer({ height: 32 })

        Text('Devices')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF000000')

        Spacer({ height: 16 })

        // Devices Grid
        Row() {
          Column() {
            DeviceCard({
              name: 'Smart Lamp',
              icon: '⭐',
              isActive: true,
              accentColor: '#FFFFC107'
            })
            Spacer({ height: 16 })
            DeviceCard({
              name: 'Thermostat',
              icon: '☰',
              isActive: true,
              accentColor: '#FFFF7043'
            })
          }
          .layoutWeight(1)

          Spacer({ width: 16 })

          Column() {
            DeviceCard({
              name: 'Main Lock',
              icon: '🔒',
              isActive: false,
              accentColor: '#FF4CAF50'
            })
            Spacer({ height: 16 })
            DeviceCard({
              name: 'Wi-Fi Router',
              icon: '⚙️',
              isActive: true,
              accentColor: '#FF2196F3'
            })
          }
          .layoutWeight(1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)

        Spacer({ height: 24 })
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#FFF4F6F8')
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }
}

@Component
struct SceneButton {
  @Prop text: string = '';
  @Prop icon: string = '';
  @Prop isSelected: boolean = false;

  build() {
    Row() {
      Text(this.icon)
        .fontSize(18)
      Spacer({ width: 8 })
      Text(this.text)
        .fontColor(this.isSelected ? '#FFFFFFFF' : '#FF000000')
        .fontWeight(FontWeight.Medium)
        .fontSize(14)
    }
    .alignItems(VerticalAlign.Center)
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(this.isSelected ? '#FF212121' : '#FFFFFFFF')
    .borderRadius(30)
    .onClick(() => {})
  }
}

@Component
struct DeviceCard {
  @Prop name: string = '';
  @Prop icon: string = '';
  @Prop isActive: boolean = false;
  @Prop accentColor: string = '#FF000000';
  @State switchState: boolean = false;

  aboutToAppear() {
    this.switchState = this.isActive;
  }

  getIconBgColor(): string {
    if (this.switchState) {
      const hex = this.accentColor.replace('#FF', '');
      return `#1A${hex}`;
    }
    return '#FFF0F0F0';
  }

  build() {
    Column() {
      // Top row with icon
      Row() {
        Stack() {
          Circle()
            .width(40)
            .height(40)
            .fill(this.switchState ? this.getIconBgColor() : '#FFF0F0F0')
          Text(this.icon)
            .fontSize(20)
            .fontColor(this.switchState ? this.accentColor : '#FF9E9E9E')
        }
        .width(40)
        .height(40)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      // Device name and status
      Column() {
        Text(this.name)
          .fontWeight(FontWeight.Bold)
          .fontSize(16)
          .fontColor('#FF000000')
        Spacer({ height: 4 })
        Text(this.switchState ? 'On' : 'Off')
          .fontColor(this.switchState ? this.accentColor : '#FF9E9E9E')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')

      // Switch row
      Row() {
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .width(42)
          .height(26)
          .selectedColor(this.accentColor)
          .switchPointColor('#FFFFFFFF')
          .onChange((isOn: boolean) => {
            this.switchState = isOn;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .aspectRatio(0.85)
    .padding(16)
    .backgroundColor('#FFFFFFFF')
    .borderRadius(20)
    .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}

@Builder
function Spacer(options: { height?: number, width?: number }) {
  if (options.height) {
    Row()
      .height(options.height)
      .width('100%')
  }
  if (options.width) {
    Column()
      .width(options.width)
      .height('100%')
  }
}