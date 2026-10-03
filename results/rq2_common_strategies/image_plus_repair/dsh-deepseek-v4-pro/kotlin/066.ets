// ArkTS translation of 066.kt — Stock Calendar page (Retro Flat theme)

// ---- AppTokens: Colors ----
const COLOR_PRIMARY: string = '#214E34';
const COLOR_SECONDARY: string = '#2D6A4F';
const COLOR_TERTIARY: string = '#6C757D';
const COLOR_BACKGROUND: string = '#F8F1E5';
const COLOR_SURFACE: string = '#FFFBF0';
const COLOR_SURFACE_VARIANT: string = '#E9DFC7';
const COLOR_OUTLINE: string = '#D2C6AA';
const COLOR_SUCCESS: string = '#2B9348';
const COLOR_WARNING: string = '#F4A261';
const COLOR_ERROR: string = '#D62828';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_ON_SECONDARY: string = '#FFFFFF';
const COLOR_ON_TERTIARY: string = '#1B1F22';
const COLOR_ON_BACKGROUND: string = '#1B1F22';
const COLOR_ON_SURFACE: string = '#1B1F22';

// ---- AppTokens: Spacing ----
const SP_XS: number = 4;
const SP_SM: number = 8;
const SP_MD: number = 12;
const SP_LG: number = 16;
const SP_XL: number = 20;
const SP_XXL: number = 28;
const SP_XXXL: number = 40;

class DayTab {
  id: number;
  label: string;
  constructor(id: number, label: string) {
    this.id = id;
    this.label = label;
  }
}

class StockRow {
  code: string;
  name: string;
  price: string;
  change: string;
  positive: boolean;
  constructor(code: string, name: string, price: string, change: string, positive: boolean) {
    this.code = code;
    this.name = name;
    this.price = price;
    this.change = change;
    this.positive = positive;
  }
}

@Entry
@Component
struct StockCalendarPage {
  @State selected: number = 1;
  @State current: string = 'All';

  private days: DayTab[] = [
    new DayTab(1, 'Mon'),
    new DayTab(2, 'Tue'),
    new DayTab(3, 'Wed'),
    new DayTab(4, 'Thu'),
    new DayTab(5, 'Fri')
  ];

  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance'];

  private items: StockRow[] = [
    new StockRow('600519', 'Kweichow Moutai', '1687.3', '+1.24%', true),
    new StockRow('000001', 'Ping An Bank', '12.54', '-0.62%', false),
    new StockRow('300750', 'CATL', '192.8', '+0.87%', true),
    new StockRow('601318', 'Ping An Ins.', '44.2', '-1.12%', false),
    new StockRow('600036', 'CMBC', '36.9', '+0.15%', true),
    new StockRow('688981', 'SMIC', '56.4', '-0.48%', false)
  ];

  build() {
    Column() {
      // Top app bar
      Row() {
        Text('Stock Calendar')
          .fontSize(26)
          .fontWeight(600)
          .lineHeight(32)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_SURFACE)

      // Content
      Column({ space: SP_MD }) {
        // Filter card (day tabs + sector chips)
        Column({ space: SP_SM }) {
          // Day tabs
          Row({ space: SP_SM }) {
            ForEach(this.days, (d: DayTab) => {
              Row() {
                Text(d.label)
                  .fontSize(d.id === this.selected ? 16 : 13)
                  .fontWeight(500)
                  .fontColor(d.id === this.selected ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
              }
              .layoutWeight(1)
              .height(36)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
              .backgroundColor(d.id === this.selected ? COLOR_PRIMARY : COLOR_SURFACE_VARIANT)
              .borderRadius(6)
            }, (d: DayTab) => d.id.toString())
          }
          .width('100%')

          // Sector chips
          Row({ space: SP_SM }) {
            ForEach(this.sectors, (s: string) => {
              Text(s)
                .fontSize(11)
                .fontWeight(500)
                .lineHeight(14)
                .fontColor(this.current === s ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
                .backgroundColor(this.current === s ? COLOR_SECONDARY : COLOR_SURFACE)
                .borderRadius(6)
                .border({ width: 1, color: COLOR_OUTLINE })
                .padding({ left: SP_MD, right: SP_MD, top: 6, bottom: 6 })
                .onClick(() => {
                  this.current = s;
                })
            }, (s: string) => s)
          }
          .width('100%')
        }
        .width('100%')
        .padding(SP_MD)
        .backgroundColor(COLOR_SURFACE)
        .borderRadius(14)
        .border({ width: 1, color: COLOR_OUTLINE })

        // Stock list
        List({ space: SP_SM }) {
          ForEach(this.items, (itx: StockRow) => {
            ListItem() {
              Row() {
                // Left: avatar placeholder + name/code
                Row({ space: SP_MD }) {
                  Row()
                    .width(28)
                    .height(28)
                    .backgroundColor(COLOR_SURFACE_VARIANT)
                    .borderRadius(6)
                  Column({ space: SP_XS }) {
                    Text(itx.name)
                      .fontSize(16)
                      .fontWeight(500)
                      .lineHeight(20)
                      .fontColor(COLOR_ON_SURFACE)
                    Text(itx.code)
                      .fontSize(11)
                      .fontWeight(500)
                      .lineHeight(14)
                      .fontColor(COLOR_ON_SURFACE)
                  }
                }
                .alignItems(VerticalAlign.Center)

                // Right: price + detail button
                Row({ space: SP_LG }) {
                  Column() {
                    Text(itx.price)
                      .fontSize(16)
                      .fontWeight(500)
                      .lineHeight(20)
                      .fontColor(COLOR_ON_SURFACE)
                    Row({ space: SP_XS }) {
                      Row()
                        .width(8)
                        .height(8)
                        .backgroundColor(itx.positive ? COLOR_SUCCESS : COLOR_ERROR)
                        .borderRadius(6)
                      Text(itx.change)
                        .fontSize(11)
                        .fontWeight(500)
                        .lineHeight(14)
                        .fontColor(itx.positive ? COLOR_SUCCESS : COLOR_ERROR)
                    }
                    .alignItems(VerticalAlign.Center)
                  }
                  .alignItems(HorizontalAlign.End)

                  Button('Detail')
                    .type(ButtonType.Normal)
                    .height(36)
                    .width(76)
                    .fontSize(11)
                    .fontColor(COLOR_ON_PRIMARY)
                    .backgroundColor(COLOR_PRIMARY)
                    .borderRadius(6)
                    .onClick(() => {
                    })
                }
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .padding(SP_MD)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }
            .constraintSize({ minHeight: 72 })
            .backgroundColor(COLOR_SURFACE)
            .borderRadius(10)
            .border({ width: 1, color: COLOR_OUTLINE })
          }, (itx: StockRow) => itx.code)
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: SP_XXXL })
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: SP_LG, right: SP_LG, top: SP_MD, bottom: SP_MD })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}
