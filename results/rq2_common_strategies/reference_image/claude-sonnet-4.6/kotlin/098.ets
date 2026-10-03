// ─────────────────────────────────────────────────────────────
// entry/src/main/ets/pages/Index.ets
// ─────────────────────────────────────────────────────────────

// ---------- Theme tokens ----------
const PRIMARY_BLACK: string = '#121212';
const TEXT_GREY: string = '#757575';
const PURE_WHITE: string = '#FFFFFF';
const CARD_BG: string = '#F9F9F9';
const CARD_BORDER: string = '#EEEEEE';
const BADGE_BORDER: string = '#E0E0E0';
const PROMO_BG: string = '#F0F0F0';
const DOT_GREY: string = '#9E9E9E';

// ---------- Data model (pure UI mock data) ----------
interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: string;
}

const SAMPLE_TEAS: TeaGuide[] = [
  { id: 1, name: 'Sencha Green', origin: 'Japan', temp: '70°C / 158°F', time: '1-2 min', colorCode: '#8BC34A' },
  { id: 2, name: 'Earl Grey', origin: 'Blend', temp: '95°C / 203°F', time: '3-5 min', colorCode: '#795548' },
  { id: 3, name: 'Silver Needle', origin: 'China', temp: '80°C / 176°F', time: '3-4 min', colorCode: '#E0E0E0' },
  { id: 4, name: 'Darjeeling', origin: 'India', temp: '90°C / 194°F', time: '3 min', colorCode: '#D7CCC8' },
  { id: 5, name: 'Chamomile', origin: 'Egypt', temp: '100°C / 212°F', time: '5-7 min', colorCode: '#FFEB3B' },
  { id: 6, name: 'Matcha', origin: 'Japan', temp: '80°C / 176°F', time: 'Whisk', colorCode: '#4CAF50' },
  { id: 7, name: 'Oolong', origin: 'Taiwan', temp: '85°C / 185°F', time: '3-5 min', colorCode: '#FF9800' }
];

// Equivalent of Color.copy(alpha = 0.3f) — 8-digit AARRGGBB
function withAlpha(hex: string, alphaHex: string): string {
  const body: string = hex.length === 9 ? hex.substring(3) : hex.substring(1);
  return '#' + alphaHex + body;
}

@Entry
@Component
struct Index {
  @State teas: TeaGuide[] = SAMPLE_TEAS;

  // ---------- Top app bar ----------
  @Builder
  TopBar() {
    Row() {
      Column() {
        Text('ZenBrew')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY_BLACK)
          .letterSpacing(-0.5)
        Text('Mindful Steeping Guide')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(TEXT_GREY)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text('⚙')
        .fontSize(24)
        .fontColor(PRIMARY_BLACK)
        .width(48)
        .height(48)
        .textAlign(TextAlign.Center)
        .onClick(() => {
          // Open settings
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({ left: 20, right: 20, top: 16, bottom: 12 })
  }

  // ---------- Tip of the day card ----------
  @Builder
  PromoCard() {
    Row() {
      Column() {
        Text('Tip of the day')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(DOT_GREY)
          .margin({ bottom: 4 })
        Text('Use filtered water for a purer taste profile.')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(PRIMARY_BLACK)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Text('i')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(PURE_WHITE)
      }
      .width(48)
      .height(48)
      .backgroundColor(DOT_GREY)
      .borderRadius(24)
      .margin({ left: 16 })
    }
    .width('100%')
    .padding(24)
    .backgroundColor(PROMO_BG)
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }

  // ---------- Small info chip ----------
  @Builder
  InfoBadge(label: string, leftMargin: number) {
    Text(label)
      .fontSize(11)
      .fontColor('#000000')
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(PURE_WHITE)
      .borderRadius(6)
      .border({ width: 1, color: BADGE_BORDER })
      .margin({ left: leftMargin })
  }

  // ---------- Tea row card ----------
  @Builder
  TeaItemCard(tea: TeaGuide) {
    Row() {
      // Visual dot identifier
      Stack() {
        Text(tea.name.substring(0, 1))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(tea.colorCode)
      }
      .width(50)
      .height(50)
      .backgroundColor(PURE_WHITE)
      .borderRadius(25)
      .border({ width: 2, color: withAlpha(tea.colorCode, '4D') })
      .margin({ right: 16 })

      Column() {
        Text(tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY_BLACK)
        Text(tea.origin)
          .fontSize(12)
          .fontColor(TEXT_GREY)
          .margin({ top: 2 })

        Row() {
          this.InfoBadge(tea.temp, 0)
          this.InfoBadge(tea.time, 8)
        }
        .margin({ top: 6 })
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Start timer
      Stack() {
        Text('▶')
          .fontSize(14)
          .fontColor(PRIMARY_BLACK)
      }
      .width(40)
      .height(40)
      .backgroundColor(PURE_WHITE)
      .borderRadius(20)
      .border({ width: 1, color: BADGE_BORDER })
      .margin({ left: 8 })
      .onClick(() => {
        // Start steeping timer
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(CARD_BG)
    .borderRadius(16)
    .border({ width: 1, color: CARD_BORDER })
    .alignItems(VerticalAlign.Center)
  }

  // ---------- Root ----------
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()

        List({ space: 16 }) {
          ListItem() {
            this.PromoCard()
          }

          ListItem() {
            Text('Collections')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(PRIMARY_BLACK)
              .margin({ top: 8 })
          }

          ForEach(this.teas, (tea: TeaGuide) => {
            ListItem() {
              this.TeaItemCard(tea)
            }
          }, (tea: TeaGuide) => tea.id.toString())

          // Extra spacer so the FAB never covers the last row
          ListItem() {
            Text('').height(80)
          }
        }
        .layoutWeight(1)
        .width('100%')
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // Floating "Custom Brew" button
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Row() {
          Text('+')
            .fontSize(22)
            .fontColor(PURE_WHITE)
          Text('Custom Brew')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(PURE_WHITE)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
      }
      .height(56)
      .borderRadius(16)
      .backgroundColor(PRIMARY_BLACK)
      .padding({ left: 20, right: 20 })
      .margin({ right: 20, bottom: 28 })
      .onClick(() => {
        // Open custom brew timer
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PURE_WHITE)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}