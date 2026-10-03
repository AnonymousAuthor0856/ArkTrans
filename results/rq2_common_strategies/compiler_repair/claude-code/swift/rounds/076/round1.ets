@Entry
@Component
struct SmartHomeDashboard {
  @State scenes: { text: string, icon: string, selected: boolean }[] = [
    { text: 'Home', icon: '⌂', selected: true },
    { text: 'Away', icon: '🔒', selected: false },
    { text: 'Sleep', icon: '★', selected: false }
  ]

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F4F6F8')

      Scroll() {
        Column() {
          // Header
          Row() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#888888')
              Text('Alex Johnson')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            // Avatar circle
            Stack() {
              Circle({ width: 48, height: 48 })
                .fill('#FFFFFF')
              Text('👤')
                .fontSize(24)
            }
            .width(48)
            .height(48)
          }
          .width('100%')
          .padding({ left: 24, right: 24, top: 16 })

          // Energy Usage Card
          Stack() {
            Row() {
              Column() {
                Text('Energy Usage')
                  .fontSize(14)
                  .fontColor('rgba(255,255,255,0.8)')
                Text('28.5 kWh')
                  .fontSize(32)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
                  .margin({ top: 4 })
                Text('Today')
                  .fontSize(12)
                  .fontColor('rgba(255,255,255,0.6)')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Stack() {
                Circle({ width: 56, height: 56 })
                  .fill('rgba(255,255,255,0.2)')
                Text('🔔')
                  .fontSize(24)
              }
              .width(56)
              .height(56)
            }
            .width('100%')
            .padding(24)
          }
          .width('100%')
          .backgroundColor('#5E60CE')
          .borderRadius(24)
          .margin({ left: 24, right: 24, top: 32 })
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: 4 })

          // Scenes Section
          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
            .padding({ left: 24, right: 24, top: 32 })

          // Horizontal scroll scenes
          Scroll() {
            Row() {
              ForEach(this.scenes, (item: { text: string, icon: string, selected: boolean }, index: number) => {
                SceneButton({
                  text: item.text,
                  icon: item.icon,
                  isSelected: item.selected,
                  onSelect: () => {
                    this.scenes.forEach((s, i) => { s.selected = (i === index) })
                  }
                })
              }, (item: { text: string }) => item.text)
            }
            .padding({ left: 24, right: 24 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .margin({ top: 16 })
          .width('100%')

          // Devices Section
          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
            .padding({ left: 24, right: 24, top: 32 })

          // Devices Grid - 2 columns
          Row() {
            Column() {
              DeviceCard({ name: 'Smart Lamp', icon: '💡', isActive: true, accentColor: '#FFC107' })
              DeviceCard({ name: 'Thermostat', icon: '🌡', isActive: true, accentColor: '#FF7043' })
                .margin({ top: 16 })
            }
            .layoutWeight(1)

            Column() {
              DeviceCard({ name: 'Main Lock', icon: '🔒', isActive: false, accentColor: '#4CAF50' })
              DeviceCard({ name: 'Wi-Fi Router', icon: '⚙', isActive: true, accentColor: '#2196F3' })
                .margin({ top: 16 })
            }
            .layoutWeight(1)
            .margin({ left: 16 })
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .margin({ top: 16 })

          Blank()
            .height(24)
        }
        .width('100%')
        .padding({ top: 24, bottom: 24 })
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct SceneButton {
  text: string = ''
  icon: string = ''
  isSelected: boolean = false
  onSelect: () => void = () => {}

  build() {
    Row() {
      Text(this.icon)
        .fontSize(18)
        .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
        .margin({ left: 8 })
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(this.isSelected ? '#212121' : '#FFFFFF')
    .borderRadius(30)
    .onClick(() => {
      this.onSelect()
    })
  }
}

@Component
struct DeviceCard {
  name: string = ''
  icon: string = ''
  isActive: boolean = false
  accentColor: string = ''
  @State switchState: boolean = this.isActive

  build() {
    Column() {
      // Icon circle
      Row() {
        Stack() {
          Circle({ width: 40, height: 40 })
            .fill(this.switchState ? this.hexWithAlpha(this.accentColor, 0.1) : '#F0F0F0')
          Text(this.icon)
            .fontSize(24)
            .fontColor(this.switchState ? this.accentColor : '#888888')
        }
        .width(40)
        .height(40)
        Blank()
      }
      .width('100%')

      Blank()
        .layoutWeight(1)

      // Device name and status
      Column() {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text(this.switchState ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.switchState ? this.accentColor : '#888888')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')

      Blank()
        .layoutWeight(1)

      // Toggle switch
      Row() {
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .selectedColor(this.accentColor)
          .onChange((value: boolean) => {
            this.switchState = value
          })
          .scale({ x: 0.8, y: 0.8 })
      }
      .width('100%')
    }
    .width('100%')
    .aspectRatio(0.85)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 2, color: 'rgba(0,0,0,0.05)', offsetY: 1 })
  }

  hexWithAlpha(hex: string, alpha: number): string {
    const r = parseInt(hex.slice(1, 3), 16)
    const g = parseInt(hex.slice(3, 5), 16)
    const b = parseInt(hex.slice(5, 7), 16)
    return `rgba(${r},${g},${b},${alpha})`
  }
}
