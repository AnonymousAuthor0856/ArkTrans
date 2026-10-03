class CryoColors {
  static readonly primaryBlue: string = '#0066CC';
  static readonly alertRed: string = '#D32F2F';
  static readonly safeGreen: string = '#388E3C';
  static readonly backgroundWhite: string = '#FFFFFF';
  static readonly surfaceGrey: string = '#F5F5F5';
  static readonly textDark: string = '#212121';
  static readonly textGrey: string = '#757575';
}

class LogEntry {
  id: string;
  time: string;
  message: string;
  isSystem: boolean;

  constructor(time: string, message: string, isSystem: boolean) {
    this.id = `${time}-${message}`;
    this.time = time;
    this.message = message;
    this.isSystem = isSystem;
  }
}

@Entry
@Component
struct CryoGenApp {
  @State isLocked: boolean = true;

  private logs: LogEntry[] = [
    new LogEntry('08:00 AM', 'Auto-Cycle Complete', true),
    new LogEntry('07:45 AM', 'Pressure stabilized', true),
    new LogEntry('06:30 AM', 'Technician access', false),
    new LogEntry('02:15 AM', 'Nitrogen refill', true),
    new LogEntry('Yesterday', 'System Reboot', true)
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        this.SimpleTopBar();

        Scroll() {
          Column({ space: 0 }) {
            this.VSpace(16);
            this.SystemStatusBadge();
            this.VSpace(32);
            this.MainTemperatureDisplay();
            this.VSpace(32);
            this.SensorGrid();
            this.VSpace(24);

            Text('MAINTENANCE LOG')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(CryoColors.textGrey)
              .letterSpacing(1.5);

            this.VSpace(8);
            this.ActivityLogList();
            this.VSpace(100);
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24 });
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off);
      }
      .width('100%')
      .height('100%')
      .backgroundColor(CryoColors.backgroundWhite);

      this.BottomControlBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(CryoColors.backgroundWhite);
  }

  @Builder
  VSpace(height: number) {
    Row() {
    }
    .width('100%')
    .height(height);
  }

  @Builder
  SimpleTopBar() {
    Row() {
      Column({ space: 0 }) {
        Text('UNIT-04')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textGrey);

        Text('CryoGen Monitor')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textDark);
      }
      .alignItems(HorizontalAlign.Start);

      Blank();

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('⚙')
          .fontSize(24)
          .fontColor(CryoColors.textDark);
      }
      .padding(0)
      .width(48)
      .height(48)
      .backgroundColor('#00000000');
    }
    .width('100%')
    .height(92)
    .padding({ top: 24, bottom: 12, left: 24, right: 24 })
    .backgroundColor(CryoColors.backgroundWhite);
  }

  @Builder
  SystemStatusBadge() {
    Row({ space: 8 }) {
      Text('✓')
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(CryoColors.safeGreen);

      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(CryoColors.safeGreen);
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({
      width: 1,
      color: '#80388E3C',
      radius: 50
    });
  }

  @Builder
  MainTemperatureDisplay() {
    Column({ space: 0 }) {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(CryoColors.textGrey);

      Row({ space: 4 }) {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor(CryoColors.textDark)
          .letterSpacing(-2);

        Text('°C')
          .fontSize(24)
          .fontWeight(FontWeight.Regular)
          .fontColor(CryoColors.textGrey)
          .margin({ bottom: 8 });
      }
      .alignItems(VerticalAlign.Bottom);
    }
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  SensorGrid() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        this.SensorCard('PRESSURE', '1.02', 'Bar', 'ⓘ', false);
        this.SensorCard('O2 LEVEL', '19.5', '%', '⚠', true);
      }
      .width('100%');

      Row({ space: 12 }) {
        this.SensorCard('POWER', 'Stable', 'AC', '⚒', false);
        this.SensorCard('LIQUID N2', '88', '%', '↻', false);
      }
      .width('100%');
    }
    .width('100%');
  }

  @Builder
  SensorCard(title: string, value: string, unit: string, iconName: string, isWarning: boolean) {
    Column({ space: 0 }) {
      Row() {
        Text(iconName)
          .fontSize(20)
          .fontColor(isWarning ? CryoColors.alertRed : CryoColors.primaryBlue);

        Blank();

        if (isWarning) {
          Stack() {
          }
          .width(6)
          .height(6)
          .borderRadius(3)
          .backgroundColor(CryoColors.alertRed);
        }
      }
      .width('100%');

      this.VSpace(12);

      Column({ space: 0 }) {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textDark);

        Text(`${unit}  ${title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textGrey);
      }
      .alignItems(HorizontalAlign.Start);
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(120)
    .layoutWeight(1)
    .backgroundColor(CryoColors.surfaceGrey)
    .borderRadius(12);
  }

  @Builder
  ActivityLogList() {
    Column({ space: 8 }) {
      ForEach(this.logs, (log: LogEntry) => {
        Column({ space: 0 }) {
          Row({ space: 12 }) {
            Stack() {
              Text(log.isSystem ? 'i' : '⚒')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(CryoColors.textGrey);
            }
            .width(32)
            .height(32)
            .borderRadius(16)
            .backgroundColor(CryoColors.surfaceGrey);

            Column({ space: 2 }) {
              Text(log.message)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(CryoColors.textDark);

              Text(log.time)
                .fontSize(11)
                .fontColor(CryoColors.textGrey);
            }
            .alignItems(HorizontalAlign.Start);

            Blank();
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .padding({ top: 4, bottom: 4 });

          Divider()
            .strokeWidth(1)
            .color(CryoColors.surfaceGrey);
        }
        .width('100%');
      }, (log: LogEntry) => log.id);
    }
    .width('100%');
  }

  @Builder
  BottomControlBar() {
    Column({ space: 0 }) {
      Divider()
        .strokeWidth(1)
        .color(CryoColors.backgroundWhite)
        .shadow({
          radius: 2,
          color: '#1A000000',
          offsetX: 0,
          offsetY: -2
        });

      Row() {
        Column({ space: 2 }) {
          Text('MANUAL OVERRIDE')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(CryoColors.textGrey);

          Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? CryoColors.textDark : CryoColors.alertRed);
        }
        .alignItems(HorizontalAlign.Start);

        Blank();

        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .selectedColor(CryoColors.alertRed)
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn;
          });
      }
      .width('100%')
      .padding(24)
      .backgroundColor(CryoColors.backgroundWhite)
      .shadow({
        radius: 12,
        color: '#1A000000',
        offsetX: 0,
        offsetY: -4
      });
    }
    .width('100%');
  }
}