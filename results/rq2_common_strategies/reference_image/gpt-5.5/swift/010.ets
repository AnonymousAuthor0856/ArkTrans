class AppColors {
  static readonly primary: string = '#1976D2'
  static readonly secondary: string = '#607D8B'
  static readonly tertiary: string = '#757575'
  static readonly background: string = '#ECEFF1'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#CFD8DC'
  static readonly outline: string = '#B0BEC5'
  static readonly success: string = '#4CAF50'
  static readonly warning: string = '#FFC107'
  static readonly error: string = '#F44336'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#263238'
  static readonly onSurface: string = '#263238'
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

class AppTokens {
  static readonly topBarHeight: number = 64
}

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

@Component
struct LayerItemView {
  @Prop layer: StoryLayer
  @Prop isSelected: boolean
  onSelect: (id: number) => void = () => {
  }

  build() {
    Column({ space: AppSpacing.sm }) {
      Circle()
        .width(32)
        .height(32)
        .fill(this.isSelected ? '#33FFFFFF' : AppColors.surfaceVariant)

      Text(this.layer.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
        .opacity(this.isSelected ? 1 : 0.7)
        .textAlign(TextAlign.Center)

      Text(this.layer.content)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .width('100%')
    }
    .justifyContent(FlexAlign.Center)
    .padding({
      left: AppSpacing.xxl,
      right: AppSpacing.xxl,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .width(130)
    .height(112)
    .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
    .borderRadius(8)
    .border({
      width: 1,
      color: this.isSelected ? AppColors.primary : AppColors.outline
    })
    .onClick(() => {
      this.onSelect(this.layer.id)
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State private textOpacity: number = 1.0
  @State private uploadProgress: number = 0.65
  @State private selectedLayer: number = 3
  @State private layers: StoryLayer[] = [
    new StoryLayer(1, 'BG', 'Gradient'),
    new StoryLayer(2, 'IMG', 'User Photo'),
    new StoryLayer(3, 'TXT', 'Hello World'),
    new StoryLayer(4, 'ICO', 'Sticker')
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        Stack({ alignContent: Alignment.Center }) {
          Row() {
            Text('Exit')
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppColors.onBackground)
              .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
              .height('100%')
              .textAlign(TextAlign.Center)

            Blank()

            Text('Post')
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppColors.onPrimary)
              .padding({
                left: AppSpacing.md,
                right: AppSpacing.md,
                top: AppSpacing.sm,
                bottom: AppSpacing.sm
              })
              .backgroundColor(AppColors.primary)
              .borderRadius(8)
              .margin({ left: AppSpacing.sm, right: AppSpacing.sm })
          }
          .width('100%')
          .height('100%')
          .alignItems(VerticalAlign.Center)

          Text('Story Editor')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(AppTokens.topBarHeight)
        .backgroundColor(AppColors.surface)

        Scroll() {
          Column({ space: AppSpacing.lg }) {
            Stack({ alignContent: Alignment.Center }) {
              Text('Your Story Preview')
                .fontSize(24)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppColors.onTertiary)
                .opacity(this.textOpacity)
                .textAlign(TextAlign.Center)
            }
            .width('100%')
            .height(200)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(12)
            .shadow({
              radius: 3,
              color: '#1A000000',
              offsetX: 0,
              offsetY: 1
            })
            .margin({ left: AppSpacing.lg, right: AppSpacing.lg })

            Column({ space: AppSpacing.sm }) {
              Text('Upload Status')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.secondary)
                .width('100%')

              Stack({ alignContent: Alignment.Start }) {
                Row()
                  .width('100%')
                  .height(AppSpacing.sm)
                  .backgroundColor(AppColors.surfaceVariant)
                  .borderRadius(4)

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
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            Column({ space: AppSpacing.sm }) {
              Text('Story Layers')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.secondary)
                .width('100%')
                .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

              Scroll() {
                Row({ space: AppSpacing.lg }) {
                  ForEach(this.layers, (layer: StoryLayer) => {
                    LayerItemView({
                      layer: layer,
                      isSelected: layer.id === this.selectedLayer,
                      onSelect: (id: number) => {
                        this.selectedLayer = id
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
              .width('100%')
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
            }
            .width('100%')

            Blank()
              .height(132)
          }
          .width('100%')
          .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppColors.background)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.md }) {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .width('100%')

        Row() {
          Text('Opacity')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor('#000000')
            .width(80)

          Slider({
            value: this.textOpacity,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .layoutWeight(1)
            .selectedColor(AppColors.primary)
            .trackColor(AppColors.surfaceVariant)
            .blockColor(AppColors.surface)
            .showTips(false)
            .onChange((value: number) => {
              this.textOpacity = value
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: 6,
        color: '#1A000000',
        offsetX: 0,
        offsetY: -2
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}