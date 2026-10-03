// Filter Shop - Clay Morph style
// Converted from Kotlin Compose to ArkTS

class AppTokens {
  static Colors = {
    primary: '#D7BBA8',
    secondary: '#A2C4C9',
    tertiary: '#B3C9A2',
    background: '#F0EBE3',
    surface: '#FFFFFF',
    surfaceVariant: '#E6E0D9',
    outline: '#DCD7CF',
    success: '#7EA87E',
    warning: '#D9B872',
    error: '#D98B8B',
    onPrimary: '#433E3A',
    onSecondary: '#433E3A',
    onTertiary: '#433E3A',
    onBackground: '#433E3A',
    onSurface: '#433E3A',
  };
  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  };
}

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

@Entry
@Component
struct FilterShopPage {
  @State selectedFilter: string = 'vintage';

  private filters: Filter[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'b&w', name: 'B&W' },
    { id: 'neon', name: 'Neon' },
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
      // Top bar section
      Column() {
        Text('Filter Shop')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ bottom: AppTokens.Spacing.md })

        Row() {
          ForEach(this.filters, (filter: Filter) => {
            Text(filter.name)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(filter.id === this.selectedFilter
                ? AppTokens.Colors.onPrimary
                : AppTokens.Colors.onBackground)
              .padding({
                left: AppTokens.Spacing.md,
                right: AppTokens.Spacing.md,
                top: AppTokens.Spacing.sm,
                bottom: AppTokens.Spacing.sm,
              })
              .backgroundColor(filter.id === this.selectedFilter
                ? AppTokens.Colors.primary
                : AppTokens.Colors.surface)
              .border({
                width: 2,
                color: filter.id === this.selectedFilter
                  ? 'rgba(67, 62, 58, 0.1)'
                  : AppTokens.Colors.outline,
                radius: 24,
              })
              .borderRadius(24)
              .onClick(() => {
                this.selectedFilter = filter.id;
              })
          }, (filter: Filter) => filter.id)
        }
        .width('100%')
      }
      .width('100%')
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: AppTokens.Spacing.md,
      })

      // Filter grid
      Grid() {
        ForEach(this.items, (item: FilterItem) => {
          GridItem() {
            this.FilterCardBuilder(item)
          }
        }, (item: FilterItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppTokens.Spacing.md)
      .rowsGap(AppTokens.Spacing.md)
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.xs,
        bottom: AppTokens.Spacing.lg,
      })
      .layoutWeight(1)

      // Bottom bar
      Row() {
        Text('3 items in cart')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)

        Row() {
          Circle({ width: 20, height: 20 })
            .fill('rgba(67, 62, 58, 0.2)')
            .margin({ right: AppTokens.Spacing.sm })

          Text('Checkout')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .padding({
          left: AppTokens.Spacing.xl * 2,
          right: AppTokens.Spacing.xl * 2,
          top: AppTokens.Spacing.md + 4,
          bottom: AppTokens.Spacing.md + 4,
        })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(32)
        .shadow({
          radius: 16,
          color: 'rgba(0, 0, 0, 0.15)',
          offsetX: 4,
          offsetY: 8,
        })
      }
      .width('100%')
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: AppTokens.Spacing.md + 16,
      })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: 20,
        color: 'rgba(0, 0, 0, 0.08)',
        offsetX: 0,
        offsetY: -4,
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  FilterCardBuilder(item: FilterItem) {
    Column() {
      // Color preview
      Row() { }
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(item.color)
        .borderRadius(20)
        .margin({ bottom: AppTokens.Spacing.sm })

      Column() {
        Text(item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ bottom: 2 })

        Text(item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('rgba(67, 62, 58, 0.6)')
          .margin({ bottom: AppTokens.Spacing.sm })

        Text(item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(AppTokens.Spacing.sm)
    }
    .width('100%')
    .padding(AppTokens.Spacing.sm)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(28)
    .shadow({
      radius: 12,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 4,
      offsetY: 4,
    })
  }
}
