import router from '@ohos.router';

interface Transaction {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;
}

interface ControlAction {
  label: string;
}

interface NavItem {
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home';

  private transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true },
  ];

  private controlActions: ControlAction[] = [
    { label: 'Send' },
    { label: 'Receive' },
    { label: 'Add' },
    { label: 'More' },
  ];

  private navItems: NavItem[] = [
    { label: 'Home' },
    { label: 'Cards' },
    { label: 'Activity' },
    { label: 'Profile' },
  ];

  @Builder
  BalanceCard() {
    Column({ space: 0 }) {
      Text('Total Balance')
        .fontSize(16)
        .fontWeight(FontWeight.Normal)
        .fontColor('#B3FFFFFF')
        .margin({ bottom: 8 })

      Text('$ 1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .margin({ bottom: 4 })

      Row({ space: 8 }) {
        Circle({ width: 10, height: 10 })
          .fill('#4ADE80')

        Text('+$234.10 today')
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor('#4ADE80')
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(24)
    .backgroundColor('#020617')
    .borderRadius(24)
    .shadow({ radius: 8, color: '#14000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  ControlActions() {
    Row() {
      ForEach(this.controlActions, (action: ControlAction) => {
        Column({ space: 8 }) {
          Button({ type: ButtonType.Circle }) {
            Column() {
              Rect({ width: 24, height: 24 })
                .fill('#020617')
                .borderRadius(8)
            }
            .width(24)
            .height(24)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
          .width(64)
          .height(64)
          .backgroundColor('#FFFFFF')
          .shadow({ radius: 3, color: '#0D000000', offsetX: 0, offsetY: 1 })

          Text(action.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#020617')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
  }

  @Builder
  RecentActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#020617')

      Text('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#64748B')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TransactionItem(transaction: Transaction) {
    Row({ space: 16 }) {
      Column() {}
      .width(48)
      .height(48)
      .backgroundColor('#F1F5F9')
      .borderRadius(16)

      Column({ space: 2 }) {
        Text(transaction.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#020617')

        Text(transaction.detail)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#64748B')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text(transaction.amount)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(transaction.isCredit ? '#22C55E' : '#020617')
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#E2E8F0' })
  }

  @Builder
  BottomNavBar() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: 4 }) {
          Column() {
            Circle({ width: 24, height: 24 })
              .fill(this.selectedNavItem === item.label ? '#020617' : '#E2E8F0')
          }
          .width(48)
          .height(48)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .borderRadius(24)
          .backgroundColor(this.selectedNavItem === item.label ? '#F1F5F9' : 'transparent')

          Text(item.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedNavItem === item.label ? '#020617' : '#64748B')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
        .onClick(() => {
          this.selectedNavItem = item.label;
        })
      })
    }
    .width('100%')
    .height(80)
    .padding({ left: 8, right: 8, bottom: 8 })
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 12, color: '#1A000000', offsetX: 0, offsetY: -4 })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Column() {}
        .width(28)
        .height(28)
        .backgroundColor('#F1F5F9')
        .borderRadius(14)

        Text('My Wallet')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#020617')

        Column() {}
        .width(28)
        .height(28)
        .backgroundColor('#F1F5F9')
        .borderRadius(14)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#F8FAFC')

      // Scrollable Content
      Scroll() {
        Column({ space: 24 }) {
          this.BalanceCard()
          this.ControlActions()
          this.RecentActivityHeader()

          ForEach(this.transactions, (transaction: Transaction) => {
            this.TransactionItem(transaction)
          })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor('#F8FAFC')

      // Bottom Navigation
      this.BottomNavBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}