@Entry
@Component
struct CryoGenMonitorScreen {
  @State isLocked: boolean = true;

  private logs: LogEntry[] = [
    { time: "08:00 AM", message: "Auto-Cycle Complete", isSystem: true },
    { time: "07:45 AM", message: "Pressure stabilized", isSystem: true },
    { time: "06:30 AM", message: "Technician access", isSystem: false },
    { time: "02:15 AM", message: "Nitrogen refill", isSystem: true },
    { time: "Yesterday", message: "System Reboot", isSystem: true }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Row() {
          Column({ space: 0 }) {
            Text("UNIT-04")
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor("#757575")
            Text("CryoGen Monitor")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor("#212121")
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            Image($r('sys.media.ohos_ic_public_settings'))
              .width(24)
              .height(24)
              .fillColor("#212121")
          }
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .height(40)
          .width(40)
        }
        .width('100%')
        .height(56)
        .padding({ top: 24, bottom: 12, left: 24, right: 24 })
        .backgroundColor(Color.White)

        // Content
        Scroll() {
          Column({ space: 0 }) {
            // Status Badge
            Row({ space: 8 }) {
              Text("✓")
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor("#388E3C")
              Text("SYSTEM NOMINAL")
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor("#388E3C")
            }
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .border({
              width: 1,
              color: "#388E3C80"
            })
            .borderRadius(50)
            .margin({ top: 16 })

            // Temperature Display
            Column({ space: 0 }) {
              Text("CORE TEMPERATURE")
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor("#757575")

              Row() {
                Text("-184.2")
                  .fontSize(64)
                  .fontWeight(FontWeight.Lighter)
                  .fontColor("#212121")
                Text("°C")
                  .fontSize(24)
                  .fontWeight(FontWeight.Regular)
                  .fontColor("#757575")
                  .baselineOffset(-12)
              }
              .alignItems(VerticalAlign.Bottom)
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ top: 32 })

            // Sensor Grid
            Column({ space: 12 }) {
              Row({ space: 12 }) {
                this.SensorCard("PRESSURE", "1.02", "Bar", "info", false)
                this.SensorCard("O2 LEVEL", "19.5", "%", "warning", true)
              }
              .width('100%')

              Row({ space: 12 }) {
                this.SensorCard("POWER", "Stable", "AC", "wrench", false)
                this.SensorCard("LIQUID N2", "88", "%", "refresh", false)
              }
              .width('100%')
            }
            .margin({ top: 32 })

            // Maintenance Log Header
            Text("MAINTENANCE LOG")
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor("#757575")
              .letterSpacing(1.5)
              .margin({ top: 24 })

            // Log List
            Column({ space: 8 }) {
              ForEach(this.logs, (item: LogEntry) => {
                Column({ space: 0 }) {
                  Row({ space: 12 }) {
                    Stack({ alignContent: Alignment.Center }) {
                      Circle({ width: 32, height: 32 })
                        .fill("#F5F5F5")
                      Text(item.isSystem ? "i" : "\u{1F527}")
                        .fontSize(16)
                        .fontColor("#757575")
                    }
                    .width(32)
                    .height(32)

                    Column({ space: 2 }) {
                      Text(item.message)
                        .fontSize(14)
                        .fontWeight(FontWeight.Medium)
                        .fontColor("#212121")
                      Text(item.time)
                        .fontSize(11)
                        .fontColor("#757575")
                    }
                    .alignItems(HorizontalAlign.Start)

                    Blank()
                  }
                  .width('100%')
                  .padding({ top: 4, bottom: 4 })

                  Divider()
                    .color("#F5F5F5")
                    .strokeWidth(1)
                }
              }, (item: LogEntry, index: number) => index.toString())
            }
            .margin({ top: 8 })

            Blank()
              .height(100)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .scrollBar(BarState.Off)
        .flexGrow(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      // Bottom Control Bar
      Column({ space: 0 }) {
        Row({ space: 0 }) {
          Column({ space: 2 }) {
            Text("MANUAL OVERRIDE")
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor("#757575")
            Text(this.isLocked ? "LOCKED" : "ACTIVE")
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.isLocked ? "#212121" : "#D32F2F")
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
            .selectedColor("#D32F2F")
            .onChange((isOn: boolean) => {
              this.isLocked = !isOn;
            })
        }
        .width('100%')
        .padding(24)
        .backgroundColor(Color.White)
      }
      .width('100%')
      .shadow({
        radius: 12,
        color: "#1A000000",
        offsetY: -4
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  SensorCard(title: string, value: string, unit: string, iconName: string, isWarning: boolean) {
    Column({ space: 0 }) {
      // Header Row
      Row() {
        if (iconName === "info") {
          Text("i")
            .fontSize(20)
            .fontColor(isWarning ? "#D32F2F" : "#0066CC")
            .fontWeight(FontWeight.Bold)
        } else if (iconName === "warning") {
          Text("!")
            .fontSize(20)
            .fontColor(isWarning ? "#D32F2F" : "#0066CC")
            .fontWeight(FontWeight.Bold)
        } else if (iconName === "wrench") {
          Text("\u{1F527}")
            .fontSize(20)
            .fontColor(isWarning ? "#D32F2F" : "#0066CC")
        } else if (iconName === "refresh") {
          Text("\u{21BB}")
            .fontSize(20)
            .fontColor(isWarning ? "#D32F2F" : "#0066CC")
        }

        Blank()

        if (isWarning) {
          Circle({ width: 6, height: 6 })
            .fill("#D32F2F")
        }
      }
      .width('100%')

      Column({ space: 0 }) {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor("#212121")
          .margin({ top: 12 })
        Text(unit + "  " + title)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor("#757575")
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(16)
    .backgroundColor("#F5F5F5")
    .borderRadius(12)
    .flexGrow(1)
  }
}

interface LogEntry {
  time: string;
  message: string;
  isSystem: boolean;
}
