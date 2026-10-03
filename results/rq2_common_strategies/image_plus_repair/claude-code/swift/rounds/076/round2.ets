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
                Column() {
                  Circle({ width: 12, height: 12 })
                    .fill(Color.Black)
                  Ellipse({ width: 20, height: 10 })
                    .fill(Color.Black)
                    .margin({ top: 2 })
                }
              }
              .width(48)
              .height(48)
            }
            .width('100%')
            .padding({ left: 24, right: 24 })
            .margin({ top: 16 })

            // Energy Usage Card
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
                Column() {
                  Ellipse({ width: 24, height: 20 })
                    .fill(Color.White)
                    .margin({ bottom: -2 })
                  Circle({ width: 6, height: 6 })
                    .fill(Color.White)
                    .margin({ top: 2 })
                }
              }
              .width(56)
              .height(56)
            }
            .width('100%')
            .padding(24)
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
                SceneButton({ iconType: IconType.HOME, text: "Home", isSelected: this.homeSelected })
                  .onClick(() => {
                    this.homeSelected = true;
                    this.awaySelected = false;
                    this.sleepSelected = false;
                  })
                SceneButton({ iconType: IconType.LOCK, text: "Away", isSelected: this.awaySelected })
                  .margin({ left: 12 })
                  .onClick(() => {
                    this.homeSelected = false;
                    this.awaySelected = true;
                    this.sleepSelected = false;
                  })
                SceneButton({ iconType: IconType.STAR, text: "Sleep", isSelected: this.sleepSelected })
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
                DeviceCard({ iconType: IconType.STAR, name: "Smart Lamp", accentColor: '#FFC107', isOn: $smartLampOn })
                DeviceCard({ iconType: IconType.LIST, name: "Thermostat", accentColor: '#FF7043', isOn: $thermostatOn })
                  .margin({ top: 16 })
              }
              .layoutWeight(1)

              Column() {
                DeviceCard({ iconType: IconType.LOCK, name: "Main Lock", accentColor: '#4CAF50', isOn: $mainLockOn })
                DeviceCard({ iconType: IconType.GEAR, name: "Wi-Fi Router", accentColor: '#2196F3', isOn: $wifiRouterOn })
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
}

enum IconType {
  HOME,
  LOCK,
  STAR,
  LIST,
  GEAR
}

@Component
struct SceneButton {
  iconType: IconType = IconType.HOME;
  text: string = "";
  isSelected: boolean = false;

  build() {
    Row() {
      IconShape({ type: this.iconType, size: 18, color: this.isSelected ? Color.White : Color.Black })
      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? Color.White : Color.Black)
        .margin({ left: 8 })
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(this.isSelected ? '#212121' : Color.White)
    .borderRadius(30)
  }
}

@Component
struct DeviceCard {
  iconType: IconType = IconType.STAR;
  name: string = "";
  accentColor: string = '#FFC107';
  @Link isOn: boolean;

  build() {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 40, height: 40 })
            .fill(this.isOn ? this.hexToRgba(this.accentColor, 0.1) : '#F0F0F0')
          IconShape({ type: this.iconType, size: 24, color: this.isOn ? this.accentColor : Color.Gray })
        }
        .width(40)
        .height(40)
        Blank()
      }
      .width('100%')

      Blank()

      Column() {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text(this.isOn ? "On" : "Off")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isOn ? this.accentColor : Color.Gray)
          .margin({ top: 4 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: this.isOn })
          .onChange((val: boolean) => { this.isOn = val; })
          .selectedColor(this.accentColor)
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

@Component
struct IconShape {
  type: IconType = IconType.STAR;
  size: number = 24;
  color: ResourceColor = Color.Black;

  build() {
    Stack() {
      if (this.type === IconType.HOME) {
        Column() {
          // Roof - triangle via Path
          Path()
            .width(this.size)
            .height(this.size * 0.5)
            .commands(this.getHomeRoofPath(this.size))
            .fill(this.color)
          // House body
          Row() {
            Rect({ width: this.size * 0.18, height: this.size * 0.5 })
              .fill(this.color)
            Blank()
              .width(this.size * 0.1)
            Rect({ width: this.size * 0.18, height: this.size * 0.5 })
              .fill(this.color)
          }
          .width(this.size)
          .height(this.size * 0.5)
        }
        .width(this.size)
        .height(this.size)
      } else if (this.type === IconType.LOCK) {
        Column() {
          // Lock shackle (U-shape via Path)
          Path()
            .width(this.size)
            .height(this.size * 0.5)
            .commands(this.getLockShacklePath(this.size))
            .stroke(this.color)
            .strokeWidth(this.size * 0.12)
            .fill('transparent')
          // Lock body
          RoundedRect({ width: this.size * 0.8, height: this.size * 0.5, radius: this.size * 0.08 })
            .fill(this.color)
            .margin({ top: -this.size * 0.05 })
        }
        .width(this.size)
        .height(this.size)
      } else if (this.type === IconType.STAR) {
        Path()
          .width(this.size)
          .height(this.size)
          .commands(this.getStarPath(this.size))
          .fill(this.color)
      } else if (this.type === IconType.LIST) {
        Column() {
          RoundedRect({ width: this.size, height: this.size * 0.12, radius: this.size * 0.06 })
            .fill(this.color)
          RoundedRect({ width: this.size, height: this.size * 0.12, radius: this.size * 0.06 })
            .fill(this.color)
            .margin({ top: this.size * 0.12 })
          RoundedRect({ width: this.size, height: this.size * 0.12, radius: this.size * 0.06 })
            .fill(this.color)
            .margin({ top: this.size * 0.12 })
        }
        .width(this.size)
        .height(this.size)
        .justifyContent(FlexAlign.Center)
      } else if (this.type === IconType.GEAR) {
        Stack() {
          // Outer circle
          Circle({ width: this.size * 0.7, height: this.size * 0.7 })
            .fill(this.color)
          // Center hole
          Circle({ width: this.size * 0.3, height: this.size * 0.3 })
            .fill(Color.White)
          // 6 teeth as rectangles
          Column() {
            Rect({ width: this.size * 0.15, height: this.size * 0.85 })
              .fill(this.color)
          }
          .width(this.size)
          .height(this.size)
          .justifyContent(FlexAlign.Center)
          Column() {
            Rect({ width: this.size * 0.85, height: this.size * 0.15 })
              .fill(this.color)
          }
          .width(this.size)
          .height(this.size)
          .justifyContent(FlexAlign.Center)
          Stack() {
            Rect({ width: this.size * 0.15, height: this.size * 0.85 })
              .fill(this.color)
          }
          .width(this.size)
          .height(this.size)
          .rotate({ angle: 45 })
          Stack() {
            Rect({ width: this.size * 0.85, height: this.size * 0.15 })
              .fill(this.color)
          }
          .width(this.size)
          .height(this.size)
          .rotate({ angle: 45 })
        }
        .width(this.size)
        .height(this.size)
      }
    }
    .width(this.size)
    .height(this.size)
  }

  getHomeRoofPath(size: number): string {
    return `M${size * 0.5} 0 L0 ${size * 0.45} L${size} ${size * 0.45} Z`;
  }

  getLockShacklePath(size: number): string {
    let halfW = size * 0.25;
    let cx = size * 0.5;
    let top = size * 0.05;
    let bottom = size * 0.45;
    return `M${cx - halfW} ${bottom} Q${cx - halfW} ${top} ${cx} ${top} Q${cx + halfW} ${top} ${cx + halfW} ${bottom}`;
  }

  getStarPath(size: number): string {
    let cx = size / 2;
    let cy = size / 2;
    let outerR = size / 2;
    let innerR = size * 0.22;
    let path = "";
    for (let i = 0; i < 10; i++) {
      let r = i % 2 === 0 ? outerR : innerR;
      let angle = (Math.PI / 5) * i - Math.PI / 2;
      let x = cx + r * Math.cos(angle);
      let y = cy + r * Math.sin(angle);
      path += (i === 0 ? "M" : "L") + x.toFixed(1) + " " + y.toFixed(1) + " ";
    }
    path += "Z";
    return path;
  }
}
