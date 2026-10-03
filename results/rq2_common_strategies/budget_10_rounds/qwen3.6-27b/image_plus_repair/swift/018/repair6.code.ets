// AppTokens.ts - Design tokens and constants

interface ColorMap {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyLevel {
  size: number;
  weight: string;
}

interface TypographyMap {
  display: TypographyLevel;
  headline: TypographyLevel;
  title: TypographyLevel;
  body: TypographyLevel;
  label: TypographyLevel;
}

interface ShapeMap {
  small: number;
  medium: number;
  large: number;
  circle: number;
}

interface SpacingMap {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface ElevationLevel {
  offsetX: number;
  offsetY: number;
  blurRadius: number;
  color: string;
}

interface ElevationMap {
  level1: ElevationLevel;
  level2: ElevationLevel;
}

export class AppTokens {
  static Colors: ColorMap = {
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

  static TypographyTokens: TypographyMap = {
    display: { size: 28, weight: 'bold' },
    headline: { size: 22, weight: 'semibold' },
    title: { size: 16, weight: 'medium' },
    body: { size: 14, weight: 'regular' },
    label: { size: 12, weight: 'medium' }
  }

  static Shapes: ShapeMap = {
    small: 8,
    medium: 16,
    large: 24,
    circle: 50 // percentage for circular shape
  }

  static Spacing: SpacingMap = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }

  static ElevationMapping: ElevationMap = {
    level1: { offsetX: 4, offsetY: 4, blurRadius: 8, color: 'rgba(0,0,0,0.05)' },
    level2: { offsetX: 6, offsetY: 6, blurRadius: 12, color: 'rgba(0,0,0,0.08)' }
  }
}

// Data models
export interface Filter {
  id: string;
  name: string;
}

export interface FilterItem {
  id: number;
  name: string;
  author: string;
  price: string;
  color: string;
}

// Main application component
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
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: AppTokens.Colors.outline }
  ];

  build() {
    Column() {
      // Top bar section
      this.TopBarSection();
      
      // Scrollable content area
      Scroll() {
        Grid() {
          ForEach(this.items, (item: FilterItem) => {
            GridItem() {
              this.FilterCard(item);
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(AppTokens.Spacing.md)
        .columnsGap(AppTokens.Spacing.md)
        .padding(AppTokens.Spacing.lg)
      }
      .layoutWeight(1)
      
      // Bottom bar section
      this.BottomBarSection();
    }
    .backgroundColor(AppTokens.Colors.background)
    .width('100%')
    .height('100%')
  }

  @Builder
  TopBarSection() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Filter Shop')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
        .alignSelf(ItemAlign.Start)
      
      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filters, (filter: Filter) => {
          this.FilterChip(filter);
        })
      }
      .alignItems(VerticalAlign.Center)
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .width('100%')
  }

  @Builder
  FilterChip(filter: Filter) {
    const isSelected = filter.id === this.selectedFilter;
    
    Button(filter.name) {
      Text(filter.name)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(FontWeight.Medium)
        .letterSpacing(0.5)
        .fontColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onBackground)
    }
    .backgroundColor(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .borderWidth(2)
    .borderColor(isSelected ? 'rgba(67,62,58,0.1)' : AppTokens.Colors.outline)
    .borderRadius(AppTokens.Shapes.large)
    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .onClick(() => {
      this.selectedFilter = filter.id;
    })
  }

  @Builder
  FilterCard(item: FilterItem) {
    Column({ space: 0 }) {
      // Color preview
      Column() {
        Blank()
      }
      .aspectRatio(1)
      .backgroundColor(item.color)
      .borderRadius(AppTokens.Shapes.medium)
      
      // Text content
      Column({ space: AppTokens.Spacing.sm }) {
        Text(item.name)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(item.author)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor('#6B6B6B') // Approximation of opacity effect
        
        Text(item.price)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(AppTokens.Spacing.sm)
    }
    .padding(AppTokens.Spacing.sm)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: AppTokens.ElevationMapping.level1.blurRadius, color: AppTokens.ElevationMapping.level1.color, offsetX: AppTokens.ElevationMapping.level1.offsetX, offsetY: AppTokens.ElevationMapping.level1.offsetY })
  }

  @Builder
  BottomBarSection() {
    Row({ space: AppTokens.Spacing.sm }) {
      Text('3 items in cart')
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(FontWeight.Regular)
        .lineHeight(20)
        .fontColor(AppTokens.Colors.onSurface)
      
      Flex({ justifyContent: FlexAlign.End }) {
        Button() {
          Row({ space: AppTokens.Spacing.sm }) {
            Circle()
              .width(16)
              .height(16)
              .fill('rgba(67,62,58,0.2)')
            
            Text('Checkout')
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .padding({ left: 24, right: 24, top: 8, bottom: 8 })
        }
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: AppTokens.ElevationMapping.level1.blurRadius, color: AppTokens.ElevationMapping.level1.color, offsetX: AppTokens.ElevationMapping.level1.offsetX, offsetY: AppTokens.ElevationMapping.level1.offsetY })
      }
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: AppTokens.ElevationMapping.level2.blurRadius, color: AppTokens.ElevationMapping.level2.color, offsetX: AppTokens.ElevationMapping.level2.offsetX, offsetY: AppTokens.ElevationMapping.level2.offsetY })
  }
}