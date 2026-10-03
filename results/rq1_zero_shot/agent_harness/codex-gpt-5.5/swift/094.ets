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

const SECURE_PRIMARY: string = '#000000';
const SECURE_SURFACE: string = '#F8F8F8';
const SECURE_LOCKED: string = '#212121';
const SECURE_UNLOCKED: string = '#4CAF50';
const SECURE_BORDER: string = '#EFEFEF';
const SECURE_TEXT_GRAY: string = '#808080';
const SECURE_LIGHT_GRAY: string = '#CCCCCC';

@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true;

  private accessPoints: AccessPoint[] = [
    new AccessPoint('1', 'Main Entrance', 'Active', true, '2h ago'),
    new AccessPoint('2', 'Garage Door', 'Active', false, '12m ago'),
    new AccessPoint('3', 'Server Room', 'Restricted', true, 'Yesterday')
  ];

  build() {
    Stack() {
      Scroll() {
        Column() {
          HeaderSection()
            .margin({ top: 24 })

          Blank()
            .height(40)

          MasterStatusCard({ isLocked: this.masterLockState, onToggle: () => {
            this.masterLockState = !this.masterLockState;
          } })

          Blank()
            .height(32)

          Text('My Access Points')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          Blank()
            .height(16)

          Column({ space: 12 }) {
            ForEach(this.accessPoints, (point: AccessPoint) => {
              AccessPointRow({ item: point })
            }, (point: AccessPoint) => point.id)
          }
          .width('100%')

          Blank()
            .height(32)

          Text('Recent Activity')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          Blank()
            .height(16)

          Column() {
            ActivityLogItem({ time: '10:42 AM', event: 'Main Gate unlocked', user: 'You' })
            ActivityLogItem({ time: '09:15 AM', event: 'Guest Entry Denied', user: 'System' })
            ActivityLogItem({ time: '08:30 AM', event: 'Garage Door opened', user: 'Alice' })
          }
          .width('100%')

          Blank()
            .height(24)
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 24, right: 24 })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor(SECURE_TEXT_GRAY)

        Text('David Miller')
          .fontSize(24)
          .fontWeight(FontWeight.Black)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Circle()
          .fill('#F5F5F5')
          .stroke('#E0E0E0')
          .width(48)
          .height(48)

        Text('person')
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
  }
}

@Component
struct MasterStatusCard {
  @Prop isLocked: boolean;
  onToggle: () => void = () => {};

  private statusColor(): string {
    return this.isLocked ? SECURE_LOCKED : SECURE_UNLOCKED;
  }

  build() {
    Column() {
      Button() {
        Stack() {
          Circle()
            .fill(Color.White)
            .stroke(this.isLocked ? '#E7E7E7' : '#EAF5EA')
            .strokeWidth(2)
            .width(80)
            .height(80)

          Text(this.isLocked ? 'lock' : 'check')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.statusColor())
        }
        .width(80)
        .height(80)
      }
      .type(ButtonType.Circle)
      .backgroundColor(Color.Transparent)
      .onClick(() => this.onToggle())
      .margin({ bottom: 16 })

      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Black)
        .fontColor(this.statusColor())
        .letterSpacing(2)

      Blank()
        .height(8)

      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor(SECURE_TEXT_GRAY)
    }
    .padding(24)
    .width('100%')
    .backgroundColor(SECURE_SURFACE)
    .borderRadius(24)
    .border({ width: 1, color: SECURE_BORDER })
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
          Rect()
            .fill('#FAFAFA')
            .width(40)
            .height(40)
            .radius(10)

          Text('home')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .width(40)
        .height(40)

        Column({ space: 2 }) {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Color.Black)

          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor(SECURE_LIGHT_GRAY)
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .selectedColor(Color.Black)
        .onChange((value: boolean) => {
          this.checked = value;
        })
    }
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

@Component
struct ActivityLogItem {
  @Prop time: string;
  @Prop event: string;
  @Prop user: string;

  build() {
    Row() {
      Text(this.time)
        .fontSize(12)
        .fontColor(SECURE_TEXT_GRAY)
        .width(70)
        .textAlign(TextAlign.Start)

      Rect()
        .fill('#EEEEEE')
        .width(1)
        .height(20)
        .margin({ right: 16 })

      Column({ space: 2 }) {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Text(`by ${this.user}`)
          .fontSize(11)
          .fontColor(SECURE_TEXT_GRAY)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
    }
    .alignItems(VerticalAlign.Center)
    .padding({ top: 12, bottom: 12 })
    .width('100%')
  }
}
