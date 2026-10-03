class AppColors {
  primary: string = '#1F2937';
  secondary: string = '#10B981';
  tertiary: string = '#3B82F6';
  background: string = '#F3F4F6';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#E5E7EB';
  outline: string = '#D1D5DB';
  success: string = '#16A34A';
  warning: string = '#F59E0B';
  error: string = '#EF4444';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#0B1220';
  onSurface: string = '#0B1220';
}

const Colors = new AppColors();

class AccountCardModel {
  id: number = 0;
  name: string = '';
  balance: string = '';
  accent: string = '';
}

class TxItemModel {
  id: number = 0;
  title: string = '';
  subtitle: string = '';
  amount: string = '';
  positive: boolean = false;
}

@Entry
@Component
struct ContentView {
  @State showBalance: boolean = true;
  @State selectedFilter: string = 'Month';
  @State incomeSelected: boolean = false;
  @State expenseSelected: boolean = false;

  filters: string[] = ['All', 'Week', 'Month', 'Year'];

  accounts: AccountCardModel[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: '#10B981' },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: '#3B82F6' },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: '#F59E0B' },
  ];

  transactions: TxItemModel[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true },
  ];

  @Builder
  FilterChip(label: string, isSelected: boolean) {
    Text(label)
      .fontSize(isSelected ? 14 : 12)
      .fontWeight(isSelected ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(isSelected ? Colors.onPrimary : Colors.onSurface)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(isSelected ? Colors.primary : Colors.surface)
      .borderRadius(8)
      .border({ width: isSelected ? 0 : 1, color: Colors.outline })
      .onClick(() => {
        this.selectedFilter = label;
      })
  }

  @Builder
  AssistChip(label: string, isSelected: boolean, onClickFn: () => void) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(isSelected ? Colors.onSecondary : Colors.onSurface)
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor(isSelected ? Colors.secondary : Colors.surface)
      .borderRadius(6)
      .border({ width: 1, color: Colors.outline })
      .onClick(onClickFn)
  }

  @Builder
  AccountCard(account: AccountCardModel) {
    Column({ space: 4 }) {
      Row() {
        Row({ space: 4 }) {
          Column()
            .width(16)
            .height(16)
            .borderRadius(6)
            .backgroundColor(account.accent)
          Text(account.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
        }
        .alignItems(VerticalAlign.Center)

        Blank()

        Text('Manage')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSecondary)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(Colors.secondary)
          .borderRadius(6)
          .border({ width: 1, color: Colors.outline })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Stack() {
        Column()
          .width('100%')
          .height(120)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(8)

        Text(this.showBalance ? account.balance : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(120)
      .borderRadius(8)

      Row({ space: 4 }) {
        Text('Transfer')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSecondary)
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .backgroundColor(Colors.secondary)
          .borderRadius(6)
          .border({ width: 1, color: Colors.outline })

        Text('Details')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .backgroundColor(Colors.surface)
          .borderRadius(6)
          .border({ width: 1, color: Colors.outline })
      }
      .width('100%')
    }
    .padding(8)
    .backgroundColor(Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: Colors.outline })
    .shadow({ radius: 4, color: '#22000000', offsetX: 0, offsetY: 1 })
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  TransactionCard(tx: TxItemModel) {
    Row() {
      Row({ space: 6 }) {
        Column()
          .width(32)
          .height(32)
          .borderRadius(6)
          .backgroundColor(tx.positive ? Colors.success : Colors.error)

        Column({ space: 2 }) {
          Text(tx.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text(tx.subtitle)
            .fontSize(12)
            .fontWeight(FontWeight.Normal)
            .fontColor(Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Blank()

      Text(tx.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(tx.positive ? Colors.success : Colors.error)
    }
    .padding(8)
    .width('100%')
    .constraintSize({ minHeight: 72 })
    .backgroundColor(Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: Colors.outline })
    .shadow({ radius: 2, color: '#1F000000', offsetX: 0, offsetY: 1 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Row({ space: 4 }) {
          Column()
            .width(20)
            .height(20)
            .borderRadius(6)
            .backgroundColor(Colors.primary)
          Text('Wallet')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
          Blank()
        }
        .width('100%')
        .padding(16)
        .backgroundColor(Colors.background)
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Column({ space: 8 }) {
            // Filters Row
            Row() {
              Row({ space: 4 }) {
                ForEach(this.filters, (filter: string) => {
                  this.FilterChip(filter, this.selectedFilter === filter)
                })
              }
              .alignItems(VerticalAlign.Center)

              Blank()

              Row({ space: 4 }) {
                Text('Hide')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)

                Stack() {
                  Column()
                    .width(36)
                    .height(20)
                    .borderRadius(16)
                    .backgroundColor(this.showBalance ? Colors.surfaceVariant : Colors.primary)
                    .border({ width: this.showBalance ? 1 : 0, color: Colors.outline })

                  Column()
                    .width(16)
                    .height(16)
                    .borderRadius(8)
                    .backgroundColor(this.showBalance ? Colors.outline : Colors.onPrimary)
                    .translate({ x: this.showBalance ? -8 : 8 })
                }
                .width(36)
                .height(20)
                .onClick(() => {
                  this.showBalance = !this.showBalance;
                })
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            // Accounts
            ForEach(this.accounts, (account: AccountCardModel) => {
              this.AccountCard(account)
            })

            // Recent Activity Header
            Row() {
              Text('Recent Activity')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.onSurface)

              Blank()

              Row({ space: 4 }) {
                this.AssistChip('Income', this.incomeSelected, () => {
                  this.incomeSelected = !this.incomeSelected;
                })
                this.AssistChip('Expense', this.expenseSelected, () => {
                  this.expenseSelected = !this.expenseSelected;
                })
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            // Transactions
            ForEach(this.transactions, (tx: TxItemModel) => {
              this.TransactionCard(tx)
            })

            Column()
              .height(100)
          }
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Colors.background)

      // Bottom Bar
      Column() {
        Row() {
          Column({ space: 2 }) {
            Text('Total Balance')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
            Text(this.showBalance ? '$26,395.75' : '•••••••')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Text('Add Money')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSecondary)
            .width(140)
            .height(44)
            .textAlign(TextAlign.Center)
            .backgroundColor(Colors.secondary)
            .borderRadius(12)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor(Colors.surface)
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
  }
}