// FinanceWalletApp.ets

// MARK: - App Tokens & Colors
class AppColors {
  primary: ResourceColor = '#1F2937';
  secondary: ResourceColor = '#10B981';
  tertiary: ResourceColor = '#3B82F6';
  background: ResourceColor = '#F3F4F6';
  surface: ResourceColor = '#FFFFFF';
  surfaceVariant: ResourceColor = '#E5E7EB';
  outline: ResourceColor = '#D1D5DB';
  success: ResourceColor = '#16A34A';
  warning: ResourceColor = '#F59E0B';
  error: ResourceColor = '#EF4444';
  onPrimary: ResourceColor = '#FFFFFF';
  onSecondary: ResourceColor = '#0B1220';
  onSurface: ResourceColor = '#0B1220';
}

interface FontInfo {
  size: number | string | Resource;
  weight: FontWeight;
}

class AppTypography {
  display: FontInfo = { size: 24, weight: FontWeight.Medium };
  headline: FontInfo = { size: 18, weight: FontWeight.Medium };
  title: FontInfo = { size: 14, weight: FontWeight.Medium };
  body: FontInfo = { size: 12, weight: FontWeight.Regular };
  label: FontInfo = { size: 10, weight: FontWeight.Medium };
}

class AppSpacing {
  xs: number = 2;
  sm: number = 4;
  md: number = 6;
  lg: number = 8;
  xl: number = 12;
  xxl: number = 16;
  xxxl: number = 24;
}

class AppShapes {
  small: number = 6;
  medium: number = 8;
  large: number = 12;
}

class AppTokens {
  static readonly Colors: AppColors = new AppColors();
  static readonly Typography: AppTypography = new AppTypography();
  static readonly Spacing: AppSpacing = new AppSpacing();
  static readonly Shapes: AppShapes = new AppShapes();
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

// MARK: - Entry Point
@Entry
@Component
struct FinanceWalletApp {
  // State
  @State showBalance: boolean = true;
  @State selectedFilter: string = "Month";
  @State flags: Set<string> = new Set();

  // Data
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

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column() {
        // Top Bar
        Row() {
          Row()
            .width(20)
            .height(20)
            .borderRadius(AppTokens.Shapes.small)
            .backgroundColor(AppTokens.Colors.primary);

          Text("Wallet")
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ left: AppTokens.Spacing.sm });

          Blank();
        }
        .width('100%')
        .padding(AppTokens.Spacing.xxl)
        .backgroundColor(AppTokens.Colors.background);

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
                    onClickAction: () => {
                      this.selectedFilter = filter;
                    }
                  });
                });
              }

              Blank();

              Row({ space: AppTokens.Spacing.sm }) {
                Text("Hide")
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(AppTokens.Colors.onSurface);

                // Custom Toggle Implementation
                Row() {
                  Circle({ width: 16, height: 16 })
                    .fill(this.showBalance ? AppTokens.Colors.onPrimary : AppTokens.Colors.outline)
                    .margin(this.showBalance ? { left: 18 } : { left: 2 });
                }
                .width(36)
                .height(20)
                .borderRadius(10)
                .backgroundColor(this.showBalance ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                .border({ width: this.showBalance ? 0 : 1, color: AppTokens.Colors.outline })
                .onClick(() => {
                  this.showBalance = !this.showBalance;
                });
              }
            }
            .width('100%');

            // Accounts List
            ForEach(this.accounts, (account: AccountCardModel) => {
              AccountCardView({ account: account, showBalance: this.showBalance });
            });

            // Recent Activity Header
            Row() {
              Text("Recent Activity")
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface);

              Blank();

              Row({ space: AppTokens.Spacing.sm }) {
                AssistChip({
                  label: "Income",
                  isSelected: this.flags.has("Income"),
                  onClickAction: () => {
                    if (this.flags.has("Income")) {
                      this.flags.delete("Income");
                    } else {
                      this.flags.add("Income");
                    }
                    // Trigger re-render
                    this.flags = new Set(this.flags);
                  }
                });
                AssistChip({
                  label: "Expense",
                  isSelected: this.flags.has("Expense"),
                  onClickAction: () => {
                    if (this.flags.has("Expense")) {
                      this.flags.delete("Expense");
                    } else {
                      this.flags.add("Expense");
                    }
                    // Trigger re-render
                    this.flags = new Set(this.flags);
                  }
                });
              }
            }
            .width('100%');

            // Transactions List
            ForEach(this.transactions, (tx: TxItemModel) => {
              TransactionCard({ tx: tx });
            });

            // Bottom Padding for FAB/BottomBar
            Column().height(100);
          }
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.md,
            bottom: AppTokens.Spacing.md
          });
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1);
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background);

      // Bottom Bar Overlay
      Column() {
        Row() {
          Column() {
            Text("Total Balance")
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onSurface);
            Text(this.showBalance ? "$26,395.75" : "•••••••")
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.onSurface);
          }
          .alignItems(HorizontalAlign.Start);

          Blank();

          Button("Add Money")
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .width(140)
            .height(44)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large);
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: -1.5 });
      }
      .width('100%');
    }
    .width('100%')
    .height('100%');
  }
}

// MARK: - Components

@Component
struct FilterChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  onClickAction: () => void = () => {};

  build() {
    Text(this.label)
      .fontSize(this.isSelected ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
      .fontWeight(this.isSelected ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.medium)
      .border({ width: this.isSelected ? 0 : 1, color: AppTokens.Colors.outline })
      .onClick(() => {
        this.onClickAction();
      });
  }
}

@Component
struct AssistChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  onClickAction: () => void = () => {};

  build() {
    Text(this.label)
      .fontSize(AppTokens.Typography.label.size)
      .fontWeight(AppTokens.Typography.label.weight)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .onClick(() => {
        this.onClickAction();
      });
  }
}

@Component
struct AccountCardView {
  @Prop account: AccountCardModel;
  @Prop showBalance: boolean;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Header
      Row() {
        Row({ space: AppTokens.Spacing.sm }) {
          Row()
            .width(16)
            .height(16)
            .borderRadius(AppTokens.Shapes.small)
            .backgroundColor(this.account.accent);

          Text(this.account.name)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface);
        }

        Blank();

        Text("Manage")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSecondary)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline });
      }
      .width('100%');

      // Balance Box
      Stack() {
        Text(this.showBalance ? this.account.balance : "•••••••")
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface);
      }
      .width('100%')
      .aspectRatio(2.8)
      .borderRadius(AppTokens.Shapes.medium)
      .backgroundColor(AppTokens.Colors.surfaceVariant);

      // Actions
      Row({ space: AppTokens.Spacing.sm }) {
        Text("Transfer")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSecondary)
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline });

        Text("Details")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline });
      }
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: 1 })
    .border({ width: 1, color: AppTokens.Colors.outline })
    .constraintSize({ minHeight: 120 });
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
          .backgroundColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error);

        Column({ space: AppTokens.Spacing.xs }) {
          Text(this.tx.title)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface);
          Text(this.tx.subtitle)
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .alignItems(HorizontalAlign.Start);
      }

      Blank();

      Text(this.tx.amount)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error);
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .constraintSize({ minHeight: 72 })
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 2, color: 'rgba(0,0,0,0.12)', offsetX: 0, offsetY: 0.5 })
    .border({ width: 1, color: AppTokens.Colors.outline });
  }
}