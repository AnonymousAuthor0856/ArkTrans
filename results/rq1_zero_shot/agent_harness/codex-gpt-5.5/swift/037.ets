class BudgetItem {
  name: string;
  value: number;
  color: string;

  constructor(name: string, value: number, color: string) {
    this.name = name;
    this.value = value;
    this.color = color;
  }
}

@Entry
@Component
struct ContentView {
  private budgetData: BudgetItem[] = [
    new BudgetItem('Housing', 1250.00, '#4299E1'),
    new BudgetItem('Food', 480.50, '#38B2AC'),
    new BudgetItem('Transport', 210.75, '#5A67D8'),
    new BudgetItem('Entertainment', 150.00, '#D53F8C'),
    new BudgetItem('Utilities', 320.00, '#ED8936')
  ];

  private totalValue(): number {
    let total = 0;
    for (let item of this.budgetData) {
      total += item.value;
    }
    return total;
  }

  private currency(value: number): string {
    return '$' + value.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
  }

  @Builder
  PieChart() {
    Stack({ alignContent: Alignment.Center }) {
      Circle().width(240).height(240).fill('#EDF2F7')
      Circle().width(220).height(220).fill('#4299E1')
      Circle().width(180).height(180).fill('#38B2AC')
      Circle().width(140).height(140).fill('#5A67D8')
      Circle().width(100).height(100).fill('#D53F8C')
      Circle().width(72).height(72).fill('#F7FAFC')
      Column() {
        Text('Total Spent')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#718096')
        Text(this.currency(this.totalValue()))
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#4A5568')
      }
    }
    .width(240)
    .height(240)
  }

  @Builder
  BudgetItemRow(item: BudgetItem) {
    Row() {
      Row() {
        Circle().width(20).height(20).fill(item.color)
        Text(item.name)
          .fontSize(16)
          .fontColor('#1A202C')
          .margin({ left: 16 })
      }
      .layoutWeight(1)
      Text(this.currency(item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1A202C')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 16, bottom: 16 })
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 3, color: '#0D000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  BottomBarItem(textValue: string, active: boolean) {
    Column() {
      Circle()
        .width(24)
        .height(24)
        .fill(active ? '#334A5568' : '#33A0AEC0')
      Text(textValue)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(active ? '#4A5568' : '#A0AEC0')
        .margin({ top: 4 })
    }
  }

  @Builder
  BottomBar() {
    Stack({ alignContent: Alignment.Top }) {
      Row() {
        this.BottomBarItem('Home', true)
        Blank()
        this.BottomBarItem('Reports', false)
        Blank()
        Rect().width(56).height(1).fill(Color.Transparent)
        Blank()
        this.BottomBarItem('Goals', false)
        Blank()
        this.BottomBarItem('Settings', false)
      }
      .width('100%')
      .height(80)
      .padding({ left: 24, right: 24 })
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 15, color: '#1A000000', offsetX: 0, offsetY: -5 })

      Button('+')
        .fontSize(24)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#FFFFFF')
        .backgroundColor('#4A5568')
        .width(56)
        .height(56)
        .borderRadius(28)
        .translate({ y: -28 })
    }
    .width('100%')
    .height(108)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Blank()
          Text('Monthly Budget')
            .fontSize(24)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#4A5568')
            .padding({ top: 16, bottom: 16 })
          Blank()
        }
        .backgroundColor('#F7FAFC')

        Scroll() {
          Column() {
            this.PieChart()
              .margin({ top: 24, bottom: 24 })
            ForEach(this.budgetData, (item: BudgetItem) => {
              this.BudgetItemRow(item)
                .margin({ bottom: 16 })
            }, (item: BudgetItem) => item.name)
            Blank().height(128)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .padding({ left: 24, right: 24 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F7FAFC')

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7FAFC')
  }
}
