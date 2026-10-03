import { router } from '@kit.ArkUI'

// Color tokens
const Colors = {
  primary: 0xFF1F2937,
  secondary: 0xFF10B981,
  tertiary: 0xFF3B82F6,
  background: 0xFFF3F4F6,
  surface: 0xFFFFFFFF,
  surfaceVariant: 0xFFE5E7EB,
  outline: 0xFFD1D5DB,
  success: 0xFF16A34A,
  warning: 0xFFF59E0B,
  error: 0xFFEF4444,
  onPrimary: 0xFFFFFFFF,
  onSecondary: 0xFF0B1220,
  onTertiary: 0xFFFFFFFF,
  onBackground: 0xFF0B1220,
  onSurface: 0xFF0B1220,
}

interface AccountCardData {
  id: number
  name: string
  balance: string
  accent: number
}

interface TxItemData {
  id: number
  title: string
  subtitle: string
  amount: string
  positive: boolean
}

@Entry
@Component
struct RootScreen {
  @State showBalance: boolean = true
  @State selectedRange: string = 'Month'
  @State incomeFlag: boolean = false
  @State expenseFlag: boolean = false

  private ranges: string[] = ['All', 'Week', 'Month', 'Year']
  private accounts: AccountCardData[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: 0xFF10B981 },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: 0xFF3B82F6 },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: 0xFFF59E0B },
  ]
  private txs: TxItemData[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true },
  ]

  @Builder
  TopBar() {
    Row() {
      Stack() {}
      .width(20)
      .height(20)
      .backgroundColor(Colors.primary)
      .borderRadius(6)
      .margin({ right: 4 })

      Text('Wallet')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onSurface)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Colors.surface)
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Total Balance')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .margin({ bottom: 2 })
        Text(this.showBalance ? '$26,395.75' : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Add Money')
        .height(44)
        .width(140)
        .backgroundColor(Colors.secondary)
        .fontColor(Colors.onSecondary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(12)
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Colors.surface)
    .shadow({ radius: 6, color: '#29000000', offsetY: 1 })
  }

  @Builder
  FilterRow() {
    Row() {
      Row() {
        ForEach(this.ranges, (r: string) => {
          Text(r)
            .fontSize(r === this.selectedRange ? 14 : 12)
            .fontWeight(r === this.selectedRange ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(r === this.selectedRange ? Colors.onPrimary : Colors.onSurface)
            .padding({ left: 10, right: 10, top: 6, bottom: 6 })
            .backgroundColor(r === this.selectedRange ? Colors.primary : Colors.surface)
            .borderRadius(8)
            .border({ width: 1, color: Colors.outline })
            .margin({ right: 4 })
            .onClick(() => {
              this.selectedRange = r
            })
        })
      }
      .alignItems(VerticalAlign.Center)

      Row() {
        Text('Hide')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .margin({ right: 4 })
        Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
          .selectedColor(Colors.primary)
          .onChange((isOn: boolean) => {
            this.showBalance = !isOn
          })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 8 })
  }

  @Builder
  AccountCardItem(a: AccountCardData) {
    Column() {
      Row() {
        Row() {
          Stack() {}
          .width(16)
          .height(16)
          .backgroundColor(a.accent)
          .borderRadius(6)
          .margin({ right: 4 })

          Text(a.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
        }
        .alignItems(VerticalAlign.Center)

        Text('Manage')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSecondary)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(Colors.secondary)
          .borderRadius(6)
          .border({ width: 1, color: Colors.outline })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 4 })

      Row() {
        Text(this.showBalance ? a.balance : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.surfaceVariant)
      .borderRadius(8)
      .margin({ bottom: 4 })

      Row() {
        Text('Transfer')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSecondary)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(Colors.secondary)
          .borderRadius(6)
          .border({ width: 1, color: Colors.outline })
          .margin({ right: 4 })

        Text('Details')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(Colors.surface)
          .borderRadius(6)
          .border({ width: 1, color: Colors.outline })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(8)
    .backgroundColor(Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: Colors.outline })
    .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
    .margin({ bottom: 8 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onSurface)

      Row() {
        Text('Income')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.incomeFlag ? Colors.onSecondary : Colors.onSurface)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(this.incomeFlag ? Colors.secondary : Colors.surface)
          .borderRadius(6)
          .border({ width: 1, color: Colors.outline })
          .margin({ right: 4 })
          .onClick(() => {
            this.incomeFlag = !this.incomeFlag
          })

        Text('Expense')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.expenseFlag ? Colors.onSecondary : Colors.onSurface)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(this.expenseFlag ? Colors.secondary : Colors.surface)
          .borderRadius(6)
          .border({ width: 1, color: Colors.outline })
          .onClick(() => {
            this.expenseFlag = !this.expenseFlag
          })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 8 })
  }

  @Builder
  TxCard(t: TxItemData) {
    Row() {
      Row() {
        Stack() {}
        .width(32)
        .height(32)
        .backgroundColor(t.positive ? Colors.success : Colors.error)
        .borderRadius(6)
        .margin({ right: 6 })

        Column() {
          Text(t.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
            .margin({ bottom: 2 })
          Text(t.subtitle)
            .fontSize(12)
            .fontWeight(FontWeight.Normal)
            .fontColor(Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Text(t.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(t.positive ? Colors.success : Colors.error)
    }
    .width('100%')
    .padding(8)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: Colors.outline })
    .shadow({ radius: 2, color: '#1F000000', offsetY: 0 })
    .margin({ bottom: 8 })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          this.FilterRow()

          ForEach(this.accounts, (a: AccountCardData) => {
            this.AccountCardItem(a)
          })

          this.ActivityHeader()

          ForEach(this.txs, (t: TxItemData) => {
            this.TxCard(t)
          })

          Row() {}
          .height(16)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .backgroundColor(Colors.background)
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}