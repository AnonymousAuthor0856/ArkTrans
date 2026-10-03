@Entry
@Component
struct SmartHomeApp {
  @State switchStates: boolean[] = [true, true, false, true, false, true]
  private deviceNames: string[] = ['Living Room', 'Smart Lock', 'Bedroom AC', 'Router', 'Kitchen', 'Corridor']
  private deviceIcons: string[] = ['🏠', '🔒', '⭐', '📍', 'ℹ️', '🔔']

  private generateIndices(count: number): number[] {
    let arr: number[] = []
    for (let i = 0; i < count; i++) { arr.push(i) }
    return arr
  }

  build() {
    Stack({ alignContent: Alignment.BottomStart }) {
      // Background
      Column().width('100%').height('100%').backgroundColor('#F5F6F8')

      // Main list
      List({ space: 0 }) {
        // Header
        ListItem() {
          Row({ space: 0 }) {
            Column({ space: 4 }) {
              Text('Welcome Home,').fontSize(16).foregroundColor('#808080')
              Text('Alex Johnson').fontSize(28).fontWeight(FontWeight.Bold).foregroundColor('#000000')
            }.alignItems(HorizontalAlign.Start)
            Blank()
            Stack({ alignContent: Alignment.Center }) {
              Column().width(48).height(48).backgroundColor('#4A6572').opacity(0.1).borderRadius(24)
              Text('👤').fontSize(32).foregroundColor('#4A6572')
            }.width(48).height(48)
          }.width('100%').padding({ left: 24, right: 24, top: 24 })
        }

        // Environment cards
        ListItem() {
          Row({ space: 16 }) {
            Column({ space: 0 }) {
              Text('Temperature').fontSize(12).fontWeight(FontWeight.Medium).foregroundColor('#1565C0').opacity(0.8)
              Column({ space: 0 }) {
                Text('24°C').fontSize(22).fontWeight(FontWeight.Bold).foregroundColor('#1565C0')
                Text('Comfortable').fontSize(11).foregroundColor('#1565C0').opacity(0.7)
              }.alignItems(HorizontalAlign.Start)
            }.padding(16).layoutWeight(1).height(100).backgroundColor('#E3F2FD').borderRadius(16)

            Column({ space: 0 }) {
              Text('Humidity').fontSize(12).fontWeight(FontWeight.Medium).foregroundColor('#2E7D32').opacity(0.8)
              Column({ space: 0 }) {
                Text('45%').fontSize(22).fontWeight(FontWeight.Bold).foregroundColor('#2E7D32')
                Text('Normal').fontSize(11).foregroundColor('#2E7D32').opacity(0.7)
              }.alignItems(HorizontalAlign.Start)
            }.padding(16).layoutWeight(1).height(100).backgroundColor('#E8F5E9').borderRadius(16)
          }.width('100%').padding({ left: 24, right: 24 })
        }

        // Devices grid
        ListItem() {
          Column({ space: 16 }) {
            Text('My Devices').fontSize(20).fontWeight(FontWeight.Bold).foregroundColor('#000000').width('100%')
            Grid() {
              ForEach(this.generateIndices(6), (index: number) => {
                GridItem() {
                  this.buildDeviceCard(index)
                }
              })
            }.columnsTemplate('1fr 1fr').columnsGap(16).rowsGap(16).width('100%')
          }.padding({ left: 24, right: 24 })
        }

        // Bottom spacer
        ListItem() {
          Column().height(100).width('100%')
        }
      }.width('100%').layoutWeight(1).padding({ top: 24 })

      // Bottom navigation bar (overlay)
      Column() {
        Column().width('100%').height(80).backgroundColor('#FFFFFF')
          .borderRadius({ topLeft: 24, topRight: 24 })
          .shadow({ radius: 4, color: '#0D000000', offsetY: -2 })
        Row({ space: 0 }) {
          this.buildNavItem('🏠', 'Home', true)
          this.buildNavItem('⭐', 'Scenes', false)
          this.buildNavItem('⚙️', 'Settings', false)
        }.width('100%').justifyContent(FlexAlign.SpaceEvenly).padding({ top: 16 })
          .margin({ top: -80 })
      }.width('100%')
    }.width('100%').height('100%')
  }

  @Builder
  buildDeviceCard(index: number) {
    let isOn = this.switchStates[index]
    Column({ space: 0 }) {
      Row({ space: 0 }) {
        Stack({ alignContent: Alignment.Center }) {
          Column().width(36).height(36)
            .backgroundColor(isOn ? '#FFFFFF' : '#F0F0F0')
            .opacity(isOn ? 0.2 : 1.0).borderRadius(18)
          Text(this.deviceIcons[index]).fontSize(14)
            .foregroundColor(isOn ? '#FFFFFF' : '#808080')
        }
        Blank()
        Button() {
          Text(isOn ? 'ON' : 'OFF').fontSize(10).fontWeight(FontWeight.Medium)
            .foregroundColor(isOn ? '#FFFFFF' : '#000000')
            .padding({ left: 4, right: 4, top: 2, bottom: 2 })
        }.backgroundColor(isOn ? '#FFFFFF' : '#E0E0E0')
          .opacity(isOn ? 0.4 : 1.0).borderRadius(16)
          .onClick(() => { this.switchStates[index] = !this.switchStates[index] })
      }.width('100%')
      Column({ space: 4 }) {
        Text(this.deviceNames[index]).fontSize(14).fontWeight(FontWeight.Medium)
          .foregroundColor(isOn ? '#FFFFFF' : '#000000')
        Text(isOn ? 'On' : 'Off').fontSize(11)
          .foregroundColor(isOn ? '#FFFFFF' : '#808080')
          .opacity(isOn ? 0.7 : 1.0)
      }.alignItems(HorizontalAlign.Start)
    }.padding(16).height(140)
      .backgroundColor(isOn ? '#4A6572' : '#FFFFFF').borderRadius(20)
      .shadow({ radius: 8, color: isOn ? '#4A6572' : '#0D000000', offsetY: 4 })
      .opacity(isOn ? 1.0 : 0.95)
  }

  @Builder
  buildNavItem(icon: string, label: string, isSelected: boolean) {
    Column({ space: 4 }) {
      Stack({ alignContent: Alignment.Center }) {
        Column().width(64).height(32)
          .backgroundColor('#4A6572')
          .opacity(isSelected ? 0.1 : 0).borderRadius(16)
        Text(icon).fontSize(24)
          .foregroundColor(isSelected ? '#4A6572' : '#808080')
      }
      Text(label).fontSize(12).fontWeight(FontWeight.Medium)
        .foregroundColor(isSelected ? '#4A6572' : '#808080')
    }
  }
}