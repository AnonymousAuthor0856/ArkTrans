import { Component, View, Text, Button, Column, Row, Grid, GridItem, Card, Stack, ScrollView, Circle, Shape, Color, Font, Padding, Margin, Size, Position, Align, Border, Background, Opacity, Shadow, State, Prop, Builder, BuilderParam, Any } from '@ohos/arkui';

// AppTokens
class AppTokens {
  static readonly Colors = {
    primary: '#A0C4FF',
    secondary: '#B7E4C7',
    tertiary: '#FFDDC1',
    background: '#F8F7FF',
    surface: '#FFFFFF',
    surfaceVariant: '#F0F0F5',
    outline: '#D9D9E3',
    success: '#B4E4C7',
    warning: '#FFDDC1',
    error: '#FFB4AB',
    onPrimary: '#001D3D',
    onSecondary: '#003720',
    onTertiary: '#3E2800',
    onBackground: '#1B1B1F',
    onSurface: '#1B1B1F'
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 12
  };
}

// AnnotationToolButton component
@Component
struct AnnotationToolButton {
  @Prop icon: string;
  @Prop toolName: string;
  @Prop selectedTool: string;
  onButtonClick: () => void = () => {};

  private isSelected(): boolean {
    return this.toolName === this.selectedTool;
  }

  build() {
    Button({ type: ButtonType.Circle }) {
      Text(this.icon)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isSelected() ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
    }
    .width(40)
    .height(40)
    .backgroundColor(this.isSelected() ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
    .onClick(() => {
      this.onButtonClick();
    })
  }
}

// PageThumbnail component
@Component
struct PageThumbnail {
  @Prop pageNumber: number;
  @Prop isSelected: boolean;
  onPageClick: () => void = () => {};

  build() {
    Column() {
      Stack() {
        Column() {
          Text(this.pageNumber.toString())
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
      .border(this.isSelected ? { width: 2, color: AppTokens.Colors.primary } : { width: 0, color: Color.Transparent })
    }
    .width('100%')
    .aspectRatio(0.7)
    .onClick(() => {
      this.onPageClick();
    })
  }
}

// RootScreen component
@Component
struct RootScreen {
  @State selectedPage: number = 1;
  @State selectedTool: string = 'pen';
  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Navigation icon
        Column() {
          Stack() {
            Column() {}
            .width(24)
            .height(24)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(12)
          }
          .width(40)
          .height(40)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .width(48)
        .height(48)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        // Title
        Text('Document.pdf')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // Share button
        Button() {
          Text('Share')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .height(36)
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .margin({ right: AppTokens.Spacing.sm })

        // Spacer
        Column()
          .width(AppTokens.Spacing.sm)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
      .alignItems(VerticalAlign.Center)

      // Main content
      Row() {
        // Left thumbnail grid
        ScrollView() {
          Grid() {
            ForEach(this.pages, (page: number) => {
              GridItem() {
                PageThumbnail({
                  pageNumber: page,
                  isSelected: this.selectedPage === page,
                  onPageClick: () => {
                    this.selectedPage = page;
                  }
                })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppTokens.Spacing.sm)
          .rowsGap(AppTokens.Spacing.sm)
          .padding(AppTokens.Spacing.sm)
        }
        .width(150)
        .height('100%')
        .scrollable(ScrollDirection.Vertical)

        // Spacer
        Column()
          .width(AppTokens.Spacing.md)

        // Right preview area
        Stack() {
          // Page preview card
          Column() {
            Stack() {
              Column() {
                Text(`Page ${this.selectedPage}`)
                  .fontSize(24)
                  .fontWeight(FontWeight.SemiBold)
                  .fontColor(AppTokens.Colors.onSurface)
              }
              .width('100%')
              .height('100%')
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
            }
            .width('100%')
            .height('100%')
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: 2, color: 'rgba(0,0,0,0.08)', offsetY: 1 })
          }
          .width('100%')
          .height('100%')

          // Tool panel
          Column() {
            AnnotationToolButton({
              icon: 'P',
              toolName: 'pen',
              selectedTool: this.selectedTool,
              onButtonClick: () => {
                this.selectedTool = 'pen';
              }
            })
            AnnotationToolButton({
              icon: 'H',
              toolName: 'highlighter',
              selectedTool: this.selectedTool,
              onButtonClick: () => {
                this.selectedTool = 'highlighter';
              }
            })
            AnnotationToolButton({
              icon: 'T',
              toolName: 'text',
              selectedTool: this.selectedTool,
              onButtonClick: () => {
                this.selectedTool = 'text';
              }
            })
            AnnotationToolButton({
              icon: 'S',
              toolName: 'shape',
              selectedTool: this.selectedTool,
              onButtonClick: () => {
                this.selectedTool = 'shape';
              }
            })
          }
          .padding(AppTokens.Spacing.sm)
          .backgroundColor('rgba(255,255,255,0.8)')
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .align(Alignment.Start)
          .margin({ left: AppTokens.Spacing.md })
          .space(AppTokens.Spacing.sm)
        }
        .layoutWeight(1)
        .height('100%')
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.md)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// Main entry
@Entry
@Component
struct MainPage {
  build() {
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}