@Entry
@Component
struct SmartHomeApp {
  @State isChecked0: boolean = true
  @State isChecked1: boolean = true
  @State isChecked2: boolean = false
  @State isChecked3: boolean = true
  @State isChecked4: boolean = false
  @State isChecked5: boolean = true

  private devices: DeviceItem[] = [
    { name: 'Living Room', status: '2 Lights On', icon: '🏠' },
    { name: 'Smart Lock', status: 'Locked', icon: '🔒' },
    { name: 'Bedroom AC', status: '22°C', icon: '⭐' },
    { name: 'Router', status: 'Online', icon: '📍' },
    { name: 'Kitchen', status: 'All Off', icon: 'ℹ️' },
    { name: 'Corridor', status: 'Motion Detected', icon: '🔔' }
  ]

  private getChecked(index: number): boolean {
    switch (index) {
      case 0: return this.isChecked0
      case 1: return this.isChecked1
      case 2: return this.isChecked2
      case 3: return this.isChecked3
      case 4: return this.isChecked4
      case 5: return this.isChecked5
      default: return false
    }
  }

  private toggleChecked(index: number): void {
    switch (index) {
      case 0: this.isChecked0 = !this.isChecked0; break
      case 1: this.isChecked1 = !this.isChecked1; break
      case 2: this.isChecked2 = !this.isChecked2; break
      case 3: this.isChecked3 = !this.isChecked3; break
      case 4: this.isChecked4 = !this.isChecked4; break
      case 5: this.isChecked5 = !this.isChecked5; break
    }
  }

  private generateIndices(count: number): number[] {
    let arr: number[] = []
    for (let i = 0; i < count; i++) {
      arr.push(i)
    }
    return arr
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F6F8')

      List({ space: 0 }) {
        ListItem() {
          Row({ space: 0 }) {
            Column({ space: 4 }) {
              Text('Welcome Home,')
                .fontSize(16)
                .foregroundColor('#808080')
              Text('Alex Johnson')
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .foregroundColor('#000000')
            }
            .alignItems(HorizontalAlign.Start)
            Blank()
            Stack({ alignContent: Alignment.Center }) {
              Column()
                .width(48)
                .height(48)
                .backgroundColor('#4A6572')
                .opacity(0.1)
                .borderRadius(24)
              Text('👤')
                .fontSize(32)
                .foregroundColor('#4A6572')
            }
            .width(48)
            .height(48)
          }
          .width('100%')
          .padding({ left: 24, right: 24, top: 24 })
        }

        ListItem() {
          Row({ space: 16 }) {
            this.buildEnvCard('Temperature', '24°C', 'Comfortable', '#E3F2FD', '#1565C0')
            this.buildEnvCard('Humidity', '45%', 'Normal', '#E8F5E9', '#2E7D32')
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }

        ListItem() {
          Column({ space: 16 }) {
            Text('My Devices')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .foregroundColor('#000000')
              .width('100%')

            Grid() {
              ForEach(this.generateIndices(this.devices.length), (index: number) => {
                GridItem() {
                  this.buildDeviceCard(index)
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(16)
            .rowsGap(16)
            .width('100%')
          }
          .padding({ left: 24, right: 24 })
        }

        ListItem() {
          Column()
            .height(100)
            .width('100%')
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ top: 24 })

      // Bottom navigation bar overlay
      Stack({ alignContent: Alignment.TopStart }) {
        Column()
          .width('100%')
          .height(80)
          .backgroundColor('#FFFFFF')
          .borderRadius({ topLeft: 24, topRight: 24 })
          .shadow({ radius: 4, color: '#0D000000', offsetY: -2 })

        Row({ space: 0 }) {
          this.buildNavItem('🏠', 'Home', true)
          this.buildNavItem('⭐', 'Scenes', false)
          this.buildNavItem('⚙️', 'Settings', false)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .padding({ top: 16 })
        .position({ x: 0, y: 0 })
      }
      .width('100%')
      .position({ x: 0, y: '100%' })
      .margin({ bottom: 0 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildEnvCard(title: string, value: string, subtitle: string, bg: string, textColor: string) {
    Column({ space: 0 }) {
      Text(title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .foregroundColor(textColor)
        .opacity(0.8)
      Blank()
      Column({ space: 0 }) {
        Text(value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .foregroundColor(textColor)
        Text(subtitle)
          .fontSize(11)
          .foregroundColor(textColor)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .layoutWeight(1)
    .height(100)
    .backgroundColor(bg)
    .borderRadius(16)
  }

  @Builder
  buildDeviceCard(index: number) {
    let device = this.devices[index]
    let isOn = this.getChecked(index)
    Column({ space: 0 }) {
      Row({ space: 0 }) {
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width(36)
            .height(36)
            .backgroundColor(isOn ? '#FFFFFF' : '#F0F0F0')
            .opacity(isOn ? 0.2 : 1.0)
            .borderRadius(18)
          Text(device.icon)
            .fontSize(14)
            .foregroundColor(isOn ? '#FFFFFF' : '#808080')
        }
        Blank()
        Button() {
          Text(isOn ? 'ON' : 'OFF')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .foregroundColor(isOn ? '#FFFFFF' : '#000000')
            .padding({ left: 4, right: 4, top: 2, bottom: 2 })
        }
        .backgroundColor(isOn ? '#FFFFFF' : '#E0E0E0')
        .opacity(isOn ? 0.4 : 1.0)
        .borderRadius(16)
        .onClick(() => {
          this.toggleChecked(index)
        })
      }
      .width('100%')
      Blank()
      Column({ space: 4 }) {
        Text(device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .foregroundColor(isOn ? '#FFFFFF' : '#000000')
        Text(isOn ? 'On' : 'Off')
          .fontSize(11)
          .foregroundColor(isOn ? '#FFFFFF' : '#808080')
          .opacity(isOn ? 0.7 : 1.0)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .height(140)
    .backgroundColor(isOn ? '#4A6572' : '#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: isOn ? '#4A6572' : '#0D000000', offsetY: 4 })
    .opacity(isOn ? 1.0 : 0.95)
  }

  @Builder
  buildNavItem(icon: string, label: string, isSelected: boolean) {
    Column({ space: 4 }) {
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width(64)
          .height(32)
          .backgroundColor('#4A6572')
          .opacity(isSelected ? 0.1 : 0)
          .borderRadius(16)
        Text(icon)
          .fontSize(24)
          .foregroundColor(isSelected ? '#4A6572' : '#808080')
      }
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .foregroundColor(isSelected ? '#4A6572' : '#808080')
    }
  }
}

interface DeviceItem {
  name: string
  status: string
  icon: string
}