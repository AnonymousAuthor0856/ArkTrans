import { LengthMetrics } from '@kit.ArkUI'

interface TransactionItem {
  id: number
  name: string
  detail: string
  amount: string
  isCredit: boolean
}

interface ControlActionItem {
  label: string
}

interface NavItemData {
  label: string
}

const primaryColor: string = '#FF020617'
const secondaryColor: string = '#FF4ADE80'
const tertiaryColor: string = '#FF64748B'
const backgroundColor: string = '#FFF8FAFC'
const surfaceColor: string = '#FFFFFFFF'
const surfaceVariantColor: string = '#FFF1F5F9'
const outlineColor: string = '#FFE2E8F0'
const successColor: string = '#FF22C55E'
const onPrimaryColor: string = '#FFFFFFFF'
const onSurfaceColor: string = '#FF020617'

const transactions: TransactionItem[] = [
  { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
  { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
  { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
  { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
  { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
]

const controlActions: ControlActionItem[] = [
  { label: 'Send' },
  { label: 'Receive' },
  { label: 'Add' },
  { label: 'More' }
]

const navItems: NavItemData[] = [
  { label: 'Home' },
  { label: 'Cards' },
  { label: 'Activity' },
  { label: 'Profile' }
]

@Entry
@Component
struct Index {
  @State selectedNavItem: string = 'Home'

  build() {
    Column() {
      // Top Bar
      Row() {
        Button({ type: ButtonType.Circle }) {
          // empty circle button
        }
        .width(28)
        .height(28)
        .backgroundColor(surfaceVariantColor)

        Text('My Wallet')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(onSurfaceColor)

        Button({ type: ButtonType.Circle }) {
          // empty circle button
        }
        .width(28)
        .height(28)
        .backgroundColor(surfaceVariantColor)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 16, right: 16 })
      .backgroundColor(backgroundColor)

      // Main Content
      Scroll() {
        Column({ space: 24 }) {
          // Balance Card
          Column() {
            Text('Total Balance')
              .fontSize(16)
              .fontColor('#B3FFFFFF')
              .fontWeight(FontWeight.Normal)

            Blank().height(8)

            Text('$ 1,145.14')
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .fontColor(onPrimaryColor)

            Blank().height(4)

            Row() {
              Circle()
                .width(10)
                .height(10)
                .fill(secondaryColor)

              Blank().width(8)

              Text('+$234.10 today')
                .fontSize(16)
                .fontColor(secondaryColor)
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(24)
          .backgroundColor(primaryColor)
          .borderRadius(24)
          .alignItems(HorizontalAlign.Start)
          .shadow({ radius: 8, color: '#14000000', offsetY: 2 })

          // Control Actions
          Row() {
            ForEach(controlActions, (action: ControlActionItem) => {
              Column({ space: 8 }) {
                Button({ type: ButtonType.Circle }) {
                  // empty
                }
                .width(64)
                .height(64)
                .backgroundColor(surfaceColor)
                .shadow({ radius: 3, color: '#0D000000', offsetY: 1 })

                Text(action.label)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(onSurfaceColor)
              }
              .alignItems(HorizontalAlign.Center)
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)
          .alignItems(VerticalAlign.Center)

          // Recent Activity Header
          Row() {
            Text('Recent Activity')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(onSurfaceColor)

            Text('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(tertiaryColor)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Transactions
          Column({ space: 12 }) {
            ForEach(transactions, (transaction: TransactionItem) => {
              Row({ space: 16 }) {
                Column()
                  .width(48)
                  .height(48)
                  .backgroundColor(surfaceVariantColor)
                  .borderRadius(16)

                Column({ space: 4 }) {
                  Text(transaction.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(onSurfaceColor)

                  Text(transaction.detail)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(tertiaryColor)
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Text(transaction.amount)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(transaction.isCredit ? successColor : onSurfaceColor)
                  .textAlign(TextAlign.End)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(surfaceColor)
              .borderRadius(16)
              .border({ width: 1, color: outlineColor })
              .alignItems(VerticalAlign.Center)
            })
          }
          .width('100%')

          Blank().height(16)
        }
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(backgroundColor)

      // Bottom Navigation Bar
      Row() {
        ForEach(navItems, (item: NavItemData) => {
          Column({ space: 4 }) {
            Circle()
              .width(24)
              .height(24)
              .fill(this.selectedNavItem === item.label ? primaryColor : outlineColor)

            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNavItem === item.label ? primaryColor : tertiaryColor)
          }
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .layoutWeight(1)
          .height(56)
          .onClick(() => {
            this.selectedNavItem = item.label
          })
        })
      }
      .width('100%')
      .height(64)
      .backgroundColor(surfaceColor)
      .shadow({ radius: 12, color: '#1A000000', offsetY: -4 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundColor)
  }
}