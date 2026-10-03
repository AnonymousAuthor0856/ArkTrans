// Index.ets
class AppTokens {
  static Colors: Record<string, string> = {
    primary: '#FFFF7043',
    secondary: '#FFFFB74D',
    tertiary: '#FFFFD180',
    background: '#FFFFF8F2',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFFFE0B2',
    outline: '#FFD7CCC8',
    success: '#FF43A047',
    warning: '#FFFFB300',
    error: '#FFE53935',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF3E2723',
    onTertiary: '#FF3E2723',
    onBackground: '#FF3E2723',
    onSurface: '#FF3E2723'
  }

  static Typography: Record<string, Record<string, number | FontWeight>> = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static Shapes: Record<string, number> = {
    small: 8,
    medium: 14,
    large: 20
  }

  static Spacing: Record<string, number> = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  }

  static gridItemMinSize: number = 160;
}

class ShadowSpec {
  elevation: number = 0;
  radius: number = 0;
  dy: number = 0;
  opacity: number = 0;
  
  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }

  get color(): ResourceColor {
    return `rgba(0,0,0,${this.opacity})`;
  }
}

class ElevationMapping {
  static level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1);
  static level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15);
  static level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18);
}

class TripCard {
  id: number;
  title: string;
  days: number;
  price: string;

  constructor(id: number, title: string, days: number, price: string) {
    this.id = id;
    this.title = title;
    this.days = days;
    this.price = price;
  }
}

@Component
export struct TripCardView {
  private trip: TripCard = new TripCard(0, '', 0, '');

  build() {
    Column({
      space: AppTokens.Spacing.sm
    }) {
      // Image Placeholder
      Stack()
        .width('100%')
        .height(100)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.trip.title)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(`${this.trip.days} days`)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7)

      Row() {
        Text(this.trip.price)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.primary)

        Blank() // Pushes button to the end

        Button('Details')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(36)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          .onClick(() => {
            console.log(`Details for ${this.trip.title}`);
          })
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: ElevationMapping.level2.radius,
      color: ElevationMapping.level2.color,
      offsetX: 0,
      offsetY: ElevationMapping.level2.dy
    })
  }
}

@Entry
@Component
struct RootScreen {
  private trips: TripCard[] = [
    new TripCard(1, "Kyoto Cherry Trail", 4, "$460"),
    new TripCard(2, "Tokyo City Break", 3, "$390"),
    new TripCard(3, "Osaka Gourmet Tour", 5, "$520"),
    new TripCard(4, "Mount Fuji Escape", 2, "$280"),
    new TripCard(5, "Okinawa Beach Week", 6, "$740"),
    new TripCard(6, "Hokkaido Winter Lights", 5, "$680")
  ];

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Itinerary Planner")
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.primary)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      Scroll() {
        Grid() {
          ForEach(this.trips, (trip: TripCard) => {
            GridItem() {
              TripCardView({ trip: trip })
            }
          }, (trip: TripCard) => trip.id.toString())
        }
        .columnsTemplate(`repeat(auto-fill, minmax(${AppTokens.gridItemMinSize}, 1fr))`)
        .columnsGap(AppTokens.Spacing.lg)
        .rowsGap(AppTokens.Spacing.lg)
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          bottom: AppTokens.Spacing.xxl
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [AppTokens.Colors.secondary, 0.3],
        [AppTokens.Colors.background, 1.0],
        [AppTokens.Colors.primary, 0.3]
      ]
    })
  }
}