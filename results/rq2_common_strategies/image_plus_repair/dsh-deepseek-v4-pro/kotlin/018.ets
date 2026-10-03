// 018_FilterShop_en - translated from Kotlin Jetpack Compose to ArkTS/ArkUI

interface FilterOption {
  id: string;
  name: string;
}

interface FilterItem {
  id: number;
  name: string;
  author: string;
  price: string;
  color: string;
}

// Color tokens (Android 0xFFRRGGBB -> ArkUI '#RRGGBB')
const COLOR_PRIMARY: string = '#D7BBA8';
const COLOR_SECONDARY: string = '#A2C4C9';
const COLOR_TERTIARY: string = '#B3C9A2';
const COLOR_BACKGROUND: string = '#F0EBE3';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#E6E0D9';
const COLOR_OUTLINE: string = '#DCD7CF';
const COLOR_SUCCESS: string = '#7EA87E';
const COLOR_WARNING: string = '#D9B872';
const COLOR_ERROR: string = '#D98B8B';
const COLOR_ON: string = '#433E3A';
const COLOR_ON_60: string = '#99433E3A';
const COLOR_ON_10: string = '#1A433E3A';
const COLOR_ON_20: string = '#33433E3A';
const SHADOW_L1: string = '#0D000000';
const SHADOW_L2: string = '#14000000';

@Entry
@Component
struct FilterShopPage {
  private filters: FilterOption[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'b&w', name: 'B&W' },
    { id: 'neon', name: 'Neon' }
  ];

  @State selectedFilter: string = 'vintage';

  private items: FilterItem[] = [
    { id: 1, name: 'Redscale', author: 'by UserA', price: '$4.99', color: COLOR_ERROR },
    { id: 2, name: 'Sepia Tone', author: 'by UserB', price: '$2.99', color: COLOR_PRIMARY },
    { id: 3, name: 'Aqua', author: 'by UserC', price: '$4.99', color: COLOR_SECONDARY },
    { id: 4, name: 'Forest', author: 'by UserD', price: '$3.99', color: COLOR_TERTIARY },
    { id: 5, name: 'Golden Hour', author: 'by UserE', price: '$5.99', color: COLOR_WARNING },
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: COLOR_OUTLINE }
  ];

  @Builder
  TopBarSection() {
    Column() {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON)
      Blank()
        .height(12)
      Row({ space: 8 }) {
        ForEach(this.filters, (filter: FilterOption) => {
          Text(filter.name)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.5)
            .fontColor(this.selectedFilter === filter.id ? COLOR_ON : COLOR_ON)
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .backgroundColor(this.selectedFilter === filter.id ? COLOR_PRIMARY : COLOR_SURFACE)
            .borderRadius(24)
            .border({
              width: 2,
              color: this.selectedFilter === filter.id ? COLOR_ON_10 : COLOR_OUTLINE
            })
            .onClick(() => {
              this.selectedFilter = filter.id;
            })
        }, (filter: FilterOption) => filter.id)
      }
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
  }

  @Builder
  FilterCard(item: FilterItem) {
    Column() {
      Column() {
      }
      .width('100%')
      .aspectRatio(1)
      .backgroundColor(item.color)
      .borderRadius(16)

      Column() {
        Text(item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON)
        Text(item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor(COLOR_ON_60)
        Blank()
          .height(8)
        Text(item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_PRIMARY)
      }
      .padding(8)
    }
    .padding(8)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(24)
    .shadow({ radius: 8, color: SHADOW_L1, offsetX: 4, offsetY: 4 })
  }

  @Builder
  BottomBarSection() {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .lineHeight(20)
        .fontColor(COLOR_ON)

      Row({ space: 8 }) {
        Column() {
        }
        .width(16)
        .height(16)
        .borderRadius(8)
        .backgroundColor(COLOR_ON_20)
        Text('Checkout')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON)
      }
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(COLOR_PRIMARY)
      .borderRadius(24)
      .shadow({ radius: 8, color: SHADOW_L1, offsetX: 4, offsetY: 4 })
      .onClick(() => {
      })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
    .shadow({ radius: 12, color: SHADOW_L2, offsetX: 6, offsetY: 6 })
  }

  build() {
    Column() {
      this.TopBarSection()

      Grid() {
        ForEach(this.items, (item: FilterItem) => {
          GridItem() {
            this.FilterCard(item)
          }
        }, (item: FilterItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(12)
      .rowsGap(12)
      .padding(16)
      .layoutWeight(1)

      this.BottomBarSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}
