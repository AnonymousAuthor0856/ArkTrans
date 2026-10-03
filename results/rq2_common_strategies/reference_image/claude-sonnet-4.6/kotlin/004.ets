// Index.ets — HarmonyOS ArkTS conversion of the Compose "Finance Wallet" screen.
// Renders at 360x640vp: top bar (accent square + "Wallet"), a scrollable body with
// range chips + Hide switch, three account cards (accent square, name, Manage chip,
// balance panel at 2.8:1, Transfer/Details chips), a "Recent Activity" header with
// Income/Expense chips, a transaction list, and a pinned bottom bar with the total
// balance and a green "Add Money" button.

const COLOR_PRIMARY: string = '#1F2937';
const COLOR_SECONDARY: string = '#10B981';
const COLOR_TERTIARY: string = '#3B82F6';
const COLOR_BACKGROUND: string = '#F3F4F6';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#E5E7EB';
const COLOR_OUTLINE: string = '#D1D5DB';
const COLOR_SUCCESS: string = '#16A34A';
const COLOR_WARNING: string = '#F59E0B';
const COLOR_ERROR: string = '#EF4444';
const COLOR_ON_SECONDARY: string = '#0B1220';
const COLOR_ON_SURFACE: string = '#0B1220';

const FONT_DISPLAY: number = 24;   // SemiBold / line 30
const FONT_HEADLINE: number = 18;  // SemiBold / line 24
const FONT_TITLE: number = 14;     // Medium   / line 18
const FONT_BODY: number = 12;      // Normal   / line 16
const FONT_LABEL: number = 10;     // Medium   / line 14

const SPACE_XS: number = 2;
const SPACE_SM: number = 4;
const SPACE_MD: number = 6;
const SPACE_LG: number = 8;
const SPACE_XL: number = 12;
const SPACE_XXL: number = 16;
const SPACE_XXXL: number = 24;

const RADIUS_SMALL: number = 6;
const RADIUS_MEDIUM: number = 8;
const RADIUS_LARGE: number = 12;

const SHADOW_LEVEL_1: ShadowOptions = { radius: 2, color: '#1F000000', offsetX: 0, offsetY: 1 };
const SHADOW_LEVEL_2: ShadowOptions = { radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 };
const SHADOW_LEVEL_3: ShadowOptions = { radius: 6, color: '#29000000', offsetX: 0, offsetY: 1.5 };

const CARD_MIN_HEIGHT: number = 120;
const TX_MIN_HEIGHT: number = 72;

interface AccountCard {
  id: number;
  name: string;
  balance: string;
  accent: string;
}

interface TxItem {
  id: number;
  title: string;
  subtitle: string;
  amount: string;
  positive: boolean;
}

@Entry
@Component
struct Index {
  @State showBalance: boolean = true;
  @State selectedRange: string = 'Month';
  @State flags: string[] = [];

  private ranges: string[] = ['All', 'Week', 'Month', 'Year'];

  private accounts: AccountCard[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: COLOR_SECONDARY },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: COLOR_TERTIARY },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: COLOR_WARNING }
  ];

  private txs: TxItem[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ];

  private isFlagged(tag: string): boolean {
    return this.flags.indexOf(tag) >= 0;
  }

  private toggleFlag(tag: string): void {
    const index: number = this.flags.indexOf(tag);
    if (index >= 0) {
      this.flags.splice(index, 1);
    } else {
      this.flags.push(tag);
    }
  }

  // Pill used for "Manage", "Transfer", "Details", "Income", "Expense".
  @Builder
  chip(containerColor: string, contentColor: string, label: string) {
    Text(label)
      .fontSize(FONT_LABEL)
      .fontWeight(FontWeight.Medium)
      .fontColor(contentColor)
      .padding({ left: 10, right: 10, top: 6, bottom: 6 })
      .backgroundColor(containerColor)
      .borderRadius(RADIUS_SMALL)
      .border({ width: 1, color: COLOR_OUTLINE })
  }

  build() {
    Column() {
      // ================= Top app bar =================
      Row() {
        Row()
          .width(20)
          .height(20)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(RADIUS_SMALL)

        Text('Wallet')
          .fontSize(FONT_DISPLAY)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
          .margin({ left: SPACE_SM })
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_SURFACE)
      .border({ width: { bottom: 1 }, color: COLOR_SURFACE_VARIANT })

      // ================= Scrollable body =================
      Scroll() {
        Column() {
          // ----- Range chips + Hide switch -----
          Row() {
            Row() {
              ForEach(this.ranges, (range: string) => {
                Text(range)
                  .fontSize(this.selectedRange === range ? FONT_TITLE : FONT_BODY)
                  .fontWeight(this.selectedRange === range ? FontWeight.Medium : FontWeight.Normal)
                  .fontColor(this.selectedRange === range ? COLOR_SURFACE : COLOR_ON_SURFACE)
                  .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                  .backgroundColor(this.selectedRange === range ? COLOR_PRIMARY : COLOR_SURFACE)
                  .borderRadius(RADIUS_MEDIUM)
                  .border({ width: 1, color: COLOR_OUTLINE })
                  .margin({ right: SPACE_SM })
                  .onClick(() => {
                    this.selectedRange = range;
                  })
              }, (range: string) => range)
            }
            .layoutWeight(1)
            .alignItems(VerticalAlign.Center)

            Row() {
              Text('Hide')
                .fontSize(FONT_LABEL)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE)

              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .selectedColor(COLOR_PRIMARY)
                .margin({ left: SPACE_SM })
                .onChange((isOn: boolean) => {
                  this.showBalance = !isOn;
                })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: SPACE_LG })

          // ----- Account cards -----
          ForEach(this.accounts, (account: AccountCard) => {
            Column() {
              Row() {
                Row() {
                  Row()
                    .width(16)
                    .height(16)
                    .backgroundColor(account.accent)
                    .borderRadius(RADIUS_SMALL)

                  Text(account.name)
                    .fontSize(FONT_TITLE)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(COLOR_ON_SURFACE)
                    .margin({ left: SPACE_SM })
                }
                .layoutWeight(1)
                .alignItems(VerticalAlign.Center)

                this.chip(COLOR_SECONDARY, COLOR_ON_SECONDARY, 'Manage')
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              // Balance panel, 2.8:1
              Row() {
                Text(this.showBalance ? account.balance : '•••••••')
                  .fontSize(FONT_HEADLINE)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(COLOR_ON_SURFACE)
              }
              .width('100%')
              .aspectRatio(2.8)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
              .backgroundColor(COLOR_SURFACE_VARIANT)
              .borderRadius(RADIUS_MEDIUM)
              .margin({ top: SPACE_SM })

              Row() {
                this.chip(COLOR_SECONDARY, COLOR_ON_SECONDARY, 'Transfer')
                Blank().width(SPACE_SM)
                this.chip(COLOR_SURFACE, COLOR_ON_SURFACE, 'Details')
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
              .margin({ top: SPACE_SM })
            }
            .width('100%')
            .constraintSize({ minHeight: CARD_MIN_HEIGHT })
            .padding(SPACE_LG)
            .backgroundColor(COLOR_SURFACE)
            .borderRadius(RADIUS_LARGE)
            .border({ width: 1, color: COLOR_OUTLINE })
            .shadow(SHADOW_LEVEL_2)
            .margin({ bottom: SPACE_LG })
          }, (account: AccountCard) => account.id.toString())

          // ----- Recent Activity header + filters -----
          Row() {
            Text('Recent Activity')
              .fontSize(FONT_HEADLINE)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLOR_ON_SURFACE)
              .layoutWeight(1)

            Row() {
              Text('Income')
                .fontSize(FONT_LABEL)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.isFlagged('Income') ? COLOR_ON_SECONDARY : COLOR_ON_SURFACE)
                .padding({ left: 10, right: 10, top: 6, bottom: 6 })
                .backgroundColor(this.isFlagged('Income') ? COLOR_SECONDARY : COLOR_SURFACE)
                .borderRadius(RADIUS_SMALL)
                .border({ width: 1, color: COLOR_OUTLINE })
                .margin({ right: SPACE_SM })
                .onClick(() => {
                  this.toggleFlag('Income');
                })

              Text('Expense')
                .fontSize(FONT_LABEL)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.isFlagged('Expense') ? COLOR_ON_SECONDARY : COLOR_ON_SURFACE)
                .padding({ left: 10, right: 10, top: 6, bottom: 6 })
                .backgroundColor(this.isFlagged('Expense') ? COLOR_SECONDARY : COLOR_SURFACE)
                .borderRadius(RADIUS_SMALL)
                .border({ width: 1, color: COLOR_OUTLINE })
                .onClick(() => {
                  this.toggleFlag('Expense');
                })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: SPACE_LG })

          // ----- Transaction rows -----
          ForEach(this.txs, (tx: TxItem) => {
            Row() {
              Row() {
                Row()
                  .width(32)
                  .height(32)
                  .backgroundColor(tx.positive ? COLOR_SUCCESS : COLOR_ERROR)
                  .borderRadius(RADIUS_SMALL)

                Column() {
                  Text(tx.title)
                    .fontSize(FONT_TITLE)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(COLOR_ON_SURFACE)

                  Text(tx.subtitle)
                    .fontSize(FONT_BODY)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(COLOR_ON_SURFACE)
                    .margin({ top: SPACE_XS })
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ left: SPACE_MD })
              }
              .layoutWeight(1)
              .alignItems(VerticalAlign.Center)

              Text(tx.amount)
                .fontSize(FONT_TITLE)
                .fontWeight(FontWeight.Medium)
                .fontColor(tx.positive ? COLOR_SUCCESS : COLOR_ERROR)
            }
            .width('100%')
            .constraintSize({ minHeight: TX_MIN_HEIGHT })
            .padding(SPACE_LG)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(COLOR_SURFACE)
            .borderRadius(RADIUS_LARGE)
            .border({ width: 1, color: COLOR_OUTLINE })
            .shadow(SHADOW_LEVEL_1)
            .margin({ bottom: SPACE_LG })
          }, (tx: TxItem) => tx.id.toString())

          Row().width('100%').height(SPACE_XXL)
        }
        .width('100%')
        .padding({ left: SPACE_LG, right: SPACE_LG, top: SPACE_MD, bottom: SPACE_XXXL })
      }
      .width('100%')
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      // ================= Bottom bar =================
      Row() {
        Column() {
          Text('Total Balance')
            .fontSize(FONT_LABEL)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)

          Text(this.showBalance ? '$26,395.75' : '•••••••')
            .fontSize(FONT_HEADLINE)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_SURFACE)
            .margin({ top: SPACE_XS })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Button('Add Money')
          .type(ButtonType.Normal)
          .width(140)
          .height(44)
          .fontSize(FONT_TITLE)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SECONDARY)
          .backgroundColor(COLOR_SECONDARY)
          .borderRadius(RADIUS_LARGE)
          .onClick(() => {
          })
      }
      .width('100%')
      .padding({ left: SPACE_LG, right: SPACE_LG, top: SPACE_MD, bottom: SPACE_MD })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_SURFACE)
      .shadow(SHADOW_LEVEL_3)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}