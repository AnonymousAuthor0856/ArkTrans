import { FontWeight } from '@kit.ArkUI';

export interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

export interface TypographyToken {
  size: number;
  weight: FontWeight;
}

export interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

export interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

export class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#1976D2',
    secondary: '#607D8B',
    tertiary: '#757575',
    background: '#ECEFF1',
    surface: '#FFFFFF',
    surfaceVariant: '#CFD8DC',
    outline: '#B0BEC5',
    success: '#4CAF50',
    warning: '#FFC107',
    error: '#F44336',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#263238',
    onSurface: '#263238'
  }

  static readonly TypographyTokens: Record<string, TypographyToken> = {
    display: { size: 36, weight: FontWeight.Bold },
    headline: { size: 24, weight: FontWeight.Medium }, // SemiBold is not standard in ArkTS, using Medium or Bold
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: ShapeTokens = {
    small: 4,
    medium: 8,
    large: 12
  }

  static readonly Spacing: SpacingTokens = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly topBarHeight: number = 64
}

export interface StoryLayer {
  id: number;
  type: string;
  content: string;
}

@Component
export struct LayerItemView {
  @Prop layer: StoryLayer;
  @Prop isSelected: boolean;
  onSelect?: () => void;

  build() {
    Column() {
      // Icon area
      Circle()
        .fill(this.isSelected ? Color.Transparent : AppTokens.Colors.surfaceVariant)
        .width(32)
        .height(32)
      
      Text(this.layer.type)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .foregroundColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .opacity(0.7)
      
      Text(this.layer.content)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .foregroundColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
    }
    .padding({ left: AppTokens.Spacing.xxl, right: AppTokens.Spacing.xxl, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .width(130)
    .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
    .onClick(() => {
      if (this.onSelect) {
        this.onSelect();
      }
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State textOpacity: number = 1.0;
  @State uploadProgress: number = 0.65;
  @State layers: StoryLayer[] = [
    { id: 1, type: "BG", content: "Gradient" },
    { id: 2, type: "IMG", content: "User Photo" },
    { id: 3, type: "TXT", content: "Hello World" },
    { id: 4, type: "ICO", content: "Sticker" }
  ];
  @State selectedLayer: number = 3;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main Content Area
      Column() {
        // Top Bar
        Row() {
          Button('Exit')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .foregroundColor(AppTokens.Colors.onBackground)
            .backgroundColor(Color.Transparent)
            .borderWidth(0)
            .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
          
          Blank()
          
          Text('Story Editor')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .foregroundColor(AppTokens.Colors.onSurface)
          
          Blank()
          
          Button('Post')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .foregroundColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .margin({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
        }
        .height(AppTokens.topBarHeight)
        .backgroundColor(AppTokens.Colors.surface)
        
        // Scrollable Content
        Scroll() {
          Column() {
            // Preview Card
            Stack() {
              Rect()
                .fill(AppTokens.Colors.tertiary)
                .shadow({ radius: 3, color: '#0000001A', offsetY: 1 })
              
              Text('Your Story Preview')
                .fontSize(AppTokens.TypographyTokens.headline.size)
                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                .foregroundColor(AppTokens.Colors.onTertiary)
                .opacity(this.textOpacity)
                .textAlign(TextAlign.Center)
            }
            .height(200)
            .borderRadius(AppTokens.Shapes.large)
            .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            
            // Upload Status
            Column() {
              Text('Upload Status')
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .foregroundColor(AppTokens.Colors.secondary)
              
              Row() {
                Rect()
                  .fill(AppTokens.Colors.surfaceVariant)
                  .borderRadius(4)
                  .height(AppTokens.Spacing.sm)
                
                Rect()
                  .fill(AppTokens.Colors.success)
                  .borderRadius(4)
                  .height(AppTokens.Spacing.sm)
                  .width(`${this.uploadProgress * 100}%`)
              }
              .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            
            // Story Layers
            Column() {
              Text('Story Layers')
                .fontSize(AppTokens.TypographyTokens.label.size)
                .fontWeight(AppTokens.TypographyTokens.label.weight)
                .foregroundColor(AppTokens.Colors.secondary)
              
              Scroll() {
                Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
                  ForEach(this.layers, (layer: StoryLayer) => {
                    LayerItemView({
                      layer: layer,
                      isSelected: layer.id === this.selectedLayer,
                      onSelect: () => { this.selectedLayer = layer.id }
                    })
                  }, (item: StoryLayer) => item.id.toString())
                }
                .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
            }
            .alignItems(HorizontalAlign.Start)
          }
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        }
        .backgroundColor(AppTokens.Colors.background)
      }
      
      // Bottom Bar
      Column() {
        Text('Layer Properties')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .foregroundColor(AppTokens.Colors.secondary)
        
        Row() {
          Text('Opacity')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .width(80)
            .textAlign(TextAlign.Start)
          
          Slider({ value: this.textOpacity, min: 0, max: 1, step: 0.01 })
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .blockColor(AppTokens.Colors.surface)
        }
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 6, color: '#0000001A', offsetY: -2 })
    }
    .backgroundColor(AppTokens.Colors.background)
  }
}