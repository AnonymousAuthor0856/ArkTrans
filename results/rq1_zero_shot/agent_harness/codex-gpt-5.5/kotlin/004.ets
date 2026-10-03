const NAME: string = '007_FinanceWallect_en';
const UI_TYPE: string = 'Finance Wallet';
const STYLE_THEME: string = 'High-Contrast Accessible';
const LANG: string = 'en';
const BASELINE_SIZE: string = '1280x720';

class AppColors {
  static readonly primary: string = '#1F2937';
  static readonly secondary: string = '#10B981';
  static readonly tertiary: string = '#3B82F6';
  static readonly background: string = '#F3F4F6';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#0B1220';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0B1220';
  static readonly onSurface: string = '#0B1220';
}

class AppSpacing {
  static readonly xs: number = 2;
  static readonly sm: number = 4;
  static readonly md: number = 6;
  static readonly lg: number = 8;
  static readonly xl: number = 12;
  static readonly xxl: number = 16;
  static readonly xxxl: number = 24;
}

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

@Entry
@Component
struct MainActivity {
  @State showBalance: boolean = true;
  @State selected: string = 'Month';
  @State flags: string[] = [];
  private range: string[] = ['All', 'Week', 'Month', 'Year'];
  private accounts: AccountCard[] = [
    new AccountCard(1, 'Wallet', '$2,845.20', '#10B981'),
    new AccountCard(2, 'Savings', '$8,120.00', '#3B82F6'),
    new AccountCard(3, 'Investments', '$15,430.55', '#F59E0B')
  ];
  private txs: TxItem[] = [
    new TxItem(1, 'Grocery Market', 'Today • 12:40', '-$32.18', false),
    new TxItem(2, 'Salary', 'Yesterday • 09:00', '+$3,200.00', true),
    new TxItem(3, 'Coffee Shop', 'Yesterday • 15:22', '-$4.90', false),
    new TxItem(4, 'ETF Purchase', 'Mon • 10:05', '-$250.00', false),
    new TxItem(5, 'Refund', 'Sun • 18:40', '+$18.99', true)
  ];

  toggleFlag(label: string): void {
    if (this.flags.includes(label)) {
      this.flags = this.flags.filter((item: string) => item !== label);
    } else {
      this.flags = [...this.flags, label];
    }
  }

  @Builder
  Header(): void {
    Row({ space: AppSpacing.sm }) {
      Rect().width(20).height(20).fill(AppColors.primary).radius(6);
      Text('Wallet')
        .fontSize(24)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface);
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface);
  }

  @Builder
  RangeChip(label: string): void {
    Button(label)
      .fontSize(label === this.selected ? 14 : 12)
      .fontWeight(label === this.selected ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(label === this.selected ? AppColors.onPrimary : AppColors.onSurface)
      .backgroundColor(label === this.selected ? AppColors.primary : AppColors.surface)
      .border({ width: 1, color: AppColors.outline })
      .borderRadius(8)
      .height(36)
      .padding({ left: 10, right: 10 })
      .onClick(() => {
        this.selected = label;
      });
  }

  @Builder
  Controls(): void {
    Row() {
      Row({ space: AppSpacing.sm }) {
        ForEach(this.range, (label: string) => {
          this.RangeChip(label);
        }, (label: string) => label)
      }
      .alignItems(VerticalAlign.Center);
      Blank();
      Row({ space: AppSpacing.sm }) {
        Text('Hide')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
          .selectedColor(AppColors.primary)
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
  Chip(label: string, active: boolean, onTap: () => void): void {
    Button(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(active ? AppColors.onSecondary : AppColors.onSurface)
      .backgroundColor(active ? AppColors.secondary : AppColors.surface)
      .border({ width: 1, color: AppColors.outline })
      .borderRadius(6)
      .height(32)
      .padding({ left: 10, right: 10 })
      .onClick(onTap);
  }

  @Builder
  AccountItem(account: AccountCard): void {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Row({ space: AppSpacing.sm }) {
          Rect().width(16).height(16).fill(account.accent).radius(6);
          Text(account.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface);
        }
        .alignItems(VerticalAlign.Center);
        Blank();
        this.Chip('Manage', true, () => {});
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);

      Stack() {
        Text(this.showBalance ? account.balance : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface);
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(8)
      .alignContent(Alignment.Center);

      Row({ space: AppSpacing.sm }) {
        this.Chip('Transfer', true, () => {});
        this.Chip('Details', false, () => {});
      }
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .constraintSize({ minHeight: 120 })
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .borderRadius(12)
    .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  ActivityHeader(): void {
    Row() {
      Text('Recent Activity')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface);
      Blank();
      Row({ space: AppSpacing.sm }) {
        this.Chip('Income', this.flags.includes('Income'), () => {
          this.toggleFlag('Income');
        });
        this.Chip('Expense', this.flags.includes('Expense'), () => {
          this.toggleFlag('Expense');
        });
      }
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  TransactionItem(tx: TxItem): void {
    Row() {
      Row({ space: AppSpacing.md }) {
        Rect()
          .width(32)
          .height(32)
          .fill(tx.positive ? AppColors.success : AppColors.error)
          .radius(6);
        Column({ space: AppSpacing.xs }) {
          Text(tx.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface);
          Text(tx.subtitle)
            .fontSize(12)
            .fontColor(AppColors.onSurface);
        }
        .alignItems(HorizontalAlign.Start);
      }
      .alignItems(VerticalAlign.Center);
      Blank();
      Text(tx.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(tx.positive ? AppColors.success : AppColors.error);
    }
    .width('100%')
    .constraintSize({ minHeight: 72 })
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .borderRadius(12)
    .shadow({ radius: 2, color: '#1F000000', offsetY: 0.5 })
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  BottomBar(): void {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Total Balance')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Text(this.showBalance ? '$26,395.75' : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface);
      }
      .alignItems(HorizontalAlign.Start);
      Blank();
      Button('Add Money')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(12)
        .width(140)
        .height(44);
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 6, color: '#29000000', offsetY: 1.5 })
    .alignItems(VerticalAlign.Center);
  }

  build() {
    Column() {
      this.Header();
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          this.Controls();
          ForEach(this.accounts, (account: AccountCard) => {
            this.AccountItem(account);
          }, (account: AccountCard) => account.id.toString())
          this.ActivityHeader();
          ForEach(this.txs, (tx: TxItem) => {
            this.TransactionItem(tx);
          }, (tx: TxItem) => tx.id.toString())
          Blank().height(AppSpacing.xxl);
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.xxxl });
      }
      .layoutWeight(1);
      this.BottomBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
