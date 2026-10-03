import { router } from '@kit.ArkUI';

// ============ Tokens ============
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FFD7BBA8';
    export const secondary: string = '#FFA2C4C9';
    export const tertiary: string = '#FFB3C9A2';
    export const background: string = '#FFF0EBE3';
    export const surface: string = '#FFFFFFFF';
    export const surfaceVariant: string = '#FFE6E0D9';
    export const outline: string = '#FFDCD7CF';
    export const success: string = '#FF7EA87E';
    export const warning: string = '#FFD9B872';
    export const error: string = '#FFD98B8B';
    export const onPrimary: string = '#FF433E3A';
    export const onSecondary: string = '#FF433E3A';
    export const onTertiary: string = '#FF433E3A';
    export const onBackground: string = '#FF433E3A';
    export const onSurface: string = '#FF433E3A';
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
  }

  export namespace Radius {
    export const small: number = 8;
    export const medium: number = 16;
    export const large: number = 24;
  }
}

// ============ Data Models ============
interface Filter {
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

// ============ FilterCard Component ============
@Component
struct FilterCard {
  item: FilterItem = {
    id: 0,
    name: '',
    author: '',
    price: '',
    color: '#FFFFFFFF'
  };

  build() {
    Column() {
      Column() {
        // Color preview box
        Row()
          .width('100%')
          .aspectRatio(1)
          .borderRadius(AppTokens.Radius.medium)
          .backgroundColor(this.item.color)

        Column() {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')

          Text(this.item.author)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#99433E3A')
            .width('100%')
            .margin({ top: 2 })

          Blank()
            .height(AppTokens.Spacing.sm)

          Text(this.item.price)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.primary)
            .width('100%')
        }
        .padding(AppTokens.Spacing.sm)
        .alignItems(HorizontalAlign.Start)
      }
      .padding(AppTokens.Spacing.sm)
      .alignItems(HorizontalAlign.Start)
    }
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.large)
    .shadow({
      radius: 8,
      color: '#0D000000',
      offsetX: 4,
      offsetY: 4
    })
    .width('100%')
  }
}

// ============ TopBarSection Component ============
@Component
struct TopBarSection {
  filters: Filter[] = [];
  selectedFilter: string = '';
  onFilterSelected: (id: string) => void = () => {};

  build() {
    Column() {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
        .width('100%')

      Blank().height(AppTokens.Spacing.md)

      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filters, (filter: Filter) => {
          FilterChip({
            filter: filter,
            isSelected: filter.id === this.selectedFilter,
            onSelect: this.onFilterSelected
          })
        }, (filter: Filter) => filter.id)
      }
      .width('100%')
    }
    .padding({
      horizontal: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md
    })
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// ============ FilterChip Component ============
@Component
struct FilterChip {
  filter: Filter = { id: '', name: '' };
  isSelected: boolean = false;
  onSelect: (id: string) => void = () => {};

  build() {
    Text(this.filter.name)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .letterSpacing(0.5)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onBackground)
      .padding({
        horizontal: AppTokens.Spacing.md,
        vertical: AppTokens.Spacing.sm
      })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Radius.large)
      .border({
        width: 2,
        color: this.isSelected ? '#1A433E3A' : AppTokens.Colors.outline,
        radius: AppTokens.Radius.large
      })
      .onClick(() => {
        this.onSelect(this.filter.id);
      })
  }
}

// ============ BottomBarSection Component ============
@Component
struct BottomBarSection {
  build() {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.Colors.onSurface)

      Row({ space: AppTokens.Spacing.sm }) {
        Row()
          .width(16)
          .height(16)
          .borderRadius(8)
          .backgroundColor('#33433E3A')

        Text('Checkout')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .alignItems(VerticalAlign.Center)
      .padding({
        horizontal: AppTokens.Spacing.lg,
        vertical: AppTokens.Spacing.sm
      })
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Radius.large)
      .shadow({
        radius: 8,
        color: '#0D000000',
        offsetX: 4,
        offsetY: 4
      })
      .onClick(() => {})
    }
    .width('100%')
    .padding({
      horizontal: AppTokens.Spacing.lg,
      vertical: AppTokens.Spacing.md
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: 12,
      color: '#14000000',
      offsetX: 6,
      offsetY: 6
    })
  }
}

// ============ RootScreen ============
@Component
struct RootScreen {
  @State selectedFilter: string = 'vintage';

  private filters: Filter[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'b&w', name: 'B&W' },
    { id: 'neon', name: 'Neon' }
  ];

  private items: FilterItem[] = [
    { id: 1, name: 'Redscale', author: 'by UserA', price: '$4.99', color: AppTokens.Colors.error },
    { id: 2, name: 'Sepia Tone', author: 'by UserB', price: '$2.99', color: AppTokens.Colors.primary },
    { id: 3, name: 'Aqua', author: 'by UserC', price: '$4.99', color: AppTokens.Colors.secondary },
    { id: 4, name: 'Forest', author: 'by UserD', price: '$3.99', color: AppTokens.Colors.tertiary },
    { id: 5, name: 'Golden Hour', author: 'by UserE', price: '$5.99', color: AppTokens.Colors.warning },
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: AppTokens.Colors.outline },
  ];

  build() {
    Column() {
      // Top Bar
      TopBarSection({
        filters: this.filters,
        selectedFilter: this.selectedFilter,
        onFilterSelected: (id: string) => {
          this.selectedFilter = id;
        }
      })

      // Grid Content
      Grid() {
        ForEach(this.items, (item: FilterItem) => {
          GridItem() {
            FilterCard({ item: item })
          }
        }, (item: FilterItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppTokens.Spacing.md)
      .rowsGap(AppTokens.Spacing.md)
      .padding(AppTokens.Spacing.lg)
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)

      // Bottom Bar
      BottomBarSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// ============ Entry Point ============
@Entry
@Component
struct Index {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}