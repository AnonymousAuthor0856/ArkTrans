class BudgetItem {
  name: string;
  value: number;
  color: string;
  amount: string;

  constructor(name: string, value: number, color: string, amount: string) {
    this.name = name;
    this.value = value;
    this.color = color;
    this.amount = amount;
  }
}

class BudgetColors {
  static primary: string = '#4A5568';
  static secondary: string = '#718096';
  static tertiary: string = '#A0AEC0';
  static background: string = '#F7FAFC';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#EDF2F7';
  static outline: string = '#E2E8F0';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#1A202C';
  static chart1: string = '#4299E1';
  static chart2: string = '#38B2AC';
  static chart3: string = '#5A67D8';
  static chart4: string = '#D53F8C';
  static chart5: string = '#ED8936';
}

@Entry
@Component
struct Index {
  private items: BudgetItem[] = [
    new BudgetItem('Housing', 1250.00, BudgetColors.chart1, '$1,250.00'),
    new BudgetItem('Food', 480.50, BudgetColors.chart2, '$480.50'),
    new BudgetItem('Transport', 210.75, BudgetColors.chart3, '$210.75'),
    new BudgetItem('Entertainment', 150.00, BudgetColors.chart4, '$150.00'),
    new BudgetItem('Utilities', 320.00, BudgetColors.chart5, '$320.00')
  ];

  private navItems: string[] = ['Home', 'Reports', 'Goals', 'Settings'];

  @Builder
  PieSummary() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(240)
        .height(240)
        .fill(BudgetColors.surfaceVariant)
      Circle()
        .width(198)
        .height(198)
        .fill(BudgetColors.surface)
      Row() {
        ForEach(this.items, (item: BudgetItem) => {
          Text('')
            .width(24)
            .height(80 + item.value / 20)
            .backgroundColor(item.color)
            .borderRadius(12)
        }, (item: BudgetItem) => item.name)
      }
      .width(200)
      .height(150)
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Bottom)
      Column() {
        Text('Total Spent')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(BudgetColors.secondary)
        Text('$2,411.25')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(BudgetColors.primary)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(240)
    .height(240)
  }

  @Builder
  BudgetRow(item: BudgetItem) {
    Row() {
      Row() {
        Circle()
          .width(20)
          .height(20)
          .fill(item.color)
        Text(item.name)
          .fontSize(16)
          .fontColor(BudgetColors.onSurface)
          .lineHeight(24)
          .margin({ left: 16 })
      }
      .alignItems(VerticalAlign.Center)
      Text(item.amount)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(BudgetColors.onSurface)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 16, bottom: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(BudgetColors.surface)
    .borderRadius(16)
    .shadow({ radius: 3, color: '#0D000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  BottomBarItem(label: string) {
    Column() {
      Circle()
        .width(24)
        .height(24)
        .fill(label === 'Home' ? '#334A5568' : '#33A0AEC0')
      Text(label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(label === 'Home' ? BudgetColors.primary : BudgetColors.tertiary)
        .textAlign(TextAlign.Center)
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column() {
      Text('Monthly Budget')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(BudgetColors.primary)
        .lineHeight(32)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Stack() {
        Scroll() {
          Column() {
            this.PieSummary()
            Blank().height(24)
            ForEach(this.items, (item: BudgetItem) => {
              Column() {
                this.BudgetRow(item)
              }
              .width('100%')
              .margin({ bottom: 16 })
            }, (item: BudgetItem) => item.name)
            Blank().height(48)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .padding({ left: 24, right: 24 })
        }
        .width('100%')
        .height('100%')

        Button('+')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(BudgetColors.onPrimary)
          .width(64)
          .height(64)
          .backgroundColor(BudgetColors.primary)
          .borderRadius(32)
          .position({ x: 296, y: 540 })
      }
      .width('100%')
      .layoutWeight(1)

      Row() {
        ForEach(this.navItems, (item: string) => {
          this.BottomBarItem(item)
        }, (item: string) => item)
      }
      .width('100%')
      .padding({ top: 10, bottom: 10, left: 8, right: 8 })
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(BudgetColors.surface)
      .shadow({ radius: 15, color: '#1A000000', offsetX: 0, offsetY: -5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BudgetColors.background)
  }
}
