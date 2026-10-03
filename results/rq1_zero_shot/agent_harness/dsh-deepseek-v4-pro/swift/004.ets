// MARK: - App Tokens & Colors
interface AppColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onSurface: string;
}

interface FontSpec {
  size: number;
  weight: FontWeight;
}

interface AppTypography {
  display: FontSpec;
  headline: FontSpec;
  title: FontSpec;
  body: FontSpec;
  label: FontSpec;
}

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface AppShapes {
  small: number;
  medium: number;
  large: number;
}

class AppTokens {
  static readonly Colors: AppColors = {
    primary: '#1F2937',
    secondary: '#10B981',
    tertiary: '#3B82F6',
    background: '#F3F4F6',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#0B1220',
    onSurface: '#0B1220'
  };

  static readonly Typography: AppTypography = {
    display: { size: 24, weight: FontWeight.Semibold },
    headline: { size: 18, weight: FontWeight.Semibold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular },
    label: { size: 10, weight: FontWeight.Medium }
  };

  static readonly Spacing: AppSpacing = {
    xs: 2, sm: 4, md: 6, lg: 8, xl: 12, xxl: 16, xxxl: 24
  };

  static readonly Shapes: AppShapes = {
    small: 6, medium: 8, large: 12
  };
}

// MARK: - Models
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

// MARK: - Root View
@Entry
@Component
struct ContentView {
  // State
  @State showBalance: boolean = true;
  @State selectedFilter: string = 'Month';
  @State flags: string[] = [];

  // Data
  filters: string[] = ['All', 'Week', 'Month', 'Year'];
  accounts: AccountCardModel[] = [
    new AccountCardModel(1, 'Wallet', '$2,845.20', '#10B981'),
    new AccountCardModel(2, 'Savings', '$8,120.00', '#3B82F6'),
    new AccountCardModel(3, 'Investments', '$15,430.55', '#F59E0B')
  ];
  transactions: TxItemModel[] = [
    new TxItemModel(1, 'Grocery Market', 'Today • 12:40', '-$32.18', false),
    new TxItemModel(2, 'Salary', 'Yesterday • 09:00', '+$3,200.00', true),
    new TxItemModel(3, 'Coffee Shop', 'Yesterday • 15:22', '-$4.90', false),
    new TxItemModel(4, 'ETF Purchase', 'Mon • 10:05', '-$250.00', false),
    new TxItemModel(5, 'Refund', 'Sun • 18:40', '+$18.99', true)
  ];

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: 0 }) {
        // Top Bar
        Row({ space: AppTokens.Spacing.sm }) {
          Row()
            .width(20)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
          Text('Wallet')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
        }
        .padding(16)
        .backgroundColor(AppTokens.Colors.background)

        // Content
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Filters Row
            Row() {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  FilterChip({
                    label: filter,
                    isSelected: this.selectedFilter === filter,
                    onClick: () => { this.selectedFilter = filter; }
                  })
                }, (filter: string) => filter)
              }

              Blank()

              Row({ space: AppTokens.Spacing.sm }) {
                Text('Hide')
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(AppTokens.Colors.onSurface)

                Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                  .selectedColor(AppTokens.Colors.primary)
                  .width(36)
                  .height(20)
                  .onChange((isOn: boolean) => { this.showBalance = !isOn; })
              }
            }

            // Accounts List
            ForEach(this.accounts, (account: AccountCardModel) => {
              AccountCardView({ account: account, showBalance: this.showBalance })
            }, (account: AccountCardModel) => account.id.toString())

            // Recent Activity Header
            Row() {
              Text('Recent Activity')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              Row({ space: AppTokens.Spacing.sm }) {
                AssistChip({
                  label: 'Income',
                  isSelected: this.flags.includes('Income'),
                  onClick: () => {
                    if (this.flags.includes('Income')) {
                      this.flags = this.flags.filter((f: string) => f !== 'Income');
                    } else {
                      this.flags = this.flags.concat(['Income']);
                    }
                  }
                })
                AssistChip({
                  label: 'Expense',
                  isSelected: this.flags.includes('Expense'),
                  onClick: () => {
                    if (this.flags.includes('Expense')) {
                      this.flags = this.flags.filter((f: string) => f !== 'Expense');
                    } else {
                      this.flags = this.flags.concat(['Expense']);
                    }
                  }
                })
              }
            }

            // Transactions List
            ForEach(this.transactions, (tx: TxItemModel) => {
              TransactionCard({ tx: tx })
            }, (tx: TxItemModel) => tx.id.toString())

            // Bottom Padding for FAB/BottomBar
            Blank()
              .height(100)
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // Bottom Bar Overlay
      Column() {
        Blank()

        Column() {
          Row() {
            Column({ space: AppTokens.Spacing.xs }) {
              Text('Total Balance')
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.onSurface)
              Text(this.showBalance ? '$26,395.75' : '•••••••')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button('Add Money')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .width(140)
              .height(44)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.large)
              .onClick(() => {})
          }
          .alignItems(VerticalAlign.Center)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: -1.5 })
      }
      .width('100%')
      .height('100%')
    }
  }
}

// MARK: - Components
@Component
struct FilterChip {
  @Prop label: string = '';
  @Prop isSelected: boolean = false;
  onClick: () => void = () => {};

  build() {
    Button(this.label)
      .fontSize(this.isSelected ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
      .fontWeight(this.isSelected ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.medium)
      .border({ width: this.isSelected ? 0 : 1, color: AppTokens.Colors.outline })
      .onClick(() => { this.onClick(); })
  }
}

@Component
struct AssistChip {
  @Prop label: string = '';
  @Prop isSelected: boolean = false;
  onClick: () => void = () => {};

  build() {
    Button(this.label)
      .fontSize(AppTokens.Typography.label.size)
      .fontWeight(AppTokens.Typography.label.weight)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .onClick(() => { this.onClick(); })
  }
}

@Component
struct AccountCardView {
  @Prop account: AccountCardModel = new AccountCardModel(0, '', '', '');
  @Prop showBalance: boolean = true;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Header
      Row() {
        Row({ space: AppTokens.Spacing.sm }) {
          Row()
            .width(16)
            .height(16)
            .backgroundColor(this.account.accent)
            .borderRadius(AppTokens.Shapes.small)
          Text(this.account.name)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        Blank()
        Button('Manage')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSecondary)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .onClick(() => {})
      }

      // Balance Box
      Stack() {
        Text(this.showBalance ? this.account.balance : '•••••••')
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)

      // Actions
      Row({ space: AppTokens.Spacing.sm }) {
        Button('Transfer')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSecondary)
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .onClick(() => {})

        Button('Details')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .onClick(() => {})
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: 1 })
    .border({ width: 1, color: AppTokens.Colors.outline })
    .constraintSize({ minHeight: 120 })
  }
}

@Component
struct TransactionCard {
  @Prop tx: TxItemModel = new TxItemModel(0, '', '', '', false);

  build() {
    Row() {
      Row({ space: AppTokens.Spacing.md }) {
        Row()
          .width(32)
          .height(32)
          .backgroundColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
          .borderRadius(AppTokens.Shapes.small)

        Column({ space: AppTokens.Spacing.xs }) {
          Text(this.tx.title)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
          Text(this.tx.subtitle)
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }
      Blank()
      Text(this.tx.amount)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
    }
    .padding(AppTokens.Spacing.lg)
    .constraintSize({ minHeight: 72 })
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 2, color: 'rgba(0,0,0,0.12)', offsetX: 0, offsetY: 0.5 })
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}
