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
struct FinanceWalletApp {
  @State private showBalance: boolean = true
  @State private selectedFilter: string = 'Month'
  @State private flags: string[] = []

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

  private hasFlag(flag: string): boolean {
    return this.flags.indexOf(flag) >= 0
  }

  private toggleFlag(flag: string): void {
    const index = this.flags.indexOf(flag)
    if (index >= 0) {
      this.flags = this.flags.filter((item: string) => item !== flag)
    } else {
      this.flags = [...this.flags, flag]
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Rect()
            .width(20)
            .height(20)
            .fill(AppColors.primary)
            .radius(AppShapes.small)

          Text('Wallet')
            .fontSize(24)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onSurface)
            .margin({ left: AppSpacing.sm })

          Blank()
        }
        .width('100%')
        .padding(16)
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
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)

                CustomSwitch({
                  isOn: !this.showBalance,
                  onChange: (value: boolean) => {
                    this.showBalance = !value
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
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppColors.onSurface)

              Blank()

              Row({ space: AppSpacing.sm }) {
                AssistChip({
                  label: 'Income',
                  isSelected: this.hasFlag('Income'),
                  onClick: () => {
                    this.toggleFlag('Income')
                  }
                })

                AssistChip({
                  label: 'Expense',
                  isSelected: this.hasFlag('Expense'),
                  onClick: () => {
                    this.toggleFlag('Expense')
                  }
                })
              }
            }
            .width('100%')

            ForEach(this.transactions, (tx: TxItemModel) => {
              TransactionCard({ tx: tx })
            }, (tx: TxItemModel) => tx.id.toString())

            Blank()
              .height(100)
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
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

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
          .type(ButtonType.Normal)
          .width(140)
          .height(44)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppShapes.large)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.md
        })
      }
      .width('100%')
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: 6,
        color: 'rgba(0, 0, 0, 0.16)',
        offsetX: 0,
        offsetY: -1.5
      })
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
  onClick: () => void = () => {}

  build() {
    Button() {
      Text(this.label)
        .fontSize(this.isSelected ? 14 : 12)
        .fontWeight(this.isSelected ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
    }
    .type(ButtonType.Normal)
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
  onClick: () => void = () => {}

  build() {
    Button() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? AppColors.onSecondary : AppColors.onSurface)
    }
    .type(ButtonType.Normal)
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
          Rect()
            .width(16)
            .height(16)
            .fill(this.account.accent)
            .radius(AppShapes.small)

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
        }
        .type(ButtonType.Normal)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.small)
        .border({
          width: 1,
          color: AppColors.outline
        })
      }
      .width('100%')

      Stack({ alignContent: Alignment.Center }) {
        Text(this.showBalance ? this.account.balance : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)

      Row({ space: AppSpacing.sm }) {
        Button() {
          Text('Transfer')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
        }
        .type(ButtonType.Normal)
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.small)
        .border({
          width: 1,
          color: AppColors.outline
        })

        Button() {
          Text('Details')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .type(ButtonType.Normal)
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.small)
        .border({
          width: 1,
          color: AppColors.outline
        })
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .constraintSize({ minHeight: 120 })
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.14)',
      offsetX: 0,
      offsetY: 1
    })
  }
}

@Component
struct TransactionCard {
  tx: TxItemModel = new TxItemModel(0, '', '', '', false)

  build() {
    Row() {
      Row({ space: AppSpacing.md }) {
        Rect()
          .width(32)
          .height(32)
          .fill(this.tx.positive ? AppColors.success : AppColors.error)
          .radius(AppShapes.small)

        Column({ space: AppSpacing.xs }) {
          Text(this.tx.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text(this.tx.subtitle)
            .fontSize(12)
            .fontWeight(FontWeight.Regular)
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
    .width('100%')
    .constraintSize({ minHeight: 72 })
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .shadow({
      radius: 2,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: 0.5
    })
  }
}

@Component
struct CustomSwitch {
  isOn: boolean = false
  onChange: (value: boolean) => void = (_: boolean) => {}

  build() {
    Stack({ alignContent: this.isOn ? Alignment.End : Alignment.Start }) {
      Circle()
        .width(16)
        .height(16)
        .fill(this.isOn ? AppColors.onPrimary : AppColors.outline)
        .margin(2)
    }
    .width(36)
    .height(20)
    .backgroundColor(this.isOn ? AppColors.primary : AppColors.surfaceVariant)
    .borderRadius(16)
    .border({
      width: this.isOn ? 0 : 1,
      color: AppColors.outline
    })
    .onClick(() => {
      this.onChange(!this.isOn)
    })
  }
}