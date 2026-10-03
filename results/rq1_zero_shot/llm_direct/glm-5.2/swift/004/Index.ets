// MARK: - App Tokens & Colors
class AppTokens {
  static Colors = {
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
  }

  static Typography = {
    display: { size: 24, weight: FontWeight.Medium },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
    label: { size: 10, weight: FontWeight.Medium }
  }

  static Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  }

  static Shapes = {
    small: 6,
    medium: 8,
    large: 12
  }
}

// MARK: - Models
class AccountCardModel {
  id: number;
  name: string;
  balance: string;
  accent: ResourceColor;

  constructor(id: number, name: string, balance: string, accent: ResourceColor) {
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
struct FinanceWalletApp {
  @State showBalance: boolean = true;
  @State selectedFilter: string = "Month";
  @State flags: Set<string> = new Set<string>();

  private filters: string[] = ["All", "Week", "Month", "Year"];
  private accounts: AccountCardModel[] = [
    new AccountCardModel(1, "Wallet", "$2,845.20", AppTokens.Colors.secondary),
    new AccountCardModel(2, "Savings", "$8,120.00", AppTokens.Colors.tertiary),
    new AccountCardModel(3, "Investments", "$15,430.55", AppTokens.Colors.warning)
  ];
  private transactions: TxItemModel[] = [
    new TxItemModel(1, "Grocery Market", "Today • 12:40", "-$32.18", false),
    new TxItemModel(2, "Salary", "Yesterday • 09:00", "+$3,200.00", true),
    new TxItemModel(3, "Coffee Shop", "Yesterday • 15:22", "-$4.90", false),
    new TxItemModel(4, "ETF Purchase", "Mon • 10:05", "-$250.00", false),
    new TxItemModel(5, "Refund", "Sun • 18:40", "+$18.99", true)
  ];

  toggleFlag(flag: string) {
    if (this.flags.has(flag)) {
      this.flags.delete(flag);
    } else {
      this.flags.add(flag);
    }
    // Trigger re-render by reassigning the Set
    this.flags = new Set(this.flags);
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column() {
        // Top Bar
        Row() {
          Row()
            .width(20)
            .height(20)
            .borderRadius(AppTokens.Shapes.small)
            .backgroundColor(AppTokens.Colors.primary)
          
          Text("Wallet")
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ left: AppTokens.Spacing.sm })

          Blank()
        }
        .width('100%')
        .padding(AppTokens.Spacing.xxl)
        .backgroundColor(AppTokens.Colors.background)

        // Scrollable Content
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
                })
              }

              Blank()

              Row({ space: AppTokens.Spacing.sm }) {
                Text("Hide")
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(AppTokens.Colors.onSurface)
                
                // Custom Switch
                Stack({ alignContent: this.showBalance ? Alignment.End : Alignment.Start }) {
                  Circle({ width: 16, height: 16 })
                    .fill(this.showBalance ? AppTokens.Colors.onPrimary : AppTokens.Colors.outline)
                    .margin(2)
                }
                .width(36)
                .height(20)
                .borderRadius(16)
                .backgroundColor(this.showBalance ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                .border({ width: this.showBalance ? 0 : 1, color: AppTokens.Colors.outline })
                .onClick(() => {
                  this.showBalance = !this.showBalance;
                })
              }
            }
            .width('100%')

            // Accounts List
            ForEach(this.accounts, (account: AccountCardModel) => {
              AccountCardView({ account: account, showBalance: this.showBalance })
            })

            // Recent Activity Header
            Row() {
              Text("Recent Activity")
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              Row({ space: AppTokens.Spacing.sm }) {
                AssistChip({
                  label: "Income",
                  isSelected: this.flags.has("Income"),
                  onClick: () => { this.toggleFlag("Income"); }
                })
                AssistChip({
                  label: "Expense",
                  isSelected: this.flags.has("Expense"),
                  onClick: () => { this.toggleFlag("Expense"); }
                })
              }
            }
            .width('100%')

            // Transactions List
            ForEach(this.transactions, (tx: TxItemModel) => {
              TransactionCard({ tx: tx })
            })

            // Bottom Padding for FAB/BottomBar
            Column().height(100)
          }
          .padding({
            horizontal: AppTokens.Spacing.lg,
            vertical: AppTokens.Spacing.md
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.TopStart)
      }
      .width('100%')
      .height('100%')

      // Bottom Bar Overlay
      Column() {
        Blank()

        Row() {
          Column() {
            Text("Total Balance")
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onSurface)
            Text(this.showBalance ? "$26,395.75" : "•••••••")
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })

          Blank()

          Button("Add Money")
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .width(140)
            .height(44)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
        }
        .width('100%')
        .padding({
          horizontal: AppTokens.Spacing.lg,
          vertical: AppTokens.Spacing.md
        })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: -1.5 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

@Component
struct FilterChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  onClick: () => void;

  build() {
    Button(this.label)
      .fontSize(this.isSelected ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
      .fontWeight(this.isSelected ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({ horizontal: 12, vertical: 8 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.medium)
      .border({ width: this.isSelected ? 0 : 1, color: AppTokens.Colors.outline })
      .onClick(() => this.onClick())
  }
}

@Component
struct AssistChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  onClick: () => void;

  build() {
    Button(this.label)
      .fontSize(AppTokens.Typography.label.size)
      .fontWeight(AppTokens.Typography.label.weight)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .padding({ horizontal: 8, vertical: 6 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .onClick(() => this.onClick())
  }
}

@Component
struct AccountCardView {
  @Prop account: AccountCardModel;
  @Prop showBalance: boolean;

  build() {
    Column() {
      // Header
      Row() {
        Row({ space: AppTokens.Spacing.sm }) {
          Row()
            .width(16)
            .height(16)
            .borderRadius(AppTokens.Shapes.small)
            .backgroundColor(this.account.accent)
          
          Text(this.account.name)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }

        Blank()

        Button("Manage")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSecondary)
          .padding({ horizontal: 8, vertical: 4 })
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
      }
      .width('100%')

      // Balance Box
      Stack() {
        Text(this.showBalance ? this.account.balance : "•••••••")
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
      .margin({ top: AppTokens.Spacing.sm })

      // Actions
      Row({ space: AppTokens.Spacing.sm }) {
        Button("Transfer")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSecondary)
          .padding({ horizontal: 8, vertical: 6 })
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
        
        Button("Details")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ horizontal: 8, vertical: 6 })
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
      }
      .margin({ top: AppTokens.Spacing.sm })
    }
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
  @Prop tx: TxItemModel;

  build() {
    Row() {
      Row({ space: AppTokens.Spacing.md }) {
        Row()
          .width(32)
          .height(32)
          .borderRadius(AppTokens.Shapes.small)
          .backgroundColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
        
        Column() {
          Text(this.tx.title)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
          Text(this.tx.subtitle)
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank()

      Text(this.tx.amount)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .constraintSize({ minHeight: 72 })
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 2, color: 'rgba(0,0,0,0.12)', offsetX: 0, offsetY: 0.5 })
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}