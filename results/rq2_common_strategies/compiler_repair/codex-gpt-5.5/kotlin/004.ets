class AccountCard {
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

class TxItem {
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

class WalletColors {
  static primary: string = '#1F2937';
  static secondary: string = '#10B981';
  static tertiary: string = '#3B82F6';
  static background: string = '#F3F4F6';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E5E7EB';
  static outline: string = '#D1D5DB';
  static success: string = '#16A34A';
  static warning: string = '#F59E0B';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#0B1220';
  static onSurface: string = '#0B1220';
}

@Entry
@Component
struct Index {
  @State showBalance: boolean = true;
  @State selectedRange: string = 'Month';
  @State incomeSelected: boolean = false;
  @State expenseSelected: boolean = false;

  private ranges: string[] = ['All', 'Week', 'Month', 'Year'];
  private accounts: AccountCard[] = [
    new AccountCard(1, 'Wallet', '$2,845.20', WalletColors.secondary),
    new AccountCard(2, 'Savings', '$8,120.00', WalletColors.tertiary),
    new AccountCard(3, 'Investments', '$15,430.55', WalletColors.warning)
  ];
  private txs: TxItem[] = [
    new TxItem(1, 'Grocery Market', 'Today - 12:40', '-$32.18', false),
    new TxItem(2, 'Salary', 'Yesterday - 09:00', '+$3,200.00', true),
    new TxItem(3, 'Coffee Shop', 'Yesterday - 15:22', '-$4.90', false),
    new TxItem(4, 'ETF Purchase', 'Mon - 10:05', '-$250.00', false),
    new TxItem(5, 'Refund', 'Sun - 18:40', '+$18.99', true)
  ];

  @Builder
  RangeChip(label: string) {
    Text(label)
      .fontSize(this.selectedRange === label ? 14 : 12)
      .fontWeight(this.selectedRange === label ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.selectedRange === label ? WalletColors.onPrimary : WalletColors.onSurface)
      .lineHeight(this.selectedRange === label ? 18 : 16)
      .padding({ left: 10, right: 10, top: 7, bottom: 7 })
      .backgroundColor(this.selectedRange === label ? WalletColors.primary : WalletColors.surface)
      .border({ width: 1, color: WalletColors.outline, radius: 8 })
      .onClick(() => {
        this.selectedRange = label;
      })
  }

  @Builder
  AssistChip(label: string, active: boolean, action: () => void, filledColor: string = WalletColors.secondary) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(active ? WalletColors.onSecondary : WalletColors.onSurface)
      .lineHeight(14)
      .padding({ left: 10, right: 10, top: 6, bottom: 6 })
      .backgroundColor(active ? filledColor : WalletColors.surface)
      .border({ width: 1, color: WalletColors.outline, radius: 6 })
      .onClick(action)
  }

  @Builder
  AccountView(account: AccountCard) {
    Column({ space: 4 }) {
      Row() {
        Row({ space: 4 }) {
          Blank()
            .width(16)
            .height(16)
            .backgroundColor(account.accent)
            .borderRadius(6)
          Text(account.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(WalletColors.onSurface)
            .lineHeight(18)
        }
        .alignItems(VerticalAlign.Center)

        this.AssistChip('Manage', true, () => {}, WalletColors.secondary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Stack() {
        Text(this.showBalance ? account.balance : '*******')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(WalletColors.onSurface)
          .lineHeight(24)
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(WalletColors.surfaceVariant)
      .borderRadius(8)
      .alignContent(Alignment.Center)

      Row({ space: 4 }) {
        this.AssistChip('Transfer', true, () => {}, WalletColors.secondary)
        this.AssistChip('Details', false, () => {})
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .constraintSize({ minHeight: 120 })
    .padding(8)
    .backgroundColor(WalletColors.surface)
    .border({ width: 1, color: WalletColors.outline, radius: 12 })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  TransactionView(tx: TxItem) {
    Row() {
      Row({ space: 6 }) {
        Blank()
          .width(32)
          .height(32)
          .backgroundColor(tx.positive ? WalletColors.success : WalletColors.error)
          .borderRadius(6)
        Column({ space: 2 }) {
          Text(tx.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(WalletColors.onSurface)
            .lineHeight(18)
          Text(tx.subtitle)
            .fontSize(12)
            .fontColor(WalletColors.onSurface)
            .lineHeight(16)
        }
      }
      .alignItems(VerticalAlign.Center)
      .layoutWeight(1)

      Text(tx.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(tx.positive ? WalletColors.success : WalletColors.error)
        .lineHeight(18)
    }
    .width('100%')
    .constraintSize({ minHeight: 72 })
    .padding(8)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(WalletColors.surface)
    .border({ width: 1, color: WalletColors.outline, radius: 12 })
    .shadow({ radius: 2, color: '#1F000000', offsetX: 0, offsetY: 1 })
  }

  build() {
    Column() {
      Row({ space: 4 }) {
        Blank()
          .width(20)
          .height(20)
          .backgroundColor(WalletColors.primary)
          .borderRadius(6)
        Text('Wallet')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(WalletColors.onSurface)
          .lineHeight(30)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(WalletColors.surface)

      Scroll() {
        Column({ space: 8 }) {
          Row() {
            Row({ space: 4 }) {
              ForEach(this.ranges, (range: string) => {
                this.RangeChip(range)
              }, (range: string) => range)
            }
            .alignItems(VerticalAlign.Center)

            Row({ space: 4 }) {
              Text('Hide')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(WalletColors.onSurface)
                .lineHeight(14)
              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .selectedColor(WalletColors.primary)
                .onChange((isOn: boolean) => {
                  this.showBalance = !isOn;
                })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          ForEach(this.accounts, (account: AccountCard) => {
            this.AccountView(account)
          }, (account: AccountCard) => account.id.toString())

          Row() {
            Text('Recent Activity')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(WalletColors.onSurface)
              .lineHeight(24)
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

          ForEach(this.txs, (tx: TxItem) => {
            this.TransactionView(tx)
          }, (tx: TxItem) => tx.id.toString())

          Blank().height(16)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 24 })
      }
      .layoutWeight(1)
      .width('100%')

      Row() {
        Column({ space: 2 }) {
          Text('Total Balance')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(WalletColors.onSurface)
            .lineHeight(14)
          Text(this.showBalance ? '$26,395.75' : '*******')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(WalletColors.onSurface)
            .lineHeight(24)
        }
        Button('Add Money')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(WalletColors.onSecondary)
          .backgroundColor(WalletColors.secondary)
          .borderRadius(12)
          .width(140)
          .height(44)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(WalletColors.surface)
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: -1 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(WalletColors.background)
  }
}
