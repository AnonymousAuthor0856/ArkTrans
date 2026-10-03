@Entry
@Component
struct Index {
  // Define constants to replace SwiftUI tokens for compilability
  private static readonly AppTokens: AppTokenConfig = {
    Colors: {
      background: '#FFFFFCF2',
      onSurface: '#FF1E1E1E',
      primary: '#FFEF476F',
      onPrimary: '#FFFFFFFF',
      secondary: '#FFFFD166',
      onSecondary: '#FF1E1E1E',
      tertiary: '#FF06D6A0',
      onTertiary: '#FF1E1E1E'
    },
    TypographyTokens: {
      display: 26,
      body: 14,
      label: 12
    },
    Spacing: {
      md: 8,
      xl: 16
    },
    Shapes: {
      smallCornerRadius: 8
    },
    ElevationMapping: {
      level1: {
        opacity: 0.25,
        elevation: 4,
        dy: 2
      }
    }
  }

  private static readonly buttonHeight = 36;
  private static readonly fabSize = 48;
  private static readonly canvasBottomPadding = 80;
  private static readonly topBarActualHeight = 60;
  private static readonly fabBottomMargin = 24;

  build() {
    Stack() {
      // Simulating WindowGroup/Content structure
      Stack() {
        // Canvas Layer (Background)
        // Note: ArkTS Canvas requires a painter function. We provide a minimal one.
        Canvas({})
          .width('100%')
          .height('100%')
          .padding({ bottom: Index.canvasBottomPadding, top: Index.topBarActualHeight })
          .gesture(
            DragGesture()
              .onActionEnd((event?: GestureEvent) => {
                // Placeholder for drag logic
              })
          )

        // Top Title Bar
        Column() {
          Text('Retro Whiteboard')
            .backgroundColor(Index.AppTokens.Colors.background)
            .width('100%')
            .padding({ top: Index.AppTokens.Spacing.md, bottom: Index.AppTokens.Spacing.md })
            .fontColor(Index.AppTokens.Colors.onSurface)
            .fontSize(Index.AppTokens.TypographyTokens.display)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        // Bottom Color Palette
        Column() {
          Blank()
          Row() {
            Blank()
            
            Button() {
              Text('Red')
                .borderRadius(Index.AppTokens.Shapes.smallCornerRadius)
                .backgroundColor(Index.AppTokens.Colors.primary)
                .height(Index.buttonHeight)
                .width('100%')
                .fontColor(Index.AppTokens.Colors.onPrimary)
                .fontSize(Index.AppTokens.TypographyTokens.body)
            }
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
            .borderWidth(0)

            Blank()

            Button() {
              Text('Yellow')
                .borderRadius(Index.AppTokens.Shapes.smallCornerRadius)
                .backgroundColor(Index.AppTokens.Colors.secondary)
                .height(Index.buttonHeight)
                .width('100%')
                .fontColor(Index.AppTokens.Colors.onSecondary)
                .fontSize(Index.AppTokens.TypographyTokens.body)
            }
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
            .borderWidth(0)

            Blank()

            Button() {
              Text('Green')
                .borderRadius(Index.AppTokens.Shapes.smallCornerRadius)
                .backgroundColor(Index.AppTokens.Colors.tertiary)
                .height(Index.buttonHeight)
                .width('100%')
                .fontColor(Index.AppTokens.Colors.onTertiary)
                .fontSize(Index.AppTokens.TypographyTokens.body)
            }
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
            .borderWidth(0)

            Blank()
          }
          .shadow({ radius: Index.AppTokens.ElevationMapping.level1.elevation, color: 'rgba(0,0,0,' + Index.AppTokens.ElevationMapping.level1.opacity + ')' })
          .backgroundColor(Index.AppTokens.Colors.background) // Using background as surface proxy
          .padding(Index.AppTokens.Spacing.md)
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.End)

        // FAB (Floating Action Button) - Clear
        Column() {
          Blank()
          Row() {
            Blank()
            Button() {
              Text('Clear')
                .shadow({ 
                  radius: Index.AppTokens.ElevationMapping.level1.elevation, 
                  color: 'rgba(0,0,0,' + Index.AppTokens.ElevationMapping.level1.opacity + ')',
                  offsetX: 0,
                  offsetY: Index.AppTokens.ElevationMapping.level1.dy
                })
                .clip(Circle())
                .backgroundColor(Index.AppTokens.Colors.secondary)
                .width(Index.fabSize)
                .height(Index.fabSize)
                .fontColor(Index.AppTokens.Colors.onSecondary)
                .fontSize(Index.AppTokens.TypographyTokens.label)
            }
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
            .borderWidth(0)
            .margin({ bottom: Index.fabBottomMargin, right: Index.AppTokens.Spacing.xl })
          }
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.End)
      }
    }.width('100%').height('100%')
  }
}

interface ColorConfig {
  background: string;
  onSurface: string;
  primary: string;
  onPrimary: string;
  secondary: string;
  onSecondary: string;
  tertiary: string;
  onTertiary: string;
}

interface TypographyConfig {
  display: number;
  body: number;
  label: number;
}

interface SpacingConfig {
  md: number;
  xl: number;
}

interface ShapeConfig {
  smallCornerRadius: number;
}

interface ElevationLevelConfig {
  opacity: number;
  elevation: number;
  dy: number;
}

interface ElevationConfig {
  level1: ElevationLevelConfig;
}

interface AppTokenConfig {
  Colors: ColorConfig;
  TypographyTokens: TypographyConfig;
  Spacing: SpacingConfig;
  Shapes: ShapeConfig;
  ElevationMapping: ElevationConfig;
}