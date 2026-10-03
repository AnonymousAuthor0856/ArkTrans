// MARK: - App Tokens & Colors
namespace AppTokens {
  export namespace Colors {
    export const primary = '#1F2937';
    export const secondary = '#10B981';
    export const tertiary = '#3B82F6';
    export const background = '#F3F4F6';
    export const surface = '#FFFFFF';
    export const surfaceVariant = '#E5E7EB';
    export const outline = '#D1D5DB';
    export const success = '#16A34A';
    export const warning = '#F59E0B';
    export const error = '#EF4444';
    export const onPrimary = '#FFFFFF';
    export const onSecondary = '#0B1220';
    export const onSurface = '#0B1220';
  }

  export namespace Spacing {
    export const xs = 2;
    export const sm = 4;
    export const md = 6;
    export const lg = 8;
    export const xl = 12;
    export const xxl = 16;
    export const xxxl = 24;
  }

  export namespace Shapes {
    export const small = 6;
    export const medium = 8;
    export const large = 12;
  }
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

// MARK: - Filter Chip Component
@Component
struct FilterChip {
  label: string = '';
  isSelected: boolean = false;
  onChipClick: () => void = () => {};

  build() {
    Text(this.label)
      .fontSize(this.isSelected ? 14 : 12)
      .fontWeight(this.isSelected ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.medium)
      .border({
        width: this.isSelected ? 0 : 1,
        color: AppTokens.Colors.outline
      })
      .onClick(() => this.onChipClick())
  }
}

// MARK: - Assist Chip Component
@Component
struct AssistChip {
  label: string = '';
  isSelected: boolean = false;
  onChipClick: () => void = () => {};

  build() {
    Text(this.label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .onClick(() => this.onChipClick())
  }
}

// MARK: - Account Card Component
@Component
struct AccountCardView {
  account: AccountCardModel = { id: 0, name: '', balance: '', accent: '' };
  showBalance: boolean = true;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Header
      Row() {
        Row({ space: AppTokens.Spacing.sm }) {
          Column()
            .width(16)
            .height(16)
            .backgroundColor(this.account.accent)
            .borderRadius(AppTokens.Shapes.small)

          Text(this.account.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
        }

        Blank()

        Text('Manage')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Balance Box
      Stack() {
        Text(this.showBalance ? this.account.balance : '•••••••')
          .fontSize(18)
          .fontWeight(600)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(80)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
      .alignContent(Alignment.Center)

      // Actions
      Row({ space: AppTokens.Spacing.sm }) {
        Text('Transfer')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })

        Text('Details')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .constraintSize({ minHeight: 120 })
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({
      radius: 4,
      color: '#24000000',
      offsetX: 0,
      offsetY: 1
    })
  }
}

// MARK: - Transaction Card Component
@Component
struct TransactionCard {
  tx: TxItemModel = { id: 0, title: '', subtitle: '', amount: '', positive: false };

  build() {
    Row() {
      Row({ space: AppTokens.Spacing.md }) {
        Column()
          .width(32)
          .height(32)
          .backgroundColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
          .borderRadius(AppTokens.Shapes.small)

        Column({ space: AppTokens.Spacing.xs }) {
          Text(this.tx.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Text(this.tx.subtitle)
            .fontSize(12)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Blank()

      Text(this.tx.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(AppTokens.Spacing.lg)
    .constraintSize({ minHeight: 72 })
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({
      radius: 2,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 1
    })
  }
}

// MARK: - Custom Toggle Component
@Component
struct CustomToggle {
  @Prop isOn: boolean = false;
  onToggle: (val: boolean) => void = () => {};

  build() {
    Stack() {
      // Track
      Column()
        .width(36)
        .height(20)
        .borderRadius(16)
        .backgroundColor(this.isOn ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
        .border({ width: this.isOn ? 0 : 1, color: AppTokens.Colors.outline })

      // Thumb
      Column()
        .width(16)
        .height(16)
        .borderRadius(8)
        .backgroundColor(this.isOn ? AppTokens.Colors.onPrimary : AppTokens.Colors.outline)
        .offset({ x: this.isOn ? 8 : -8, y: 0 })
    }
    .width(36)
    .height(20)
    .alignContent(Alignment.Center)
    .onClick(() => {
      this.onToggle(!this.isOn);
    })
    .animation({
      duration: 200,
      curve: Curve.EaseInOut
    })
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

  filters: string[] = ['All', 'Week', 'Month', 'Year'];

  accounts: AccountCardModel[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: '#10B981' },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: '#3B82F6' },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: '#F59E0B' }
  ];

  transactions: TxItemModel[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background + Main Content
      Column() {
        // Top Bar
        Row({ space: AppTokens.Spacing.sm }) {
          Column()
            .width(20)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)

          Text('Wallet')
            .fontSize(24)
            .fontWeight(600)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()
        }
        .width('100%')
        .padding(16)
        .backgroundColor(AppTokens.Colors.background)
        .alignItems(VerticalAlign.Center)

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
                    onChipClick: () => {
                      this.selectedFilter = filter;
                    }
                  })
                })
              }

              Blank()

              Row({ space: AppTokens.Spacing.sm }) {
                Text('Hide')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)

                CustomToggle({
                  isOn: !this.showBalance,
                  onToggle: (val: boolean) => {
                    this.showBalance = !val;
                  }
                })
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

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
                .fontWeight(600)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              Row({ space: AppTokens.Spacing.sm }) {
                AssistChip({
                  label: 'Income',
                  isSelected: this.incomeSelected,
                  onChipClick: () => {
                    this.incomeSelected = !this.incomeSelected;
                  }
                })
                AssistChip({
                  label: 'Expense',
                  isSelected: this.expenseSelected,
                  onChipClick: () => {
                    this.expenseSelected = !this.expenseSelected;
                  }
                })
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            // Transactions List
            ForEach(this.transactions, (tx: TxItemModel) => {
              TransactionCard({ tx: tx })
            })

            // Bottom padding for bottom bar
            Column()
              .height(100)
          }
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.md,
            bottom: AppTokens.Spacing.md
          })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // Bottom Bar Overlay
      Column() {
        Row() {
          Column({ space: AppTokens.Spacing.xs }) {
            Text('Total Balance')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)

            Text(this.showBalance ? '$26,395.75' : '•••••••')
              .fontSize(18)
              .fontWeight(600)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Text('Add Money')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
            .width(140)
            .height(44)
            .textAlign(TextAlign.Center)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: 6,
        color: '#29000000',
        offsetX: 0,
        offsetY: -2
      })
    }
    .width('100%')
    .height('100%')
  }
}