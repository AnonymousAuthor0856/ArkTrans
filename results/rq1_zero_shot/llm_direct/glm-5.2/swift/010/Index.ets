// MARK: - AppTokens
class AppTokens {
  static readonly Colors = {
    primary: '#FF1976D2',
    secondary: '#FF607D8B',
    tertiary: '#FF757575',
    background: '#FFECEFF1',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFCFD8DC',
    outline: '#FFB0BEC5',
    success: '#FF4CAF50',
    warning: '#FFFFC107',
    error: '#FFF44336',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF263238',
    onSurface: '#FF263238',
  }

  static readonly TypographyTokens = {
    display: { size: 36, weight: FontWeight.Bold },
    headline: { size: 24, weight: FontWeight.Medium },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }

  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 12,
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  }

  static readonly topBarHeight: number = 64
}

// MARK: - Data Models
class StoryLayer {
  id: number
  type: string
  content: string

  constructor(id: number, type: string, content: string) {
    this.id = id
    this.type = type
    this.content = content
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State private textOpacity: number = 1.0
  @State private uploadProgress: number = 0.65
  @State private layers: StoryLayer[] = [
    new StoryLayer(1, 'BG', 'Gradient'),
    new StoryLayer(2, 'IMG', 'User Photo'),
    new StoryLayer(3, 'TXT', 'Hello World'),
    new StoryLayer(4, 'ICO', 'Sticker')
  ]
  @State private selectedLayer: number = 3

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main Content Area
      Column() {
        // Top App Bar
        Row() {
          // Exit Button
          Button('Exit', { type: ButtonType.Normal })
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onBackground)
            .backgroundColor(Color.Transparent)
            .padding({ horizontal: AppTokens.Spacing.sm })

          Blank()

          // Title
          Text('Story Editor')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          // Post Button
          Button('Post', { type: ButtonType.Normal })
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .padding({ horizontal: AppTokens.Spacing.md, vertical: AppTokens.Spacing.sm })
        }
        .width('100%')
        .height(AppTokens.topBarHeight)
        .backgroundColor(AppTokens.Colors.surface)
        .padding({ horizontal: AppTokens.Spacing.sm })

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Preview Card
            Stack() {
              Text('Your Story Preview')
                .fontSize(AppTokens.TypographyTokens.headline.size)
                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                .fontColor(AppTokens.Colors.onTertiary)
                .opacity(this.textOpacity)
                .textAlign(TextAlign.Center)
            }
            .width('100%')
            .height(200)
            .borderRadius(AppTokens.Shapes.large)
            .backgroundColor(AppTokens.Colors.tertiary)
            .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
            .padding({ horizontal: AppTokens.Spacing.lg })

            // Upload Status
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Upload Status')
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.secondary)

              // Custom Progress Bar
              Stack({ alignContent: Alignment.Start }) {
                // Track Background
                Column()
                  .width('100%')
                  .height(AppTokens.Spacing.sm)
                  .borderRadius(AppTokens.Shapes.small)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)

                // Progress Fill
                Column()
                  .width(`${this.uploadProgress * 100}%`)
                  .height(AppTokens.Spacing.sm)
                  .borderRadius(AppTokens.Shapes.small)
                  .backgroundColor(AppTokens.Colors.success)
              }
              .width('100%')
              .height(AppTokens.Spacing.sm)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ horizontal: AppTokens.Spacing.lg })

            // Story Layers
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Story Layers')
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .fontColor(AppTokens.Colors.secondary)
                .padding({ horizontal: AppTokens.Spacing.lg })

              // Horizontal Scroll
              Scroll() {
                Row({ space: AppTokens.Spacing.lg }) {
                  ForEach(this.layers, (layer: StoryLayer) => {
                    LayerItemView({
                      layer: layer,
                      isSelected: layer.id === this.selectedLayer,
                      onSelect: () => {
                        this.selectedLayer = layer.id
                      }
                    })
                  })
                }
                .padding({ horizontal: AppTokens.Spacing.lg, vertical: AppTokens.Spacing.md })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({ vertical: AppTokens.Spacing.lg })
        }
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background)
        .align(Alignment.Top)
      }

      // Bottom Bar
      Column({ space: AppTokens.Spacing.md }) {
        Text('Layer Properties')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.secondary)

        Row() {
          Text('Opacity')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .width(80)
            .textAlign(TextAlign.Start)

          Slider({
            value: this.textOpacity,
            min: 0,
            max: 1,
            onChange: (value: number) => {
              this.textOpacity = value
            }
          })
            .layoutWeight(1)
            .selectedColor(AppTokens.Colors.primary)
        }
        .width('100%')
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - Layer Item View
@Component
struct LayerItemView {
  @Prop layer: StoryLayer
  @Prop isSelected: boolean
  onSelect: () => void

  build() {
    Button({ type: ButtonType.Normal, action: this.onSelect }) {
      Column({ space: AppTokens.Spacing.sm }) {
        // Icon Area
        Circle()
          .width(32)
          .height(32)
          .backgroundColor(this.isSelected ? '#33FFFFFF' : AppTokens.Colors.surfaceVariant)

        // Type Label
        Text(this.layer.type)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .opacity(this.isSelected ? 1 : 0.7)

        // Content Text
        Text(this.layer.content)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .width(130)
      .padding({ horizontal: AppTokens.Spacing.xxl, vertical: AppTokens.Spacing.md })
      .borderRadius(AppTokens.Shapes.medium)
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .border({
        width: 1,
        color: this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.outline
      })
    }
  }
}