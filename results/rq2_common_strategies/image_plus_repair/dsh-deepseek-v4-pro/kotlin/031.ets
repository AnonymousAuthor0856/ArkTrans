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

const COLOR_PRIMARY = '#020617';
const COLOR_SECONDARY = '#4ADE80';
const COLOR_TERTIARY = '#64748B';
const COLOR_BACKGROUND = '#F8FAFC';
const COLOR_SURFACE = '#FFFFFF';
const COLOR_SURFACE_VARIANT = '#F1F5F9';
const COLOR_OUTLINE = '#E2E8F0';
const COLOR_SUCCESS = '#22C55E';
const COLOR_WARNING = '#F59E0B';
const COLOR_ERROR = '#EF4444';
const COLOR_ON_PRIMARY = '#FFFFFF';
const COLOR_ON_SECONDARY = '#020617';
const COLOR_ON_TERTIARY = '#FFFFFF';
const COLOR_ON_BACKGROUND = '#020617';
const COLOR_ON_SURFACE = '#020617';

const SP_XS = 4;
const SP_SM = 8;
const SP_MD = 16;
const SP_LG = 24;
const SP_XL = 32;
const SP_XXL = 48;

const SHAPE_SMALL = 8;
const SHAPE_MEDIUM = 16;
const SHAPE_LARGE = 24;

@Entry
@Component
struct WalletDashFinancePage {
  @State selectedNavItem: string = 'Home';

  private transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
  ];

  private controlActions: ControlAction[] = [
    { label: 'Send' },
    { label: 'Receive' },
    { label: 'Add' },
    { label: 'More' }
  ];

  private navItems: NavItem[] = [
    { label: 'Home' },
    { label: 'Cards' },
    { label: 'Activity' },
    { label: 'Profile' }
  ];

  @Builder
  TransactionRow(tx: Transaction) {
    Row() {
      Row()
        .width(48)
        .height(48)
        .backgroundColor(COLOR_SURFACE_VARIANT)
        .borderRadius(SHAPE_MEDIUM)
      Column() {
        Text(tx.name)
          .fontSize(16)
          .fontWeight(600)
          .fontColor(COLOR_ON_SURFACE)
        Text(tx.detail)
          .fontSize(12)
          .fontWeight(500)
          .fontColor(COLOR_TERTIARY)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: SP_MD })
      Text(tx.amount)
        .fontSize(16)
        .fontWeight(600)
        .textAlign(TextAlign.End)
        .fontColor(tx.isCredit ? COLOR_SUCCESS : COLOR_ON_SURFACE)
    }
    .width('100%')
    .padding(SP_MD)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(SHAPE_MEDIUM)
    .border({ width: 1, color: COLOR_OUTLINE })
    .margin({ top: SP_LG })
  }

  build() {
    Column() {
      // Top bar
      Row() {
        Row()
          .width(28)
          .height(28)
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .borderRadius(14)
        Text('My Wallet')
          .fontSize(20)
          .fontWeight(500)
          .fontColor(COLOR_ON_SURFACE)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Row()
          .width(28)
          .height(28)
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .borderRadius(14)
      }
      .width('100%')
      .padding({ left: SP_MD, right: SP_MD, top: SP_SM, bottom: SP_SM })

      // Scrollable content
      Scroll() {
        Column() {
          // Balance card
          Column() {
            Text('Total Balance')
              .fontSize(16)
              .fontWeight(400)
              .fontColor('#B2FFFFFF')
            Text('$ 1,145.14')
              .fontSize(48)
              .fontWeight(700)
              .lineHeight(56)
              .fontColor(COLOR_ON_PRIMARY)
              .margin({ top: SP_SM })
            Row() {
              Row()
                .width(10)
                .height(10)
                .borderRadius(5)
                .backgroundColor(COLOR_SECONDARY)
              Text('+$234.10 today')
                .fontSize(16)
                .fontWeight(400)
                .fontColor(COLOR_SECONDARY)
                .margin({ left: SP_SM })
            }
            .alignItems(VerticalAlign.Center)
            .margin({ top: SP_XS })
          }
          .width('100%')
          .padding(SP_LG)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(SHAPE_LARGE)
          .shadow({ radius: 8, color: '#14020617', offsetY: 2 })

          // Control actions row
          Row() {
            ForEach(this.controlActions, (action: ControlAction) => {
              Column() {
                Button() {
                  Row()
                    .width(24)
                    .height(24)
                    .backgroundColor(COLOR_PRIMARY)
                    .borderRadius(SHAPE_SMALL)
                }
                .width(64)
                .height(64)
                .borderRadius(32)
                .backgroundColor(COLOR_SURFACE)
                .shadow({ radius: 3, color: '#0D020617', offsetY: 1 })
                .onClick(() => {})
                Text(action.label)
                  .fontSize(12)
                  .fontWeight(500)
                  .fontColor(COLOR_ON_SURFACE)
                  .margin({ top: SP_SM })
              }
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
            }, (action: ControlAction) => action.label)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)
          .alignItems(VerticalAlign.Center)
          .margin({ top: SP_LG })

          // Recent Activity header
          Row() {
            Text('Recent Activity')
              .fontSize(20)
              .fontWeight(500)
              .fontColor(COLOR_ON_SURFACE)
            Text('View All')
              .fontSize(12)
              .fontWeight(500)
              .fontColor(COLOR_TERTIARY)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: SP_LG })

          // Transaction list
          ForEach(this.transactions, (tx: Transaction) => {
            this.TransactionRow(tx)
          }, (tx: Transaction) => tx.id.toString())
        }
        .width('100%')
        .padding({ left: SP_MD, right: SP_MD, top: SP_SM, bottom: SP_SM })
      }
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollable(ScrollDirection.Vertical)
      .width('100%')

      // Bottom navigation bar
      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          Column() {
            Row()
              .width(24)
              .height(24)
              .borderRadius(12)
              .backgroundColor(this.selectedNavItem === item.label ? COLOR_PRIMARY : COLOR_OUTLINE)
            Text(item.label)
              .fontSize(12)
              .fontWeight(500)
              .fontColor(this.selectedNavItem === item.label ? COLOR_PRIMARY : COLOR_TERTIARY)
              .margin({ top: SP_XS })
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.selectedNavItem = item.label;
          })
        }, (item: NavItem) => item.label)
      }
      .width('100%')
      .padding({ top: SP_SM, bottom: SP_SM })
      .backgroundColor(COLOR_SURFACE)
      .shadow({ radius: 12, color: '#1A020617', offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}
