import { router } from '@kit.ArkUI'

interface AccessPoint {
  id: string
  name: string
  status: string
  isLocked: boolean
  lastAccessed: string
}

@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true
  private scrollerForScroll: Scroller = new Scroller()

  build() {
    Scroll(this.scrollerForScroll) {
      Column() {
        // Header Section
        HeaderSection()

        Blank().height(40)

        // Master Status Card
        MasterStatusCard({
          isLocked: this.masterLockState,
          onToggle: () => {
            this.masterLockState = !this.masterLockState
          }
        })

        Blank().height(32)

        // My Access Points
        Text('My Access Points')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#424242')
          .alignSelf(ItemAlign.Start)

        Blank().height(16)

        AccessPointList()

        Blank().height(32)

        // Recent Activity
        Text('Recent Activity')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#424242')
          .alignSelf(ItemAlign.Start)

        Blank().height(16)

        ActivityLogItem({ time: '10:42 AM', event: 'Main Gate unlocked', user: 'You' })
        ActivityLogItem({ time: '09:15 AM', event: 'Guest Entry Denied', user: 'System' })
        ActivityLogItem({ time: '08:30 AM', event: 'Garage Door opened', user: 'Alice' })

        Blank().height(24)
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .scrollBar(BarState.Off)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Welcome back,')
          .fontSize(14)
          .fontColor(Color.Gray)
        Text('David Miller')
          .fontSize(22)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('#F5F5F5')
          .stroke('#E0E0E0')
          .strokeWidth(1)

        Text('\uD83D\uDC64')
          .fontSize(22)
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
  @Prop isLocked: boolean = true
  onToggle: () => void = () => {}

  build() {
    Column() {
      Stack() {
        Circle()
          .width(80)
          .height(80)
          .fill(Color.White)
          .stroke(this.isLocked ? '#21212119' : '#4CAF5019')
          .strokeWidth(2)

        Text(this.isLocked ? '🔒' : '✅')
          .fontSize(32)
      }
      .width(80)
      .height(80)
      .onClick(() => {
        this.onToggle()
      })

      Blank().height(16)

      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(20)
        .fontWeight(FontWeight.Bolder)
        .letterSpacing(2)
        .fontColor(this.isLocked ? '#212121' : '#4CAF50')

      Blank().height(8)

      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
        .fontSize(14)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F8F8F8')
    .borderRadius(24)
    .border({ width: 1, color: '#EFEFEF' })
  }
}

@Component
struct AccessPointList {
  private accessPoints: AccessPoint[] = [
    { id: '1', name: 'Main Entrance', status: 'Active', isLocked: true, lastAccessed: '2h ago' },
    { id: '2', name: 'Garage Door', status: 'Active', isLocked: false, lastAccessed: '12m ago' },
    { id: '3', name: 'Server Room', status: 'Restricted', isLocked: true, lastAccessed: 'Yesterday' }
  ]

  build() {
    Column({ space: 12 }) {
      ForEach(this.accessPoints, (point: AccessPoint) => {
        AccessPointRow({ item: point })
      }, (point: AccessPoint) => point.id)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct AccessPointRow {
  @Prop item: AccessPoint = { id: '', name: '', status: '', isLocked: false, lastAccessed: '' }
  @State checked: boolean = false

  aboutToAppear() {
    this.checked = !this.item.isLocked
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

          Text('🏠')
            .fontSize(18)
        }
        .width(40)
        .height(40)

        Blank().width(16)

        Column() {
          Text(this.item.name)
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor('#BDBDBD')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .selectedColor(Color.Black)
        .switchPointColor(Color.White)
        .onChange((isOn: boolean) => {
          this.checked = isOn
        })
    }
    .width('100%')
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

@Component
struct ActivityLogItem {
  @Prop time: string = ''
  @Prop event: string = ''
  @Prop user: string = ''

  build() {
    Row() {
      Text(this.time)
        .fontSize(12)
        .fontColor(Color.Gray)
        .width(70)

      Divider()
        .vertical(true)
        .height(20)
        .strokeWidth(1)
        .color('#EEEEEE')

      Blank().width(16)

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
        Text(`by ${this.user}`)
          .fontSize(11)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }
}