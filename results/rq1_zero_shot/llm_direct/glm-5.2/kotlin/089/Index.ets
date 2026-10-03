// MainPage.ets
interface LogEntry {
  time: string;
  message: string;
  isSystem: boolean;
}

@Entry
@Component
struct CryoGenApp {
  private logs: LogEntry[] = [
    { time: "08:00 AM", message: "Auto-Cycle Complete", isSystem: true },
    { time: "07:45 AM", message: "Pressure stabilized", isSystem: true },
    { time: "06:30 AM", message: "Technician access", isSystem: false },
    { time: "02:15 AM", message: "Nitrogen refill", isSystem: true },
    { time: "Yesterday", message: "System Reboot", isSystem: true },
  ];

  @State isLocked: boolean = true;

  build() {
    Column() {
      // Top Bar
      this.SimpleTopBar();

      // Scrollable Content Area
      Scroll() {
        Column() {
          // Status Header
          this.SystemStatusBadge();

          // Big Temperature Display
          this.MainTemperatureDisplay();

          // Grid of Sensor Cards
          this.SensorGrid();

          // Activity Log Title
          Text("MAINTENANCE LOG")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#757575')
            .letterSpacing(1.5)
            .margin({ top: 24, bottom: 8 });

          // Activity Log List
          this.ActivityLogList();
        }
        .padding({ left: 24, right: 24, bottom: 100 })
        .alignItems(HorizontalAlign.Start)
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top);

      // Bottom Control Bar
      this.BottomControlBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  SimpleTopBar() {
    Row() {
      Column() {
        Text("UNIT-04")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575');
        Text("CryoGen Monitor")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#212121');
      }
      .alignItems(HorizontalAlign.Start);

      // Settings Icon
      Image($r('sys.media.ohos_ic_public_settings'))
        .width(24)
        .height(24)
        .fillColor('#212121')
        .onClick(() => {});
    }
    .width('100%')
    .height(56)
    .padding({ top: 24, bottom: 12, left: 24, right: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  SystemStatusBadge() {
    Row() {
      Image($r('sys.media.ohos_ic_public_select'))
        .width(16)
        .height(16)
        .fillColor('#388E3C')
        .margin({ right: 8 });
      Text("SYSTEM NOMINAL")
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#388E3C');
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .borderRadius(50)
    .border({ width: 1, color: '#80388E3C' })
    .margin({ top: 16 });
  }

  @Builder
  MainTemperatureDisplay() {
    Column() {
      Text("CORE TEMPERATURE")
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#757575')
        .margin({ bottom: 4 });

      Row() {
        Text("-184.2")
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#212121')
          .letterSpacing(-2);
        Text("°C")
          .fontSize(24)
          .fontWeight(FontWeight.Normal)
          .fontColor('#757575')
          .margin({ bottom: 12, left: 4 })
          .align(VerticalAlign.Bottom);
      }
      .alignItems(VerticalAlign.Bottom);
    }
    .alignItems(HorizontalAlign.Start)
    .margin({ top: 32 });
  }

  @Builder
  SensorGrid() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        this.SensorCard("PRESSURE", "1.02", "Bar", false);
        this.SensorCard("O2 LEVEL", "19.5", "%", true);
      }
      .width('100%');

      Row({ space: 12 }) {
        this.SensorCard("POWER", "Stable", "AC", false);
        this.SensorCard("LIQUID N2", "88", "%", false);
      }
      .width('100%');
    }
    .margin({ top: 32 })
    .width('100%');
  }

  @Builder
  SensorCard(title: string, value: string, unit: string, isWarning: boolean) {
    Column() {
      Row() {
        Image($r('sys.media.ohos_ic_public_info'))
          .width(20)
          .height(20)
          .fillColor(isWarning ? '#D32F2F' : '#0066CC');

        if (isWarning) {
          // Warning indicator dot
          Circle({ width: 6, height: 6 })
            .fill('#D32F2F');
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: 12 });

      Column() {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#212121');
        Text(`${unit}  ${title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575');
      }
      .alignItems(HorizontalAlign.Start);
    }
    .layoutWeight(1)
    .padding(16)
    .borderRadius(12)
    .backgroundColor('#F5F5F5')
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  ActivityLogList() {
    Column({ space: 8 }) {
      ForEach(this.logs, (log: LogEntry) => {
        Row() {
          Circle({ width: 32, height: 32 })
            .fill('#F5F5F5')
            .child(
              Image(log.isSystem ? $r('sys.media.ohos_ic_public_refresh') : $r('sys.media.ohos_ic_public_contacts'))
                .width(16)
                .height(16)
                .fillColor('#757575')
            );

          Column() {
            Text(log.message)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#212121');
            Text(log.time)
              .fontSize(11)
              .fontColor('#757575');
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 12 });
        }
        .width('100%')
        .padding({ top: 4, bottom: 4 })
        .alignItems(VerticalAlign.Center);

        // Divider
        Divider()
          .color('#F5F5F5')
          .strokeWidth(1)
          .width('100%');
      });
    }
    .width('100%');
  }

  @Builder
  BottomControlBar() {
    Column() {
      Divider()
        .color('#F0F0F0')
        .strokeWidth(1);
        
      Row() {
        Column() {
          Text("MANUAL OVERRIDE")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#757575');
          Text(this.isLocked ? "LOCKED" : "ACTIVE")
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? '#212121' : '#D32F2F');
        }
        .alignItems(HorizontalAlign.Start);

        // Custom Switch
        Row() {
          if (!this.isLocked) {
            Image($r('sys.media.ohos_ic_public_warning'))
              .width(16)
              .height(16)
              .fillColor('#FFFFFF')
              .margin({ left: 6 });
          } else {
            Image($r('sys.media.ohos_ic_public_lock'))
              .width(16)
              .height(16)
              .fillColor('#757575')
              .margin({ left: 6 });
          }
        }
        .width(40)
        .height(24)
        .borderRadius(12)
        .backgroundColor(this.isLocked ? '#F5F5F5' : '#D32F2F')
        .justifyContent(FlexAlign.End)
        .padding(2)
        .onClick(() => {
          this.isLocked = !this.isLocked;
        });
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .backgroundColor('#FFFFFF');
  }
}