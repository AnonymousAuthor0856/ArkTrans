import { router } from '@kit.ArkUI'

// ==================== Design Tokens ====================
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#1F2937'
    export const secondary: string = '#10B981'
    export const tertiary: string = '#3B82F6'
    export const background: string = '#F3F4F6'
    export const surface: string = '#FFFFFF'
    export const surfaceVariant: string = '#E5E7EB'
    export const outline: string = '#D1D5DB'
    export const success: string = '#16A34A'
    export const warning: string = '#F59E0B'
    export const error: string = '#EF4444'
    export const onPrimary: string = '#FFFFFF'
    export const onSecondary: string = '#0B1220'
    export const onTertiary: string = '#FFFFFF'
    export const onBackground: string = '#0B1220'
    export const onSurface: string = '#0B1220'
  }

  export namespace Spacing {
    export const xs: number = 2
    export const sm: number = 4
    export const md: number = 6
    export const lg: number = 8
    export const xl: number = 12
    export const xxl: number = 16
    export const xxxl: number = 24
  }

  export namespace Radius {
    export const small: number = 6
    export const medium: number = 8
    export const large: number = 12
  }

  export namespace FontSize {
    export const display: number = 24
    export const headline: number = 18
    export const title: number = 14
    export const body: number = 12
    export const label: number = 10
  }
}

// ==================== Data Models ====================
interface AccountCard {
  id: number
  name: string
  balance: string
  accent: string
}

interface TxItem {
  id: number
  title: string
  subtitle: string
  amount: string
  positive: boolean
}

// ==================== State ====================
@Observed
class AppState {
  showBalance: boolean = true
  selectedRange: string = 'Month'
  flags: string[] = []
  accounts: AccountCard[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: '#10B981' },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: '#3B82F6' },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: '#F59E0B' }
  ]
  txs: TxItem[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ]
}

// ==================== Account Card Component ====================
@Component
struct AccountCardItem {
  @ObjectLink state: AppState
  account: AccountCard = { id: 0, name: '', balance: '', accent: '#000000' }

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Header row
      Row() {
        Row({ space: AppTokens.Spacing.sm }) {
          Box()
            .width(16)
            .height(16)
            .backgroundColor(this.account.accent)
            .borderRadius(AppTokens.Radius.small)
          Text(this.account.name)
            .fontSize(AppTokens.FontSize.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(VerticalAlign.Center)

        Button('Manage')
          .fontSize(AppTokens.FontSize.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Radius.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .height(28)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Balance display
      Row() {
        Text(this.state.showBalance ? this.account.balance : '•••••••')
          .fontSize(AppTokens.FontSize.headline)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(60)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Radius.medium)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Action buttons
      Row({ space: AppTokens.Spacing.sm }) {
        Button('Transfer')
          .fontSize(AppTokens.FontSize.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Radius.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .height(28)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        Button('Details')
          .fontSize(AppTokens.FontSize.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Radius.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .height(28)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: '#22000000', offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }
}

// ==================== Transaction Item Component ====================
@Component
struct TxItemCard {
  tx: TxItem = { id: 0, title: '', subtitle: '', amount: '', positive: false }

  build() {
    Row() {
      Row({ space: AppTokens.Spacing.md }) {
        Box()
          .width(32)
          .height(32)
          .backgroundColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
          .borderRadius(AppTokens.Radius.small)

        Column({ space: AppTokens.Spacing.xs }) {
          Text(this.tx.title)
            .fontSize(AppTokens.FontSize.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Text(this.tx.subtitle)
            .fontSize(AppTokens.FontSize.body)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Text(this.tx.amount)
        .fontSize(AppTokens.FontSize.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 2, color: '#1F000000', offsetY: 0 })
    .constraintSize({ minHeight: 72 })
  }
}

// ==================== Root Screen ====================
@Component
struct RootScreen {
  @State state: AppState = new AppState()
  private ranges: string[] = ['All', 'Week', 'Month', 'Year']
  private scroller: Scroller = new Scroller()

  build() {
    Column() {
      // ---- Top App Bar ----
      Row({ space: AppTokens.Spacing.sm }) {
        Box()
          .width(20)
          .height(20)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Radius.small)
        Text('Wallet')
          .fontSize(AppTokens.FontSize.display)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)

      // ---- Scrollable Content ----
      Scroll(this.scroller) {
        Column({ space: AppTokens.Spacing.lg }) {

          // Range filter + Hide toggle
          Row() {
            Row({ space: AppTokens.Spacing.sm }) {
              ForEach(this.ranges, (r: string) => {
                Button(r)
                  .fontSize(this.state.selectedRange === r ? AppTokens.FontSize.title : AppTokens.FontSize.body)
                  .fontWeight(this.state.selectedRange === r ? FontWeight.Medium : FontWeight.Normal)
                  .fontColor(this.state.selectedRange === r ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                  .backgroundColor(this.state.selectedRange === r ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Radius.medium)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .height(32)
                  .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
                  .onClick(() => {
                    this.state.selectedRange = r
                  })
              })
            }
            .alignItems(VerticalAlign.Center)

            Row({ space: AppTokens.Spacing.sm }) {
              Text('Hide')
                .fontSize(AppTokens.FontSize.label)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
              Toggle({ type: ToggleType.Switch, isOn: !this.state.showBalance })
                .selectedColor(AppTokens.Colors.primary)
                .onChange((isOn: boolean) => {
                  this.state.showBalance = !isOn
                })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Account Cards
          ForEach(this.state.accounts, (account: AccountCard) => {
            AccountCardItem({ state: this.state, account: account })
          })

          // Recent Activity Header
          Row() {
            Text('Recent Activity')
              .fontSize(AppTokens.FontSize.headline)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onSurface)

            Row({ space: AppTokens.Spacing.sm }) {
              Button('Income')
                .fontSize(AppTokens.FontSize.label)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.state.flags.includes('Income') ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                .backgroundColor(this.state.flags.includes('Income') ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .borderRadius(AppTokens.Radius.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .height(28)
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
                .onClick(() => {
                  const idx = this.state.flags.indexOf('Income')
                  if (idx >= 0) {
                    this.state.flags.splice(idx, 1)
                  } else {
                    this.state.flags.push('Income')
                  }
                  this.state.flags = [...this.state.flags]
                })

              Button('Expense')
                .fontSize(AppTokens.FontSize.label)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.state.flags.includes('Expense') ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                .backgroundColor(this.state.flags.includes('Expense') ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .borderRadius(AppTokens.Radius.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .height(28)
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
                .onClick(() => {
                  const idx = this.state.flags.indexOf('Expense')
                  if (idx >= 0) {
                    this.state.flags.splice(idx, 1)
                  } else {
                    this.state.flags.push('Expense')
                  }
                  this.state.flags = [...this.state.flags]
                })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Transaction Items
          ForEach(this.state.txs, (tx: TxItem) => {
            TxItemCard({ tx: tx })
          })

          // Bottom spacer
          Row().height(AppTokens.Spacing.xxl)
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.xxxl
        })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      // ---- Bottom Bar ----
      Row() {
        Column({ space: AppTokens.Spacing.xs }) {
          Text('Total Balance')
            .fontSize(AppTokens.FontSize.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Text(this.state.showBalance ? '$26,395.75' : '•••••••')
            .fontSize(AppTokens.FontSize.headline)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Add Money')
          .fontSize(AppTokens.FontSize.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Radius.large)
          .height(44)
          .width(140)
      }
      .width('100%')
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: AppTokens.Spacing.md
      })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 6, color: '#29000000', offsetY: -1 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// ==================== Entry Point ====================
@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}