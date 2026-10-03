// File 031 - Wallet Dash Finance (Finance/Wallet)
interface Transaction {
  id: number
  name: string
  detail: string
  amount: string
  isCredit: boolean
}

interface ControlAction {
  label: string
}

interface NavItem {
  label: string
}

const Colors = {
  primary: '#020617',
  secondary: '#4ADE80',
  tertiary: '#64748B',
  background: '#F8FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#F1F5F9',
  outline: '#E2E8F0',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#020617',
  onTertiary: '#FFFFFF',
  onBackground: '#020617',
  onSurface: '#020617'
}

const Shapes = {
  small: 8,
  medium: 16,
  large: 24
}

const Spacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48
}

@Entry
@Component
struct Index {
  @State selectedNavItem: string = 'Home'
  private transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
  ]
  private controlActions: ControlAction[] = [
    { label: 'Send' },
    { label: 'Receive' },
    { label: 'Add' },
    { label: 'More' }
  ]
  private navItems: NavItem[] = [
    { label: 'Home' },
    { label: 'Cards' },
    { label: 'Activity' },
    { label: 'Profile' }
  ]

  build() {
    Column() {
      Row() {
        Button({ type: ButtonType.Circle })
          .width(28)
          .height(28)
          .backgroundColor(Colors.surfaceVariant)
          .onClick(() => {})
        Text('My Wallet')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Button({ type: ButtonType.Circle })
          .width(28)
          .height(28)
          .backgroundColor(Colors.surfaceVariant)
          .onClick(() => {})
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.md, right: Spacing.md })
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column({ space: Spacing.lg }) {
          Column() {
            Text('Total Balance')
              .fontSize(16)
              .fontColor('#B3FFFFFF')
            Blank().height(Spacing.sm)
            Text('$ 1,145.14')
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onPrimary)
            Blank().height(Spacing.xs)
            Row({ space: Spacing.sm }) {
              Stack() {}
                .width(10)
                .height(10)
                .backgroundColor(Colors.secondary)
                .borderRadius(5)
              Text('+$234.10 today')
                .fontSize(16)
                .fontColor(Colors.secondary)
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(Spacing.lg)
          .backgroundColor(Colors.primary)
          .borderRadius(Shapes.large)

          Row() {
            ForEach(this.controlActions, (action: ControlAction) => {
              Column({ space: Spacing.sm }) {
                Button({ type: ButtonType.Circle }) {
                  Stack() {}
                    .width(24)
                    .height(24)
                    .backgroundColor(Colors.primary)
                    .borderRadius(Shapes.small)
                }
                .width(64)
                .height(64)
                .backgroundColor(Colors.surface)
                .onClick(() => {})
                Text(action.label)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
              }
              .alignItems(HorizontalAlign.Center)
            }, (action: ControlAction) => action.label)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)
          .alignItems(VerticalAlign.Center)

          Row() {
            Text('Recent Activity')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
            Blank().layoutWeight(1)
            Text('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.tertiary)
              .onClick(() => {})
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          ForEach(this.transactions, (tx: Transaction) => {
            Column() {
              Row({ space: Spacing.md }) {
                Stack() {}
                  .width(48)
                  .height(48)
                  .backgroundColor(Colors.surfaceVariant)
                  .borderRadius(Shapes.medium)
                Column() {
                  Text(tx.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Colors.onSurface)
                  Text(tx.detail)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.tertiary)
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)
                Text(tx.amount)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(tx.isCredit ? Colors.success : Colors.onSurface)
                  .textAlign(TextAlign.End)
              }
              .width('100%')
              .padding(Spacing.md)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .backgroundColor(Colors.surface)
            .borderRadius(Shapes.medium)
            .border({ width: 1, color: Colors.outline })
          }, (tx: Transaction) => tx.id.toString())
        }
        .width('100%')
        .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          Column({ space: Spacing.xs }) {
            Stack() {}
              .width(24)
              .height(24)
              .backgroundColor(this.selectedNavItem === item.label ? Colors.primary : Colors.outline)
              .borderRadius(12)
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNavItem === item.label ? Colors.primary : Colors.tertiary)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => { this.selectedNavItem = item.label })
        }, (item: NavItem) => item.label)
      }
      .width('100%')
      .backgroundColor(Colors.surface)
      .padding({ top: Spacing.sm, bottom: Spacing.sm })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
