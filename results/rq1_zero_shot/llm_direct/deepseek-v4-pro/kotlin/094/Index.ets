import { display } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

// Domain Model
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
struct SecureKeyScreen {
  @State masterLockState: boolean = true;
  @State accessPoints: AccessPoint[] = [
    new AccessPoint("1", "Main Entrance", "Active", true, "2h ago"),
    new AccessPoint("2", "Garage Door", "Active", false, "12m ago"),
    new AccessPoint("3", "Server Room", "Restricted", true, "Yesterday")
  ];
  @State switchStates: boolean[] = [false, true, false];

  aboutToAppear(): void {
    // Initialize switch states based on access points
    this.switchStates = this.accessPoints.map((point: AccessPoint) => !point.isLocked);
  }

  build() {
    Column() {
      // Hide system bars for immersive mode
      this.hideSystemBars();

      Scroll() {
        Column({ space: 0 }) {
          // Top Header
          this.HeaderSection();

          Blank().height(40);

          // Master Control Status
          this.MasterStatusCard();

          Blank().height(32);

          // Quick Access List
          Text('My Access Points')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#444444')
            .margin({ bottom: 16 });

          // Access Point List
          Column({ space: 12 }) {
            ForEach(this.accessPoints, (point: AccessPoint, index: number) => {
              this.AccessPointRow(point, index);
            }, (point: AccessPoint, index: number) => point.id);
          }

          Blank().height(32);

          // Recent Activity
          Text('Recent Activity')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#444444')
            .margin({ bottom: 16 });

          this.ActivityLogItem('10:42 AM', 'Main Gate unlocked', 'You');
          this.ActivityLogItem('09:15 AM', 'Guest Entry Denied', 'System');
          this.ActivityLogItem('08:30 AM', 'Garage Door opened', 'Alice');
        }
        .width('100%')
        .padding(24)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  private hideSystemBars(): void {
    const windowStage = AppStorage.get<window.WindowStage>('windowStage');
    if (windowStage) {
      const windowClass = windowStage.getMainWindowSync();
      windowClass.setWindowLayoutFullScreen(true);
      windowClass.setWindowSystemBarEnable([]);
    }
  }

  @Builder
  HeaderSection() {
    Row() {
      Column({ space: 4 }) {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor('#888888');
        Text('David Miller')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000');
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('#F5F5F5')
          .stroke('#E0E0E0')
          .strokeWidth(1);

        Text('👤')
          .fontSize(22);
      }
      .width(48)
      .height(48);
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  MasterStatusCard() {
    Column({ space: 0 }) {
      Stack() {
        Circle()
          .width(80)
          .height(80)
          .fill('#FFFFFF')
          .stroke(this.masterLockState ? '#212121' : '#4CAF50')
          .strokeWidth(2);

        Text(this.masterLockState ? '🔒' : '✅')
          .fontSize(36);
      }
      .width(80)
      .height(80)
      .onClick(() => {
        this.masterLockState = !this.masterLockState;
      });

      Blank().height(16);

      Text(this.masterLockState ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.masterLockState ? '#212121' : '#4CAF50')
        .letterSpacing(2);

      Blank().height(8);

      Text(this.masterLockState ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor('#888888');
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F8F8F8')
    .borderRadius(24)
    .border({ width: 1, color: '#EFEFEF', radius: 24 });
  }

  @Builder
  AccessPointRow(point: AccessPoint, index: number) {
    Row() {
      Row({ space: 16 }) {
        Stack() {
          Rect()
            .width(40)
            .height(40)
            .fill('#FAFAFA')
            .radius(10);

          Text('🏠')
            .fontSize(20);
        }
        .width(40)
        .height(40);

        Column({ space: 2 }) {
          Text(point.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000');
          Text(point.lastAccessed)
            .fontSize(12)
            .fontColor('#AAAAAA');
        }
        .alignItems(HorizontalAlign.Start);
      }
      .alignItems(VerticalAlign.Center);

      Blank();

      Toggle({ type: ToggleType.Switch, isOn: this.switchStates[index] })
        .selectedColor('#000000')
        .switchPointColor('#FFFFFF')
        .onChange((isOn: boolean) => {
          this.switchStates[index] = isOn;
        });
    }
    .width('100%')
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE', radius: 16 });
  }

  @Builder
  ActivityLogItem(time: string, event: string, user: string) {
    Row() {
      Text(time)
        .fontSize(12)
        .fontColor('#888888')
        .width(70);

      Divider()
        .vertical(true)
        .height(20)
        .width(1)
        .color('#EEEEEE');

      Blank().width(16);

      Column({ space: 2 }) {
        Text(event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000');
        Text(`by ${user}`)
          .fontSize(12)
          .fontColor('#888888');
      }
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center);
  }
}