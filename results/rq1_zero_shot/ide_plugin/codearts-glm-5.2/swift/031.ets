class AppTokens {
  static readonly Colors = {
    primary: '#FF020617',
    secondary: '#FF4ADE80',
    tertiary: '#FF64748B',
    background: '#FFF8FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF1F5F9',
    outline: '#FFE2E8F0',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF020617',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF020617',
    onSurface: '#FF020617',
    onPrimary70: '#B3FFFFFF'
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  }

  static readonly Shapes = {
    small: 8,
    medium: 16,
    large: 24
  }
}

class Transaction {
  id: number
  name: string
  detail: string
  amount: string
  isCredit: boolean

  constructor(id: number, name: string, detail: string, amount: string, isCredit: boolean) {
    this.id = id
    this.name = name
    this.detail = detail
    this.amount = amount
    this.isCredit = isCredit
  }
}

@Entry
@Component
struct MyWallet {
  @State selectedNavItem: string = 'Home'

  private transactions: Transaction[] = [
    new Transaction(1, 'Spotify', 'Subscription', '-$9.99', false),
    new Transaction(2, 'Income', 'Monthly Salary', '+$2,500.00', true),
    new Transaction(3, 'Starbucks', 'Coffee', '-$5.75', false),
    new Transaction(4, 'Amazon', 'Shopping', '-$124.50', false),
    new Transaction(5, 'Refund', 'Amazon Return', '+$32.00', true)
  ]

  private controlActions: string[] = ['Send', 'Receive', 'Add', 'More']
  private navItems: string[] = ['Home', 'Cards', 'Activity', 'Profile']

  build() {
    Column() {
      Row() {
        Row()
          .width(28)
          .height(28)
          .borderRadius(14)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
        Blank()
        Text('My Wallet')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onBackground)
        Blank()
        Row()
          .width(28)
          .height(28)
          .borderRadius(14)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })

      Scroll() {
        Column() {
          Column() {
            Text('Total Balance')
              .fontSize(16)
              .fontColor(AppTokens.Colors.onPrimary70)
            Text('$ 1,145.14')
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onPrimary)
              .margin({ top: 8 })
            Row() {
              Row()
                .width(10)
                .height(10)
                .borderRadius(5)
                .backgroundColor(AppTokens.Colors.secondary)
              Text('+$234.10 today')
                .fontSize(16)
                .fontColor(AppTokens.Colors.secondary)
                .margin({ left: 8 })
            }
            .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)
          .padding(24)
          .width('100%')
          .borderRadius(24)
          .backgroundColor(AppTokens.Colors.primary)
          .shadow({ radius: 8, color: '#14000000', offsetX: 0, offsetY: 2 })

          Row() {
            ForEach(this.controlActions, (action: string) => {
              Column() {
                Row()
                  .width(64)
                  .height(64)
                  .borderRadius(32)
                  .backgroundColor(AppTokens.Colors.surface)
                  .shadow({ radius: 3, color: '#0D000000', offsetX: 0, offsetY: 1 })
                  .justifyContent(FlexAlign.Center)

                Text(action)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onBackground)
                  .margin({ top: 8 })
              }
              .layoutWeight(1)
            })
          }
          .width('100%')
          .margin({ top: 24 })

          Row() {
            Text('Recent Activity')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onBackground)
            Blank()
            Text('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.tertiary)
          }
          .width('100%')
          .margin({ top: 24 })

          ForEach(this.transactions, (transaction: Transaction) => {
            Row() {
              Row()
                .width(48)
                .height(48)
                .borderRadius(16)
                .backgroundColor(AppTokens.Colors.surfaceVariant)

              Column() {
                Text(transaction.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Semibold)
                  .fontColor(AppTokens.Colors.onSurface)
                Text(transaction.detail)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.tertiary)
                  .margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              .margin({ left: 16 })

              Text(transaction.amount)
                .fontSize(16)
                .fontWeight(FontWeight.Semibold)
                .fontColor(transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
            }
            .width('100%')
            .padding(16)
            .borderRadius(16)
            .backgroundColor(AppTokens.Colors.surface)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .margin({ top: 16 })
          })
        }
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Row() {
        ForEach(this.navItems, (item: string) => {
          Column() {
            Row()
              .width(24)
              .height(24)
              .borderRadius(12)
              .backgroundColor(this.selectedNavItem === item ? AppTokens.Colors.primary : AppTokens.Colors.outline)
            Text(item)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNavItem === item ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .padding({ top: 8, bottom: 8 })
          .borderRadius(16)
          .backgroundColor(this.selectedNavItem === item ? AppTokens.Colors.surfaceVariant : '#00000000')
          .onClick(() => {
            this.selectedNavItem = item
          })
        })
      }
      .width('100%')
      .height(80)
      .padding({ left: 4, right: 4 })
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}