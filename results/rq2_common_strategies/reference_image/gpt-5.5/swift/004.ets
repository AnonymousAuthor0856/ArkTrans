class AppColors {
  static readonly primary: string = '#1F2937'
  static readonly secondary: string = '#10B981'
  static readonly tertiary: string = '#3B82F6'
  static readonly background: string = '#F3F4F6'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E5E7EB'
  static readonly outline: string = '#D1D5DB'
  static readonly success: string = '#16A34A'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#0B1220'
  static readonly onSurface: string = '#0B1220'
}

class AppTypography {
  static readonly display: number = 24
  static readonly headline: number = 18
  static readonly title: number = 14
  static readonly body: number = 12
  static readonly label: number = 10
}

class AppSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 4
  static readonly md: number = 6
  static readonly lg: number = 8
  static readonly xl: number = 12
  static readonly xxl: number = 16
  static readonly xxxl: number = 24
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 8
  static readonly large: number = 12
}

class AccountCardModel {
  id: number
  name: string
  balance: string
  accent: string

  constructor(id: number, name: string, balance: string, accent: string) {
    this.id = id
    this.name = name
    this.balance = balance
    this.accent = accent
  }
}

class TxItemModel {
  id: number
  title: string
  subtitle: string
  amount: string
  positive: boolean

  constructor(id: number, title: string, subtitle: string, amount: string, positive: boolean) {
    this.id = id
    this.title = title
    this.subtitle = subtitle
    this.amount = amount
    this.positive = positive
  }
}

@Entry
@Component
struct ContentView {
  @State private showBalance: boolean = true
  @State private selectedFilter: string = 'Month'
  @State private incomeSelected: boolean = false
  @State private expenseSelected: boolean = false

  private filters: string[] = ['All', 'Week', 'Month', 'Year']

  private accounts: AccountCardModel[] = [
    new AccountCardModel(1, 'Wallet', '$2,845.20', AppColors.secondary),
    new AccountCardModel(2, 'Savings', '$8,120.00', AppColors.tertiary),
    new AccountCardModel(3, 'Investments', '$15,430.55', AppColors.warning)
  ]

  private transactions: TxItemModel[] = [
    new TxItemModel(1, 'Grocery Market', 'Today • 12:40', '-$32.18', false),
    new TxItemModel(2, 'Salary', 'Yesterday • 09:00', '+$3,200.00', true),
    new TxItemModel(3, 'Coffee Shop', 'Yesterday • 15:22', '-$4.90', false),
    new TxItemModel(4, 'ETF Purchase', 'Mon • 10:05', '-$250.00', false),
    new TxItemModel(5, 'Refund', 'Sun • 18:40', '+$18.99', true)
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row({ space: AppSpacing.sm }) {
          Row()
            .width(20)
            .height(20)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.small)

          Text('Wallet')
            .fontSize(AppTypography.display)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onSurface)

          Blank()
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 40, bottom: 24 })
        .backgroundColor(AppColors.background)

        Scroll() {
          Column({ space: AppSpacing.lg }) {
            Row() {
              Row({ space: AppSpacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  FilterChip({
                    label: filter,
                    isSelected: this.selectedFilter === filter,
                    onClick: () => {
                      this.selectedFilter = filter
                    }
                  })
                }, (filter: string) => filter)
              }

              Blank()

              Row({ space: AppSpacing.sm }) {
                Text('Hide')
                  .fontSize(AppTypography.label)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)

                CustomSwitch({
                  isOn: !this.showBalance,
                  onToggle: () => {
                    this.showBalance = !this.showBalance
                  }
                })
              }
            }
            .width('100%')

            ForEach(this.accounts, (account: AccountCardModel) => {
              AccountCardView({
                account: account,
                showBalance: this.showBalance
              })
            }, (account: AccountCardModel) => account.id.toString())

            Row() {
              Text('Recent Activity')
                .fontSize(AppTypography.headline)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppColors.onSurface)

              Blank()

              Row({ space: AppSpacing.sm }) {
                AssistChip({
                  label: 'Income',
                  isSelected: this.incomeSelected,
                  onClick: () => {
                    this.incomeSelected = !this.incomeSelected
                  }
                })

                AssistChip({
                  label: 'Expense',
                  isSelected: this.expenseSelected,
                  onClick: () => {
                    this.expenseSelected = !this.expenseSelected
                  }
                })
              }
            }
            .width('100%')

            ForEach(this.transactions, (tx: TxItemModel) => {
              TransactionCard({ tx: tx })
            }, (tx: TxItemModel) => tx.id.toString())

            Row()
              .width('100%')
              .height(100)
          }
          .width('100%')
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Column() {
        Row() {
          Column({ space: AppSpacing.xs }) {
            Text('Total Balance')
              .fontSize(AppTypography.title)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)

            Text(this.showBalance ? '$26,395.75' : '•••••••')
              .fontSize(AppTypography.headline)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Row() {
            Text('Add Money')
              .fontSize(AppTypography.title)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
          }
          .width(140)
          .height(44)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppShapes.large)
          .onClick(() => {
          })
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      }
      .width('100%')
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: -1.5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Component
struct FilterChip {
  label: string = ''
  isSelected: boolean = false
  onClick: () => void = () => {
  }

  build() {
    Row() {
      Text(this.label)
        .fontSize(this.isSelected ? AppTypography.title : AppTypography.body)
        .fontWeight(this.isSelected ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
    }
    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
    .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({
      width: this.isSelected ? 0 : 1,
      color: AppColors.outline
    })
    .onClick(() => {
      this.onClick()
    })
  }
}

@Component
struct AssistChip {
  label: string = ''
  isSelected: boolean = false
  onClick: () => void = () => {
  }

  build() {
    Row() {
      Text(this.label)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? AppColors.onSecondary : AppColors.onSurface)
    }
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .backgroundColor(this.isSelected ? AppColors.secondary : AppColors.surface)
    .borderRadius(AppShapes.small)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .onClick(() => {
      this.onClick()
    })
  }
}

@Component
struct AccountCardView {
  account: AccountCardModel = new AccountCardModel(0, '', '', AppColors.secondary)
  showBalance: boolean = true

  build() {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Row({ space: AppSpacing.sm }) {
          Row()
            .width(16)
            .height(16)
            .backgroundColor(this.account.accent)
            .borderRadius(AppShapes.small)

          Text(this.account.name)
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }

        Blank()

        Row() {
          Text('Manage')
            .fontSize(AppTypography.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
        }
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.small)
        .border({
          width: 1,
          color: AppColors.outline
        })
        .onClick(() => {
        })
      }
      .width('100%')

      Stack({ alignContent: Alignment.Center }) {
        Text(this.showBalance ? this.account.balance : '•••••••')
          .fontSize(AppTypography.headline)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)

      Row({ space: AppSpacing.sm }) {
        Row() {
          Text('Transfer')
            .fontSize(AppTypography.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
        }
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.small)
        .border({
          width: 1,
          color: AppColors.outline
        })
        .onClick(() => {
        })

        Row() {
          Text('Details')
            .fontSize(AppTypography.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.small)
        .border({
          width: 1,
          color: AppColors.outline
        })
        .onClick(() => {
        })

        Blank()
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.lg)
    .constraintSize({ minHeight: 120 })
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
  }
}

@Component
struct TransactionCard {
  tx: TxItemModel = new TxItemModel(0, '', '', '', false)

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
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text(this.tx.subtitle)
            .fontSize(AppTypography.body)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank()

      Text(this.tx.amount)
        .fontSize(AppTypography.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.tx.positive ? AppColors.success : AppColors.error)
    }
    .width('100%')
    .constraintSize({ minHeight: 72 })
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .shadow({ radius: 2, color: '#1F000000', offsetX: 0, offsetY: 0.5 })
  }
}

@Component
struct CustomSwitch {
  isOn: boolean = false
  onToggle: () => void = () => {
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Row()
        .width(36)
        .height(20)
        .backgroundColor(this.isOn ? AppColors.primary : AppColors.surfaceVariant)
        .borderRadius(16)
        .border({
          width: this.isOn ? 0 : 1,
          color: AppColors.outline
        })

      Circle()
        .width(16)
        .height(16)
        .fill(this.isOn ? AppColors.onPrimary : AppColors.outline)
        .offset({ x: this.isOn ? 8 : -8, y: 0 })
    }
    .width(44)
    .height(24)
    .onClick(() => {
      this.onToggle()
    })
  }
}