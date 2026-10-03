// MARK: - App Tokens & Colors
class AppTokens {
  static Colors = {
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
interface AccountCardModel {
  id: number
  name: string
  balance: string
  accent: string
}

interface TxItemModel {
  id: number
  title: string
  subtitle: string
  amount: string
  positive: boolean
}

// MARK: - FilterChip Component
@Component
struct FilterChip {
  label: string = ''
  isSelected: boolean = false
  onClick: () => void = () => {}

  build() {
    Text(this.label)
      .fontSize(this.isSelected ? 14 : 12)
      .fontWeight(this.isSelected ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.medium)
      .border({
        width: this.isSelected ? 0 : 1,
        color: AppTokens.Colors.outline,
        radius: AppTokens.Shapes.medium
      })
      .onClick(() => {
        this.onClick()
      })
  }
}

// MARK: - AssistChip Component
@Component
struct AssistChip {
  label: string = ''
  isSelected: boolean = false
  onClick: () => void = () => {}

  build() {
    Text(this.label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({
        width: 1,
        color: AppTokens.Colors.outline,
        radius: AppTokens.Shapes.small
      })
      .onClick(() => {
        this.onClick()
      })
  }
}

// MARK: - Custom Toggle Component
@Component
struct CustomToggle {
  @Link isOn: boolean

  build() {
    Stack() {
      RoundedRect({ width: 36, height: 20, radius: 16 })
        .fill(this.isOn ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
        .stroke({
          color: AppTokens.Colors.outline,
          width: this.isOn ? 0 : 1
        })

      Circle()
        .width(16)
        .height(16)
        .fill(this.isOn ? AppTokens.Colors.onPrimary : AppTokens.Colors.outline)
        .translate({ x: this.isOn ? 8 : -8, y: 0 })
        .animation({ duration: 200, curve: Curve.EaseInOut })
    }
    .width(36)
    .height(20)
    .onClick(() => {
      this.isOn = !this.isOn
    })
  }
}

// MARK: - AccountCardView Component
@Component
struct AccountCardView {
  account: AccountCardModel
  showBalance: boolean = true

  build() {
    Column() {
      Row() {
        Row() {
          RoundedRect({ width: 16, height: 16, radius: AppTokens.Shapes.small })
            .fill(this.account.accent)

          Text(this.account.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ left: AppTokens.Spacing.sm })
        }

        Spacer()

        Text('Manage')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
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
      .margin({ bottom: AppTokens.Spacing.sm })

      Stack() {
        RoundedRect({ width: '100%', height: '100%', radius: AppTokens.Shapes.medium })
          .fill(AppTokens.Colors.surfaceVariant)

        Text(this.showBalance ? this.account.balance : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .aspectRatio(2.8)

      Row() {
        Text('Transfer')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .border({
            width: 1,
            color: AppTokens.Colors.outline,
            radius: AppTokens.Shapes.small
          })

        Text('Details')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)
          .border({
            width: 1,
            color: AppTokens.Colors.outline,
            radius: AppTokens.Shapes.small
          })
          .margin({ left: AppTokens.Spacing.sm })
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.large
    })
    .shadow({
      radius: 4,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 1
    })
  }
}

// MARK: - TransactionCard Component
@Component
struct TransactionCard {
  tx: TxItemModel

  build() {
    Row() {
      Row() {
        RoundedRect({ width: 32, height: 32, radius: AppTokens.Shapes.small })
          .fill(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)

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

      Spacer()

      Text(this.tx.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.large
    })
    .shadow({
      radius: 2,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 0.5
    })
  }
}

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  @State showBalance: boolean = true
  @State selectedFilter: string = 'Month'
  @State flags: Set<string> = new Set()

  private filters: string[] = ['All', 'Week', 'Month', 'Year']
  private accounts: AccountCardModel[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: '#10B981' },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: '#3B82F6' },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: '#F59E0B' }
  ]
  private transactions: TxItemModel[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ]

  @Builder
  FilterChipBuilder(filter: string) {
    FilterChip({
      label: filter,
      isSelected: this.selectedFilter === filter,
      onClick: () => {
        this.selectedFilter = filter
      }
    })
  }

  @Builder
  AccountCardBuilder(account: AccountCardModel) {
    AccountCardView({
      account: account,
      showBalance: this.showBalance
    })
  }

  @Builder
  TransactionCardBuilder(tx: TxItemModel) {
    TransactionCard({
      tx: tx
    })
  }

  toggleFlag(flag: string) {
    if (this.flags.has(flag)) {
      this.flags.delete(flag)
    } else {
      this.flags.add(flag)
    }
    this.flags = new Set(this.flags)
  }

  build() {
    Stack() {
      Column() {
        Row() {
          RoundedRect({ width: 20, height: 20, radius: AppTokens.Shapes.small })
            .fill(AppTokens.Colors.primary)

          Text('Wallet')
            .fontSize(24)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ left: AppTokens.Spacing.sm })

          Spacer()
        }
        .width('100%')
        .padding(AppTokens.Spacing.xxl)
        .backgroundColor(AppTokens.Colors.background)

        Scroll() {
          Column() {
            Row() {
              Row() {
                ForEach(this.filters, (filter: string) => {
                  this.FilterChipBuilder(filter)
                }, (filter: string) => filter)
              }

              Spacer()

              Row() {
                Text('Hide')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ right: AppTokens.Spacing.sm })

                CustomToggle({ isOn: $showBalance })
              }
            }
            .width('100%')

            ForEach(this.accounts, (account: AccountCardModel) => {
              this.AccountCardBuilder(account)
            }, (account: AccountCardModel) => account.id.toString())

            Row() {
              Text('Recent Activity')
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppTokens.Colors.onSurface)

              Spacer()

              Row() {
                AssistChip({
                  label: 'Income',
                  isSelected: this.flags.has('Income'),
                  onClick: () => {
                    this.toggleFlag('Income')
                  }
                })

                AssistChip({
                  label: 'Expense',
                  isSelected: this.flags.has('Expense'),
                  onClick: () => {
                    this.toggleFlag('Expense')
                  }
                })
                  .margin({ left: AppTokens.Spacing.sm })
              }
            }
            .width('100%')

            ForEach(this.transactions, (tx: TxItemModel) => {
              this.TransactionCardBuilder(tx)
            }, (tx: TxItemModel) => tx.id.toString())

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
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      Column() {
        Spacer()

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

          Spacer()

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
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: 6,
          color: '#29000000',
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
