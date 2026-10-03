const AppColors = {
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
  onSurface: '#433E3A'
}

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
}

interface FilterItem {
  id: number
  name: string
  author: string
  price: string
  color: string
}

@Component
struct FilterCard {
  private item: FilterItem = { id: 0, name: '', author: '', price: '', color: '' }

  build() {
    Column() {
      Column()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.item.color)
        .borderRadius(16)

      Column() {
        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
        Text(this.item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99433E3A')
        Blank().height(AppSpacing.sm)
        Text(this.item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
      }
      .padding(AppSpacing.sm)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor(AppColors.surface)
    .borderRadius(24)
  }
}

@Entry
@Component
struct Index {
  @State selectedFilter: string = 'vintage'
  private filters: string[] = ['vintage', 'grain', 'b&w', 'neon']
  private filterNames: string[] = ['Vintage', 'Grain', 'B&W', 'Neon']
  private items: FilterItem[] = [
    { id: 1, name: 'Redscale', author: 'by UserA', price: '$4.99', color: '#D98B8B' },
    { id: 2, name: 'Sepia Tone', author: 'by UserB', price: '$2.99', color: '#D7BBA8' },
    { id: 3, name: 'Aqua', author: 'by UserC', price: '$4.99', color: '#A2C4C9' },
    { id: 4, name: 'Forest', author: 'by UserD', price: '$3.99', color: '#B3C9A2' },
    { id: 5, name: 'Golden Hour', author: 'by UserE', price: '$5.99', color: '#D9B872' },
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: '#DCD7CF' }
  ]

  build() {
    Column() {
      Column() {
        Text('Filter Shop')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
        Blank().height(AppSpacing.md)
        Row({ space: AppSpacing.sm }) {
          ForEach(this.filters, (filterId: string, index: number) => {
            Text(this.filterNames[index])
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedFilter === filterId ? AppColors.onPrimary : AppColors.onBackground)
              .backgroundColor(this.selectedFilter === filterId ? AppColors.primary : AppColors.surface)
              .border({ width: 2, color: this.selectedFilter === filterId ? '#1A433E3A' : AppColors.outline, radius: 24 })
              .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
              .onClick(() => {
                this.selectedFilter = filterId
              })
          }, (filterId: string, index: number) => index.toString())
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })

      Grid() {
        ForEach(this.items, (item: FilterItem) => {
          GridItem() {
            FilterCard({ item: item })
          }
        }, (item: FilterItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppSpacing.md)
      .rowsGap(AppSpacing.md)
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)

      Row() {
        Text('3 items in cart')
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)

        Row({ space: AppSpacing.sm }) {
          Column()
            .width(16)
            .height(16)
            .backgroundColor('#33433E3A')
            .borderRadius(8)
          Text('Checkout')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
        .backgroundColor(AppColors.primary)
        .borderRadius(24)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      .backgroundColor(AppColors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}