// AppTokens equivalent in ArkTS
class AppColors {
  primary: string = '#FF7B00';
  secondary: string = '#FFD166';
  background: string = '#FFF6E5';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#FFF0C1';
  outline: string = '#E0C080';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#3E2723';
  onBackground: string = '#3E2723';
  onSurface: string = '#3E2723';
}

class AppTypography {
  display: AppFont = { size: 28, weight: FontWeight.Bold };
  headline: AppFont = { size: 20, weight: FontWeight.Medium };
  title: AppFont = { size: 16, weight: FontWeight.Medium };
  body: AppFont = { size: 14, weight: FontWeight.Normal };
  label: AppFont = { size: 12, weight: FontWeight.Medium };
  labelFontSize: number = 12.0;
}

interface AppFont {
  size: number | string | Resource;
  weight: FontWeight;
}

class AppShapes {
  small: number = 6.0;
  medium: number = 10.0;
  large: number = 14.0;
}

class AppSpacing {
  sm: number = 8.0;
  md: number = 12.0;
  lg: number = 16.0;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppElevationMapping {
  level2: ShadowSpec = { elevation: 4.0, radius: 8.0, dy: 4.0, opacity: 0.12 };
}

class AppTokens {
  static Colors: AppColors = new AppColors();
  static TypographyTokens: AppTypography = new AppTypography();
  static Shapes: AppShapes = new AppShapes();
  static Spacing: AppSpacing = new AppSpacing();
  static ElevationMapping: AppElevationMapping = new AppElevationMapping();
}

// Data Model
class ResultItem {
  id: number;
  title: string;

  constructor(id: number, title: string) {
    this.id = id;
    this.title = title;
  }
}

// RootScreen Component
@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State knobOffsetX: number = 144;
  @State knobOffsetY: number = 104;
  @State isTextFieldFocused: boolean = false;
  
  private results: ResultItem[] = [
    new ResultItem(0, 'Result 1'),
    new ResultItem(1, 'Result 2'),
    new ResultItem(2, 'Result 3'),
    new ResultItem(3, 'Result 4'),
    new ResultItem(4, 'Result 5'),
    new ResultItem(5, 'Result 6')
  ];
  
  private filters: string[] = ['Popular', 'New', 'Discount', 'Premium'];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column({ space: AppTokens.Spacing.md }) {
        Text('Retro Filter Search')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Search Field
        Stack({ alignContent: Alignment.Start }) {
          if (this.query === '') {
            Text('Search products')
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontColor(AppTokens.Colors.onSurface)
              .opacity(0.4)
              .margin({ left: AppTokens.Spacing.lg })
          }
          TextInput({ text: this.query, controller: new TextInputController() })
            .type(InputType.Normal)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: this.isTextFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline })
            .height(56)
            .width('100%')
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .onEditChange((isEditing: boolean) => {
              this.isTextFieldFocused = isEditing;
            })
            .onChange((value: string) => {
              this.query = value;
            })
        }

        // Filter Buttons
        Row({ space: AppTokens.Spacing.sm }) {
          ForEach(this.filters, (text: string) => {
            Button(text)
              .fontSize(AppTokens.TypographyTokens.label.size)
              .fontWeight(AppTokens.TypographyTokens.label.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.small)
              .height(36)
              .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        // Canvas Area
        Stack() {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.large)
          
          // Radial Gradient Circle
          Column()
            .width(120)
            .height(120)
            .borderRadius(60)
            .linearGradient({
              angle: 0,
              colors: [[AppTokens.Colors.secondary, 0.0], [AppTokens.Colors.primary, 1.0]]
            })
            .position({ x: '50%', y: '50%' })
            .markAnchor({ x: '50%', y: '50%' })

          // Draggable Knob
          Column()
            .width(32)
            .height(32)
            .borderRadius(16)
            .backgroundColor(AppTokens.Colors.primary)
            .position({ x: this.knobOffsetX, y: this.knobOffsetY })
            .markAnchor({ x: '50%', y: '50%' })
            .gesture(
              PanGesture()
                .onActionStart((event: GestureEvent) => {
                  // Optional: Handle start
                })
                .onActionUpdate((event: GestureEvent) => {
                  // Clamp logic simplified for ArkUI
                  this.knobOffsetX += event.offsetX;
                  this.knobOffsetY += event.offsetY;
                  // Basic bounds check (can be refined based on actual layout dimensions)
                  if (this.knobOffsetX < 16) this.knobOffsetX = 16;
                  if (this.knobOffsetY < 16) this.knobOffsetY = 16;
                })
            )
        }
        .width('100%')
        .height(180)
        .padding(AppTokens.Spacing.lg)

        // Results Grid
        Grid() {
          ForEach(this.results, (item: ResultItem) => {
            GridItem() {
              CardView({ item: item })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppTokens.Spacing.lg)
        .rowsGap(AppTokens.Spacing.lg)
        .padding({ bottom: 24 })
        .layoutWeight(1) // Fill remaining space

      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// CardView Component
@Component
struct CardView {
  private item: ResultItem = new ResultItem(0, '');

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Image Placeholder
      Column()
        .width(96)
        .height(96)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.item.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      // Add Button
      Button('Add')
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .width('100%')
        .height(36)
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
  }
}