import { router } from '@kit.ArkUI';

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#00FF66';
    export const secondary: string = '#CCCCCC';
    export const tertiary: string = '#999999';
    export const background: string = '#000000';
    export const surface: string = '#0A0A0A';
    export const surfaceVariant: string = '#111111';
    export const outline: string = '#1F1F1F';
    export const success: string = '#16A34A';
    export const warning: string = '#F59E0B';
    export const error: string = '#FF4444';
    export const onPrimary: string = '#000000';
    export const onSecondary: string = '#FFFFFF';
    export const onTertiary: string = '#FFFFFF';
    export const onBackground: string = '#E0E0E0';
    export const onSurface: string = '#E0E0E0';
  }

  export namespace Spacing {
    export const xs: number = 4;
    export const sm: number = 8;
    export const md: number = 12;
    export const lg: number = 16;
    export const xl: number = 24;
    export const xxl: number = 32;
  }

  export namespace Radius {
    export const small: number = 6;
    export const medium: number = 10;
    export const large: number = 14;
  }

  export namespace FontSize {
    export const display: number = 28;
    export const headline: number = 20;
    export const title: number = 16;
    export const body: number = 13;
    export const label: number = 11;
  }
}

interface MapMarker {
  name: string;
  distance: string;
}

@Entry
@Component
struct RootScreen {
  @State query: string = '';

  private markers: MapMarker[] = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' },
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Explore Map')
          .fontSize(AppTokens.FontSize.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Search TextField
          TextInput({ placeholder: 'Search destination', text: this.query })
            .placeholderColor(AppTokens.Colors.onSurface)
            .placeholderFont({ size: AppTokens.FontSize.body })
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.FontSize.body)
            .caretColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Radius.medium)
            .borderWidth(1)
            .borderColor(AppTokens.Colors.outline)
            .backgroundColor(AppTokens.Colors.surface)
            .width('100%')
            .height(48)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
            .onChange((value: string) => {
              this.query = value;
            })

          // Markers List
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.markers, (marker: MapMarker) => {
              Column() {
                Row() {
                  Column({ space: 4 }) {
                    Text(marker.name)
                      .fontSize(AppTokens.FontSize.title)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(AppTokens.Colors.onSurface)

                    Text(marker.distance)
                      .fontSize(AppTokens.FontSize.body)
                      .fontWeight(FontWeight.Normal)
                      .fontColor(AppTokens.Colors.secondary)
                  }
                  .alignItems(HorizontalAlign.Start)
                  .layoutWeight(1)

                  Button('View')
                    .fontSize(AppTokens.FontSize.label)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onPrimary)
                    .backgroundColor(AppTokens.Colors.primary)
                    .borderRadius(AppTokens.Radius.small)
                    .height(36)
                    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                    .onClick(() => {})
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)
                .padding(AppTokens.Spacing.md)
              }
              .width('100%')
              .borderRadius(AppTokens.Radius.medium)
              .backgroundColor(AppTokens.Colors.surface)
              .shadow({
                radius: 4,
                color: '#1F000000',
                offsetX: 0,
                offsetY: 2
              })
            }, (marker: MapMarker) => marker.name)
          }
          .width('100%')

          // Spacer
          Row()
            .height(AppTokens.Spacing.xxl)

          // Refresh Map Button
          Button('Refresh Map')
            .width('100%')
            .height(48)
            .fontSize(AppTokens.FontSize.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Radius.large)
            .onClick(() => {})
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}