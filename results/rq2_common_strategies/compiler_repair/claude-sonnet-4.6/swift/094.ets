// Models
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

// Colors
class SecureColors {
  static primary: string = '#000000';
  static surface: string = '#F8F8F8';
  static locked: string = '#212121';
  static unlocked: string = '#4CAF50';
  static border: string = '#EFEFEF';
  static textGray: string = '#9E9E9E';
  static backgroundWhite: string = '#FFFFFF';
}

@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true;

  accessPoints: AccessPoint[] = [
    new AccessPoint('1', 'Main Entrance', 'Active', true, '2h ago'),
    new AccessPoint('2', 'Garage Door', 'Active', false, '12m ago'),
    new AccessPoint('3', 'Server Room', 'Restricted', true, 'Yesterday'),
  ];

  build() {
    Stack() {
      Scroll() {
        Column() {
          // Header
          HeaderSection()
            .margin({ top: 24 })

          Blank().height(40)

          // Master Status Card
          MasterStatusCard({
            isLocked: this.masterLockState,
            onToggle: () => {
              this.masterLockState = !this.masterLockState;
            }
          })

          Blank().height(32)

          // Access Points Header
          Text('My Access Points')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .alignSelf(ItemAlign.Start)

          Blank().height(16)

          // Access Points List
          Column({ space: 12 }) {
            ForEach(this.accessPoints, (point: AccessPoint) => {
              AccessPointRow({ item: point })
            }, (point: AccessPoint) => point.id)
          }
          .width('100%')

          Blank().height(32)

          // Recent Activity Header
          Text('Recent Activity')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .alignSelf(ItemAlign.Start)

          Blank().height(16)

          // Activity Log
          Column() {
            ActivityLogItem({ time: '10:42 AM', event: 'Main Gate unlocked', user: 'You' })
            ActivityLogItem({ time: '09:15 AM', event: 'Guest Entry Denied', user: 'System' })
            ActivityLogItem({ time: '08:30 AM', event: 'Garage Door opened', user: 'Alice' })
          }
          .width('100%')

          Blank().height(24)
        }
        .padding({ left: 24, right: 24 })
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(SecureColors.backgroundWhite)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor(SecureColors.textGray)
          .margin({ bottom: 2 })

        Text('David Miller')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Circle()
          .fill('#F5F5F5')
          .width(48)
          .height(48)
          .border({ width: 1, color: '#E0E0E0', radius: 24 })

        Text('👤')
          .fontSize(20)
          .fontColor('#000000')
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MasterStatusCard {
  @Prop isLocked: boolean = true;
  onToggle: () => void = () => {};

  getStatusColor(): string {
    return this.isLocked ? SecureColors.locked : SecureColors.unlocked;
  }

  getBorderColor(): string {
    return this.isLocked ? 'rgba(33,33,33,0.1)' : 'rgba(76,175,80,0.1)';
  }

  build() {
    Column() {
      // Icon Button
      Button({ type: ButtonType.Circle }) {
        Stack() {
          Circle()
            .fill('#FFFFFF')
            .width(80)
            .height(80)
            .border({
              width: 2,
              color: this.getBorderColor(),
              radius: 40
            })

          Text(this.isLocked ? '🔒' : '✅')
            .fontSize(36)
        }
        .width(80)
        .height(80)
      }
      .width(80)
      .height(80)
      .backgroundColor('#FFFFFF')
      .onClick(() => {
        this.onToggle();
      })
      .margin({ bottom: 16 })

      // Status Text
      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Bolder)
        .fontColor(this.getStatusColor())
        .letterSpacing(2)

      Blank().height(8)

      // Subtext
      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor(SecureColors.textGray)
        .textAlign(TextAlign.Center)
    }
    .padding(24)
    .width('100%')
    .backgroundColor(SecureColors.surface)
    .borderRadius(24)
    .border({ width: 1, color: SecureColors.border, radius: 24 })
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct AccessPointRow {
  @Prop item: AccessPoint = new AccessPoint('', '', '', false, '');
  @State checked: boolean = false;

  aboutToAppear() {
    this.checked = !this.item.isLocked;
  }

  build() {
    Row() {
      Row({ space: 16 }) {
        Stack() {
          Column()
            .width(40)
            .height(40)
            .backgroundColor('#FAFAFA')
            .borderRadius(10)

          Text('🏠')
            .fontSize(20)
            .fontColor('#000000')
        }
        .width(40)
        .height(40)

        Column() {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ bottom: 2 })

          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor('#CCCCCC')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .selectedColor('#000000')
        .switchPointColor('#FFFFFF')
        .onChange((isOn: boolean) => {
          this.checked = isOn;
        })
    }
    .padding(16)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE', radius: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct ActivityLogItem {
  @Prop time: string = '';
  @Prop event: string = '';
  @Prop user: string = '';

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
        .color('#EEEEEE')
        .strokeWidth(1)
        .margin({ right: 16 })

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .margin({ bottom: 2 })

        Text(`by ${this.user}`)
          .fontSize(11)
          .fontColor(SecureColors.textGray)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }
}