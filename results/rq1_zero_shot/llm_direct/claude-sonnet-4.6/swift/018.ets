import { LengthMetrics } from '@kit.ArkUI';

// MARK: - AppTokens
namespace AppTokens {
  export namespace Colors {
    export const primary = '#D7BBA8';
    export const secondary = '#A2C4C9';
    export const tertiary = '#B3C9A2';
    export const background = '#F0EBE3';
    export const surface = '#FFFFFF';
    export const surfaceVariant = '#E6E0D9';
    export const outline = '#DCD7CF';
    export const success = '#7EA87E';
    export const warning = '#D9B872';
    export const error = '#D98B8B';
    export const onPrimary = '#433E3A';
    export const onSecondary = '#433E3A';
    export const onTertiary = '#433E3A';
    export const onBackground = '#433E3A';
    export const onSurface = '#433E3A';
  }

  export namespace Typography {
    export const displaySize = 28;
    export const headlineSize = 22;
    export const titleSize = 16;
    export const bodySize = 14;
    export const labelSize = 12;
  }

  export namespace Radius {
    export const small = 8;
    export const medium = 16;
    export const large = 24;
  }

  export namespace Spacing {
    export const xs = 4;
    export const sm = 8;
    export const md = 12;
    export const lg = 16;
    export const xl = 24;
  }

  export interface ShadowSpec {
    color: string;
    offsetX: number;
    offsetY: number;
    blurRadius: number;
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = {
      color: '#0D000000',
      offsetX: 4,
      offsetY: 4,
      blurRadius: 8
    };
    export const level2: ShadowSpec = {
      color: '#14000000',
      offsetX: 6,
      offsetY: 6,
      blurRadius: 12
    };
  }
}

// MARK: - Data Models
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

// MARK: - TopBarSection
@Component
struct TopBarSection {
  filters: Filter[] = [];
  @Link selectedFilter: string;

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Filter Shop')
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)

      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filters, (filter: Filter) => {
          Text(filter.name)
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.5)
            .fontColor(filter.id === this.selectedFilter
              ? AppTokens.Colors.onPrimary
              : AppTokens.Colors.onBackground)
            .padding({
              left: AppTokens.Spacing.md,
              right: AppTokens.Spacing.md,
              top: AppTokens.Spacing.sm,
              bottom: AppTokens.Spacing.sm
            })
            .backgroundColor(filter.id === this.selectedFilter
              ? AppTokens.Colors.primary
              : AppTokens.Colors.surface)
            .borderRadius(AppTokens.Radius.large)
            .border({
              width: 2,
              color: filter.id === this.selectedFilter
                ? '#1A433E3A'
                : AppTokens.Colors.outline
            })
            .onClick(() => {
              this.selectedFilter = filter.id;
            })
        }, (filter: Filter) => filter.id)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// MARK: - FilterCard
@Component
struct FilterCard {
  item: FilterItem = { id: 0, name: '', author: '', price: '', color: '' };

  build() {
    Column({ space: 0 }) {
      Column()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.item.color)
        .borderRadius(AppTokens.Radius.medium)

      Column({ space: AppTokens.Spacing.sm }) {
        Text(this.item.name)
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.item.author)
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor('#99433E3A')

        Text(this.item.price)
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(AppTokens.Spacing.sm)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.sm)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.large)
    .shadow({
      color: AppTokens.ElevationMapping.level1.color,
      offsetX: AppTokens.ElevationMapping.level1.offsetX,
      offsetY: AppTokens.ElevationMapping.level1.offsetY,
      radius: AppTokens.ElevationMapping.level1.blurRadius
    })
  }
}

// MARK: - BottomBarSection
@Component
struct BottomBarSection {
  build() {
    Row() {
      Text('3 items in cart')
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(FontWeight.Regular)
        .lineHeight(20)
        .fontColor(AppTokens.Colors.onSurface)

      Blank()

      Row({ space: AppTokens.Spacing.sm }) {
        Column()
          .width(16)
          .height(16)
          .borderRadius(8)
          .backgroundColor('#33433E3A')

        Text('Checkout')
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .padding({ left: 24, right: 24, top: 8, bottom: 8 })
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Radius.large)
      .shadow({
        color: AppTokens.ElevationMapping.level1.color,
        offsetX: AppTokens.ElevationMapping.level1.offsetX,
        offsetY: AppTokens.ElevationMapping.level1.offsetY,
        radius: AppTokens.ElevationMapping.level1.blurRadius
      })
      .onClick(() => {
        console.log('Checkout tapped');
      })
    }
    .width('100%')
    .padding({
      left: AppTokens.Spacing.lg,
      right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md
    })
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'vintage';

  filters: Filter[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'b&w', name: 'B&W' },
    { id: 'neon', name: 'Neon' }
  ];

  items: FilterItem[] = [
    { id: 1, name: 'Redscale', author: 'by UserA', price: '$4.99', color: AppTokens.Colors.error },
    { id: 2, name: 'Sepia Tone', author: 'by UserB', price: '$2.99', color: AppTokens.Colors.primary },
    { id: 3, name: 'Aqua', author: 'by UserC', price: '$4.99', color: AppTokens.Colors.secondary },
    { id: 4, name: 'Forest', author: 'by UserD', price: '$3.99', color: AppTokens.Colors.tertiary },
    { id: 5, name: 'Golden Hour', author: 'by UserE', price: '$5.99', color: AppTokens.Colors.warning },
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: AppTokens.Colors.outline },
  ];

  build() {
    Column({ space: 0 }) {
      TopBarSection({ filters: this.filters, selectedFilter: $selectedFilter })
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })
        .backgroundColor(AppTokens.Colors.background)
        .width('100%')

      Scroll() {
        WaterFlow() {
          ForEach(this.items, (item: FilterItem) => {
            FlowItem() {
              FilterCard({ item: item })
            }
          }, (item: FilterItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppTokens.Spacing.md)
        .rowsGap(AppTokens.Spacing.md)
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .backgroundColor(AppTokens.Colors.background)
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .width('100%')

      BottomBarSection()
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          color: AppTokens.ElevationMapping.level2.color,
          offsetX: AppTokens.ElevationMapping.level2.offsetX,
          offsetY: AppTokens.ElevationMapping.level2.offsetY,
          radius: AppTokens.ElevationMapping.level2.blurRadius
        })
        .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}