// Translated from SwiftUI to ArkTS (ArkUI declarative syntax)

// MARK: - AppTokens
class AppTokens {
  static readonly Colors = {
    primary: "#D7BBA8",
    secondary: "#A2C4C9",
    tertiary: "#B3C9A2",
    background: "#F0EBE3",
    surface: "#FFFFFF",
    surfaceVariant: "#E6E0D9",
    outline: "#DCD7CF",
    success: "#7EA87E",
    warning: "#D9B872",
    error: "#D98B8B",
    onPrimary: "#433E3A",
    onSecondary: "#433E3A",
    onTertiary: "#433E3A",
    onBackground: "#433E3A",
    onSurface: "#433E3A",
  };

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 22, weight: FontWeight.Semibold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 8,
    medium: 16,
    large: 24,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  };
}

// MARK: - Data Models
class Filter {
  id: string;
  name: string;
  constructor(id: string, name: string) {
    this.id = id;
    this.name = name;
  }
}

class FilterItem {
  id: number;
  name: string;
  author: string;
  price: string;
  color: string;
  constructor(id: number, name: string, author: string, price: string, color: string) {
    this.id = id;
    this.name = name;
    this.author = author;
    this.price = price;
    this.color = color;
  }
}

// MARK: - TopBarSection
@Component
struct TopBarSection {
  filters: Filter[] = [];
  @Link selectedFilter: string;

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Filter Shop")
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onBackground)

      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filters, (filter: Filter) => {
          Text(filter.name)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .letterSpacing(0.5)
            .fontColor(filter.id == this.selectedFilter ? AppTokens.Colors.onPrimary : AppTokens.Colors.onBackground)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
            .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .backgroundColor(filter.id == this.selectedFilter ? AppTokens.Colors.primary : AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({
              width: 2,
              color: filter.id == this.selectedFilter ? "#433E3A1A" : AppTokens.Colors.outline
            })
            .onClick(() => {
              this.selectedFilter = filter.id;
            })
        }, (filter: Filter) => filter.id)
      }
    }
    .width("100%")
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - FilterCard
@Component
struct FilterCard {
  item: FilterItem = new FilterItem(0, "", "", "", "#FFFFFF");

  build() {
    Column({ space: 0 }) {
      // Color swatch (aspect ratio 1:1)
      Rect()
        .width("100%")
        .aspectRatio(1)
        .fill(this.item.color)
        .radius(AppTokens.Shapes.medium)

      Column({ space: AppTokens.Spacing.sm }) {
        Text(this.item.name)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.item.author)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .letterSpacing(0.5)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.6)

        Text(this.item.price)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(AppTokens.Spacing.sm)
    }
    .width("100%")
    .padding(AppTokens.Spacing.sm)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 8, color: "#0000000D", offsetX: 4, offsetY: 4 })
  }
}

// MARK: - BottomBarSection
@Component
struct BottomBarSection {
  build() {
    Row() {
      Text("3 items in cart")
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .lineHeight(20)
        .fontColor(AppTokens.Colors.onSurface)

      Blank()

      Button() {
        Row({ space: AppTokens.Spacing.sm }) {
          Rect()
            .width(16)
            .height(16)
            .fill("#433E3A33")
            .radius(8)
          Text("Checkout")
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .padding({ left: 24, right: 24 })
        .padding({ top: 8, bottom: 8 })
      }
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({ radius: 8, color: "#0000000D", offsetX: 4, offsetY: 4 })
      .onClick(() => {
        // Handle checkout action
        console.log("Checkout tapped");
      })
    }
    .alignItems(VerticalAlign.Center)
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .width("100%")
  }
}

// MARK: - RootScreen
@Component
struct RootScreen {
  @State selectedFilter: string = "vintage";

  private filters: Filter[] = [
    new Filter("vintage", "Vintage"),
    new Filter("grain", "Grain"),
    new Filter("b&w", "B&W"),
    new Filter("neon", "Neon"),
  ];

  private items: FilterItem[] = [
    new FilterItem(1, "Redscale", "by UserA", "$4.99", AppTokens.Colors.error),
    new FilterItem(2, "Sepia Tone", "by UserB", "$2.99", AppTokens.Colors.primary),
    new FilterItem(3, "Aqua", "by UserC", "$4.99", AppTokens.Colors.secondary),
    new FilterItem(4, "Forest", "by UserD", "$3.99", AppTokens.Colors.tertiary),
    new FilterItem(5, "Golden Hour", "by UserE", "$5.99", AppTokens.Colors.warning),
    new FilterItem(6, "Monochrome", "by UserF", "$1.99", AppTokens.Colors.outline),
  ];

  build() {
    Column({ space: 0 }) {
      TopBarSection({ filters: this.filters, selectedFilter: $this.selectedFilter })
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.background)

      Scroll() {
        Grid() {
          ForEach(this.items, (item: FilterItem) => {
            GridItem() {
              FilterCard({ item: item })
            }
          }, (item: FilterItem) => item.id.toString())
        }
        .columnsTemplate("1fr 1fr")
        .columnsGap(AppTokens.Spacing.md)
        .rowsGap(AppTokens.Spacing.md)
        .padding(AppTokens.Spacing.lg)
      }
      .backgroundColor(AppTokens.Colors.background)
      .layoutWeight(1)

      BottomBarSection()
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 12, color: "#00000014", offsetX: 6, offsetY: 6 })
    }
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
