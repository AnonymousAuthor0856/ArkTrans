import { router } from '@kit.ArkUI'

// --- Design Tokens & Constants ---

const AppTokens = {
  Colors: {
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
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  },
  Shapes: {
    small: 8,
    medium: 16,
    large: 24
  }
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

// --- Components ---

@Component
struct TopBarSection {
  @Link selectedFilter: string;
  private filters: Filter[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'b&w', name: 'B&W' },
    { id: 'neon', name: 'Neon' }
  ];

  build() {
    Column() {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)

      Spacer().height(AppTokens.Spacing.md)

      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filters, (filter: Filter) => {
          let isSelected = filter.id === this.selectedFilter;
          Button(filter.name)
            .type(ButtonType.Normal)
            .backgroundColor(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
            .fontColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onBackground)
            .borderWidth(2)
            .borderColor(isSelected ? Color.Transparent : AppTokens.Colors.outline) // Simplified border logic for ArkTS Button
            .borderRadius(AppTokens.Shapes.large)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .onClick(() => {
              this.selectedFilter = filter.id;
            })
        })
      }
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
  }
}

@Component
struct FilterCard {
  @State item: FilterItem = {
    id: 0,
    name: '',
    author: '',
    price: '',
    color: ''
  };

  build() {
    Column() {
      // Image Placeholder
      Column()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.item.color)
        .borderRadius(AppTokens.Shapes.medium)

      Column() {
        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(this.item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor('#99433E3A') // Approximate alpha 0.6 of onSurface

        Spacer().height(AppTokens.Spacing.sm)

        Text(this.item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
      }
      .margin(AppTokens.Spacing.sm)
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 }) // Level 1 Shadow approximation
    .padding(AppTokens.Spacing.sm)
  }
}

@Component
struct BottomBarSection {
  build() {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .lineHeight(20)
        .fontColor(AppTokens.Colors.onSurface)

      Button() {
        Row({ space: AppTokens.Spacing.sm }) {
          Circle({ width: 16, height: 16 })
            .fill('#33433E3A') // Alpha 0.2 of onPrimary
          
          Text('Checkout')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
        }
      }
      .type(ButtonType.Normal)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({ radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 12, color: '#14000000', offsetX: 6, offsetY: 6 }) // Level 2 Shadow approximation
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'vintage';
  
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
      TopBarSection({ selectedFilter: $selectedFilter })
      
      GridContainer() {
        ForEach(this.items, (item: FilterItem) => {
          GridItem() {
            FilterCard({ item: item })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('auto')
      .gap(AppTokens.Spacing.md)
      .padding(AppTokens.Spacing.lg)
      .layoutWeight(1)
      .alignSelf(ItemAlign.Center)

      BottomBarSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}