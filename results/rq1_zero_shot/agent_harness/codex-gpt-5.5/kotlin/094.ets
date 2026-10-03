class AccessPoint {
  id: string;
  name: string;
  status: string;
  locked: boolean;
  lastAccessed: string;

  constructor(id: string, name: string, status: string, locked: boolean, lastAccessed: string) {
    this.id = id;
    this.name = name;
    this.status = status;
    this.locked = locked;
    this.lastAccessed = lastAccessed;
  }
}

class ActivityLog {
  time: string;
  event: string;
  user: string;

  constructor(time: string, event: string, user: string) {
    this.time = time;
    this.event = event;
    this.user = user;
  }
}

@Entry
@Component
struct MainActivity {
  @State masterLocked: boolean = true;
  @State points: AccessPoint[] = [
    new AccessPoint('1', 'Main Entrance', 'Active', true, '2h ago'),
    new AccessPoint('2', 'Garage Door', 'Active', false, '12m ago'),
    new AccessPoint('3', 'Server Room', 'Restricted', true, 'Yesterday')
  ];

  private logs: ActivityLog[] = [
    new ActivityLog('10:42 AM', 'Main Gate unlocked', 'You'),
    new ActivityLog('09:15 AM', 'Guest Entry Denied', 'System'),
    new ActivityLog('08:30 AM', 'Garage Door opened', 'Alice')
  ];

  private togglePoint(index: number, unlocked: boolean): void {
    this.points[index].locked = !unlocked;
    this.points = [...this.points];
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor('#808080')
        Text('David Miller')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Text('●')
        .fontSize(28)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .width(48)
        .height(48)
        .lineHeight(48)
        .backgroundColor('#F5F5F5')
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(24)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  MasterStatusCard() {
    Column() {
      Text(this.masterLocked ? '⌘' : '✓')
        .fontSize(36)
        .fontColor(this.masterLocked ? '#212121' : '#4CAF50')
        .textAlign(TextAlign.Center)
        .width(80)
        .height(80)
        .lineHeight(80)
        .backgroundColor('#FFFFFF')
        .border({ width: 2, color: this.masterLocked ? '#1A212121' : '#1A4CAF50' })
        .borderRadius(40)
        .onClick(() => {
          this.masterLocked = !this.masterLocked;
        })

      Text(this.masterLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Black)
        .fontColor(this.masterLocked ? '#212121' : '#4CAF50')
        .margin({ top: 16 })
      Text(this.masterLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor('#808080')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F8F8F8')
    .border({ width: 1, color: '#EFEFEF' })
    .borderRadius(24)
  }

  @Builder
  AccessPointRow(item: AccessPoint, index: number) {
    Row() {
      Row() {
        Text('⌂')
          .fontSize(20)
          .fontColor('#000000')
          .textAlign(TextAlign.Center)
          .width(40)
          .height(40)
          .lineHeight(40)
          .backgroundColor('#FAFAFA')
          .borderRadius(10)
        Column() {
          Text(item.name)
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#000000')
          Text(item.lastAccessed)
            .fontSize(11)
            .fontColor('#D3D3D3')
        }
        .margin({ left: 16 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(VerticalAlign.Center)

      Toggle({ type: ToggleType.Switch, isOn: !item.locked })
        .selectedColor('#000000')
        .onChange((value: boolean) => {
          this.togglePoint(index, value);
        })
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#EEEEEE' })
    .borderRadius(16)
  }

  @Builder
  ActivityLogItem(item: ActivityLog) {
    Row() {
      Text(item.time)
        .fontSize(12)
        .fontColor('#808080')
        .width(70)
      Divider().vertical(true).height(20).color('#EEEEEE')
      Column() {
        Text(item.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
        Text(`by ${item.user}`)
          .fontSize(11)
          .fontColor('#808080')
      }
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Scroll() {
      Column() {
        this.HeaderSection()
        Blank().height(40)
        this.MasterStatusCard()
        Blank().height(32)
        Text('My Access Points')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#444444')
          .width('100%')
        Blank().height(16)
        Column({ space: 12 }) {
          ForEach(this.points, (point: AccessPoint, index: number) => {
            this.AccessPointRow(point, index)
          })
        }
        .width('100%')
        Blank().height(32)
        Text('Recent Activity')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#444444')
          .width('100%')
        Blank().height(16)
        ForEach(this.logs, (item: ActivityLog) => {
          this.ActivityLogItem(item)
        })
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .scrollBar(BarState.Off)
  }
}
