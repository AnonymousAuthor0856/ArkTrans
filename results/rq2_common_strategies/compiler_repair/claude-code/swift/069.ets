// SupplyHub - Cargo Logistics Grid
// Converted from SwiftUI to ArkTS

// MARK: - Data Models

interface CargoCard {
  id: string;
  title: string;
  itemId: string;
  fill: string;
}

interface HubFilter {
  id: string;
  label: string;
}

// MARK: - Design Tokens

const DT_PRIMARY = '#8B6B4C';
const DT_SECONDARY = '#C27D38';
const DT_TERTIARY = '#F2C57C';
const DT_BACKGROUND = '#100C08';
const DT_SURFACE = '#19110D';
const DT_SURFACE_VARIANT = '#2A1C14';
const DT_OUTLINE = '#4F3A2C';
const DT_SUCCESS = '#6ECE89';
const DT_WARNING = '#E19F41';
const DT_ERROR = '#D96666';
const DT_ON_PRIMARY = '#100C08';
const DT_ON_SECONDARY = '#100C08';
const DT_ON_TERTIARY = '#120E04';
const DT_ON_BACKGROUND = '#F7EAD8';
const DT_ON_SURFACE = '#FBF0E0';

const DT_DISPLAY_SIZE = 28;
const DT_DISPLAY_WEIGHT = 700;
const DT_HEADLINE_SIZE = 22;
const DT_HEADLINE_WEIGHT = 600;
const DT_TITLE_SIZE = 16;
const DT_TITLE_WEIGHT = 500;
const DT_BODY_SIZE = 14;
const DT_BODY_WEIGHT = 400;
const DT_LABEL_SIZE = 12;
const DT_LABEL_WEIGHT = 500;

const DT_XXS = 6;
const DT_XS = 10;
const DT_SM = 14;
const DT_MD = 18;
const DT_LG = 26;
const DT_XL = 36;
const DT_XXL = 48;
const DT_XXXL = 62;

const DT_CR_SMALL = 10;
const DT_CR_MEDIUM = 18;
const DT_CR_LARGE = 26;

// MARK: - Top App Bar Component

@Component
struct TopAppBar {
  build() {
    Stack() {
      Row() {
        Circle({ width: 26, height: 26 })
          .fill(DT_SURFACE_VARIANT)

        Blank()

        Column() {
          Text('SupplyHub')
            .fontSize(DT_TITLE_SIZE)
            .fontWeight(DT_TITLE_WEIGHT)
            .fontColor(DT_ON_SURFACE)

          Text('Logistics grid')
            .fontSize(DT_LABEL_SIZE)
            .fontWeight(DT_LABEL_WEIGHT)
            .fontColor(DT_ON_SURFACE)
            .opacity(0.7)
        }
        .alignItems(HorizontalAlign.Center)

        Blank()

        Circle({ width: 26, height: 26 })
          .fill(DT_SURFACE_VARIANT)
      }
      .width('100%')
      .padding({
        left: DT_LG,
        right: DT_LG,
        top: DT_MD,
        bottom: DT_MD
      })
    }
    .width('100%')
    .height(64)
    .backgroundColor(DT_SURFACE)
    .opacity(0.95)
  }
}

// MARK: - Filter Buttons Component

@Component
struct FilterButtons {
  @Link activeFilter: string;
  filters: HubFilter[] = [];

  build() {
    Scroll() {
      Row() {
        ForEach(this.filters, (filter: HubFilter) => {
          Button(filter.label)
            .type(ButtonType.Normal)
            .fontSize(DT_LABEL_SIZE)
            .fontWeight(DT_LABEL_WEIGHT)
            .fontColor(this.activeFilter === filter.label ? DT_ON_SECONDARY : DT_ON_SURFACE)
            .backgroundColor(this.activeFilter === filter.label ? DT_SECONDARY : DT_SURFACE_VARIANT)
            .borderRadius(DT_CR_SMALL)
            .padding({
              left: DT_SM,
              right: DT_SM,
              top: DT_XXS,
              bottom: DT_XXS
            })
            .onClick(() => {
              this.activeFilter = filter.label;
            })
        }, (filter: HubFilter) => filter.id)
      }
      .width('100%')
      .padding({ left: DT_LG, right: DT_LG })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

// MARK: - Cargo Card View Component

@Component
struct CargoCardView {
  card: CargoCard = { id: '', title: '', itemId: '', fill: '' };

  build() {
    Column() {
      Stack() {
        Stack()
          .width('100%')
          .height(90)
          .backgroundColor(DT_SURFACE)
          .borderRadius(DT_CR_SMALL)

        Circle({ width: 60, height: 60 })
          .fill(DT_TERTIARY)
          .opacity(0.4)
      }
      .width('100%')
      .height(90)

      Column() {
        Text(this.card.title)
          .fontSize(DT_TITLE_SIZE)
          .fontWeight(DT_TITLE_WEIGHT)
          .fontColor(DT_ON_SURFACE)

        Text(this.card.itemId)
          .fontSize(DT_BODY_SIZE)
          .fontWeight(DT_BODY_WEIGHT)
          .fontColor(DT_ON_SURFACE)
          .opacity(0.7)

        Text('Fill ' + this.card.fill)
          .fontSize(DT_LABEL_SIZE)
          .fontWeight(DT_LABEL_WEIGHT)
          .fontColor(DT_SUCCESS)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(DT_MD)
    .backgroundColor(DT_SURFACE_VARIANT)
    .opacity(0.92)
    .borderRadius(DT_CR_MEDIUM)
  }
}

// MARK: - Main Content View

@Entry
@Component
struct SupplyHubApp {
  @State activeFilter: string = 'All';

  private cards: CargoCard[] = [
    { id: '1', title: 'Copper stack', itemId: 'SH-014', fill: '78%' },
    { id: '2', title: 'Fiber reels', itemId: 'SH-022', fill: '64%' },
    { id: '3', title: 'Agro crates', itemId: 'SH-031', fill: '92%' },
    { id: '4', title: 'Glass kits', itemId: 'SH-045', fill: '51%' },
    { id: '5', title: 'Steel mesh', itemId: 'SH-057', fill: '88%' },
    { id: '6', title: 'Raw silica', itemId: 'SH-063', fill: '43%' }
  ];

  private filters: HubFilter[] = [
    { id: '1', label: 'All' },
    { id: '2', label: 'Atlantic' },
    { id: '3', label: 'Pacific' },
    { id: '4', label: 'Inland' }
  ];

  build() {
    Stack() {
      Column() {
        TopAppBar()

        Scroll() {
          Column() {
            FilterButtons({ activeFilter: $activeFilter, filters: this.filters })

            Text('Cargo grid')
              .fontSize(DT_HEADLINE_SIZE)
              .fontWeight(DT_HEADLINE_WEIGHT)
              .fontColor(DT_ON_SURFACE)
              .width('100%')
              .padding({ left: DT_LG, right: DT_LG })

            Grid() {
              ForEach(this.cards, (card: CargoCard) => {
                GridItem() {
                  CargoCardView({ card: card })
                }
              }, (card: CargoCard) => card.id)
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(DT_SM)
            .rowsGap(DT_SM)
            .padding({ left: DT_LG, right: DT_LG })

            Column() {
              Text('Manifest filter')
                .fontSize(DT_LABEL_SIZE)
                .fontWeight(DT_LABEL_WEIGHT)
                .fontColor(DT_ON_SURFACE)
                .opacity(0.7)

              Text(this.activeFilter)
                .fontSize(DT_TITLE_SIZE)
                .fontWeight(DT_TITLE_WEIGHT)
                .fontColor(DT_ON_SURFACE)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({
              left: DT_LG,
              right: DT_LG,
              top: DT_MD,
              bottom: DT_MD
            })
            .backgroundColor(DT_SURFACE_VARIANT)
            .opacity(0.85)
            .borderRadius(DT_CR_MEDIUM)
            .margin({ left: DT_LG, right: DT_LG })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ top: DT_MD, bottom: DT_MD })
        }
        .scrollable(ScrollDirection.Vertical)
        .width('100%')
        .flexGrow(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DT_BACKGROUND)
  }
}
