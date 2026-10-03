import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - Color Extension for Hex
function hexToColor(hex: number, alpha: number = 1.0): string {
  const r = ((hex >> 16) & 0xff);
  const g = ((hex >> 8) & 0xff);
  const b = (hex & 0xff);
  return `rgba(${r}, ${g}, ${b}, ${alpha})`;
}

// MARK: - Interfaces for AppTokens
interface ColorToken {
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

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

interface SpacingToken {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface ShadowSpecItem {
  color: string;
  offsetX: number;
  offsetY: number;
  blurRadius: number;
}

interface ShadowSpec {
  level1: ShadowSpecItem;
  level2: ShadowSpecItem;
}

// MARK: - AppTokens
const AppTokens = {
  Colors: {
    primary: hexToColor(0xD7BBA8),
    secondary: hexToColor(0xA2C4C9),
    tertiary: hexToColor(0xB3C9A2),
    background: hexToColor(0xF0EBE3),
    surface: hexToColor(0xFFFFFF),
    surfaceVariant: hexToColor(0xE6E0D9),
    outline: hexToColor(0xDCD7CF),
    success: hexToColor(0x7EA87E),
    warning: hexToColor(0xD9B872),
    error: hexToColor(0xD98B8B),
    onPrimary: hexToColor(0x433E3A),
    onSecondary: hexToColor(0x433E3A),
    onTertiary: hexToColor(0x433E3A),
    onBackground: hexToColor(0x433E3A),
    onSurface: hexToColor(0x433E3A),
  } as ColorToken,

  TypographyTokens: {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 22, weight: FontWeight.Medium }, // Fixed SemiBold to Medium
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  } as TypographyTokens,

  Shapes: {
    small: 8,
    medium: 16,
    large: 24,
  } as ShapeToken,

  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  } as SpacingToken,

  ShadowSpec: {
    level1: { color: 'rgba(0, 0, 0, 0.05)', offsetX: 4, offsetY: 4, blurRadius: 8 },
    level2: { color: 'rgba(0, 0, 0, 0.08)', offsetX: 6, offsetY: 6, blurRadius: 12 },
  } as ShadowSpec
};

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
  @Link selectedFilter: string;
  filters: Filter[] = [];

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Filter Shop")
        .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
        .foregroundColor(AppTokens.Colors.onBackground)

      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filters, (filter: Filter) => {
          let isSelected = filter.id === this.selectedFilter;
          Text(filter.name)
            .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
            .letterSpacing(0.5)
            .foregroundColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onBackground)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .backgroundColor(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
            .borderWidth(2)
            .borderColor(isSelected ? hexToColor(0x433E3A, 0.1) : AppTokens.Colors.outline)
            .borderRadius(AppTokens.Shapes.large)
            .onClick(() => {
              this.selectedFilter = filter.id;
            })
        })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// MARK: - FilterCard
@Component
struct FilterCard {
  item: FilterItem = {} as FilterItem;

  build() {
    Column() {
      // Image Placeholder
      Column() {
        Text('🖼️')
          .fontSize(40)
          .textAlign(TextAlign.Center)
      }
      .aspectRatio(1)
      .backgroundColor(this.item.color)
      .borderRadius(AppTokens.Shapes.medium)
      .width('100%')

      Column({ space: AppTokens.Spacing.sm }) {
        Text(this.item.name)
          .font({ size: AppTokens.TypographyTokens.title.size, weight: FontWeight.Bold })
          .foregroundColor(AppTokens.Colors.onSurface)

        Text(this.item.author)
          .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
          .letterSpacing(0.5)
          .opacity(0.6)
          .foregroundColor(AppTokens.Colors.onSurface)

        Text(this.item.price)
          .font({ size: AppTokens.TypographyTokens.title.size, weight: FontWeight.Bold })
          .foregroundColor(AppTokens.Colors.primary)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(AppTokens.Spacing.sm)
    }
    .padding(AppTokens.Spacing.sm)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ShadowSpec.level1.blurRadius,
      color: AppTokens.ShadowSpec.level1.color,
      offsetX: AppTokens.ShadowSpec.level1.offsetX,
      offsetY: AppTokens.ShadowSpec.level1.offsetY
    })
  }
}

// MARK: - BottomBarSection
@Component
struct BottomBarSection {
  build() {
    Row() {
      Text("3 items in cart")
        .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
        .lineHeight(20)
        .foregroundColor(AppTokens.Colors.onSurface)

      Blank()

      Button({ type: ButtonType.Capsule }) {
        Row({ space: AppTokens.Spacing.sm }) {
          Circle()
            .width(16)
            .height(16)
            .fill(AppTokens.Colors.onPrimary)
            .opacity(0.2)
          
          Text("Checkout")
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
            .foregroundColor(AppTokens.Colors.onPrimary)
        }
        .padding({ left: 24, right: 24, top: 8, bottom: 8 })
      }
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: AppTokens.ShadowSpec.level1.blurRadius,
        color: AppTokens.ShadowSpec.level1.color,
        offsetX: AppTokens.ShadowSpec.level1.offsetX,
        offsetY: AppTokens.ShadowSpec.level1.offsetY
      })
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = "vintage";

  private filters: Filter[] = [
    { id: "vintage", name: "Vintage" },
    { id: "grain", name: "Grain" },
    { id: "b&w", name: "B&W" },
    { id: "neon", name: "Neon" }
  ];

  private items: FilterItem[] = [
    { id: 1, name: "Redscale", author: "by UserA", price: "$4.99", color: AppTokens.Colors.error },
    { id: 2, name: "Sepia Tone", author: "by UserB", price: "$2.99", color: AppTokens.Colors.primary },
    { id: 3, name: "Aqua", author: "by UserC", price: "$4.99", color: AppTokens.Colors.secondary },
    { id: 4, name: "Forest", author: "by UserD", price: "$3.99", color: AppTokens.Colors.tertiary },
    { id: 5, name: "Golden Hour", author: "by UserE", price: "$5.99", color: AppTokens.Colors.warning },
    { id: 6, name: "Monochrome", author: "by UserF", price: "$1.99", color: AppTokens.Colors.outline },
  ];

  build() {
    Column() {
      TopBarSection({
        selectedFilter: $this.selectedFilter,
        filters: this.filters
      })
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.background)

      Scroll() {
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
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)

      BottomBarSection()
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ShadowSpec.level2.blurRadius,
          color: AppTokens.ShadowSpec.level2.color,
          offsetX: AppTokens.ShadowSpec.level2.offsetX,
          offsetY: AppTokens.ShadowSpec.level2.offsetY
        })
    }
    .backgroundColor(AppTokens.Colors.background)
    .width('100%')
    .height('100%')
  }
}