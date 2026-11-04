class CareLog {
  title: string
  subtitle: string
  done: boolean

  constructor(title: string, subtitle: string, done: boolean) {
    this.title = title
    this.subtitle = subtitle
    this.done = done
  }
}

@Entry
@Component
struct Index {
  private logs: CareLog[] = [
    new CareLog('Watering', 'Today, 8:00 AM', true),
    new CareLog('Pruning', 'Tomorrow', false),
    new CareLog('Fertilizer', 'In 5 days', false)
  ]

  build() {
    Column() {
      Scroll() {
        Column() {
          this.HeaderSection()
          this.BonsaiVisual()
          this.StatusRow()
          this.ActivityLogSection()
        }
        .width('100%')
        .padding(24)
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      this.SimpleBottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(13)
        .fontColor('#7F8C8D')
      Text('Zen Garden')
        .fontSize(34)
        .fontWeight(FontWeight.Lighter)
        .fontColor('#2C3E50')
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  BonsaiVisual() {
    Stack({ alignContent: Alignment.Bottom }) {
      Rect()
        .width(130)
        .height(28)
        .fill('#8D6E63')
        .margin({ bottom: 0 })
      Rect()
        .width(150)
        .height(14)
        .fill('rgba(141,110,99,0.8)')
        .margin({ bottom: 22 })
      Rect()
        .width(24)
        .height(130)
        .radius(12)
        .fill('#5D4037')
        .rotate({ angle: -22 })
        .margin({ bottom: 28, left: 14 })
      Rect()
        .width(16)
        .height(80)
        .radius(8)
        .fill('#5D4037')
        .rotate({ angle: 48 })
        .margin({ bottom: 76, right: 70 })
      Circle()
        .width(90)
        .height(90)
        .fill('#6A8E6A')
        .margin({ bottom: 118, left: 76 })
      Circle()
        .width(70)
        .height(70)
        .fill('rgba(106,142,106,0.8)')
        .margin({ bottom: 114, left: 142 })
      Circle()
        .width(70)
        .height(70)
        .fill('rgba(106,142,106,0.9)')
        .margin({ bottom: 150, left: 36 })
      Circle()
        .width(72)
        .height(72)
        .fill('#6A8E6A')
        .margin({ bottom: 72, right: 72 })
      Circle()
        .width(54)
        .height(54)
        .fill('rgba(106,142,106,0.8)')
        .margin({ bottom: 112, right: 122 })
    }
    .width(220)
    .height(220)
    .margin({ top: 32 })
  }

  @Builder
  StatusRow() {
    Row() {
      this.StatusItem('♥', 'Health', '98%', '#E57373')
      this.StatusItem('□', 'Age', '4 Yrs', '#8D6E63')
      this.StatusItem('✓', 'Water', '2 Days', '#64B5F6')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .margin({ top: 32 })
  }

  @Builder
  StatusItem(icon: string, label: string, value: string, tint: string) {
    Column() {
      Stack() {
        Circle()
          .width(50)
          .height(50)
          .fill('#F7F9F9')
          .stroke('#ECEFF1')
          .strokeWidth(1)
        Text(icon)
          .fontSize(24)
          .fontColor(tint)
      }
      Text(value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2C3E50')
        .margin({ top: 8 })
      Text(label)
        .fontSize(12)
        .fontColor('#7F8C8D')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActivityLogSection() {
    Column() {
      Row() {
        Text('Care Schedule')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2C3E50')
        Button('+')
          .fontSize(22)
          .fontColor('#6A8E6A')
          .backgroundColor('#E8F5E9')
          .width(28)
          .height(28)
          .borderRadius(14)
          .padding(0)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      ForEach(this.logs, (log: CareLog) => {
        this.CareLogItem(log)
      })
    }
    .width('100%')
    .margin({ top: 32 })
  }

  @Builder
  CareLogItem(log: CareLog) {
    Row() {
      Circle()
        .width(12)
        .height(12)
        .fill(log.done ? '#6A8E6A' : '#E0E0E0')
      Column() {
        Text(log.title)
          .fontSize(14)
          .fontColor(log.done ? '#2C3E50' : '#7F8C8D')
        Text(log.subtitle)
          .fontSize(12)
          .fontColor('#9E9E9E')
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })
      if (log.done) {
        Text('✓')
          .fontSize(20)
          .fontColor('#6A8E6A')
          .fontWeight(FontWeight.Bold)
      }
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#F0F0F0', radius: 12 })
    .backgroundColor('#FAFAFA')
    .alignItems(VerticalAlign.Center)
    .margin({ top: 12 })
  }

  @Builder
  SimpleBottomNav() {
    Row() {
      this.NavIcon('⌂', true)
      this.NavIcon('i', false)
      this.NavIcon('⚙', false)
    }
    .width('100%')
    .height(80)
    .backgroundColor(Color.White)
    .border({ width: 1, color: '#F5F5F5' })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  NavIcon(icon: string, selected: boolean) {
    Column() {
      Text(icon)
        .fontSize(28)
        .fontColor(selected ? '#6A8E6A' : '#CFD8DC')
      if (selected) {
        Circle()
          .width(4)
          .height(4)
          .fill('#6A8E6A')
          .margin({ top: 4 })
      }
    }
    .alignItems(HorizontalAlign.Center)
  }
}
