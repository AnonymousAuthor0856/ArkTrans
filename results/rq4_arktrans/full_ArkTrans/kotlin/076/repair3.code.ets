@Entry
@Component
struct Index {
  @State isLampOn: boolean = true
  @State isThermostatOn: boolean = true
  @State isLockOn: boolean = false
  @State isWifiOn: boolean = true

  build() {
    Stack() {
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
              .margin({ top: 4 })
          }
          
          Blank()
          
          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#000000')
          }
          .width(48)
          .height(48)
          .backgroundColor('#FFFFFF')
          .borderRadius(24)
        }
        .width('100%')
        .margin({ bottom: 32 })

        // Energy Card
        Column() {
          Row() {
            Column() {
              Text('Energy Usage')
                .fontSize(14)
                .fontColor('rgba(255, 255, 255, 0.8)')
              
              Text('28.5 kWh')
                .fontSize(32)
                .fontColor('#FFFFFF')
                .fontWeight(FontWeight.Bold)
                .margin({ top: 4 })
              
              Text('Today')
                .fontSize(12)
                .fontColor('rgba(255, 255, 255, 0.6)')
                .margin({ top: 4 })
            }
            
            Blank()
            
            Stack({ alignContent: Alignment.Center }) {
               // Using startIcon as a placeholder for the bell icon in the screenshot
               Image($r('app.media.startIcon'))
                 .width(24)
                 .height(24)
                 .fillColor('#FFFFFF')
            }
            .width(56)
            .height(56)
            .backgroundColor('rgba(255, 255, 255, 0.2)')
            .borderRadius(28)
          }
          .width('100%')
          .padding(24)
        }
        .width('100%')
        .height(160)
        .backgroundColor('#5E60CE')
        .borderRadius(24)
        .shadow({ radius: 10, color: '#1A000000', offsetY: 4 })
        .margin({ bottom: 32 })

        // Scenes Section
        Text('Scenes')
          .fontSize(20)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 16 })

        Row({ space: 12 }) {
          // Home Button (Active)
          Row({ space: 8 }) {
             Image($r('app.media.startIcon')).width(18).height(18).fillColor('#FFFFFF')
             Text('Home').fontSize(14).fontColor('#FFFFFF').fontWeight(FontWeight.Medium)
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .height(56)
          .backgroundColor('#222222')
          .borderRadius(28)

          // Away Button (Inactive)
          Row({ space: 8 }) {
             Image($r('app.media.startIcon')).width(18).height(18).fillColor('#000000')
             Text('Away').fontSize(14).fontColor('#000000').fontWeight(FontWeight.Medium)
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .height(56)
          .backgroundColor('#FFFFFF')
          .borderRadius(28)

          // Favorite Button (Inactive/Placeholder)
          Row({ space: 8 }) {
             Image($r('app.media.startIcon')).width(18).height(18).fillColor('#000000')
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .height(56)
          .backgroundColor('#FFFFFF')
          .borderRadius(28)
        }
        .width('100%')
        .margin({ bottom: 32 })

        // Devices Section
        Text('Devices')
          .fontSize(20)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 16 })

        GridRowComponent() {
          DeviceCardItem({
            name: 'Smart Lamp',
            isActive: this.isLampOn,
            accentColor: '#FFC107',
            onToggle: () => this.isLampOn = !this.isLampOn
          })
          
          DeviceCardItem({
            name: 'Main Lock',
            isActive: this.isLockOn,
            accentColor: '#4CAF50',
            onToggle: () => this.isLockOn = !this.isLockOn
          })
        }
        
        GridRowComponent() {
           DeviceCardItem({
            name: 'Thermostat',
            isActive: this.isThermostatOn,
            accentColor: '#FF7043',
            onToggle: () => this.isThermostatOn = !this.isThermostatOn
          })

           DeviceCardItem({
            name: 'Wi-Fi Router',
            isActive: this.isWifiOn,
            accentColor: '#2196F3',
            onToggle: () => this.isWifiOn = !this.isWifiOn
          })
        }

        Blank().height(24)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F4F6F8')
      .padding(24)
    }
    .width('100%')
    .height('100%')
  }
}

// Helper component to render the two-column grid layout
@Component
struct GridRowComponent {
  @BuilderParam content: () => void

  build() {
    Row({ space: 16 }) {
      Column() {
        this.content()
      }.layoutWeight(1)
    }.width('100%')
  }
}

interface DeviceProps {
  name: string;
  isActive: boolean;
  accentColor: string;
  onToggle: () => void;
}

@Component
struct DeviceCardItem {
  @Prop name: string
  @Prop isActive: boolean
  @Prop accentColor: string
  @ObjectLink onToggle: () => void

  build() {
    Column() {
      Column() {
        // Icon Container
        Row() {
          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor(this.isActive ? this.accentColor : '#888888')
          }
          .width(40)
          .height(40)
          .borderRadius(20)
          .backgroundColor(this.isActive ? this.hexToRgba(this.accentColor, 0.1) : '#F0F0F0')
        }
        .width('100%')

        // Text Info
        Column() {
          Text(this.name)
            .fontSize(16)
            .fontColor('#000000')
            .fontWeight(FontWeight.Bold)
            .margin({ top: 12 })
          
          Text(this.isActive ? 'On' : 'Off')
            .fontSize(14)
            .fontColor(this.isActive ? this.accentColor : '#888888')
            .fontWeight(FontWeight.Medium)
            .margin({ top: 4 })
        }

        // Toggle Switch
        Row() {
          Toggle({ type: ToggleType.Switch, isOn: this.isActive })
            .onChange((isOn: boolean) => {
              this.onToggle()
            })
            .width(40) // Scale down effect
            .height(24)
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
        .margin({ top: 12 })

      }
      .width('100%')
      .height('100%')
      .padding(16)
    }
    .width('100%')
    .height(160) // Fixed height to match aspect ratio roughly
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }

  private hexToRgba(hex: string, alpha: number): string {
    let c = hex.substring(1);
    if (c.length === 3) {
      c = c.split('').map(ch => ch + ch).join('');
    }
    const rgb = parseInt(c, 16);
    return `rgba(${(rgb >> 16) & 255}, ${(rgb >> 8) & 255}, ${rgb & 255}, ${alpha})`;
  }
}