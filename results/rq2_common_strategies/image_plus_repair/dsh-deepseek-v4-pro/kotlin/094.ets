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

@Entry
@Component
struct SecureKeyPage {
  @State masterLockState: boolean = true;

  private accessPoints: AccessPoint[] = [
    new AccessPoint('1', 'Main Entrance', 'Active', true, '2h ago'),
    new AccessPoint('2', 'Garage Door', 'Active', false, '12m ago'),
    new AccessPoint('3', 'Server Room', 'Restricted', true, 'Yesterday')
  ];

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor('#888888')
        Text('David Miller')
          .fontSize(24)
          .fontWeight(800)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Text('👤')
          .fontSize(22)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .border({ width: 1, color: '#E0E0E0' })
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  MasterStatusCard(isLocked: boolean, onToggle: () => void) {
    Column() {
      Stack() {
        Text(isLocked ? '🔒' : '✅')
          .fontSize(36)
          .fontColor(isLocked ? '#212121' : '#4CAF50')
      }
      .width(80)
      .height(80)
      .borderRadius(40)
      .backgroundColor('#FFFFFF')
      .onClick(() => {
        onToggle();
      })
      .border({ width: 2, color: isLocked ? '#1A212121' : '#1A4CAF50' })

      Blank().height(16)

      Text(isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(900)
        .letterSpacing(2)
        .fontColor(isLocked ? '#212121' : '#4CAF50')

      Blank().height(8)

      Text(isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor('#888888')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .padding(24)
    .backgroundColor('#F8F8F8')
    .borderRadius(24)
    .border({ width: 1, color: '#EFEFEF' })
  }

  @Builder
  AccessPointList() {
    Column({ space: 12 }) {
      ForEach(this.accessPoints, (point: AccessPoint) => {
        AccessPointRowComponent({ item: point })
      }, (point: AccessPoint) => point.id)
    }
    .width('100%')
  }

  @Builder
  ActivityLogItem(time: string, event: string, user: string) {
    Row() {
      Text(time)
        .fontSize(12)
        .fontColor('#888888')
        .width(70)

      Divider()
        .vertical(true)
        .height(20)
        .width(1)
        .color('#EEEEEE')

      Blank().width(16)

      Column() {
        Text(event)
          .fontSize(14)
          .fontWeight(500)
        Text('by ' + user)
          .fontSize(11)
          .fontColor('#888888')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({ top: 12, bottom: 12 })
  }

  build() {
    Scroll() {
      Column() {
        this.HeaderSection()

        Blank().height(40)

        this.MasterStatusCard(this.masterLockState, () => {
          this.masterLockState = !this.masterLockState;
        })

        Blank().height(32)

        Text('My Access Points')
          .fontSize(16)
          .fontWeight(700)
          .fontColor('#444444')

        Blank().height(16)

        this.AccessPointList()

        Blank().height(32)

        Text('Recent Activity')
          .fontSize(16)
          .fontWeight(700)
          .fontColor('#444444')

        Blank().height(16)

        this.ActivityLogItem('10:42 AM', 'Main Gate unlocked', 'You')
        this.ActivityLogItem('09:15 AM', 'Guest Entry Denied', 'System')
        this.ActivityLogItem('08:30 AM', 'Garage Door opened', 'Alice')
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct AccessPointRowComponent {
  item: AccessPoint = new AccessPoint('', '', '', false, '');
  @State checked: boolean = true;

  aboutToAppear(): void {
    this.checked = !this.item.isLocked;
  }

  build() {
    Row() {
      Row() {
        Stack() {
          Text('🏠')
            .fontSize(20)
            .fontColor('#000000')
        }
        .width(40)
        .height(40)
        .borderRadius(10)
        .backgroundColor('#FAFAFA')
        .alignContent(Alignment.Center)

        Blank().width(16)

        Column() {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(600)
          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor('#CCCCCC')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .selectedColor('#000000')
        .switchPointColor('#FFFFFF')
        .onChange((isOn: boolean) => {
          this.checked = isOn;
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
    .padding(16)
  }
}
