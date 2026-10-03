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

class TransactionItem {
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

class AppColors {
  primary: string = '#1F2937';
  secondary: string = '#10B981';
  tertiary: string = '#3B82F6';
  background: string = '#F3F4F6';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#E5E7EB';
  outline: string = '#D1D5DB';
  text: string = '#0B1220';
  success: string = '#16A34A';
  error: string = '#EF4444';
}

const COLORS: AppColors = new AppColors();

const accounts: AccountCard[] = [
  new AccountCard(1, 'Wallet', '$2,845.20', COLORS.secondary),
  new AccountCard(2, 'Savings', '$8,120.00', COLORS.tertiary),
  new AccountCard(3, 'Investments', '$15,430.55', '#F59E0B')
];

const transactions: TransactionItem[] = [
  new TransactionItem(1, 'Grocery Market', 'Today • 12:40', '-$32.18', false),
  new TransactionItem(2, 'Salary', 'Yesterday • 09:00', '+$3,200.00', true),
  new TransactionItem(3, 'Coffee Shop', 'Yesterday • 15:22', '-$4.90', false),
  new TransactionItem(4, 'ETF Purchase', 'Mon • 10:05', '-$250.00', false),
  new TransactionItem(5, 'Refund', 'Sun • 18:40', '+$18.99', true)
];

@Entry
@Component
struct MainPage {
  @State selectedRange: string = 'Month';
  @State showBalance: boolean = true;
  @State incomeSelected: boolean = false;
  @State expenseSelected: boolean = false;

  private readonly ranges: string[] = ['All', 'Week', 'Month', 'Year'];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.topBar();
        this.content();
      }
      .width('100%')
      .height('100%')
      .backgroundColor(COLORS.background);

      this.bottomBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background);
  }

  @Builder
  topBar() {
    Row({ space: 8 }) {
      Column()
        .width(20)
        .height(20)
        .borderRadius(6)
        .backgroundColor(COLORS.primary);

      Text('Wallet')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.text);
    }
    .width('100%')
    .height(176)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLORS.surface);
  }

  @Builder
  content() {
    Scroll() {
      Column({ space: 16 }) {
        this.filters();

        ForEach(accounts, (account: AccountCard) => {
          this.accountCard(account);
        }, (account: AccountCard) => account.id.toString());

        this.activityHeader();

        ForEach(transactions, (item: TransactionItem) => {
          this.transactionCard(item);
        }, (item: TransactionItem) => item.id.toString());

        Blank().height(100);
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 28, bottom: 24 });
    }
    .width('100%')
    .layoutWeight(1)
    .scrollBar(BarState.Off);
  }

  @Builder
  filters() {
    Row() {
      Row({ space: 10 }) {
        ForEach(this.ranges, (range: string) => {
          Button(range, { type: ButtonType.Normal, stateEffect: true })
            .height(64)
            .padding({ left: 20, right: 20 })
            .borderRadius(14)
            .borderWidth(1)
            .borderColor(COLORS.outline)
            .backgroundColor(this.selectedRange === range ? COLORS.primary : COLORS.surface)
            .fontColor(this.selectedRange === range ? COLORS.surface : COLORS.text)
            .fontSize(24)
            .fontWeight(this.selectedRange === range ? FontWeight.Bold : FontWeight.Normal)
            .onClick(() => {
              this.selectedRange = range;
            });
        }, (range: string) => range);
      }
      .layoutWeight(1);

      Row({ space: 8 }) {
        Text('Hide')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.text);

        Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
          .width(76)
          .height(42)
          .selectedColor('#D9D5DD')
          .switchPointColor('#D0D5DD')
          .onChange((isOn: boolean) => {
            this.showBalance = !isOn;
          });
      }
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  accountCard(account: AccountCard) {
    Column({ space: 24 }) {
      Row() {
        Row({ space: 10 }) {
          Column()
            .width(32)
            .height(32)
            .borderRadius(10)
            .backgroundColor(account.accent);

          Text(account.name)
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLORS.text);
        }
        .layoutWeight(1)
        .alignItems(VerticalAlign.Center);

        Button('Manage', { type: ButtonType.Normal, stateEffect: true })
          .width(136)
          .height(64)
          .borderRadius(12)
          .borderWidth(1)
          .borderColor(COLORS.outline)
          .backgroundColor(COLORS.secondary)
          .fontColor('#071B19')
          .fontSize(20)
          .onClick(() => {});
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);

      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .aspectRatio(2.8)
          .borderRadius(15)
          .backgroundColor(COLORS.surfaceVariant);

        Text(this.showBalance ? account.balance : '•••••••')
          .fontSize(38)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.text);
      }
      .width('100%');

      Row({ space: 10 }) {
        Button('Transfer', { type: ButtonType.Normal, stateEffect: true })
          .height(64)
          .padding({ left: 30, right: 30 })
          .borderRadius(12)
          .borderWidth(1)
          .borderColor(COLORS.outline)
          .backgroundColor(COLORS.secondary)
          .fontColor('#071B19')
          .fontSize(20)
          .onClick(() => {});

        Button('Details', { type: ButtonType.Normal, stateEffect: true })
          .height(64)
          .padding({ left: 30, right: 30 })
          .borderRadius(12)
          .borderWidth(1)
          .borderColor(COLORS.outline)
          .backgroundColor(COLORS.surface)
          .fontColor(COLORS.text)
          .fontSize(20)
          .onClick(() => {});
      }
      .width('100%')
      .justifyContent(FlexAlign.Start);
    }
    .width('100%')
    .padding(16)
    .borderRadius(20)
    .borderWidth(1)
    .borderColor(COLORS.outline)
    .backgroundColor(COLORS.surface)
    .shadow({
      radius: 6,
      color: '#22000000',
      offsetX: 0,
      offsetY: 2
    });
  }

  @Builder
  activityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.text)
        .layoutWeight(1);

      Row({ space: 8 }) {
        this.filterChip('Income', this.incomeSelected, () => {
          this.incomeSelected = !this.incomeSelected;
        });
        this.filterChip('Expense', this.expenseSelected, () => {
          this.expenseSelected = !this.expenseSelected;
        });
      }
    }
    .width('100%')
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  filterChip(label: string, selected: boolean, action: () => void) {
    Button(label, { type: ButtonType.Normal, stateEffect: true })
      .height(40)
      .padding({ left: 14, right: 14 })
      .borderRadius(10)
      .borderWidth(1)
      .borderColor(COLORS.outline)
      .backgroundColor(selected ? COLORS.secondary : COLORS.surface)
      .fontColor(selected ? '#071B19' : COLORS.text)
      .fontSize(15)
      .onClick(action);
  }

  @Builder
  transactionCard(item: TransactionItem) {
    Row() {
      Row({ space: 12 }) {
        Column()
          .width(32)
          .height(32)
          .borderRadius(10)
          .backgroundColor(item.positive ? COLORS.success : COLORS.error);

        Column({ space: 3 }) {
          Text(item.title)
            .fontSize(17)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLORS.text);

          Text(item.subtitle)
            .fontSize(14)
            .fontColor('#4B5563');
        }
        .alignItems(HorizontalAlign.Start);
      }
      .layoutWeight(1)
      .alignItems(VerticalAlign.Center);

      Text(item.amount)
        .fontSize(17)
        .fontWeight(FontWeight.Medium)
        .fontColor(item.positive ? COLORS.success : COLORS.error);
    }
    .width('100%')
    .height(76)
    .padding(16)
    .borderRadius(16)
    .borderWidth(1)
    .borderColor(COLORS.outline)
    .backgroundColor(COLORS.surface);
  }

  @Builder
  bottomBar() {
    Row() {
      Column({ space: 2 }) {
        Text('Total Balance')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.text);

        Text(this.showBalance ? '$26,395.75' : '•••••••')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.text);
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1);

      Button('Add Money', { type: ButtonType.Normal, stateEffect: true })
        .width(280)
        .height(88)
        .borderRadius(24)
        .backgroundColor(COLORS.secondary)
        .fontColor('#071B19')
        .fontSize(27)
        .onClick(() => {});
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 14, bottom: 12 })
    .backgroundColor('#F0F1F3')
    .shadow({
      radius: 8,
      color: '#24000000',
      offsetX: 0,
      offsetY: -2
    });
  }
}
