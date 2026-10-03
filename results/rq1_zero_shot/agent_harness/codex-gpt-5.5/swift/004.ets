class AccountCardModel {
  id: number;
  name: string;
  balance: string;
  accent: string;

  constructor(id: number, name: string, balance: string, accent: string) {
    this.id = id;
    this.name = name;
    this.balance = balance;
    this.accent = accent;
  }
}

class TxItemModel {
  id: number;
  title: string;
  subtitle: string;
  amount: string;
  positive: boolean;

  constructor(id: number, title: string, subtitle: string, amount: string, positive: boolean) {
    this.id = id;
    this.title = title;
    this.subtitle = subtitle;
    this.amount = amount;
    this.positive = positive;
  }
}

@Entry
@Component
struct ContentView {
  @State private showBalance: boolean = true;
  @State private selectedFilter: string = 'Month';
  @State private flags: string[] = [];

  private filters: string[] = ['All', 'Week', 'Month', 'Year'];
  private accounts: AccountCardModel[] = [
    new AccountCardModel(1, 'Wallet', '$2,845.20', '#10B981'),
    new AccountCardModel(2, 'Savings', '$8,120.00', '#3B82F6'),
    new AccountCardModel(3, 'Investments', '$15,430.55', '#F59E0B')
  ];
  private transactions: TxItemModel[] = [
    new TxItemModel(1, 'Grocery Market', 'Today • 12:40', '-$32.18', false),
    new TxItemModel(2, 'Salary', 'Yesterday • 09:00', '+$3,200.00', true),
    new TxItemModel(3, 'Coffee Shop', 'Yesterday • 15:22', '-$4.90', false),
    new TxItemModel(4, 'ETF Purchase', 'Mon • 10:05', '-$250.00', false),
    new TxItemModel(5, 'Refund', 'Sun • 18:40', '+$18.99', true)
  ];

  private hasFlag(flag: string): boolean {
    return this.flags.indexOf(flag) >= 0;
  }

  private toggleFlag(flag: string): void {
    if (this.hasFlag(flag)) {
      this.flags = this.flags.filter((item: string) => item !== flag);
    } else {
      this.flags = [...this.flags, flag];
    }
  }

  @Builder
  FilterChip(label: string) {
    Button(label)
      .fontSize(this.selectedFilter === label ? 14 : 12)
      .fontWeight(this.selectedFilter === label ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.selectedFilter === label ? '#FFFFFF' : '#0B1220')
      .backgroundColor(this.selectedFilter === label ? '#1F2937' : '#FFFFFF')
      .border({ width: this.selectedFilter === label ? 0 : 1, color: '#D1D5DB', radius: 8 })
      .borderRadius(8)
      .height(36)
      .padding({ left: 12, right: 12 })
      .margin({ right: 4 })
      .onClick(() => {
        this.selectedFilter = label;
      })
  }

  @Builder
  AssistChip(label: string) {
    Button(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.hasFlag(label) ? '#0B1220' : '#0B1220')
      .backgroundColor(this.hasFlag(label) ? '#10B981' : '#FFFFFF')
      .border({ width: 1, color: '#D1D5DB', radius: 6 })
      .borderRadius(6)
      .height(30)
      .padding({ left: 8, right: 8 })
      .onClick(() => {
        this.toggleFlag(label);
      })
  }

  @Builder
  AccountCard(account: AccountCardModel) {
    Column() {
      Row() {
        Row() {
          Rect()
            .width(16)
            .height(16)
            .fill(account.accent)
            .radius(6)
          Text(account.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)
        .layoutWeight(1)

        Button('Manage')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
          .backgroundColor('#10B981')
          .height(26)
          .padding({ left: 8, right: 8 })
          .border({ width: 1, color: '#D1D5DB', radius: 6 })
          .borderRadius(6)
      }
      .width('100%')

      Stack() {
        Rect()
          .width('100%')
          .height('100%')
          .fill('#E5E7EB')
          .radius(8)
        Text(this.showBalance ? account.balance : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#0B1220')
      }
      .width('100%')
      .aspectRatio(2.8)
      .margin({ top: 4 })

      Row() {
        Button('Transfer')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
          .backgroundColor('#10B981')
          .height(30)
          .padding({ left: 8, right: 8 })
          .border({ width: 1, color: '#D1D5DB', radius: 6 })
          .borderRadius(6)
        Button('Details')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
          .backgroundColor('#FFFFFF')
          .height(30)
          .padding({ left: 8, right: 8 })
          .border({ width: 1, color: '#D1D5DB', radius: 6 })
          .borderRadius(6)
          .margin({ left: 4 })
      }
      .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(8)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#D1D5DB', radius: 12 })
    .borderRadius(12)
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
    .constraintSize({ minHeight: 120 })
  }

  @Builder
  TransactionCard(tx: TxItemModel) {
    Row() {
      Row() {
        Rect()
          .width(32)
          .height(32)
          .radius(6)
          .fill(tx.positive ? '#16A34A' : '#EF4444')
        Column() {
          Text(tx.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
          Text(tx.subtitle)
            .fontSize(12)
            .fontColor('#0B1220')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 6 })
      }
      .alignItems(VerticalAlign.Center)
      .layoutWeight(1)

      Text(tx.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(tx.positive ? '#16A34A' : '#EF4444')
    }
    .width('100%')
    .constraintSize({ minHeight: 72 })
    .padding(8)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#D1D5DB', radius: 12 })
    .borderRadius(12)
    .shadow({ radius: 2, color: '#1F000000', offsetX: 0, offsetY: 0.5 })
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Total Balance')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
        Text(this.showBalance ? '$26,395.75' : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#0B1220')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Add Money')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0B1220')
        .backgroundColor('#10B981')
        .width(140)
        .height(44)
        .borderRadius(12)
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: -1.5 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Rect()
            .width(20)
            .height(20)
            .fill('#1F2937')
            .radius(6)
          Text('Wallet')
            .fontSize(24)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#0B1220')
            .margin({ left: 4 })
          Blank()
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#F3F4F6')

        Scroll() {
          Column() {
            Row() {
              Row() {
                ForEach(this.filters, (filter: string) => {
                  this.FilterChip(filter)
                }, (filter: string) => filter)
              }
              .layoutWeight(1)

              Row() {
                Text('Hide')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                  .width(36)
                  .height(24)
                  .selectedColor('#1F2937')
                  .margin({ left: 4 })
                  .onChange((isOn: boolean) => {
                    this.showBalance = !isOn;
                  })
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')

            ForEach(this.accounts, (account: AccountCardModel) => {
              this.AccountCard(account)
                .margin({ top: 8 })
            }, (account: AccountCardModel) => account.id.toString())

            Row() {
              Text('Recent Activity')
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor('#0B1220')
                .layoutWeight(1)
              Row() {
                this.AssistChip('Income')
                this.AssistChip('Expense')
                  .margin({ left: 4 })
              }
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .margin({ top: 8 })

            ForEach(this.transactions, (tx: TxItemModel) => {
              this.TransactionCard(tx)
                .margin({ top: 8 })
            }, (tx: TxItemModel) => tx.id.toString())

            Blank().height(100)
          }
          .width('100%')
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F3F4F6')

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F6')
  }
}
