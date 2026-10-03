import { router } from '@kit.ArkUI';

// MARK: - App Tokens & Colors
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

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 8;
  static readonly large: number = 12;
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

// MARK: - Filter Chip Component
@Component
struct FilterChip {
  label: string = '';
  isSelected: boolean = false;
  onClick: () => void = () => {};

  build() {
    Button() {
      Text(this.label)
        .fontSize(this.isSelected ? 14 : 12)
        .fontWeight(this.isSelected ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
    }
    .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({
      width: this.isSelected ? 0 : 1,
      color: AppColors.outline
    })
    .onClick(() => {
      this.onClick();
    })
  }
}

// MARK: - Assist Chip Component
@Component
struct AssistChip {
  label: string = '';
  isSelected: boolean = false;
  onClick: () => void = () => {};

  build() {
    Button() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? AppColors.onSecondary : AppColors.onSurface)
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    }
    .backgroundColor(this.isSelected ? AppColors.secondary : AppColors.surface)
    .borderRadius(AppShapes.small)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.onClick();
    })
  }
}

// MARK: - Account Card Component
@Component
struct AccountCardView {
  account: AccountCardModel = new AccountCardModel(0, '', '', '');
  showBalance: boolean = true;

  build() {
    Column({ space: AppSpacing.sm }) {
      // Header
      Row() {
        Row({ space: AppSpacing.sm }) {
          Column()
            .width(16)
            .height(16)
            .borderRadius(AppShapes.small)
            .backgroundColor(this.account.accent)

          Text(this.account.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }

        Blank()

        Button() {
          Text('Manage')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        }
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.small)
        .border({ width: 1, color: AppColors.outline })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // Balance Box
      Stack() {
        Column()
          .width('100%')
          .aspectRatio(2.8)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.medium)

        Text(this.showBalance ? this.account.balance : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .aspectRatio(2.8)
      .borderRadius(AppShapes.medium)

      // Actions
      Row({ space: AppSpacing.sm }) {
        Button() {
          Text('Transfer')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        }
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.small)
        .border({ width: 1, color: AppColors.outline })

        Button() {
          Text('Details')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        }
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.small)
        .border({ width: 1, color: AppColors.outline })
      }
      .width('100%')
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .constraintSize({ minHeight: 120 })
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - Transaction Card Component
@Component
struct TransactionCard {
  tx: TxItemModel = new TxItemModel(0, '', '', '', false);

  build() {
    Row() {
      Row({ space: AppSpacing.md }) {
        Column()
          .width(32)
          .height(32)
          .borderRadius(AppShapes.small)
          .backgroundColor(this.tx.positive ? AppColors.success : AppColors.error)

        Column({ space: AppSpacing.xs }) {
          Text(this.tx.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text(this.tx.subtitle)
            .fontSize(12)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank()

      Text(this.tx.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.tx.positive ? AppColors.success : AppColors.error)
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .constraintSize({ minHeight: 72 })
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 2, color: '#1F000000', offsetX: 0, offsetY: 1 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  @State showBalance: boolean = true;
  @State selectedFilter: string = 'Month';
  @State incomeSelected: boolean = false;
  @State expenseSelected: boolean = false;

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

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Row({ space: AppSpacing.sm }) {
          Column()
            .width(20)
            .height(20)
            .borderRadius(AppShapes.small)
            .backgroundColor(AppColors.primary)

          Text('Wallet')
            .fontSize(24)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onSurface)

          Blank()
        }
        .width('100%')
        .padding(16)
        .backgroundColor(AppColors.background)

        // Scrollable Content
        Scroll() {
          Column({ space: AppSpacing.lg }) {
            // Filters Row
            Row() {
              Row({ space: AppSpacing.sm }) {
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

              Row({ space: AppSpacing.sm }) {
                Text('Hide')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)

                Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                  .width(36)
                  .height(20)
                  .selectedColor(AppColors.primary)
                  .onChange((isOn: boolean) => {
                    this.showBalance = !isOn;
                  })
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

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
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppColors.onSurface)

              Blank()

              Row({ space: AppSpacing.sm }) {
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
            .justifyContent(FlexAlign.SpaceBetween)

            // Transactions List
            ForEach(this.transactions, (tx: TxItemModel) => {
              TransactionCard({ tx: tx })
            })

            // Bottom Padding
            Column()
              .height(100)
          }
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppColors.background)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      // Bottom Bar Overlay
      Column() {
        Row() {
          Column({ space: AppSpacing.xs }) {
            Text('Total Balance')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)

            Text(this.showBalance ? '$26,395.75' : '•••••••')
              .fontSize(18)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            Text('Add Money')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
          }
          .width(140)
          .height(44)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppShapes.large)
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}