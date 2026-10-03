class StatusItemModel {
  icon: string;
  label: string;
  value: string;
  tint: string;

  constructor(icon: string, label: string, value: string, tint: string) {
    this.icon = icon;
    this.label = label;
    this.value = value;
    this.tint = tint;
  }
}

class CareLog {
  title: string;
  subtitle: string;
  done: boolean;

  constructor(title: string, subtitle: string, done: boolean) {
    this.title = title;
    this.subtitle = subtitle;
    this.done = done;
  }
}

@Entry
@Component
struct MainActivity {
  private statuses: StatusItemModel[] = [
    new StatusItemModel('♥', 'Health', '98%', '#E57373'),
    new StatusItemModel('▣', 'Age', '4 Yrs', '#8D6E63'),
    new StatusItemModel('✓', 'Water', '2 Days', '#64B5F6')
  ];
  private logs: CareLog[] = [
    new CareLog('Watering', 'Today, 8:00 AM', true),
    new CareLog('Pruning', 'Tomorrow', false),
    new CareLog('Fertilizer', 'In 5 days', false)
  ];

  @Builder
  HeaderSection() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(12)
        .fontColor('#7F8C8D')
      Text('Zen Garden')
        .fontSize(34)
        .fontWeight(FontWeight.Light)
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
        .height(32)
        .fill('#8D6E63')
        .position({ x: '20%', y: '84%' })
      Rect()
        .width(150)
        .height(15)
        .fill('#CC8D6E63')
        .position({ x: '16%', y: '84%' })
      Blank()
        .width(24)
        .height(110)
        .backgroundColor('#5D4037')
        .borderRadius(12)
        .rotate({ angle: -24 })
        .position({ x: '46%', y: '42%' })
      Blank()
        .width(16)
        .height(70)
        .backgroundColor('#5D4037')
        .borderRadius(8)
        .rotate({ angle: -58 })
        .position({ x: '32%', y: '48%' })
      Circle().width(90).height(90).fill('#6A8E6A').position({ x: '48%', y: '10%' })
      Circle().width(70).height(70).fill('#CC6A8E6A').position({ x: '62%', y: '16%' })
      Circle().width(60).height(60).fill('#E66A8E6A').position({ x: '42%', y: '8%' })
      Circle().width(70).height(70).fill('#6A8E6A').position({ x: '30%', y: '38%' })
      Circle().width(50).height(50).fill('#CC6A8E6A').position({ x: '22%', y: '34%' })
      Circle().width(50).height(50).fill('#6A8E6A').position({ x: '14%', y: '30%' })
    }
    .width(220)
    .height(220)
  }

  @Builder
  StatusItem(item: StatusItemModel) {
    Column() {
      Text(item.icon)
        .fontSize(24)
        .fontColor(item.tint)
        .textAlign(TextAlign.Center)
        .width(50)
        .height(50)
        .lineHeight(50)
        .backgroundColor('#F7F9F9')
        .border({ width: 1, color: '#ECEFF1' })
        .borderRadius(25)
      Text(item.value)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2C3E50')
        .margin({ top: 8 })
      Text(item.label)
        .fontSize(11)
        .fontColor('#7F8C8D')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StatusRow() {
    Row() {
      ForEach(this.statuses, (item: StatusItemModel) => {
        this.StatusItem(item)
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder
  CareLogItem(item: CareLog) {
    Row() {
      Circle()
        .width(12)
        .height(12)
        .fill(item.done ? '#6A8E6A' : '#E0E0E0')
      Column() {
        Text(item.title)
          .fontSize(14)
          .fontColor(item.done ? '#2C3E50' : '#7F8C8D')
        Text(item.subtitle)
          .fontSize(11)
          .fontColor('#9E9E9E')
      }
      .layoutWeight(1)
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)
      if (item.done) {
        Text('✓')
          .fontSize(20)
          .fontColor('#6A8E6A')
      }
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FAFAFA')
    .border({ width: 1, color: '#F0F0F0' })
    .borderRadius(12)
  }

  @Builder
  ActivityLogSection() {
    Column() {
      Row() {
        Text('Care Schedule')
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#2C3E50')
        Text('+')
          .fontSize(22)
          .fontColor('#6A8E6A')
          .textAlign(TextAlign.Center)
          .width(28)
          .height(28)
          .lineHeight(28)
          .backgroundColor('#E8F5E9')
          .borderRadius(14)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 16 })

      Column({ space: 12 }) {
        ForEach(this.logs, (item: CareLog) => {
          this.CareLogItem(item)
        })
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  BottomNav() {
    Row() {
      Column() { Text('⌂').fontSize(28).fontColor('#6A8E6A'); Circle().width(4).height(4).fill('#6A8E6A').margin({ top: 4 }) }.alignItems(HorizontalAlign.Center)
      Text('i').fontSize(28).fontColor('#CFD8DC')
      Text('⚙').fontSize(28).fontColor('#CFD8DC')
    }
    .width('100%')
    .height(80)
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#F5F5F5' })
  }

  build() {
    Column() {
      Column() {
        this.HeaderSection()
        Blank().height(32)
        this.BonsaiVisual()
        Blank().height(32)
        this.StatusRow()
        Blank().height(32)
        this.ActivityLogSection()
      }
      .layoutWeight(1)
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
      this.BottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
