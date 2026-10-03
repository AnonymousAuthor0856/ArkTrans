// FinanceWalletApp.ets
import { display } from '@kit.ArkUI';

// MARK: - App Tokens & Colors
class AppTokens {
  static readonly Colors = {
    primary: '#1F2937',
    secondary: '#10B981',
    tertiary: '#3B82F6',
    background: '#F3F4F6',
    surface: '#FFFFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#0B1220',
    onSurface: '#0B1220'
  };

  static readonly Typography = {
    display: { size: 24, weight: FontWeight.Medium },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular },
    label: { size: 10, weight: FontWeight.Medium }
  };

  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  };

  static readonly Shapes = {
    small: 6,
    medium: 8,
    large: 12
  };
}

// MARK: - Models
interface AccountCardModel {
  id: number;
  name: string;
  balance: string;
  accent: string;
}

interface TxItemModel {
  id: number;
  title: string;
  subtitle: string;
  amount: string;
  positive: boolean;
}

// MARK: - FilterChip Component
@Component
struct FilterChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  onClick: () => void = () => {};

  build() {
    Button(this.label) {
      this.onClick();
    }
    .fontSize(this.isSelected ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
    .fontWeight(this.isSelected ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
    .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
    .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({
      width: this.isSelected ? 0 : 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.medium
    })
  }
}

// MARK: - AssistChip Component
@Component
struct AssistChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  onClick: () => void = () => {};

  build() {
    Button(this.label) {
      this.onClick();
    }
    .fontSize(AppTokens.Typography.label.size)
    .fontWeight(AppTokens.Typography.label.weight)
    .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.small
    })
  }
}

// MARK: - AccountCardView Component
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
            .backgroundColor(this.account.accent)
            .borderRadius(AppTokens.Shapes.small)

          Text(this.account.name)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }

        Blank()

        Button('Manage') {
          // Manage action
        }
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSecondary)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.small)
        .border({
          width: 1,
          color: AppTokens.Colors.outline,
          radius: AppTokens.Shapes.small
        })
      }
      .width('100%')

      // Balance Box
      Stack() {
        Text(this.showBalance ? this.account.balance : '•••••••')
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(60)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)

      // Actions
      Row({ space: AppTokens.Spacing.sm }) {
        Button('Transfer') {
          // Transfer action
        }
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSecondary)
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.small)
        .border({
          width: 1,
          color: AppTokens.Colors.outline,
          radius: AppTokens.Shapes.small
        })

        Button('Details') {
          // Details action
        }
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.small)
        .border({
          width: 1,
          color: AppTokens.Colors.outline,
          radius: AppTokens.Shapes.small
        })
      }
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.14)',
      offsetX: 0,
      offsetY: 1
    })
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.large
    })
  }
}

// MARK: - TransactionCard Component
@Component
struct TransactionCard {
  @Prop tx: TxItemModel;

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
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .height(72)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: 2,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: 0.5
    })
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.large
    })
  }
}

// MARK: - Custom Switch Component
@Component
struct CustomSwitch {
  @Prop isOn: boolean;
  onToggle: (value: boolean) => void = () => {};

  build() {
    Stack() {
      Row()
        .width(36)
        .height(20)
        .backgroundColor(this.isOn ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
        .borderRadius(16)
        .border({
          width: this.isOn ? 0 : 1,
          color: AppTokens.Colors.outline,
          radius: 16
        })

      Circle()
        .width(16)
        .height(16)
        .fill(this.isOn ? AppTokens.Colors.onPrimary : AppTokens.Colors.outline)
        .offset({ x: this.isOn ? 8 : -8, y: 0 })
    }
    .width(36)
    .height(20)
    .onClick(() => {
      this.onToggle(!this.isOn);
    })
  }
}

// MARK: - ContentView (Root View)
@Entry
@Component
struct ContentView {
  @State private showBalance: boolean = true;
  @State private selectedFilter: string = 'Month';
  @State private incomeSelected: boolean = false;
  @State private expenseSelected: boolean = false;

  private filters: string[] = ['All', 'Week', 'Month', 'Year'];
  private accounts: AccountCardModel[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: '#10B981' },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: '#3B82F6' },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: '#F59E0B' }
  ];
  private transactions: TxItemModel[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ];

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content
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
        .width('100%')
        .padding(AppTokens.Spacing.lg)
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
                    onClick: () => {
                      this.selectedFilter = filter;
                    }
                  })
                })
              }

              Blank()

              Row({ space: AppTokens.Spacing.sm }) {
                Text('Hide')
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(AppTokens.Colors.onSurface)

                CustomSwitch({
                  isOn: !this.showBalance,
                  onToggle: (value: boolean) => {
                    this.showBalance = !value;
                  }
                })
              }
            }
            .width('100%')

            // Accounts List
            ForEach(this.accounts, (account: AccountCardModel) => {
              AccountCardView({
                account: account,
                showBalance: this.showBalance
              })
            })

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
                  isSelected: this.incomeSelected,
                  onClick: () => {
                    this.incomeSelected = !this.incomeSelected;
                  }
                })

                AssistChip({
                  label: 'Expense',
                  isSelected: this.expenseSelected,
                  onClick: () => {
                    this.expenseSelected = !this.expenseSelected;
                  }
                })
              }
            }
            .width('100%')

            // Transactions List
            ForEach(this.transactions, (tx: TxItemModel) => {
              TransactionCard({ tx: tx })
            })

            // Bottom Padding
            Row()
              .width('100%')
              .height(100)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .layoutWeight(1)
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

            Button('Add Money') {
              // Add Money action
            }
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .width(140)
            .height(44)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: 6,
          color: 'rgba(0, 0, 0, 0.16)',
          offsetX: 0,
          offsetY: -1.5
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}