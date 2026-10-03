// Index.ets
interface FilterItem {
  id: number;
  name: string;
  author: string;
  price: string;
  color: ResourceColor;
}

interface FilterCategory {
  id: string;
  name: string;
}

class AppColors {
  static readonly primary: ResourceColor = '#D7BBA8';
  static readonly secondary: ResourceColor = '#A2C4C9';
  static readonly tertiary: ResourceColor = '#B3C9A2';
  static readonly background: ResourceColor = '#F0EBE3';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#E6E0D9';
  static readonly outline: ResourceColor = '#DCD7CF';
  static readonly success: ResourceColor = '#7EA87E';
  static readonly warning: ResourceColor = '#D9B872';
  static readonly error: ResourceColor = '#D98B8B';
  static readonly onPrimary: ResourceColor = '#433E3A';
  static readonly onSecondary: ResourceColor = '#433E3A';
  static readonly onTertiary: ResourceColor = '#433E3A';
  static readonly onBackground: ResourceColor = '#433E3A';
  static readonly onSurface: ResourceColor = '#433E3A';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'vintage';
  private filters: FilterCategory[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'b&w', name: 'B&W' },
    { id: 'neon', name: 'Neon' }
  ];
  private items: FilterItem[] = [
    { id: 1, name: 'Redscale', author: 'by UserA', price: '$4.99', color: AppColors.error },
    { id: 2, name: 'Sepia Tone', author: 'by UserB', price: '$2.99', color: AppColors.primary },
    { id: 3, name: 'Aqua', author: 'by UserC', price: '$4.99', color: AppColors.secondary },
    { id: 4, name: 'Forest', author: 'by UserD', price: '$3.99', color: AppColors.tertiary },
    { id: 5, name: 'Golden Hour', author: 'by UserE', price: '$5.99', color: AppColors.warning },
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: AppColors.outline }
  ];

  build() {
    Column() {
      // Top Bar
      Column() {
        Text('Filter Shop')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .width('100%')

        Row({ space: AppSpacing.sm }) {
          ForEach(this.filters, (filter: FilterCategory) => {
            Text(filter.name)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedFilter === filter.id ? AppColors.onPrimary : AppColors.onBackground)
              .backgroundColor(this.selectedFilter === filter.id ? AppColors.primary : AppColors.surface)
              .border({
                width: 2,
                color: this.selectedFilter === filter.id ? '#1A433E3A' : AppColors.outline,
                radius: 24
              })
              .borderRadius(24)
              .padding({
                left: AppSpacing.md,
                right: AppSpacing.md,
                top: AppSpacing.sm,
                bottom: AppSpacing.sm
              })
              .onClick(() => {
                this.selectedFilter = filter.id;
              })
          })
        }
        .width('100%')
        .margin({ top: AppSpacing.md })
      }
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
      .width('100%')

      // Grid Content
      Scroll() {
        Grid() {
          ForEach(this.items, (item: FilterItem) => {
            GridItem() {
              Column() {
                Column()
                  .width('100%')
                  .aspectRatio(1)
                  .backgroundColor(item.color)
                  .borderRadius(16)

                Column() {
                  Text(item.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(AppColors.onSurface)
                  
                  Text(item.author)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#99433E3A')
                    .margin({ top: 2 })

                  Text(item.price)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(AppColors.primary)
                    .margin({ top: AppSpacing.sm })
                }
                .alignItems(HorizontalAlign.Start)
                .padding(AppSpacing.sm)
                .width('100%')
              }
              .padding(AppSpacing.sm)
              .backgroundColor(AppColors.surface)
              .borderRadius(24)
              .shadow({ radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 })
            }
          }, (item: FilterItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.md)
        .rowsGap(AppSpacing.md)
        .padding(AppSpacing.lg)
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')

      // Bottom Bar
      Row() {
        Text('3 items in cart')
          .fontSize(14)
          .fontColor(AppColors.onSurface)

        Button() {
          Row({ space: AppSpacing.sm }) {
            Column()
              .width(16)
              .height(16)
              .borderRadius(8)
              .backgroundColor('#33433E3A')
            
            Text('Checkout')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
          }
        }
        .backgroundColor(AppColors.primary)
        .borderRadius(24)
        .shadow({ radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 12, color: '#14000000', offsetX: 0, offsetY: -6 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}