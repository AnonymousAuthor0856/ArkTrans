// ArkTS code
const NAME = "018_FilterShop_en";
const UI_TYPE = "Media";
const STYLE_THEME = "Clay Morph";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppTokens {
  static Colors = {
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
  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 22, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal, lineHeight: 20 },
    label: { size: 12, weight: FontWeight.Medium, letterSpacing: 0.5 },
  };
  static Shapes = {
    small: 8,
    medium: 16,
    large: 24,
  };
  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  };
  static ElevationMapping = {
    level1: 3,
    level2: 6,
  };
}

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

@Entry
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
    Column() {
      // Top Bar
      Column() {
        Text("Filter Shop")
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ bottom: AppTokens.Spacing.md });

        Row({ space: AppTokens.Spacing.sm }) {
          ForEach(this.filters, (filter: Filter) => {
            Text(filter.name)
              .fontSize(AppTokens.TypographyTokens.label.size)
              .fontWeight(AppTokens.TypographyTokens.label.weight)
              .fontColor(this.selectedFilter === filter.id ? AppTokens.Colors.onPrimary : AppTokens.Colors.onBackground)
              .backgroundColor(this.selectedFilter === filter.id ? AppTokens.Colors.primary : AppTokens.Colors.surface)
              .border({
                width: 2,
                color: this.selectedFilter === filter.id ? AppTokens.Colors.onBackground : AppTokens.Colors.outline,
                radius: AppTokens.Shapes.large,
              })
              .padding({
                horizontal: AppTokens.Spacing.md,
                vertical: AppTokens.Spacing.sm,
              })
              .onClick(() => {
                this.selectedFilter = filter.id;
              });
          });
        }
        .width("100%")
        .padding({ horizontal: AppTokens.Spacing.lg, vertical: AppTokens.Spacing.md });
      }
      .width("100%")
      .padding({ horizontal: AppTokens.Spacing.lg, vertical: AppTokens.Spacing.md });

      // Grid Content
      Scroll() {
        Grid() {
          ForEach(this.items, (item: FilterItem) => {
            GridItem() {
              Column() {
                // Image Placeholder
                Column()
                  .width("100%")
                  .aspectRatio(1)
                  .backgroundColor(item.color)
                  .borderRadius(AppTokens.Shapes.medium);

                // Text Content
                Column() {
                  Text(item.name)
                    .fontSize(AppTokens.TypographyTokens.title.size)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(AppTokens.Colors.onSurface)
                    .margin({ top: AppTokens.Spacing.sm });

                  Text(item.author)
                    .fontSize(AppTokens.TypographyTokens.label.size)
                    .fontColor(AppTokens.Colors.onSurface)
                    .opacity(0.6)
                    .margin({ top: 2 });

                  Text(item.price)
                    .fontSize(AppTokens.TypographyTokens.title.size)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(AppTokens.Colors.primary)
                    .margin({ top: AppTokens.Spacing.sm });
                }
                .padding(AppTokens.Spacing.sm)
                .alignItems(HorizontalAlign.Start);
              }
              .padding(AppTokens.Spacing.sm)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({ radius: AppTokens.ElevationMapping.level1, color: "#000000", offsetX: 2, offsetY: 2 });
            }
          });
        }
        .columnsTemplate("1fr 1fr")
        .columnsGap(AppTokens.Spacing.md)
        .rowsGap(AppTokens.Spacing.md)
        .padding(AppTokens.Spacing.lg);
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off);

      // Bottom Bar
      Row() {
        Text("3 items in cart")
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontColor(AppTokens.Colors.onSurface);

        Button() {
          Row() {
            Column()
              .width(16)
              .height(16)
              .borderRadius(8)
              .backgroundColor(AppTokens.Colors.onPrimary)
              .opacity(0.2);
            Text("Checkout")
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontColor(AppTokens.Colors.onPrimary)
              .margin({ left: AppTokens.Spacing.sm });
          }
          .alignItems(VerticalAlign.Center);
        }
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large);
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ horizontal: AppTokens.Spacing.lg, vertical: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: AppTokens.ElevationMapping.level2, color: "#000000", offsetX: 0, offsetY: -2 });
    }
    .width("100%")
    .height("100%")
    .backgroundColor(AppTokens.Colors.background);
  }
}