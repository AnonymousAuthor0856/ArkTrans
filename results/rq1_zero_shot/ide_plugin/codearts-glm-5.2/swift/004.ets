class AppTokens {
  static readonly Colors = {
    primary: '#FF1F2937',
    secondary: '#FF10B981',
    tertiary: '#FF3B82F6',
    background: '#FFF3F4F6',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE5E7EB',
    outline: '#FFD1D5DB',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF0B1220',
    onSurface: '#FF0B1220'
  }

  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  }
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
  @State showBalance: boolean = true
  @State selectedFilter: string = 'Month'
  @State flags: string[] = []

  private filters: string[] = ['All', 'Week', 'Month', 'Year']
  private accounts: AccountCardModel[] = [
    new AccountCardModel(1, 'Wallet', '$2,845.20', '#FF10B981'),
    new AccountCardModel(2, 'Savings', '$8,120.00', '#FF3B82F6'),
    new AccountCardModel(3, 'Investments', '$15,430.55', '#FFF59E0B')
  ]
  private transactions: TxItemModel[] = [
    new TxItemModel(1, 'Grocery Market', 'Today • 12:40', '-$32.18', false),
    new TxItemModel(2, 'Salary', 'Yesterday • 09:00', '+$3,200.00', true),
    new TxItemModel(3, 'Coffee Shop', 'Yesterday • 15:22', '-$4.90', false),
    new TxItemModel(4, 'ETF Purchase', 'Mon • 10:05', '-$250.00', false),
    new TxItemModel(5, 'Refund', 'Sun • 18:40', '+$18.99', true)
  ]

  private toggleFlag(flag: string) {
    let index = this.flags.indexOf(flag)
    if (index >= 0) {
      this.flags.splice(index, 1)
    } else {
      this.flags.push(flag)
    }
  }

  private isFlagSelected(flag: string): boolean {
    return this.flags.indexOf(flag) >= 0
  }

  build() {
    Column() {
      Row() {
        Row()
          .width(20)
          .height(20)
          .borderRadius(6)
          .backgroundColor(AppTokens.Colors.primary)
        Text('Wallet')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: 4 })
      }
      .width('100%')
      .padding(16)
      .backgroundColor(AppTokens.Colors.background)

      Scroll() {
        Column() {
          Row() {
            Row() {
              ForEach(this.filters, (filter: string) => {
                Text(filter)
                  .fontSize(this.selectedFilter === filter ? 14 : 12)
                  .fontWeight(this.selectedFilter === filter ? FontWeight.Medium : FontWeight.Normal)
                  .fontColor(this.selectedFilter === filter ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                  .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                  .borderRadius(8)
                  .backgroundColor(this.selectedFilter === filter ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                  .border({ width: this.selectedFilter === filter ? 0 : 1, color: AppTokens.Colors.outline })
                  .margin({ right: 4 })
                  .onClick(() => {
                    this.selectedFilter = filter
                  })
              })
            }
            .layoutWeight(1)

            Row() {
              Text('Hide')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .selectedColor(AppTokens.Colors.primary)
                .onChange((isOn: boolean) => {
                  this.showBalance = !isOn
                })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          ForEach(this.accounts, (account: AccountCardModel) => {
            AccountCardView({
              name: account.name,
              balance: account.balance,
              accent: account.accent,
              showBalance: this.showBalance
            })
              .margin({ top: 8 })
          })

          Row() {
            Text('Recent Activity')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
              .layoutWeight(1)

            Row() {
              Text('Income')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.isFlagSelected('Income') ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                .padding({ left: 8, right: 8, top: 6, bottom: 6 })
                .borderRadius(6)
                .backgroundColor(this.isFlagSelected('Income') ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .margin({ right: 4 })
                .onClick(() => {
                  this.toggleFlag('Income')
                })
              Text('Expense')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.isFlagSelected('Expense') ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                .padding({ left: 8, right: 8, top: 6, bottom: 6 })
                .borderRadius(6)
                .backgroundColor(this.isFlagSelected('Expense') ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .onClick(() => {
                  this.toggleFlag('Expense')
                })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: 8 })

          ForEach(this.transactions, (tx: TxItemModel) => {
            TransactionCard({
              title: tx.title,
              subtitle: tx.subtitle,
              amount: tx.amount,
              positive: tx.positive
            })
              .margin({ top: 8 })
          })

          Column()
            .height(100)
        }
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Row() {
        Column() {
          Text('Total Balance')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Text(this.showBalance ? '$26,395.75' : '•••••••')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text('Add Money')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .width(140)
          .height(44)
          .textAlign(TextAlign.Center)
          .borderRadius(12)
          .backgroundColor(AppTokens.Colors.secondary)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor(AppTokens.Colors.surface)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct AccountCardView {
  @Prop name: string
  @Prop balance: string
  @Prop accent: string
  @Prop showBalance: boolean

  build() {
    Column() {
      Row() {
        Row() {
          Row()
            .width(16)
            .height(16)
            .borderRadius(6)
            .backgroundColor(this.accent)
          Text(this.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)
        .layoutWeight(1)

        Text('Manage')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(6)
          .backgroundColor(AppTokens.Colors.secondary)
          .border({ width: 1, color: AppTokens.Colors.outline })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Row() {
        Text(this.showBalance ? this.balance : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(60)
      .borderRadius(8)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 4 })

      Row() {
        Text('Transfer')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .borderRadius(6)
          .backgroundColor(AppTokens.Colors.secondary)
          .border({ width: 1, color: AppTokens.Colors.outline })
        Text('Details')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
          .borderRadius(6)
          .backgroundColor(AppTokens.Colors.surface)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .margin({ left: 4 })
      }
      .margin({ top: 4 })
    }
    .padding(8)
    .borderRadius(12)
    .backgroundColor(AppTokens.Colors.surface)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct TransactionCard {
  @Prop title: string
  @Prop subtitle: string
  @Prop amount: string
  @Prop positive: boolean

  build() {
    Row() {
      Row() {
        Row()
          .width(32)
          .height(32)
          .borderRadius(6)
          .backgroundColor(this.positive ? AppTokens.Colors.success : AppTokens.Colors.error)

        Column() {
          Text(this.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Text(this.subtitle)
            .fontSize(12)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 6 })
      }
      .alignItems(VerticalAlign.Center)
      .layoutWeight(1)

      Text(this.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
    }
    .width('100%')
    .padding(8)
    .borderRadius(12)
    .backgroundColor(AppTokens.Colors.surface)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 2, color: '#1F000000', offsetX: 0, offsetY: 0.5 })
    .alignItems(VerticalAlign.Center)
  }
}