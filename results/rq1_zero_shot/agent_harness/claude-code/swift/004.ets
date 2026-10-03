// Finance Wallet App - ArkTS Conversion
// Converted from SwiftUI FinanceWalletApp

// MARK: - App Tokens & Colors
class AppTokens {
  static class Colors {
    static readonly primary: Color = 0xFF1F2937
    static readonly secondary: Color = 0xFF10B981
    static readonly tertiary: Color = 0xFF3B82F6
    static readonly background: Color = 0xFFF3F4F6
    static readonly surface: Color = 0xFFFFFFFF
    static readonly surfaceVariant: Color = 0xFFE5E7EB
    static readonly outline: Color = 0xFFD1D5DB
    static readonly success: Color = 0xFF16A34A
    static readonly warning: Color = 0xFFF59E0B
    static readonly error: Color = 0xFFEF4444
    static readonly onPrimary: Color = 0xFFFFFFFF
    static readonly onSecondary: Color = 0xFF0B1220
    static readonly onSurface: Color = 0xFF0B1220
  }

  static class Spacing {
    static readonly xs: number = 2
    static readonly sm: number = 4
    static readonly md: number = 6
    static readonly lg: number = 8
    static readonly xl: number = 12
    static readonly xxl: number = 16
    static readonly xxxl: number = 24
  }

  static class Shapes {
    static readonly small: number = 6
    static readonly medium: number = 8
    static readonly large: number = 12
  }
}

// MARK: - Models
interface AccountCardModel {
  id: number
  name: string
  balance: string
  accent: Color
}

interface TxItemModel {
  id: number
  title: string
  subtitle: string
  amount: string
  positive: boolean
}

// MARK: - Filter Chip Component
@Component
struct FilterChip {
  label: string = ''
  isSelected: boolean = false
  onClick: () => void = () => {}

  build() {
    Button(this.label)
      .fontSize(this.isSelected ? 14 : 12)
      .fontWeight(this.isSelected ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.medium)
      .border({
        width: this.isSelected ? 0 : 1,
        color: AppTokens.Colors.outline
      })
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .height(32)
      .onClick(() => this.onClick())
  }
}

// MARK: - Assist Chip Component
@Component
struct AssistChip {
  label: string = ''
  isSelected: boolean = false
  onClick: () => void = () => {}

  build() {
    Button(this.label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .height(24)
      .onClick(() => this.onClick())
  }
}

// MARK: - Account Card Component
@Component
struct AccountCardView {
  account: AccountCardModel = { id: 0, name: '', balance: '', accent: Color.White }
  showBalance: boolean = true

  build() {
    Column() {
      // Header
      Row() {
        Row() {
          Rect()
            .fill(this.account.accent)
            .width(16)
            .height(16)
            .borderRadius(AppTokens.Shapes.small)
          Text(this.account.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
        }

        Blank()

        Button('Manage')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .height(22)
          .onClick(() => {})
      }
      .width('100%')

      // Balance Box
      Stack() {
        Rect()
          .fill(AppTokens.Colors.surfaceVariant)
          .width('100%')
          .aspectRatio(2.8)
          .borderRadius(AppTokens.Shapes.medium)
        Text(this.showBalance ? this.account.balance : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.sm })

      // Actions
      Row() {
        Button('Transfer')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .height(24)
          .onClick(() => {})

        Button('Details')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .height(24)
          .margin({ left: AppTokens.Spacing.sm })
          .onClick(() => {})
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.14)',
      offsetY: 1
    })
  }
}

// MARK: - Transaction Card Component
@Component
struct TransactionCard {
  tx: TxItemModel = { id: 0, title: '', subtitle: '', amount: '', positive: false }

  build() {
    Row() {
      Row() {
        Rect()
          .fill(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
          .width(32)
          .height(32)
          .borderRadius(AppTokens.Shapes.small)
        Column() {
          Text(this.tx.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Text(this.tx.subtitle)
            .fontSize(12)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: AppTokens.Spacing.md })
      }

      Blank()

      Text(this.tx.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .height(72)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({
      radius: 2,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetY: 0.5
    })
  }
}

// MARK: - Custom Toggle Component
@Component
struct CustomToggle {
  isOn: boolean = false
  onChange: (value: boolean) => void = () => {}

  build() {
    Stack() {
      // Track
      Rect()
        .fill(this.isOn ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
        .width(36)
        .height(20)
        .borderRadius(16)
        .border({
          width: this.isOn ? 0 : 1,
          color: AppTokens.Colors.outline
        })
      // Thumb
      Circle()
        .fill(this.isOn ? AppTokens.Colors.onPrimary : AppTokens.Colors.outline)
        .width(16)
        .height(16)
        .translate({ x: this.isOn ? 8 : -8 })
        .animation({
          duration: 200,
          curve: Curve.EaseInOut
        })
    }
    .width(36)
    .height(20)
    .onClick(() => {
      this.onChange(!this.isOn)
    })
  }
}

// MARK: - Main Content View
@Entry
@Component
struct FinanceWalletApp {
  @State showBalance: boolean = true
  @State selectedFilter: string = 'Month'
  @State incomeSelected: boolean = false
  @State expenseSelected: boolean = false

  private filters: string[] = ['All', 'Week', 'Month', 'Year']

  private accounts: AccountCardModel[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: 0xFF10B981 },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: 0xFF3B82F6 },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: 0xFFF59E0B }
  ]

  private transactions: TxItemModel[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ]

  build() {
    Stack() {
      // Background
      Rect()
        .fill(AppTokens.Colors.background)
        .width('100%')
        .height('100%')

      Column() {
        // Top Bar
        Row() {
          Rect()
            .fill(AppTokens.Colors.primary)
            .width(20)
            .height(20)
            .borderRadius(AppTokens.Shapes.small)
          Text('Wallet')
            .fontSize(24)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ left: AppTokens.Spacing.sm })
          Blank()
        }
        .width('100%')
        .padding(AppTokens.Spacing.xxl)
        .backgroundColor(AppTokens.Colors.background)

        // Scrollable Content
        Scroll() {
          Column() {
            // Filters Row
            Row() {
              Row() {
                ForEach(this.filters, (filter: string) => {
                  FilterChip({
                    label: filter,
                    isSelected: this.selectedFilter === filter,
                    onClick: () => { this.selectedFilter = filter }
                  })
                }, (filter: string) => filter)
              }

              Blank()

              Row() {
                Text('Hide')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ right: AppTokens.Spacing.sm })
                CustomToggle({
                  isOn: !this.showBalance,
                  onChange: (value: boolean) => { this.showBalance = !value }
                })
              }
            }
            .width('100%')
            .margin({ bottom: AppTokens.Spacing.lg })

            // Accounts List
            ForEach(this.accounts, (account: AccountCardModel) => {
              AccountCardView({
                account: account,
                showBalance: this.showBalance
              })
              .margin({ bottom: AppTokens.Spacing.lg })
            }, (account: AccountCardModel) => account.id.toString())

            // Recent Activity Header
            Row() {
              Text('Recent Activity')
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              Row() {
                AssistChip({
                  label: 'Income',
                  isSelected: this.incomeSelected,
                  onClick: () => { this.incomeSelected = !this.incomeSelected }
                })
                AssistChip({
                  label: 'Expense',
                  isSelected: this.expenseSelected,
                  onClick: () => { this.expenseSelected = !this.expenseSelected }
                })
                .margin({ left: AppTokens.Spacing.sm })
              }
            }
            .width('100%')
            .margin({ bottom: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })

            // Transactions List
            ForEach(this.transactions, (tx: TxItemModel) => {
              TransactionCard({ tx: tx })
                .margin({ bottom: AppTokens.Spacing.lg })
            }, (tx: TxItemModel) => tx.id.toString())

            // Bottom Padding for Bottom Bar
            Blank()
              .height(100)
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.md,
            bottom: AppTokens.Spacing.md
          })
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // Bottom Bar Overlay
      Column() {
        Blank()

        Column() {
          Row() {
            Column() {
              Text('Total Balance')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
              Text(this.showBalance ? '$26,395.75' : '•••••••')
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ top: AppTokens.Spacing.xs })
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button('Add Money')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.large)
              .width(140)
              .height(44)
              .onClick(() => {})
          }
          .width('100%')
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
          color: 'rgba(0, 0, 0, 0.16)',
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
