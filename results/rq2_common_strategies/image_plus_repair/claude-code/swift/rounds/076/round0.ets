@Entry
@Component
struct SmartHomeDashboard {
  @State homeSelected: boolean = true;
  @State awaySelected: boolean = false;
  @State sleepSelected: boolean = false;
  @State smartLampOn: boolean = true;
  @State mainLockOn: boolean = false;
  @State thermostatOn: boolean = true;
  @State wifiRouterOn: boolean = true;

  build() {
    Stack() {
      Column() {
        Scroll() {
          Column() {
            // Header
            Row() {
              Column() {
                Text("Good Morning,")
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Color.Gray)
                Text("Alex Johnson")
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)
                  .margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Stack() {
                Circle({ width: 48, height: 48 })
                  .fill(Color.White)
                Text("person")
                  .fontSize(24)
                  .fontColor(Color.Black)
              }
              .width(48)
              .height(48)
            }
            .width('100%')
            .padding({ left: 24, right: 24 })
            .margin({ top: 16 })

            // Energy Usage Card
            Stack() {
              Row() {
                Column() {
                  Text("Energy Usage")
                    .fontSize(14)
                    .fontColor('rgba(255, 255, 255, 0.8)')
                  Text("28.5 kWh")
                    .fontSize(32)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.White)
                    .margin({ top: 4 })
                  Text("Today")
                    .fontSize(12)
                    .fontColor('rgba(255, 255, 255, 0.6)')
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Stack() {
                  Circle({ width: 56, height: 56 })
                    .fill('rgba(255, 255, 255, 0.2)')
                  Text("notifications")
                    .fontSize(24)
                    .fontColor(Color.White)
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
            .shadow({
              radius: 8,
              color: 'rgba(0, 0, 0, 0.1)',
              offsetX: 0,
              offsetY: 4
            })
            .margin({ left: 24, right: 24, top: 32 })

            // Scenes Section
            Text("Scenes")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .width('100%')
              .padding({ left: 24, right: 24 })
              .margin({ top: 32 })

            // Scenes Horizontal Scroll
            Scroll() {
              Row() {
                this.SceneButton("home", "Home", this.homeSelected)
                  .onClick(() => {
                    this.homeSelected = true;
                    this.awaySelected = false;
                    this.sleepSelected = false;
                  })
                this.SceneButton("lock", "Away", this.awaySelected)
                  .margin({ left: 12 })
                  .onClick(() => {
                    this.homeSelected = false;
                    this.awaySelected = true;
                    this.sleepSelected = false;
                  })
                this.SceneButton("star", "Sleep", this.sleepSelected)
                  .margin({ left: 12 })
                  .onClick(() => {
                    this.homeSelected = false;
                    this.awaySelected = false;
                    this.sleepSelected = true;
                  })
              }
              .padding({ left: 24, right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .margin({ top: 16 })
            .width('100%')

            // Devices Section
            Text("Devices")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .width('100%')
              .padding({ left: 24, right: 24 })
              .margin({ top: 32 })

            // Devices Grid
            Row() {
              Column() {
                this.DeviceCard("star", "Smart Lamp", this.smartLampOn, '#FFC107')
                  .onChange((val: boolean) => { this.smartLampOn = val; })
                this.DeviceCard("view_list", "Thermostat", this.thermostatOn, '#FF7043')
                  .margin({ top: 16 })
                  .onChange((val: boolean) => { this.thermostatOn = val; })
              }
              .layoutWeight(1)

              Column() {
                this.DeviceCard("lock", "Main Lock", this.mainLockOn, '#4CAF50')
                  .onChange((val: boolean) => { this.mainLockOn = val; })
                this.DeviceCard("settings", "Wi-Fi Router", this.wifiRouterOn, '#2196F3')
                  .margin({ top: 16 })
                  .onChange((val: boolean) => { this.wifiRouterOn = val; })
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
          .alignItems(HorizontalAlign.Start)
          .padding({ top: 24, bottom: 24 })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F4F6F8')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  SceneButton(icon: string, text: string, isSelected: boolean) {
    Row() {
      Text(icon)
        .fontSize(18)
        .fontColor(isSelected ? Color.White : Color.Black)
      Text(text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? Color.White : Color.Black)
        .margin({ left: 8 })
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(isSelected ? '#212121' : Color.White)
    .borderRadius(30)
  }

  @Builder
  DeviceCard(icon: string, name: string, @Link isOn: boolean, accentColor: string) {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 40, height: 40 })
            .fill(isOn ? this.hexToRgba(accentColor, 0.1) : '#F0F0F0')
          Text(icon)
            .fontSize(24)
            .fontColor(isOn ? accentColor : Color.Gray)
        }
        .width(40)
        .height(40)
        Blank()
      }
      .width('100%')

      Blank()

      Column() {
        Text(name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text(isOn ? "On" : "Off")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(isOn ? accentColor : Color.Gray)
          .margin({ top: 4 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: isOn })
          .onChange((val: boolean) => { isOn = val; })
          .selectedColor(accentColor)
          .scale({ x: 0.8, y: 0.8 })
      }
      .width('100%')
    }
    .width('100%')
    .aspectRatio(0.85)
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .shadow({
      radius: 2,
      color: 'rgba(0, 0, 0, 0.05)',
      offsetX: 0,
      offsetY: 1
    })
  }

  hexToRgba(hex: string, alpha: number): string {
    let r = parseInt(hex.slice(1, 3), 16);
    let g = parseInt(hex.slice(3, 5), 16);
    let b = parseInt(hex.slice(5, 7), 16);
    return `rgba(${r}, ${g}, ${b}, ${alpha})`;
  }
}
