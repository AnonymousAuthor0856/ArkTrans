// MARK: - Color Utility
function colorFromHex(hex: number, alpha: number = 1.0): ResourceColor {
  const r = (hex >> 16) & 0xff;
  const g = (hex >> 8) & 0xff;
  const b = hex & 0xff;
  return `rgba(${r}, ${g}, ${b}, ${alpha})`;
}

// MARK: - AppTokens
interface ColorTokens {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onSecondary: ResourceColor;
  onTertiary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
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

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

interface ShadowSpec {
  radius: number;
  color: ResourceColor;
  offsetX: number;
  offsetY: number;
}

interface ShadowTokens {
  level1: ShadowSpec;
  level2: ShadowSpec;
}

class AppTokens {
  static Colors: ColorTokens = {
    primary: colorFromHex(0xD7BBA8),
    secondary: colorFromHex(0xA2C4C9),
    tertiary: colorFromHex(0xB3C9A2),
    background: colorFromHex(0xF0EBE3),
    surface: colorFromHex(0xFFFFFF),
    surfaceVariant: colorFromHex(0xE6E0D9),
    outline: colorFromHex(0xDCD7CF),
    success: colorFromHex(0x7EA87E),
    warning: colorFromHex(0xD9B872),
    error: colorFromHex(0xD98B8B),
    onPrimary: colorFromHex(0x433E3A),
    onSecondary: colorFromHex(0x433E3A),
    onTertiary: colorFromHex(0x433E3A),
    onBackground: colorFromHex(0x433E3A),
    onSurface: colorFromHex(0x433E3A),
  };

  static TypographyTokens: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 22, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static Shapes: ShapeTokens = {
    small: 8,
    medium: 16,
    large: 24,
  };

  static Spacing: SpacingTokens = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  };

  static ShadowSpec: ShadowTokens = {
    level1: { radius: 8, color: 'rgba(0, 0, 0, 0.05)', offsetX: 4, offsetY: 4 },
    level2: { radius: 12, color: 'rgba(0, 0, 0, 0.08)', offsetX: 6, offsetY: 6 },
  };
}

// Helper to apply shadow
@Extend(Column)
function appShadowColumn(spec: ShadowSpec) {
  .shadow({
    radius: spec.radius,
    color: spec.color,
    offsetX: spec.offsetX,
    offsetY: spec.offsetY,
  });
}

@Extend(Row)
function appShadowRow(spec: ShadowSpec) {
  .shadow({
    radius: spec.radius,
    color: spec.color,
    offsetX: spec.offsetX,
    offsetY: spec.offsetY,
  });
}

// MARK: - Data Models
interface FilterItem {
  id: number;
  name: ResourceStr;
  author: ResourceStr;
  price: ResourceStr;
  color: ResourceColor;
}

interface FilterModel {
  id: string;
  name: ResourceStr;
}

// MARK: - TopBarSection
@Component
struct TopBarSection {
  @Prop filters: FilterModel[];
  @Link selectedFilter: string;

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Filter Shop')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onBackground)
        .width('100%')
        .textAlign(TextAlign.Start)

      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filters, (filter: FilterModel) => {
          Text(filter.name)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(this.selectedFilter === filter.id ? AppTokens.Colors.onPrimary : AppTokens.Colors.onBackground)
            .padding({
              left: AppTokens.Spacing.md,
              right: AppTokens.Spacing.md,
              top: AppTokens.Spacing.sm,
              bottom: AppTokens.Spacing.sm
            })
            .backgroundColor(this.selectedFilter === filter.id ? AppTokens.Colors.primary : AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({
              width: 2,
              color: this.selectedFilter === filter.id ? AppTokens.Colors.onBackground : AppTokens.Colors.outline
            })
            .onClick(() => {
              this.selectedFilter = filter.id;
            })
        })
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - FilterCard
@Component
struct FilterCard {
  private item: FilterItem;

  constructor(item: FilterItem) {
    super();
    this.item = item;
  }

  build() {
    Column() {
      // Image placeholder using color
      Column()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.item.color)
        .borderRadius(AppTokens.Shapes.medium)

      Column({ space: AppTokens.Spacing.sm }) {
        Text(this.item.name)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.item.author)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.6)

        Text(this.item.price)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
      }
      .padding(AppTokens.Spacing.sm)
      .alignItems(HorizontalAlign.Start)
    }
    .padding(AppTokens.Spacing.sm)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .appShadowColumn(AppTokens.ShadowSpec.level1)
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - BottomBarSection
@Component
struct BottomBarSection {
  build() {
    Row() {
      Text('3 items in cart')
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Blank() // Spacer

      Button() {
        Row({ space: AppTokens.Spacing.sm }) {
          Column()
            .width(16)
            .height(16)
            .borderRadius(8) // Circle
            .backgroundColor(AppTokens.Colors.onPrimary)
            .opacity(0.2)

          Text('Checkout')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .padding({ left: 24, right: 24, top: 8, bottom: 8 })
      }
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.large)
      .appShadowRow(AppTokens.ShadowSpec.level1)
    }
    .width('100%')
    .padding({
      left: AppTokens.Spacing.lg,
      right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md
    })
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'vintage';

  private filters: FilterModel[] = [
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
      // Top Bar
      TopBarSection({ filters: this.filters, selectedFilter: $selectedFilter })
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })
        .backgroundColor(AppTokens.Colors.background)

      // Scrollable Content
      Scroll() {
        Grid() {
          ForEach(this.items, (item: FilterItem) => {
            GridItem() {
              FilterCard({ item: item })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .padding(AppTokens.Spacing.lg)
        .columnsGap(AppTokens.Spacing.md)
        .rowsGap(AppTokens.Spacing.md)
      }
      .backgroundColor(AppTokens.Colors.background)
      .layoutWeight(1) // Fill remaining space

      // Bottom Bar
      Column() {
        BottomBarSection()
      }
      .backgroundColor(AppTokens.Colors.surface)
      .appShadowColumn(AppTokens.ShadowSpec.level2)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}