// EntryAbility.ets — call this in onWindowStageCreate for immersive full-screen:
//   windowStage.getMainWindow().then((win) => win.setWindowLayoutFullScreen(true));
// Deprecated/transient system bars can be handled with window.setWindowSystemBarEnable([]).

// --- Domain Models ---
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

// --- Main Screen ---
@Entry
@Component
struct SecureKeyScreen {
  @State masterLocked: boolean = true;
  @State switchStates: boolean[] = [false, true, false];

  private accessPoints: AccessPoint[] = [
    new AccessPoint('1', 'Main Entrance', 'Active', true, '2h ago'),
    new AccessPoint('2', 'Garage Door', 'Active', false, '12m ago'),
    new AccessPoint('3', 'Server Room', 'Restricted', true, 'Yesterday')
  ];

  private logs: ActivityLog[] = [
    new ActivityLog('10:42 AM', 'Main Gate unlocked', 'You'),
    new ActivityLog('09:15 AM', 'Guest Entry Denied', 'System'),
    new ActivityLog('08:30 AM', 'Garage Door opened', 'Alice')
  ];

  private statusColor(): string {
    return this.masterLocked ? '#212121' : '#4CAF50';
  }

  private statusTitle(): string {
    return this.masterLocked ? 'SECURE' : 'UNLOCKED';
  }

  private statusSubtitle(): string {
    return this.masterLocked
      ? 'All perimeter doors are locked.'
      : 'Perimeter access is currently open.';
  }

  @Builder
  VSpace(h: number) {
    Row()
      .width('100%')
      .height(h)
  }

  // --- Header ---
  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Welcome back,')
          .fontSize(15)
          .fontColor('#9E9E9E')
        Text('David Miller')
          .fontSize(28)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Stack() {
        SymbolGlyph($r('sys.symbol.person'))
          .fontSize(24)
          .fontColor([Color.Black])
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .border({ width: 1, color: '#E0E0E0' })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  // --- Master Status Card ---
  @Builder
  MasterStatusCard() {
    Column() {
      Stack() {
        if (this.masterLocked) {
          SymbolGlyph($r('sys.symbol.lock'))
            .fontSize(36)
            .fontColor([this.statusColor()])
        } else {
          SymbolGlyph($r('sys.symbol.checkmark_circle'))
            .fontSize(36)
            .fontColor([this.statusColor()])
        }
      }
      .width(80)
      .height(80)
      .borderRadius(40)
      .backgroundColor(Color.White)
      .border({
        width: 2,
        color: this.masterLocked ? '#1A212121' : '#1A4CAF50',
        radius: 40
      })
      .onClick(() => {
        this.masterLocked = !this.masterLocked;
      })

      this.VSpace(16)

      Text(this.statusTitle())
        .fontSize(22)
        .fontWeight(FontWeight.Bolder)
        .letterSpacing(2)
        .fontColor(this.statusColor())

      this.VSpace(8)

      Text(this.statusSubtitle())
        .fontSize(15)
        .fontColor('#9E9E9E')
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F8F8F8')
    .borderRadius(24)
    .border({ width: 1, color: '#EFEFEF', radius: 24 })
  }

  // --- Access Point Row ---
  @Builder
  AccessPointRow(item: AccessPoint, index: number) {
    Row() {
      Row() {
        Stack() {
          SymbolGlyph($r('sys.symbol.house'))
            .fontSize(20)
            .fontColor([Color.Black])
        }
        .width(40)
        .height(40)
        .borderRadius(10)
        .backgroundColor('#FAFAFA')

        Column() {
          Text(item.name)
            .fontSize(17)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
          Text(item.lastAccessed)
            .fontSize(12)
            .fontColor('#D0D0D0')
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 16 })
      }
      .layoutWeight(1)
      .alignItems(VerticalAlign.Center)

      Toggle({ type: ToggleType.Switch, isOn: this.switchStates[index] })
        .selectedColor(Color.Black)
        .onChange((isOn: boolean) => {
          this.switchStates = this.switchStates.map((value: boolean, i: number) => {
            return i === index ? isOn : value;
          });
        })
    }
    .width('100%')
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE', radius: 16 })
  }

  // --- Activity Log Row ---
  @Builder
  ActivityLogItem(log: ActivityLog) {
    Row() {
      Text(log.time)
        .fontSize(12)
        .fontColor('#9E9E9E')
        .width(70)
        .textAlign(TextAlign.Start)

      Divider()
        .vertical(true)
        .height(20)
        .width(1)
        .color('#EEEEEE')

      Column() {
        Text(log.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
        Text('by ' + log.user)
          .fontSize(11)
          .fontColor('#9E9E9E')
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          this.HeaderSection()

          this.VSpace(40)

          this.MasterStatusCard()

          this.VSpace(32)

          Text('My Access Points')
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor('#424242')

          this.VSpace(16)

          Column({ space: 12 }) {
            ForEach(this.accessPoints, (item: AccessPoint, index: number) => {
              this.AccessPointRow(item, index)
            }, (item: AccessPoint) => item.id)
          }
          .width('100%')

          this.VSpace(32)

          Text('Recent Activity')
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor('#424242')

          this.VSpace(16)

          ForEach(this.logs, (log: ActivityLog) => {
            this.ActivityLogItem(log)
          }, (log: ActivityLog) => log.time + log.event)
        }
        .width('100%')
        .padding(24)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}