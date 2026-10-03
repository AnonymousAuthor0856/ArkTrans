interface ColorPalette {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
}

const COLORS: ColorPalette = {
  primary: '#020617',
  secondary: '#4ADE80',
  tertiary: '#64748B',
  background: '#F8FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#F1F5F9',
  outline: '#E2E8F0',
  success: '#22C55E'
};

interface Transaction {
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;
}

@Entry
@Component
struct WalletApp {
  @State selectedNav: number = 0;

  private transactions: Transaction[] = [
    { name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
  ];

  private navItems: string[] = ['Home', 'Cards', 'Activity', 'Profile'];
  private actionItems: string[] = ['Send', 'Receive', 'Add', 'More'];

  build() {
    Column() {
      this.header()

      Scroll() {
        Column({ space: 24 }) {
          this.balanceCard()
          this.actionRow()
          this.activityHeader()

          ForEach(this.transactions, (transaction: Transaction) => {
            this.transactionCard(transaction)
          }, (transaction: Transaction) => transaction.name)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 28 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      this.bottomNavigation()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }

  @Builder
  header() {
    Row() {
      Row()
        .width(28)
        .height(28)
        .borderRadius(14)
        .backgroundColor(COLORS.surfaceVariant)

      Text('My Wallet')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.primary)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Row()
        .width(28)
        .height(28)
        .borderRadius(14)
        .backgroundColor(COLORS.surfaceVariant)
    }
    .width('100%')
    .height(80)
    .padding({ left: 28, right: 28, top: 12, bottom: 8 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  balanceCard() {
    Column() {
      Text('Total Balance')
        .fontSize(16)
        .fontColor('#B8BBC4')
        .width('100%')
        .textAlign(TextAlign.Start)

      Text('$ 1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.surface)
        .margin({ top: 8 })
        .width('100%')
        .textAlign(TextAlign.Start)

      Row() {
        Row()
          .width(10)
          .height(10)
          .borderRadius(5)
          .backgroundColor(COLORS.secondary)

        Text('+$234.10 today')
          .fontSize(16)
          .fontColor(COLORS.secondary)
          .margin({ left: 8 })
      }
      .margin({ top: 8 })
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height(154)
    .padding(24)
    .borderRadius(24)
    .backgroundColor(COLORS.primary)
    .shadow({
      radius: 8,
      color: '#18000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  actionRow() {
    Row({ space: 12 }) {
      ForEach(this.actionItems, (label: string) => {
        Column() {
          Button() {
            Row()
              .width(24)
              .height(24)
              .borderRadius(8)
              .backgroundColor(COLORS.primary)
          }
          .width(64)
          .height(64)
          .padding(0)
          .backgroundColor(COLORS.surface)
          .borderRadius(32)
          .shadow({
            radius: 3,
            color: '#12000000',
            offsetX: 0,
            offsetY: 1
          })

          Text(label)
            .fontSize(16)
            .fontColor(COLORS.primary)
            .margin({ top: 8 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  activityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.primary)

      Text('View All')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.tertiary)
        .layoutWeight(1)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .height(32)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  transactionCard(transaction: Transaction) {
    Row() {
      Row()
        .width(48)
        .height(48)
        .borderRadius(16)
        .backgroundColor(COLORS.surfaceVariant)

      Column() {
        Text(transaction.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.primary)

        Text(transaction.detail)
          .fontSize(14)
          .fontColor(COLORS.tertiary)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)

      Text(transaction.amount)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(transaction.isCredit ? COLORS.success : COLORS.primary)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .height(80)
    .padding(16)
    .borderRadius(16)
    .backgroundColor(COLORS.surface)
    .border({
      width: 1,
      color: COLORS.outline
    })
  }

  @Builder
  bottomNavigation() {
    Row() {
      ForEach(this.navItems, (label: string, index: number) => {
        Column() {
          Stack() {
            Row()
              .width(64)
              .height(32)
              .borderRadius(20)
              .backgroundColor(index === this.selectedNav ? COLORS.surfaceVariant : COLORS.surface)

            Row()
              .width(24)
              .height(24)
              .borderRadius(12)
              .backgroundColor(index === this.selectedNav ? COLORS.primary : COLORS.outline)
          }
          .width(64)
          .height(32)

          Text(label)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(index === this.selectedNav ? COLORS.primary : COLORS.tertiary)
            .margin({ top: 8 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.selectedNav = index;
        })
      })
    }
    .width('100%')
    .height(78)
    .padding({ left: 8, right: 8, top: 10, bottom: 8 })
    .backgroundColor(COLORS.surface)
    .shadow({
      radius: 12,
      color: '#18000000',
      offsetX: 0,
      offsetY: -2
    })
  }
}
