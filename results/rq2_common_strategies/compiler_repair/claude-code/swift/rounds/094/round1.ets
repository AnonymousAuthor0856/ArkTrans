interface AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;
}

class SecureColors {
  static readonly primary: string = '#000000';
  static readonly surface: string = '#F8F8F8';
  static readonly locked: string = '#212121';
  static readonly unlocked: string = '#4CAF50';
  static readonly border: string = '#EFEFEF';
  static readonly textGray: string = '#8E8E93';
  static readonly backgroundWhite: string = '#FFFFFF';
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
          .fontWeight(900)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 48, height: 48 })
          .fill('#F5F5F5')
          .stroke('#E0E0E0')
          .strokeWidth(1)

        Text('👤')
          .fontSize(20)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MasterStatusCard {
  @Prop isLocked: boolean = true;
  private onToggle: () => void = () => {};

  private get statusColor(): string {
    return this.isLocked ? SecureColors.locked : SecureColors.unlocked;
  }

  build() {
    Column() {
      Button() {
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 80, height: 80 })
            .fill(Color.White)
            .stroke(this.statusColor)
            .strokeWidth(2)
            .opacity(0.1)

          Text(this.isLocked ? '🔒' : '✓')
            .fontSize(36)
            .fontColor(this.statusColor)
        }
        .width(80)
        .height(80)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .borderRadius(40)
      .margin({ bottom: 16 })
      .onClick(() => {
        this.onToggle();
      })

      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(900)
        .letterSpacing(2)
        .fontColor(this.statusColor)

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

@Component
struct AccessPointRow {
  @Prop item: AccessPoint = { id: '', name: '', status: '', isLocked: true, lastAccessed: '' };
  @State checked: boolean = false;

  aboutToAppear(): void {
    this.checked = !this.item.isLocked;
  }

  build() {
    Row() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width(40)
            .height(40)
            .backgroundColor('#FAFAFA')
            .borderRadius(10)

          Text('🏠')
            .fontSize(20)
            .fontColor(Color.Black)
        }
        .width(40)
        .height(40)

        Column() {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(600)
            .fontColor(Color.Black)

          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor('#CCCCCC')
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 16 })
      }

      Blank()

      Toggle({ isOn: this.checked, type: ToggleType.Switch })
        .selectedColor(Color.Black)
        .onChange((value: boolean) => {
          this.checked = value;
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
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

      Column()
        .width(1)
        .height(20)
        .backgroundColor('#EEEEEE')
        .margin({ right: 16 })

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Text('by ' + this.user)
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

@Entry
@Component
struct SecureKeyApp {
  @State masterLockState: boolean = true;

  private accessPoints: AccessPoint[] = [
    { id: '1', name: 'Main Entrance', status: 'Active', isLocked: true, lastAccessed: '2h ago' },
    { id: '2', name: 'Garage Door', status: 'Active', isLocked: false, lastAccessed: '12m ago' },
    { id: '3', name: 'Server Room', status: 'Restricted', isLocked: true, lastAccessed: 'Yesterday' }
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(SecureColors.backgroundWhite)

      Scroll() {
        Column() {
          HeaderSection()
            .margin({ top: 24 })

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
            .fontColor('#333333')
            .margin({ top: 32 })

          Column() {
            ForEach(this.accessPoints, (item: AccessPoint) => {
              AccessPointRow({ item: item })
            }, (item: AccessPoint) => item.id)
          }
          .width('100%')
          .margin({ top: 16 })

          Text('Recent Activity')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .margin({ top: 32 })

          Column() {
            ActivityLogItem({ time: '10:42 AM', event: 'Main Gate unlocked', user: 'You' })
            ActivityLogItem({ time: '09:15 AM', event: 'Guest Entry Denied', user: 'System' })
            ActivityLogItem({ time: '08:30 AM', event: 'Garage Door opened', user: 'Alice' })
          }
          .width('100%')
          .margin({ top: 16 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
  }
}
