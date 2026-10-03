import { common } from '@kit.AbilityKit';

// --- App Tokens & Constants ---
const NAME = "061*GroupBuy*en"
const UI_TYPE = "ECommerce"
const STYLE_THEME = "Retro Flat"
const LANG = "en"
const BASELINE_SIZE = "720x1280"

interface ShadowSpec {
  elevation: number; // vp
  radius: number;    // vp
  dy: number;        // vp
  opacity: number;   // 0-1
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF8C00';
    export const secondary: string = '#FFC107';
    export const tertiary: string = '#FFE082';
    export const background: string = '#FFF8E1';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#FFECB3';
    export const outline: string = '#D7CCC8';
    export const success: string = '#4CAF50';
    export const warning: string = '#FFB300';
    export const error: string = '#E53935';
    export const onPrimary: string = '#3E2723';
    export const onSecondary: string = '#3E2723';
    export const onBackground: string = '#3E2723';
    export const onSurface: string = '#3E2723';
  }

  export namespace TypographyTokens {
    export const display: number = 28; // sp
    export const title: number = 18;   // sp
    export const body: number = 14;    // sp
    export const label: number = 12;   // sp
  }

  export namespace Shapes {
    export const small: number = 6;  // vp
    export const medium: number = 10; // vp
    export const large: number = 16; // vp
  }

  export namespace Spacing {
    export const sm: number = 6;  // vp
    export const md: number = 10; // vp
    export const lg: number = 16; // vp
    export const xl: number = 24; // vp
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.1 };
    export const level2: ShadowSpec = { elevation: 6, radius: 8, dy: 4, opacity: 0.15 };
    export const level3: ShadowSpec = { elevation: 10, radius: 12, dy: 6, opacity: 0.18 };
  }
}

// --- Data Model ---
interface Pin {
  x: number;
  y: number;
  label: string;
}

function randomInt(min: number, max: number): number {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    { x: 150, y: 250, label: "Group A" },
    { x: 350, y: 420, label: "Group B" },
    { x: 520, y: 310, label: "Group C" }
  ];

  build() {
    Column() {
      Text("Retro Group Buy")
        .fontSize(AppTokens.TypographyTokens.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)

      // Card: Live Deals Map
      Column() {
        Text("Live Deals Map")
          .fontSize(AppTokens.TypographyTokens.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .alignSelf(ItemAlign.Start)

        Column() {
          Canvas({})
            .width('100%')
            .height(220)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .padding({ left: 8, right: 8, top: 8, bottom: 8 })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: 'rgba(0, 0, 0, ' + AppTokens.ElevationMapping.level2.opacity + ')',
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level2.dy
      })

      Blank().height(AppTokens.Spacing.sm)

      // Buttons Row
      Row() {
        Button("Add Group")
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            this.pins.push({
              x: randomInt(100, 550),
              y: randomInt(150, 450),
              label: "New"
            });
          })

        Blank().width(AppTokens.Spacing.md)

        Button("Clear")
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            this.pins = [];
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Card: Active Groups
      Column() {
        Text("Active Groups")
          .fontSize(AppTokens.TypographyTokens.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .alignSelf(ItemAlign.Start)

        List({ space: AppTokens.Spacing.sm }) {
          ForEach(this.pins, (pin: Pin) => {
            ListItem() {
              Row() {
                Text(pin.label)
                  .fontSize(AppTokens.TypographyTokens.body)
                  .fontColor(AppTokens.Colors.onSurface)
                
                Blank()

                Circle({ width: 14, height: 14 })
                  .fill(AppTokens.Colors.primary)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: AppTokens.ElevationMapping.level1.radius,
        color: 'rgba(0, 0, 0, ' + AppTokens.ElevationMapping.level1.opacity + ')',
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level1.dy
      })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
    .spacing(AppTokens.Spacing.lg)
  }
}