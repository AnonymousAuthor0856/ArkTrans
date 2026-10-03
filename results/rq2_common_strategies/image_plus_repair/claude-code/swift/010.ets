import promptAction from '@ohos.promptAction'

// MARK: - AppTokens
namespace AppTokens {
  export class Colors {
    static readonly primary: string = '#FF1976D2'
    static readonly secondary: string = '#FF607D8B'
    static readonly tertiary: string = '#FF757575'
    static readonly background: string = '#FFECEFF1'
    static readonly surface: string = '#FFFFFFFF'
    static readonly surfaceVariant: string = '#FFCFD8DC'
    static readonly outline: string = '#FFB0BEC5'
    static readonly success: string = '#FF4CAF50'
    static readonly warning: string = '#FFFFC107'
    static readonly error: string = '#FFF44336'
    static readonly onPrimary: string = '#FFFFFFFF'
    static readonly onSecondary: string = '#FFFFFFFF'
    static readonly onTertiary: string = '#FFFFFFFF'
    static readonly onBackground: string = '#FF263238'
    static readonly onSurface: string = '#FF263238'
  }

  export class Spacing {
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 16
    static readonly xl: number = 24
    static readonly xxl: number = 32
  }

  export const topBarHeight: number = 64
}

// MARK: - Data Model
interface StoryLayer {
  id: number
  type: string
  content: string
}

// MARK: - Layer Item View
@Component
struct LayerItemView {
  @Prop layer: StoryLayer = { id: 0, type: '', content: '' }
  @Prop isSelected: boolean = false
  onSelect: () => void = () => {}

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Icon circle
      Circle({ width: 32, height: 32 })
        .fill(this.isSelected ? 'rgba(255,255,255,0.2)' : AppTokens.Colors.surfaceVariant)

      // Type label
      Text(this.layer.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : 'rgba(38,50,56,0.7)')

      // Content text
      Text(this.layer.content)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width(130)
    .padding({
      left: AppTokens.Spacing.xxl,
      right: AppTokens.Spacing.xxl,
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md
    })
    .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .borderRadius(8)
    .border({
      width: 1,
      color: this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.outline
    })
    .onClick(() => {
      this.onSelect()
    })
  }
}

// MARK: - Root Screen
@Entry
@Component
struct RootScreen {
  @State textOpacity: number = 1.0
  @State uploadProgress: number = 0.65
  @State layers: StoryLayer[] = [
    { id: 1, type: 'BG', content: 'Gradient' },
    { id: 2, type: 'IMG', content: 'User Photo' },
    { id: 3, type: 'TXT', content: 'Hello World' },
    { id: 4, type: 'ICO', content: 'Sticker' }
  ]
  @State selectedLayer: number = 3
  private scroller: Scroller = new Scroller()

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main content area
      Column() {
        // Top bar
        Row() {
          // Exit button (left)
          Text('Exit')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppTokens.Colors.onBackground)
            .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
            .onClick(() => {
              promptAction.showToast({ message: 'Exit tapped', duration: 1000 })
            })

          Blank()

          // Title (center)
          Text('Story Editor')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          // Post button (right)
          Text('Post')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({
              left: AppTokens.Spacing.md,
              right: AppTokens.Spacing.md,
              top: AppTokens.Spacing.sm,
              bottom: AppTokens.Spacing.sm
            })
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(8)
            .margin({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
            .onClick(() => {
              promptAction.showToast({ message: 'Post tapped', duration: 1000 })
            })
        }
        .height(AppTokens.topBarHeight)
        .backgroundColor(AppTokens.Colors.surface)

        // Scrollable content
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Preview card
            Stack({ alignContent: Alignment.Center }) {
              Column()
                .width('100%')
                .height('100%')
                .backgroundColor(AppTokens.Colors.tertiary)
                .borderRadius(12)

              Text('Your Story Preview')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppTokens.Colors.onTertiary)
                .opacity(this.textOpacity)
                .textAlign(TextAlign.Center)
            }
            .height(200)
            .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Upload status
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Upload Status')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.secondary)

              // Progress bar
              Stack({ alignContent: Alignment.Start }) {
                Column()
                  .width('100%')
                  .height(AppTokens.Spacing.sm)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .borderRadius(4)

                Column()
                  .width(`${this.uploadProgress * 100}%`)
                  .height(AppTokens.Spacing.sm)
                  .backgroundColor(AppTokens.Colors.success)
                  .borderRadius(4)
              }
              .width('100%')
              .height(AppTokens.Spacing.sm)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Story layers
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Story Layers')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.secondary)
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

              Scroll(this.scroller) {
                Row({ space: AppTokens.Spacing.lg }) {
                  ForEach(this.layers, (item: StoryLayer) => {
                    LayerItemView({
                      layer: item,
                      isSelected: item.id === this.selectedLayer,
                      onSelect: () => {
                        this.selectedLayer = item.id
                      }
                    })
                  }, (item: StoryLayer) => item.id.toString())
                }
                .padding({
                  left: AppTokens.Spacing.lg,
                  right: AppTokens.Spacing.lg,
                  top: AppTokens.Spacing.md,
                  bottom: AppTokens.Spacing.md
                })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        }
        .width('100%')
        .flexGrow(1)
        .backgroundColor(AppTokens.Colors.background)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // Bottom bar - Layer Properties
      Column({ space: AppTokens.Spacing.md }) {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)

        Row() {
          Text('Opacity')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .width(80)
            .textAlign(TextAlign.Start)

          Slider({
            value: this.textOpacity,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .blockColor(Color.White)
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .flexGrow(1)
            .onChange((value: number) => {
              this.textOpacity = value
            })
        }
        .width('100%')
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
