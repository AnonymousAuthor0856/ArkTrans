// MARK: - AppTokens
const AppColorPrimary: number = 0xFFD7BBA8;
const AppColorSecondary: number = 0xFFA2C4C9;
const AppColorTertiary: number = 0xFFB3C9A2;
const AppColorBackground: number = 0xFFF0EBE3;
const AppColorSurface: number = 0xFFFFFFFF;
const AppColorSurfaceVariant: number = 0xFFE6E0D9;
const AppColorOutline: number = 0xFFDCD7CF;
const AppColorSuccess: number = 0xFF7EA87E;
const AppColorWarning: number = 0xFFD9B872;
const AppColorError: number = 0xFFD98B8B;
const AppColorOnPrimary: number = 0xFF433E3A;
const AppColorOnSecondary: number = 0xFF433E3A;
const AppColorOnTertiary: number = 0xFF433E3A;
const AppColorOnBackground: number = 0xFF433E3A;
const AppColorOnSurface: number = 0xFF433E3A;

const AppSpacingXs: number = 4;
const AppSpacingSm: number = 8;
const AppSpacingMd: number = 12;
const AppSpacingLg: number = 16;
const AppSpacingXl: number = 24;

// MARK: - Data Models
class FilterOption {
  id: string = '';
  name: string = '';

  constructor(id: string, name: string) {
    this.id = id;
    this.name = name;
  }
}

class FilterProduct {
  id: number = 0;
  name: string = '';
  author: string = '';
  price: string = '';
  color: number = 0xFFFFFFFF;

  constructor(id: number, name: string, author: string, price: string, color: number) {
    this.id = id;
    this.name = name;
    this.author = author;
    this.price = price;
    this.color = color;
  }
}

// MARK: - FilterCard Component
@Component
struct FilterCard {
  item: FilterProduct = new FilterProduct(0, '', '', '', 0xFFFFFFFF);

  build() {
    Column({ space: 0 }) {
      Column()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.item.color)
        .borderRadius(16)

      Column({ space: AppSpacingSm }) {
        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColorOnSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(0x99433E3A)
          .letterSpacing(0.5)
          .maxLines(1)

        Text(this.item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColorPrimary)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(AppSpacingSm)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacingSm)
    .backgroundColor(AppColorSurface)
    .borderRadius(24)
    .shadow({
      radius: 8,
      color: 0x0D000000,
      offsetX: 4,
      offsetY: 4
    })
  }
}

// MARK: - TopBarSection Component
@Component
struct TopBarSection {
  filters: FilterOption[] = [];
  @Link selectedFilter: string;

  build() {
    Column({ space: AppSpacingMd }) {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColorOnBackground)

      Row({ space: AppSpacingSm }) {
        ForEach(this.filters, (filter: FilterOption) => {
          Text(filter.name)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.5)
            .fontColor(filter.id === this.selectedFilter ? AppColorOnPrimary : AppColorOnBackground)
            .padding({
              left: AppSpacingMd,
              right: AppSpacingMd,
              top: AppSpacingSm,
              bottom: AppSpacingSm
            })
            .backgroundColor(filter.id === this.selectedFilter ? AppColorPrimary : AppColorSurface)
            .borderRadius(24)
            .border({
              width: 2,
              color: filter.id === this.selectedFilter ? 0x1A433E3A : AppColorOutline
            })
            .onClick(() => {
              this.selectedFilter = filter.id;
            })
        }, (filter: FilterOption) => filter.id)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// MARK: - BottomBarSection Component
@Component
struct BottomBarSection {
  build() {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .fontColor(AppColorOnSurface)
        .lineHeight(20)

      Blank()

      Row({ space: AppSpacingSm }) {
        Column()
          .width(16)
          .height(16)
          .borderRadius(8)
          .backgroundColor(0x33433E3A)

        Text('Checkout')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColorOnPrimary)
      }
      .padding({
        left: 24,
        right: 24,
        top: 8,
        bottom: 8
      })
      .backgroundColor(AppColorPrimary)
      .borderRadius(24)
      .shadow({
        radius: 8,
        color: 0x0D000000,
        offsetX: 4,
        offsetY: 4
      })
      .onClick(() => {
        console.log('Checkout tapped');
      })
    }
    .width('100%')
    .padding({
      left: AppSpacingLg,
      right: AppSpacingLg,
      top: AppSpacingMd,
      bottom: AppSpacingMd
    })
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'vintage';

  filters: FilterOption[] = [
    new FilterOption('vintage', 'Vintage'),
    new FilterOption('grain', 'Grain'),
    new FilterOption('b&w', 'B&W'),
    new FilterOption('neon', 'Neon'),
  ];

  items: FilterProduct[] = [
    new FilterProduct(1, 'Redscale', 'by UserA', '$4.99', AppColorError),
    new FilterProduct(2, 'Sepia Tone', 'by UserB', '$2.99', AppColorPrimary),
    new FilterProduct(3, 'Aqua', 'by UserC', '$4.99', AppColorSecondary),
    new FilterProduct(4, 'Forest', 'by UserD', '$3.99', AppColorTertiary),
    new FilterProduct(5, 'Golden Hour', 'by UserE', '$5.99', AppColorWarning),
    new FilterProduct(6, 'Monochrome', 'by UserF', '$1.99', AppColorOutline),
  ];

  build() {
    Column({ space: 0 }) {
      // Top Bar
      TopBarSection({
        filters: this.filters,
        selectedFilter: $selectedFilter
      })
        .padding({
          left: AppSpacingLg,
          right: AppSpacingLg,
          top: AppSpacingMd,
          bottom: AppSpacingMd
        })
        .backgroundColor(AppColorBackground)
        .width('100%')

      // Scrollable Grid Content
      Scroll() {
        Grid() {
          ForEach(this.items, (item: FilterProduct) => {
            GridItem() {
              FilterCard({ item: item })
            }
          }, (item: FilterProduct) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacingMd)
        .rowsGap(AppSpacingMd)
        .padding(AppSpacingLg)
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(AppColorBackground)
      .width('100%')
      .scrollBar(BarState.Off)

      // Bottom Bar
      BottomBarSection()
        .backgroundColor(AppColorSurface)
        .shadow({
          radius: 12,
          color: 0x14000000,
          offsetX: 6,
          offsetY: 6
        })
        .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColorBackground)
  }
}