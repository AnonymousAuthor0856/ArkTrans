interface Transaction {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;
}

interface ActionItem {
  label: string;
}

interface NavigationItem {
  label: string;
}

const PRIMARY: string = '#020617';
const SECONDARY: string = '#4ADE80';
const TERTIARY: string = '#64748B';
const BACKGROUND: string = '#F8FAFC';
const SURFACE: string = '#FFFFFF';
const SURFACE_VARIANT: string = '#F1F5F9';
const OUTLINE: string = '#E2E8F0';
const SUCCESS: string = '#22C55E';

@Entry
@Component
struct WalletPage {
  @State private selectedNavItem: string = 'Home';

  private readonly transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
  ];

  private readonly actions: ActionItem[] = [
    { label: 'Send' },
    { label: 'Receive' },
    { label: 'Add' },
    { label: 'More' }
  ];

  private readonly navigationItems: NavigationItem[] = [
    { label: 'Home' },
    { label: 'Cards' },
    { label: 'Activity' },
    { label: 'Profile' }
  ];

  build() {
    Column({ space: 0 }) {
      this.topBar();

      Scroll() {
        Column({ space: 24 }) {
          this.balanceCard();
          this.actionRow();
          this.activityHeader();

          ForEach(this.transactions, (transaction: Transaction) => {
            this.transactionCard(transaction);
          }, (transaction: Transaction) => transaction.id.toString());
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 16 });
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring);

      this.bottomNavigation();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND);
  }

  @Builder
  private topBar() {
    Row() {
      Circle()
        .width(28)
        .height(28)
        .fill(SURFACE_VARIANT)
        .onClick(() => {});

      Text('My Wallet')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(PRIMARY)
        .textAlign(TextAlign.Center)
        .layoutWeight(1);

      Circle()
        .width(28)
        .height(28)
        .fill(SURFACE_VARIANT)
        .onClick(() => {});
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  private balanceCard() {
    Column() {
      Text('Total Balance')
        .fontSize(16)
        .fontColor('#B8BBC4')
        .width('100%')
        .textAlign(TextAlign.Start);

      Text('$ 1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(SURFACE)
        .width('100%')
        .margin({ top: 8 })
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Clip });

      Row({ space: 8 }) {
        Circle()
          .width(10)
          .height(10)
          .fill(SECONDARY);

        Text('+$234.10 today')
          .fontSize(16)
          .fontColor(SECONDARY);
      }
      .margin({ top: 4 })
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .height(156)
    .padding({ left: 24, right: 24, top: 48, bottom: 24 })
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(PRIMARY)
    .borderRadius(54)
    .shadow({
      radius: 8,
      color: '#14000000',
      offsetX: 0,
      offsetY: 2
    });
  }

  @Builder
  private actionRow() {
    Row() {
      ForEach(this.actions, (item: ActionItem) => {
        Column({ space: 8 }) {
          Stack({ alignContent: Alignment.Center }) {
            Circle()
              .width(64)
              .height(64)
              .fill(SURFACE)
              .shadow({
                radius: 4,
                color: '#0D000000',
                offsetX: 0,
                offsetY: 1
              });

            Column()
              .width(24)
              .height(24)
              .backgroundColor(PRIMARY)
              .borderRadius(15);
          }
          .width(64)
          .height(64)
          .onClick(() => {});

          Text(item.label)
            .fontSize(16)
            .fontColor(PRIMARY)
            .fontWeight(FontWeight.Medium);
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center);
      }, (item: ActionItem) => item.label);
    }
    .width('100%')
    .height(96)
    .alignItems(VerticalAlign.Top);
  }

  @Builder
  private activityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor(PRIMARY);

      Text('View All')
        .fontSize(16)
        .fontColor(TERTIARY)
        .margin({ right: 2 })
        .onClick(() => {});
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  private transactionCard(transaction: Transaction) {
    Row({ space: 16 }) {
      Column()
        .width(48)
        .height(48)
        .backgroundColor(SURFACE_VARIANT)
        .borderRadius(20);

      Column({ space: 2 }) {
        Text(transaction.name)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(PRIMARY)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis });

        Text(transaction.detail)
          .fontSize(16)
          .fontColor(TERTIARY)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis });
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start);

      Text(transaction.amount)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(transaction.isCredit ? SUCCESS : PRIMARY)
        .textAlign(TextAlign.End)
        .maxLines(1);
    }
    .width('100%')
    .height(80)
    .padding(16)
    .backgroundColor(SURFACE)
    .borderRadius(20)
    .border({ width: 1, color: OUTLINE })
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  private bottomNavigation() {
    Row() {
      ForEach(this.navigationItems, (item: NavigationItem) => {
        Button() {
          Column({ space: 4 }) {
            Circle()
              .width(24)
              .height(24)
              .fill(this.selectedNavItem === item.label ? PRIMARY : OUTLINE);

            Text(item.label)
              .fontSize(16)
              .fontWeight(this.selectedNavItem === item.label ? FontWeight.Medium : FontWeight.Regular)
              .fontColor(this.selectedNavItem === item.label ? PRIMARY : TERTIARY);
          }
          .width('100%')
          .height(72)
          .padding({ top: 8, bottom: 8 })
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center);
        }
        .layoutWeight(1)
        .height(80)
        .padding(0)
        .backgroundColor(this.selectedNavItem === item.label ? SURFACE_VARIANT : SURFACE)
        .borderRadius(24)
        .fontSize(1)
        .onClick(() => {
          this.selectedNavItem = item.label;
        });
      }, (item: NavigationItem) => item.label);
    }
    .width('100%')
    .height(80)
    .padding({ left: 4, right: 4, top: 8, bottom: 8 })
    .backgroundColor(SURFACE)
    .shadow({
      radius: 12,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -4
    });
  }
}
