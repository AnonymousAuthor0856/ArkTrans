class ColorsClass {
  primary: string = '#020617'
  secondary: string = '#4ADE80'
  tertiary: string = '#64748B'
  background: string = '#F8FAFC'
  surface: string = '#FFFFFF'
  surfaceVariant: string = '#F1F5F9'
  outline: string = '#E2E8F0'
  success: string = '#22C55E'
  warning: string = '#F59E0B'
  error: string = '#EF4444'
  onPrimary: string = '#FFFFFF'
  onSecondary: string = '#020617'
  onTertiary: string = '#FFFFFF'
  onBackground: string = '#020617'
  onSurface: string = '#020617'
}

class SpacingClass {
  xs: number = 4
  sm: number = 8
  md: number = 16
  lg: number = 24
  xl: number = 32
  xxl: number = 48
}

const Colors: ColorsClass = new ColorsClass()
const Spacing: SpacingClass = new SpacingClass()

class Transaction {
  id: number = 0
  name: string = ''
  detail: string = ''
  amount: string = ''
  isCredit: boolean = false
}

const transactions: Transaction[] = [
  { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
  { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
  { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
  { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
  { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true },
]

const controlActions: string[] = ['Send', 'Receive', 'Add', 'More']
const navItems: string[] = ['Home', 'Cards', 'Activity', 'Profile']

@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home'

  build() {
    Column() {
      // Top App Bar
      Row() {
        Button()
          .width(28)
          .height(28)
          .borderRadius(14)
          .backgroundColor(Colors.surfaceVariant)

        Text('My Wallet')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onBackground)

        Button()
          .width(28)
          .height(28)
          .borderRadius(14)
          .backgroundColor(Colors.surfaceVariant)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: Spacing.md, right: Spacing.md })
      .backgroundColor(Colors.background)

      // Scrollable Content
      Scroll() {
        Column({ space: Spacing.lg }) {
          // Total Balance Card
          Column({ space: 0 }) {
            Text('Total Balance')
              .fontSize(16)
              .fontWeight(FontWeight.Normal)
              .fontColor('#B3FFFFFF')
              .width('100%')

            Blank().height(Spacing.sm)

            Text('$ 1,145.14')
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onPrimary)
              .width('100%')
              .letterSpacing(-0.5)

            Blank().height(Spacing.xs)

            Row({ space: Spacing.sm }) {
              Circle()
                .width(10)
                .height(10)
                .fill(Colors.secondary)

              Text('+$234.10 today')
                .fontSize(16)
                .fontWeight(FontWeight.Normal)
                .fontColor(Colors.secondary)
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
          }
          .padding(Spacing.lg)
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .backgroundColor(Colors.primary)
          .borderRadius(24)
          .shadow({
            radius: 8,
            color: '#14000000',
            offsetX: 0,
            offsetY: 2
          })

          // Control Actions Row
          Row() {
            ForEach(controlActions, (action: string) => {
              Column({ space: Spacing.sm }) {
                Stack() {
                  Circle()
                    .width(64)
                    .height(64)
                    .fill(Colors.surface)

                  Column()
                    .width(24)
                    .height(24)
                    .borderRadius(8)
                    .backgroundColor(Colors.primary)
                }
                .width(64)
                .height(64)
                .shadow({
                  radius: 3,
                  color: '#0D000000',
                  offsetX: 0,
                  offsetY: 1
                })

                Text(action)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onBackground)
                  .letterSpacing(0.2)
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Center)
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)

          // Recent Activity Header
          Row() {
            Text('Recent Activity')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onBackground)

            Text('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.tertiary)
              .letterSpacing(0.2)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Transaction Cards
          ForEach(transactions, (transaction: Transaction) => {
            Row({ space: Spacing.md }) {
              Column()
                .width(48)
                .height(48)
                .borderRadius(16)
                .backgroundColor(Colors.surfaceVariant)

              Column({ space: 4 }) {
                Text(transaction.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Colors.onSurface)

                Text(transaction.detail)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.tertiary)
                  .letterSpacing(0.2)
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Text(transaction.amount)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(transaction.isCredit ? Colors.success : Colors.onSurface)
                .textAlign(TextAlign.End)
            }
            .padding(Spacing.md)
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .backgroundColor(Colors.surface)
            .borderRadius(16)
            .border({
              width: 1,
              color: Colors.outline,
              radius: 16
            })
          })
        }
        .padding({
          left: Spacing.md,
          right: Spacing.md,
          top: Spacing.sm,
          bottom: Spacing.sm
        })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(Colors.background)

      // Bottom Navigation Bar
      Row() {
        ForEach(navItems, (item: string) => {
          Column({ space: Spacing.xs }) {
            Circle()
              .width(24)
              .height(24)
              .fill(this.selectedNavItem === item ? Colors.primary : Colors.outline)

            Text(item)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNavItem === item ? Colors.primary : Colors.tertiary)
              .letterSpacing(0.2)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .padding({ top: Spacing.sm, bottom: Spacing.sm })
          .borderRadius(16)
          .backgroundColor(this.selectedNavItem === item ? Colors.surfaceVariant : Color.Transparent)
          .onClick(() => {
            this.selectedNavItem = item
          })
        })
      }
      .width('100%')
      .height(80)
      .padding({ left: Spacing.xs, right: Spacing.xs })
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)
      .shadow({
        radius: 12,
        color: '#1A000000',
        offsetX: 0,
        offsetY: -4
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}