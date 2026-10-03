import { window } from '@kit.ArkUI';

// MARK: - Models
class AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;

  constructor(id: string, name: string, status: string, isLocked: boolean, lastAccessed: string) {
    this.id = id;
    this.name = name;
    this.status = status;
    this.isLocked = isLocked;
    this.lastAccessed = lastAccessed;
  }
}

class ActivityItem {
  time: string;
  event: string;
  user: string;

  constructor(time: string, event: string, user: string) {
    this.time = time;
    this.event = event;
    this.user = user;
  }
}

// MARK: - Colors
class SecureColors {
  static readonly primary: string = '#000000';
  static readonly surface: string = '#F8F8F8';
  static readonly locked: string = '#212121';
  static readonly unlocked: string = '#4CAF50';
  static readonly border: string = '#EFEFEF';
  static readonly cardBorder: string = '#EEEEEE';
  static readonly textGray: string = '#8A8A8A';
  static readonly textLight: string = '#CCCCCC';
  static readonly backgroundWhite: string = '#FFFFFF';
  static readonly titleDark: string = '#333333';
}

// MARK: - Main Screen
@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true;

  private accessPoints: AccessPoint[] = [
    new AccessPoint('1', 'Main Entrance', 'Active', true, '2h ago'),
    new AccessPoint('2', 'Garage Door', 'Active', false, '12m ago'),
    new AccessPoint('3', 'Server Room', 'Restricted', true, 'Yesterday')
  ];

  private activities: ActivityItem[] = [
    new ActivityItem('10:42 AM', 'Main Gate unlocked', 'You'),
    new ActivityItem('09:15 AM', 'Guest Entry Denied', 'System'),
    new ActivityItem('08:30 AM', 'Garage Door opened', 'Alice')
  ];

  aboutToAppear(): void {
    this.configureWindow();
  }

  private async configureWindow(): Promise<void> {
    try {
      const win = await window.getLastWindow(getContext(this));
      await win.setWindowLayoutFullScreen(true);
      await win.setWindowSystemBarEnable([]);
    } catch (err) {
      console.error('window config failed: ' + JSON.stringify(err));
    }
  }

  build() {
    Stack() {
      Column() {
        Scroll() {
          Column() {
            HeaderSection()

            MasterStatusCard({
              isLocked: this.masterLockState,
              onToggle: () => {
                this.masterLockState = !this.masterLockState;
              }
            })
              .margin({ top: 40 })

            Text('My Access Points')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(SecureColors.titleDark)
              .margin({ top: 32 })

            Column({ space: 12 }) {
              ForEach(this.accessPoints, (point: AccessPoint) => {
                AccessPointRow({ item: point })
              }, (point: AccessPoint) => point.id)
            }
            .width('100%')
            .margin({ top: 16 })

            Text('Recent Activity')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(SecureColors.titleDark)
              .margin({ top: 32 })

            Column() {
              ForEach(this.activities, (item: ActivityItem) => {
                ActivityLogItem({ time: item.time, event: item.event, user: item.user })
              }, (item: ActivityItem) => item.time + item.event)
            }
            .width('100%')
            .margin({ top: 16 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .height('100%')
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(SecureColors.backgroundWhite)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(SecureColors.backgroundWhite)
  }
}

// MARK: - Header
@Component
struct HeaderSection {
  @Builder
  PersonIcon() {
    Column() {
      Circle()
        .width(10)
        .height(10)
        .fill(Color.Black)

      Column()
        .width(18)
        .height(9)
        .backgroundColor(Color.Black)
        .borderRadius({ topLeft: 9, topRight: 9 })
        .margin({ top: 3 })
    }
    .width(22)
    .height(22)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Row() {
      Column() {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor(SecureColors.textGray)

        Text('David Miller')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('#F5F5F5')
          .stroke('#E0E0E0')
          .strokeWidth(1)

        this.PersonIcon()
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - Master Status Card
@Component
struct MasterStatusCard {
  @Prop isLocked: boolean = true;
  private onToggle: () => void = () => {};

  private statusColor(): string {
    return this.isLocked ? SecureColors.locked : SecureColors.unlocked;
  }

  private statusRingColor(): string {
    return this.isLocked ? '#1A212121' : '#1A4CAF50';
  }

  @Builder
  LockGlyph(color: string, size: number) {
    Column() {
      Column()
        .width(size * 0.52)
        .height(size * 0.44)
        .border({
          width: { left: size * 0.13, right: size * 0.13, top: size * 0.13, bottom: 0 },
          color: color,
          radius: { topLeft: size * 0.26, topRight: size * 0.26, bottomLeft: 0, bottomRight: 0 }
        })

      Column()
        .width(size * 0.92)
        .height(size * 0.66)
        .backgroundColor(color)
        .borderRadius(size * 0.09)
        .margin({ top: 1 })
    }
    .width(size * 1.1)
    .height(size * 1.2)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.End)
  }

  @Builder
  CheckGlyph(color: string, size: number) {
    Stack() {
      Circle()
        .width(size)
        .height(size)
        .fill(color)

      Path()
        .commands('M6 12.2 L10 16.2 L17 8.2')
        .stroke(Color.White)
        .strokeWidth(2.4)
        .fill(Color.Transparent)
        .width(size)
        .height(size)
    }
    .width(size)
    .height(size)
  }

  build() {
    Column() {
      Stack() {
        Circle()
          .width(80)
          .height(80)
          .fill(Color.White)
          .stroke(this.statusRingColor())
          .strokeWidth(2)

        if (this.isLocked) {
          this.LockGlyph(SecureColors.locked, 34)
        } else {
          this.CheckGlyph(SecureColors.unlocked, 34)
        }
      }
      .width(80)
      .height(80)
      .onClick(() => {
        this.onToggle();
      })

      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Bolder)
        .letterSpacing(2)
        .fontColor(this.statusColor())
        .margin({ top: 16 })

      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor(SecureColors.textGray)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(24)
    .backgroundColor(SecureColors.surface)
    .borderRadius(24)
    .border({ width: 1, color: SecureColors.border })
  }
}

// MARK: - Access Point Row
@Component
struct AccessPointRow {
  item: AccessPoint = new AccessPoint('', '', '', false, '');
  @State checked: boolean = false;

  aboutToAppear(): void {
    this.checked = !this.item.isLocked;
  }

  @Builder
  HouseIcon() {
    Path()
      .commands('M10 2 L19.5 10.5 L17 10.5 L17 18 L3 18 L3 10.5 L0.5 10.5 Z')
      .fill(Color.Black)
      .width(20)
      .height(20)
  }

  build() {
    Row() {
      Row() {
        Stack() {
          Column()
            .width(40)
            .height(40)
            .backgroundColor('#FAFAFA')
            .borderRadius(10)

          this.HouseIcon()
        }
        .width(40)
        .height(40)
        .margin({ right: 16 })

        Column() {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor(SecureColors.textLight)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .width(51)
        .height(31)
        .selectedColor(Color.Black)
        .onChange((isOn: boolean) => {
          this.checked = isOn;
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: SecureColors.cardBorder })
  }
}

// MARK: - Activity Log Item
@Component
struct ActivityLogItem {
  time: string = '';
  event: string = '';
  user: string = '';

  build() {
    Row() {
      Text(this.time)
        .fontSize(12)
        .fontColor(SecureColors.textGray)
        .width(70)
        .textAlign(TextAlign.Start)

      Divider()
        .vertical(true)
        .height(20)
        .strokeWidth(1)
        .color(SecureColors.cardBorder)
        .margin({ right: 16 })

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Text('by ' + this.user)
          .fontSize(11)
          .fontColor(SecureColors.textGray)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
  }
}