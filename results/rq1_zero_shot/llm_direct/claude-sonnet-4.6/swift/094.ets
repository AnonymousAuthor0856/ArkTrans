import { router } from '@kit.ArkUI';

// Models
interface AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;
}

// Colors
const SecureColors = {
  primary: '#000000',
  surface: '#F8F8F8',
  locked: '#212121',
  unlocked: '#4CAF50',
  border: '#EFEFEF',
  textGray: '#9E9E9E',
  backgroundWhite: '#FFFFFF',
};

@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true;

  accessPoints: AccessPoint[] = [
    { id: '1', name: 'Main Entrance', status: 'Active', isLocked: true, lastAccessed: '2h ago' },
    { id: '2', name: 'Garage Door', status: 'Active', isLocked: false, lastAccessed: '12m ago' },
    { id: '3', name: 'Server Room', status: 'Restricted', isLocked: true, lastAccessed: 'Yesterday' },
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

        Text('David Miller')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)

      Blank()

      Stack() {
        Circle()
          .fill(Color.Transparent)
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .border({ width: 1, color: '#E0E0E0', radius: 24 })

        Image($r('sys.symbol.person_fill'))
          .width(20)
          .height(20)
          .fillColor('#000000')
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
  @Prop isLocked: boolean;
  onToggle: () => void = () => {};

  get statusColor(): string {
    return this.isLocked ? SecureColors.locked : SecureColors.unlocked;
  }

  build() {
    Column({ space: 0 }) {
      // Icon Button
      Button({ type: ButtonType.Circle }) {
        Stack() {
          Circle()
            .fill(Color.White)
            .width(80)
            .height(80)
            .border({ width: 2, color: this.isLocked ? 'rgba(33,33,33,0.1)' : 'rgba(76,175,80,0.1)', radius: 40 })

          Image(this.isLocked ? $r('sys.symbol.lock_fill') : $r('sys.symbol.checkmark_circle_fill'))
            .width(36)
            .height(36)
            .fillColor(this.statusColor)
        }
        .width(80)
        .height(80)
      }
      .width(80)
      .height(80)
      .backgroundColor(Color.White)
      .onClick(() => {
        this.onToggle();
      })
      .margin({ bottom: 16 })

      // Status Text
      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Bolder)
        .letterSpacing(2)
        .fontColor(this.statusColor)

      Blank().height(8)

      // Subtext
      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor(SecureColors.textGray)
    }
    .padding(24)
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(SecureColors.surface)
    .borderRadius(24)
    .border({ width: 1, color: SecureColors.border, radius: 24 })
  }
}

@Component
struct AccessPointRow {
  @Prop item: AccessPoint;
  @State checked: boolean = false;

  aboutToAppear() {
    this.checked = !this.item.isLocked;
  }

  build() {
    Row() {
      Row({ space: 16 }) {
        Stack() {
          RoundRect()
            .radiusWidth(10)
            .radiusHeight(10)
            .fill('#FAFAFA')
            .width(40)
            .height(40)

          Image($r('sys.symbol.house_fill'))
            .width(20)
            .height(20)
            .fillColor('#000000')
        }
        .width(40)
        .height(40)

        Column() {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')

          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor('#CCCCCC')
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
      }
      .alignItems(VerticalAlign.Center)

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .selectedColor('#000000')
        .switchPointColor(Color.White)
        .onChange((isOn: boolean) => {
          this.checked = isOn;
        })
    }
    .padding(16)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE', radius: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct ActivityLogItem {
  @Prop time: string;
  @Prop event: string;
  @Prop user: string;

  build() {
    Row({ space: 0 }) {
      Text(this.time)
        .fontSize(12)
        .fontColor(SecureColors.textGray)
        .width(70)
        .textAlign(TextAlign.Start)

      Divider()
        .vertical(true)
        .color('#EEEEEE')
        .strokeWidth(1)
        .height(20)
        .margin({ right: 16 })

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')

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