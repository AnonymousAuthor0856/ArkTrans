// ============================================================================
//  WalletPage.ets  —  ArkTS (HarmonyOS ArkUI, Stage model, API 11+)
//  Direct port of the SwiftUI FinanceWalletApp screen.
// ============================================================================

// ----------------------------------------------------------------------------
// MARK: - Design Tokens
// ----------------------------------------------------------------------------
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

  // Elevation shadows (#AARRGGBB — black at 12% / 14% / 16%)
  static readonly shadowL1: string = '#1F000000';
  static readonly shadowL2: string = '#24000000';
  static readonly shadowL3: string = '#29000000';
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

class AppType {
  static readonly displaySize: number = 24;
  static readonly headlineSize: number = 18;
  static readonly titleSize: number = 14;
  static readonly bodySize: number = 12;
  static readonly labelSize: number = 10;
}

// ----------------------------------------------------------------------------
// MARK: - Models
// ----------------------------------------------------------------------------
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

// ----------------------------------------------------------------------------
// MARK: - Components
// ----------------------------------------------------------------------------

@Component
struct FilterChip {
  @Prop label: string = '';
  @Prop isSelected: boolean = false;
  onChipClick: () => void = () => {};

  build() {
    Text(this.label)
      .fontSize(this.isSelected ? AppType.titleSize : AppType.bodySize)
      .fontWeight(this.isSelected ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
      .textAlign(TextAlign.Center)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
      .border({
        width: this.isSelected ? 0 : 1,
        color: AppColors.outline,
        radius: AppShapes.medium
      })
      .borderRadius(AppShapes.medium)
      .onClick(() => {
        this.onChipClick();
      })
  }
}

@Component
struct AssistChip {
  @Prop label: string = '';
  @Prop isSelected: boolean = false;
  onChipClick: () => void = () => {};

  build() {
    Text(this.label)
      .fontSize(AppType.labelSize)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? AppColors.onSecondary : AppColors.onSurface)
      .textAlign(TextAlign.Center)
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor(this.isSelected ? AppColors.secondary : AppColors.surface)
      .border({ width: 1, color: AppColors.outline, radius: AppShapes.small })
      .borderRadius(AppShapes.small)
      .onClick(() => {
        this.onChipClick();
      })
  }
}

@Component
struct CustomSwitch {
  @Prop isOn: boolean = false;
  onToggle: () => void = () => {};

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Row()
        .width(36)
        .height(20)
        .backgroundColor(this.isOn ? AppColors.primary : AppColors.surfaceVariant)
        .border({
          width: this.isOn ? 0 : 1,
          color: AppColors.outline,
          radius: 16
        })
        .borderRadius(16)
        .animation({ duration: 200, curve: Curve.EaseInOut })

      // Thumb
      Row()
        .width(16)
        .height(16)
        .backgroundColor(this.isOn ? AppColors.onPrimary : AppColors.outline)
        .borderRadius(8)
        .margin({ left: this.isOn ? 18 : 2 })
        .animation({ duration: 200, curve: Curve.EaseInOut })
    }
    .width(36)
    .height(20)
    .onClick(() => {
      this.onToggle();
    })
  }
}

@Component
struct AccountCard {
  account: AccountCardModel = new AccountCardModel(0, '', '', AppColors.surfaceVariant);
  @Prop showBalance: boolean = true;

  build() {
    Column({ space: AppSpacing.lg }) {
      // ---- Header ------------------------------------------------------
      Row() {
        Row({ space: AppSpacing.sm }) {
          Row()
            .width(16)
            .height(16)
            .backgroundColor(this.account.accent)
            .borderRadius(AppShapes.small)

          Text(this.account.name)
            .fontSize(AppType.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }

        Text('Manage')
          .fontSize(AppType.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(AppColors.secondary)
          .border({ width: 1, color: AppColors.outline, radius: AppShapes.small })
          .borderRadius(AppShapes.small)
          .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // ---- Balance Box -------------------------------------------------
      Stack() {
        Text(this.showBalance ? this.account.balance : '•••••••')
          .fontSize(AppType.headlineSize)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)
      .alignContent(Alignment.Center)

      // ---- Actions -----------------------------------------------------
      Row({ space: AppSpacing.lg }) {
        Text('Transfer')
          .fontSize(AppType.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .backgroundColor(AppColors.secondary)
          .border({ width: 1, color: AppColors.outline, radius: AppShapes.small })
          .borderRadius(AppShapes.small)
          .onClick(() => {})

        Text('Details')
          .fontSize(AppType.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .backgroundColor(AppColors.surface)
          .border({ width: 1, color: AppColors.outline, radius: AppShapes.small })
          .borderRadius(AppShapes.small)
          .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.lg)
    .constraintSize({ minHeight: 120 })
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline, radius: AppShapes.large })
    .shadow({
      radius: 4,
      color: AppColors.shadowL2,
      offsetX: 0,
      offsetY: 1
    })
  }
}

@Component
struct TransactionCard {
  tx: TxItemModel = new TxItemModel(0, '', '', '', false);

  build() {
    Row() {
      Row({ space: AppSpacing.md }) {
        Row()
          .width(32)
          .height(32)
          .backgroundColor(this.tx.positive ? AppColors.success : AppColors.error)
          .borderRadius(AppShapes.small)

        Column({ space: AppSpacing.xs }) {
          Text(this.tx.title)
            .fontSize(AppType.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text(this.tx.subtitle)
            .fontSize(AppType.bodySize)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }

      Text(this.tx.amount)
        .fontSize(AppType.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.tx.positive ? AppColors.success : AppColors.error)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(AppSpacing.lg)
    .constraintSize({ minHeight: 72 })
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline, radius: AppShapes.large })
    .shadow({
      radius: 2,
      color: AppColors.shadowL1,
      offsetX: 0,
      offsetY: 0.5
    })
  }
}

// ----------------------------------------------------------------------------
// MARK: - Root Page
// ----------------------------------------------------------------------------
@Entry
@Component
struct WalletPage {
  @State showBalance: boolean = true;
  @State selectedFilter: string = 'Month';
  @State incomeFlag: boolean = false;
  @State expenseFlag: boolean = false;

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
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // ---- Top Bar ---------------------------------------------------
        Row({ space: AppSpacing.sm }) {
          Row()
            .width(20)
            .height(20)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.small)

          Text('Wallet')
            .fontSize(AppType.displaySize)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding(AppSpacing.xxl)
        .backgroundColor(AppColors.background)

        // ---- Scrollable Content ---------------------------------------
        Scroll() {
          Column({ space: AppSpacing.lg }) {

            // Filters row
            Row() {
              Row({ space: AppSpacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  FilterChip({
                    label: filter,
                    isSelected: this.selectedFilter === filter,
                    onChipClick: () => {
                      this.selectedFilter = filter;
                    }
                  })
                }, (filter: string) => filter)
              }

              Row({ space: AppSpacing.sm }) {
                Text('Hide')
                  .fontSize(AppType.labelSize)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)

                CustomSwitch({
                  isOn: !this.showBalance,
                  onToggle: () => {
                    this.showBalance = !this.showBalance;
                  }
                })
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            // Accounts
            ForEach(this.accounts, (account: AccountCardModel) => {
              AccountCard({ account: account, showBalance: this.showBalance })
            }, (account: AccountCardModel) => account.id.toString())

            // Recent Activity header
            Row() {
              Text('Recent Activity')
                .fontSize(AppType.headlineSize)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppColors.onSurface)

              Row({ space: AppSpacing.sm }) {
                AssistChip({
                  label: 'Income',
                  isSelected: this.incomeFlag,
                  onChipClick: () => {
                    this.incomeFlag = !this.incomeFlag;
                  }
                })

                AssistChip({
                  label: 'Expense',
                  isSelected: this.expenseFlag,
                  onChipClick: () => {
                    this.expenseFlag = !this.expenseFlag;
                  }
                })
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            // Transactions
            ForEach(this.transactions, (tx: TxItemModel) => {
              TransactionCard({ tx: tx })
            }, (tx: TxItemModel) => tx.id.toString())

            // Bottom padding so content clears the sticky bar
            Row().width('100%').height(100)
          }
          .width('100%')
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.md,
            bottom: AppSpacing.md
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      }
      .width('100%')
      .height('100%')

      // ---- Sticky Bottom Bar ------------------------------------------
      Row() {
        Column({ space: AppSpacing.xs }) {
          Text('Total Balance')
            .fontSize(AppType.bodySize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text(this.showBalance ? '$26,395.75' : '•••••••')
            .fontSize(AppType.headlineSize)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Add Money', { type: ButtonType.Normal, stateEffect: true })
          .fontSize(AppType.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppShapes.large)
          .width(140)
          .height(44)
          .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: 6,
        color: AppColors.shadowL3,
        offsetX: 0,
        offsetY: -1.5
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}