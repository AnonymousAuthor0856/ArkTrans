// Color constants
const COLOR_PRIMARY: number = 0xFF1F2937
const COLOR_SECONDARY: number = 0xFF10B981
const COLOR_TERTIARY: number = 0xFF3B82F6
const COLOR_BACKGROUND: number = 0xFFF3F4F6
const COLOR_SURFACE: number = 0xFFFFFFFF
const COLOR_SURFACE_VARIANT: number = 0xFFE5E7EB
const COLOR_OUTLINE: number = 0xFFD1D5DB
const COLOR_SUCCESS: number = 0xFF16A34A
const COLOR_ERROR: number = 0xFFEF4444
const COLOR_ON_PRIMARY: number = 0xFFFFFFFF
const COLOR_ON_SECONDARY: number = 0xFF0B1220
const COLOR_ON_SURFACE: number = 0xFF0B1220

class AccountCardData {
  id: number = 0
  name: string = ''
  balance: string = ''
  accent: number = 0
}

class TxItemData {
  id: number = 0
  title: string = ''
  subtitle: string = ''
  amount: string = ''
  positive: boolean = false
}

@Entry
@Component
struct Index {
  @State showBalance: boolean = true
  @State selectedRange: string = 'Month'
  @State incomeSelected: boolean = false
  @State expenseSelected: boolean = false

  private rangeList: string[] = ['All', 'Week', 'Month', 'Year']

  private accounts: AccountCardData[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: 0xFF10B981 },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: 0xFF3B82F6 },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: 0xFFF59E0B }
  ]

  private txs: TxItemData[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ]

  @Builder
  FilterChipItem(label: string) {
    Text(label)
      .fontSize(this.selectedRange === label ? 14 : 12)
      .fontWeight(this.selectedRange === label ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.selectedRange === label ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
      .backgroundColor(this.selectedRange === label ? COLOR_PRIMARY : COLOR_SURFACE)
      .borderRadius(8)
      .border({ width: 1, color: COLOR_OUTLINE })
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .onClick(() => {
        this.selectedRange = label
      })
  }

  @Builder
  AccountCardItem(account: AccountCardData) {
    Column({ space: 4 }) {
      Row() {
        Row({ space: 4 }) {
          Stack() {}
          .width(16)
          .height(16)
          .backgroundColor(account.accent)
          .borderRadius(6)

          Text(account.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
        }
        .alignItems(VerticalAlign.Center)

        Text('Manage')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SECONDARY)
          .backgroundColor(COLOR_SECONDARY)
          .borderRadius(6)
          .border({ width: 1, color: COLOR_OUTLINE })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Stack() {
        Text(this.showBalance ? account.balance : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .height(100)
      .backgroundColor(COLOR_SURFACE_VARIANT)
      .borderRadius(8)
      .alignContent(Alignment.Center)

      Row({ space: 4 }) {
        Text('Transfer')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SECONDARY)
          .backgroundColor(COLOR_SECONDARY)
          .borderRadius(6)
          .border({ width: 1, color: COLOR_OUTLINE })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })

        Text('Details')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .backgroundColor(COLOR_SURFACE)
          .borderRadius(6)
          .border({ width: 1, color: COLOR_OUTLINE })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(8)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(12)
    .border({ width: 1, color: COLOR_OUTLINE })
    .shadow({ radius: 4, color: '#22000000', offsetX: 0, offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  TxCard(tx: TxItemData) {
    Row() {
      Row({ space: 6 }) {
        Stack() {}
        .width(32)
        .height(32)
        .backgroundColor(tx.positive ? COLOR_SUCCESS : COLOR_ERROR)
        .borderRadius(6)

        Column({ space: 2 }) {
          Text(tx.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)

          Text(tx.subtitle)
            .fontSize(12)
            .fontWeight(FontWeight.Normal)
            .fontColor(COLOR_ON_SURFACE)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Text(tx.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(tx.positive ? COLOR_SUCCESS : COLOR_ERROR)
    }
    .width('100%')
    .padding(8)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(12)
    .border({ width: 1, color: COLOR_OUTLINE })
    .shadow({ radius: 2, color: '#1E000000', offsetX: 0, offsetY: 0.5 })
    .constraintSize({ minHeight: 72 })
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row({ space: 4 }) {
          Stack() {}
          .width(20)
          .height(20)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(6)

          Text('Wallet')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_SURFACE)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_SURFACE)

      // Main scrollable content
      Scroll() {
        Column({ space: 8 }) {
          // Filter chips + Hide toggle row
          Row() {
            Row({ space: 4 }) {
              ForEach(this.rangeList, (r: string) => {
                this.FilterChipItem(r)
              })
            }
            .alignItems(VerticalAlign.Center)

            Row({ space: 4 }) {
              Text('Hide')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE)

              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .onChange((isOn: boolean) => {
                  this.showBalance = !isOn
                })
                .selectedColor(COLOR_PRIMARY)
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Account cards
          ForEach(this.accounts, (account: AccountCardData) => {
            this.AccountCardItem(account)
          })

          // Recent Activity header
          Row() {
            Text('Recent Activity')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLOR_ON_SURFACE)

            Row({ space: 4 }) {
              Text('Income')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.incomeSelected ? COLOR_ON_SECONDARY : COLOR_ON_SURFACE)
                .backgroundColor(this.incomeSelected ? COLOR_SECONDARY : COLOR_SURFACE)
                .borderRadius(6)
                .border({ width: 1, color: COLOR_OUTLINE })
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .onClick(() => {
                  this.incomeSelected = !this.incomeSelected
                })

              Text('Expense')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.expenseSelected ? COLOR_ON_SECONDARY : COLOR_ON_SURFACE)
                .backgroundColor(this.expenseSelected ? COLOR_SECONDARY : COLOR_SURFACE)
                .borderRadius(6)
                .border({ width: 1, color: COLOR_OUTLINE })
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .onClick(() => {
                  this.expenseSelected = !this.expenseSelected
                })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Transaction cards
          ForEach(this.txs, (tx: TxItemData) => {
            this.TxCard(tx)
          })

          // Bottom spacer
          Column() {}
          .height(16)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(COLOR_BACKGROUND)

      // Bottom bar
      Row() {
        Column({ space: 2 }) {
          Text('Total Balance')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)

          Text(this.showBalance ? '$26,395.75' : '•••••••')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_SURFACE)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Add Money')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SECONDARY)
          .backgroundColor(COLOR_SECONDARY)
          .borderRadius(12)
          .width(140)
          .height(44)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_SURFACE)
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: -1 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}