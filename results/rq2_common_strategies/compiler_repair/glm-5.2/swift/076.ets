// Index.ets

@Entry
@Component
struct SmartHomeDashboard {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F4F6F8')

      // Main Scrollable Content
      Scroll() {
        Column() {
          // Header
          Row() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#808080')
              Text('Alex Johnson')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            // Profile Icon
            Stack() {
              Circle({ width: 48, height: 48 })
                .fill(Color.White)
              Image($r('sys.symbol.person_fill'))
                .width(24)
                .height(24)
                .fillColor(Color.Black)
            }
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .margin({ top: 16 })

          // Energy Usage Card
          Row() {
            Column() {
              Text('Energy Usage')
                .fontSize(14)
                .fontColor('rgba(255, 255, 255, 0.8)')
              Text('28.5 kWh')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .margin({ top: 4, bottom: 4 })
              Text('Today')
                .fontSize(12)
                .fontColor('rgba(255, 255, 255, 0.6)')
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Stack() {
              Circle({ width: 56, height: 56 })
                .fill('rgba(255, 255, 255, 0.2)')
              Image($r('sys.symbol.bell_fill'))
                .width(24)
                .height(24)
                .fillColor(Color.White)
            }
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#5E60CE')
          .borderRadius(24)
          .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.1)', offsetY: 4 })
          .margin({ left: 24, right: 24, top: 32 })

          // Scenes Section
          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
            .padding({ left: 24, right: 24 })
            .margin({ top: 32 })

          // Horizontal Scroll for Scenes
          Scroll() {
            Row({ space: 12 }) {
              Blank().width(12) // Leading padding
              
              this.SceneButton('Home', $r('sys.symbol.house_fill'), true)
              this.SceneButton('Away', $r('sys.symbol.lock_fill'), false)
              this.SceneButton('Sleep', $r('sys.symbol.star_fill'), false)
              
              Blank().width(12) // Trailing padding
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .margin({ top: 16 })

          // Devices Section
          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
            .padding({ left: 24, right: 24 })
            .margin({ top: 32 })

          // Devices Grid
          Row({ space: 16 }) {
            // Column 1
            Column({ space: 16 }) {
              this.DeviceCard('Smart Lamp', $r('sys.symbol.star_fill'), true, '#FFC107')
              this.DeviceCard('Thermostat', $r('sys.symbol.line_3_horizontal'), true, '#FF7043')
            }
            .layoutWeight(1)

            // Column 2
            Column({ space: 16 }) {
              this.DeviceCard('Main Lock', $r('sys.symbol.lock_fill'), false, '#4CAF50')
              this.DeviceCard('Wi-Fi Router', $r('sys.symbol.gearshape_fill'), true, '#2196F3')
            }
            .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .margin({ top: 16, bottom: 24 })
        }
      }
      .scrollBar(BarState.Off)
      .align(Alignment.Top)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  SceneButton(text: string, icon: Resource, isSelected: boolean) {
    Row({ space: 8 }) {
      Image(icon)
        .width(18)
        .height(18)
        .fillColor(isSelected ? Color.White : Color.Black)
      
      Text(text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? Color.White : Color.Black)
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(isSelected ? '#212121' : Color.White)
    .borderRadius(30)
  }

  @Builder
  DeviceCard(name: string, icon: Resource, isActive: boolean, accentColor: ResourceColor) {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 40, height: 40 })
            .fill(isActive ? this.hexToRgba(accentColor as string, 0.1) : '#F0F0F0')
          Image(icon)
            .width(24)
            .height(24)
            .fillColor(isActive ? accentColor : '#808080')
        }
        Blank()
      }
      .width('100%')

      Blank()

      Column() {
        Text(name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text(isActive ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(isActive ? accentColor : '#808080')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: isActive })
          .selectedColor(accentColor)
          .scale({ x: 0.8, y: 0.8 })
      }
      .width('100%')
    }
    .padding(16)
    .aspectRatio(0.85)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.05)', offsetY: 1 })
  }

  // Helper function to convert hex to rgba
  private hexToRgba(hex: string, alpha: number): string {
    const r = parseInt(hex.slice(1, 3), 16);
    const g = parseInt(hex.slice(3, 5), 16);
    const b = parseInt(hex.slice(5, 7), 16);
    return `rgba(${r}, ${g}, ${b}, ${alpha})`;
  }
}