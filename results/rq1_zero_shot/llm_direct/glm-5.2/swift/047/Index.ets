// AppTokens (Equivalent to Kotlin AppTokens object)
class AppTokens {
  // Colors
  static readonly Colors = {
    primary: '#FF8C00',
    secondary: '#FFC107',
    tertiary: '#FFE082',
    background: '#FFF8E1',
    surface: '#FFFFFF',
    surfaceVariant: '#FFECB3',
    outline: '#D7CCC8',
    success: '#4CAF50',
    warning: '#FFB300',
    error: '#E53935',
    onPrimary: '#3E2723',
    onSecondary: '#3E2723',
    onBackground: '#3E2723',
    onSurface: '#3E2723'
  }

  // TypographyTokens
  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  // Shapes (Corner radii in vp)
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16
  }

  // Spacing (in vp)
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24
  }

  // ShadowSpec (for elevation mapping)
  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
  }
}

// Pin Data Model (Equivalent to Kotlin data class Pin)
class Pin {
  id: string;
  x: number;
  y: number;
  label: string;

  constructor(x: number, y: number, label: string) {
    this.id = Math.random().toString(36).substring(2, 10); // Unique ID for ForEach
    this.x = x;
    this.y = y;
    this.label = label;
  }
}

// RootScreen (Equivalent to RootScreen Composable)
@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    new Pin(150, 250, 'Group A'),
    new Pin(350, 420, 'Group B'),
    new Pin(520, 310, 'Group C')
  ];

  build() {
    Stack() {
      // Background color for the entire screen
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main content layout
      Column() {
        Text('Retro Group Buy')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ bottom: AppTokens.Spacing.lg })

        // Card equivalent for "Live Deals Map"
        Column() {
          Text('Live Deals Map')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.md })

          // Box equivalent for the map canvas
          Stack() {
            // Draw pins on the canvas
            ForEach(this.pins, (pin: Pin) => {
              // drawCircle(radius = 14f) means diameter is 28f
              Circle({ width: 28, height: 28 })
                .fill(AppTokens.Colors.primary)
                .position({ x: pin.x - 14, y: pin.y - 14 })
            }, (pin: Pin) => pin.id)
          }
          .width('100%')
          .height(220)
          .padding(8)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.elevation,
          color: AppTokens.Colors.onSurface,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
        .margin({ bottom: AppTokens.Spacing.sm })

        // Row equivalent for buttons
        Row({ space: AppTokens.Spacing.md }) {
          Button('Add Group')
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .layoutWeight(1) // Modifier.weight(1f) equivalent
            .height(48)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              // Random.nextInt(100, 550) generates 100 to 549
              // Random.nextInt(150, 450) generates 150 to 449
              const randomX = Math.floor(Math.random() * (550 - 100)) + 100;
              const randomY = Math.floor(Math.random() * (450 - 150)) + 150;
              this.pins.push(new Pin(randomX, randomY, 'New'));
            })

          Button('Clear')
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .layoutWeight(1) // Modifier.weight(1f) equivalent
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.pins = [];
            })
        }
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.lg })

        // Card equivalent for "Active Groups"
        Column() {
          Text('Active Groups')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.primary)
            .margin({ bottom: AppTokens.Spacing.sm })

          // ForEach for dynamic list items, equivalent to pins.forEach
          ForEach(this.pins, (pin: Pin) => {
            Row() {
              Text(pin.label)
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .fontColor(AppTokens.Colors.onSurface)

              Blank() // horizontalArrangement = Arrangement.SpaceBetween

              // Box with CircleShape
              Circle({ width: 14, height: 14 })
                .fill(AppTokens.Colors.primary)
            }
            .width('100%')
            .margin({ bottom: AppTokens.Spacing.sm })
          }, (pin: Pin) => pin.id)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level1.elevation,
          color: AppTokens.Colors.onSurface,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy
        })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL]) // Equivalent to ignoresSafeArea
  }
}