// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#1976D2';
  static readonly secondary: string = '#607D8B';
  static readonly tertiary: string = '#757575';
  static readonly background: string = '#ECEFF1';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#CFD8DC';
  static readonly outline: string = '#B0BEC5';
  static readonly success: string = '#4CAF50';
  static readonly warning: string = '#FFC107';
  static readonly error: string = '#F44336';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#263238';
  static readonly onSurface: string = '#263238';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

const topBarHeight: number = 64;

// MARK: - Data Models
interface StoryLayer {
  id: number;
  type: string;
  content: string;
}

// MARK: - Layer Item Component
@Component
struct LayerItemView {
  layer: StoryLayer = { id: 0, type: '', content: '' };
  isSelected: boolean = false;
  onSelect: () => void = () => {};

  build() {
    Column({ space: AppSpacing.sm }) {
      // Circle icon area
      Circle()
        .width(32)
        .height(32)
        .fill(this.isSelected ? '#33FFFFFF' : AppColors.surfaceVariant)

      // Type label
      Text(this.layer.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? AppColors.onPrimary : '#B3263238')

      // Content text
      Text(this.layer.content)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .padding({ left: AppSpacing.xxl, right: AppSpacing.xxl, top: AppSpacing.md, bottom: AppSpacing.md })
    .width(130)
    .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
    .borderRadius(8)
    .border({
      width: 1,
      color: this.isSelected ? AppColors.primary : AppColors.outline
    })
    .onClick(() => {
      this.onSelect();
    })
  }
}

// MARK: - Root Screen
@Entry
@Component
struct RootScreen {
  @State textOpacity: number = 1.0;
  @State uploadProgress: number = 0.65;
  @State layers: StoryLayer[] = [
    { id: 1, type: 'BG', content: 'Gradient' },
    { id: 2, type: 'IMG', content: 'User Photo' },
    { id: 3, type: 'TXT', content: 'Hello World' },
    { id: 4, type: 'ICO', content: 'Sticker' }
  ];
  @State selectedLayer: number = 3;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main content
      Column() {
        // Top Bar
        Row() {
          // Exit button
          Button({ type: ButtonType.Normal }) {
            Text('Exit')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onBackground)
          }
          .backgroundColor(Color.Transparent)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm })

          Blank()

          // Title
          Text('Story Editor')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Blank()

          // Post button
          Button({ type: ButtonType.Normal }) {
            Text('Post')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onPrimary)
              .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
          }
          .backgroundColor(AppColors.primary)
          .borderRadius(8)
          .margin({ right: AppSpacing.sm })
        }
        .width('100%')
        .height(topBarHeight)
        .backgroundColor(AppColors.surface)
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm })

        // Main scroll content
        Scroll() {
          Column({ space: AppSpacing.lg }) {
            // Preview Card
            Stack() {
              Column()
                .width('100%')
                .height(200)
                .backgroundColor(AppColors.tertiary)
                .borderRadius(12)
                .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })

              Text('Your Story Preview')
                .fontSize(24)
                .fontWeight(600)
                .fontColor(`rgba(255,255,255,${this.textOpacity})`)
                .textAlign(TextAlign.Center)
                .opacity(this.textOpacity)
            }
            .width('100%')
            .height(200)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            // Upload Status
            Column({ space: AppSpacing.sm }) {
              Text('Upload Status')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.secondary)
                .width('100%')

              // Progress bar
              Stack({ alignContent: Alignment.Start }) {
                // Track background
                Row()
                  .width('100%')
                  .height(AppSpacing.sm)
                  .backgroundColor(AppColors.surfaceVariant)
                  .borderRadius(4)

                // Progress fill
                Row()
                  .width(`${this.uploadProgress * 100}%`)
                  .height(AppSpacing.sm)
                  .backgroundColor(AppColors.success)
                  .borderRadius(4)
              }
              .width('100%')
              .height(AppSpacing.sm)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            // Story Layers
            Column({ space: AppSpacing.sm }) {
              Text('Story Layers')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.secondary)
                .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
                .width('100%')

              Scroll() {
                Row({ space: AppSpacing.lg }) {
                  ForEach(this.layers, (layer: StoryLayer) => {
                    LayerItemView({
                      layer: layer,
                      isSelected: layer.id === this.selectedLayer,
                      onSelect: () => {
                        this.selectedLayer = layer.id;
                      }
                    })
                  }, (layer: StoryLayer) => layer.id.toString())
                }
                .padding({
                  left: AppSpacing.lg,
                  right: AppSpacing.lg,
                  top: AppSpacing.md,
                  bottom: AppSpacing.md
                })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .padding({ top: AppSpacing.lg, bottom: 160 })
          .width('100%')
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .backgroundColor(AppColors.background)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      // Bottom Bar - Layer Properties
      Column({ space: AppSpacing.md }) {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .width('100%')

        Row() {
          Text('Opacity')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
            .width(80)
            .textAlign(TextAlign.Start)

          Slider({
            value: this.textOpacity * 100,
            min: 0,
            max: 100,
            step: 1,
            style: SliderStyle.OutSet
          })
            .selectedColor(AppColors.primary)
            .trackColor(AppColors.surfaceVariant)
            .layoutWeight(1)
            .onChange((value: number) => {
              this.textOpacity = value / 100;
            })
        }
        .width('100%')
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -2 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}